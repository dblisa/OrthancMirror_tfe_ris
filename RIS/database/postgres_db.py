import os
import psycopg2
from dotenv import load_dotenv

from datetime import date
from uuid import uuid4

from psycopg.errors import UniqueViolation


load_dotenv()

def get_connection():
    return psycopg2.connect(
        dbname="ris_db",
        user="loris",
        host="localhost",
        port="5432"
    )


def get_patients():
    with get_connection() as conn: #conencte a postgresql
        with conn.cursor() as cur: #execute des requete sql
            cur.execute("""
                SELECT patient_id, last_name, first_name
                FROM patients
                ORDER BY last_name
            """)
            return cur.fetchall() #retourne le resultat


def create_patient(last_name, first_name, birth_date=None, sex=None):
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO patients
                    (last_name, first_name, birthday, gender)
                VALUES (%s, %s, %s, %s)
                RETURNING patient_id
                """,
                (last_name, first_name, birth_date, sex)
            )
            return cur.fetchone()[0]


def create_appointment(exam_request_id, resource_id, start_time, end_time, created_by):    
    #sécurité (regarde si le start time est bien avant le end time)
    if start_time >= end_time:
        raise ValueError("End time must be after start time")
    with get_connection() as conn:
        with conn.cursor() as cur: 

            #vérifie si le crénaux est libre 
            cur.execute(
                """
                SELECT id
                FROM appointments
                WHERE resource_id = %s
                AND status = 'scheduled'
                AND start_time < %s
                AND end_time > %s
                """,
                (resource_id, end_time, start_time)
            )

            conflict = cur.fetchone()

            if conflict:
                raise ValueError("This resource is already reserved for this time slot")

            #si libre alors ajoute rdv 
            cur.execute(
                """
                INSERT INTO appointments (
                    exam_request_id,
                    resource_id,
                    start_time,
                    end_time,
                    status,
                    created_at,
                    created_by
                )
                VALUES (%s, %s, %s, %s, %s, NOW(), %s)  
                RETURNING id
                """,
                (
                    exam_request_id,
                    resource_id,
                    start_time,
                    end_time,
                    "scheduled",
                    created_by
                )
            )
            return cur.fetchone()[0]

def cancel_appointment(appointment_id):
    with get_connection() as conn:
        with conn.cursor() as cur:
            #recupere le rdv et verifie si il est deja cancelled ou si il existe bien
            cur.execute(
                """
                SELECT id, status
                FROM appointments
                WHERE id = %s
                """,
                (appointment_id,)
            )

            appointment = cur.fetchone()

            if appointment is None:
                raise ValueError("Appointment not found")

            if appointment[1] == "cancelled":
                raise ValueError("Appointment is already cancelled")

            #mise a jour du status du rdv en cancelled
            cur.execute(
                """
                UPDATE appointments
                SET status = 'cancelled'
                WHERE id = %s
                """,
                (appointment_id,)
            )

            return appointment_id


def create_exam_order(patient_id, modality, body_region, description):
    with get_connection() as conn:
        with conn.cursor() as cur:

            # Vérifier que le patient existe
            cur.execute(
                """
                SELECT patient_id
                FROM patients
                WHERE patient_id = %s
                """,
                (patient_id,)
            )

            if cur.fetchone() is None:
                raise ValueError("Patient Not Found")

            # Générer un numéro d'examen unique
            accession = f"ACC-{date.today():%Y%m%d}-{uuid4().hex[:12].upper()}"

            # Enregistrer la demande d'examen
            cur.execute(
                """
                INSERT INTO exam_requests (
                    accession_number,
                    patient_id,
                    exam_type,
                    body_region,
                    clinical_indication
                )
                VALUES (%s, %s, %s, %s, %s)
                RETURNING exam_id
                """,
                (
                    accession,
                    patient_id,
                    modality,
                    body_region,
                    description
                )
            )

            order_id = cur.fetchone()[0]

            return order_id, accession

import bcrypt


def authenticate_user(email, password):
    """
    Vérifie les identifiants d'un utilisateur RIS.

    Retourne les informations de l'utilisateur
    si l'authentification réussit, sinon None.
    """

    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                SELECT u.id, u.email, u.password_hash, r.name
                FROM users u
                JOIN user_roles ur ON u.id = ur.user_id
                JOIN roles r ON ur.role_id = r.id
                WHERE u.email = %s
                AND u.is_active = TRUE
                """,
                (email,)
            )

            user = cur.fetchone()

    if user is None:
        return None

    user_id, email, password_hash, role = user

    if not bcrypt.checkpw(
        password.encode("utf-8"),
        password_hash.encode("utf-8")
    ):
        return None

    return {
        "id": user_id,
        "email": email,
        "role": role
    }



def create_user(first_name, last_name, email, password, role_name):
    if not first_name.strip() or not last_name.strip() or not email.strip():
        raise ValueError("First name, last name and email are required")

    if len(password) < 5: #a définir
        raise ValueError("Password must contain at least 5 characters")

    #hache le mdp
    password_hash = bcrypt.hashpw(
        password.encode("utf-8"),
        bcrypt.gensalt()
    ).decode("utf-8")

    with get_connection() as conn:
        with conn.cursor() as cur:

            #recup role et vérifie qu'il existe
            cur.execute(
                "SELECT id FROM roles WHERE name = %s",
                (role_name,)
            )
            role = cur.fetchone()

            if role is None:
                raise ValueError("Role not found")

            #crée le user
            cur.execute(
                """
                INSERT INTO users (
                    first_name, last_name, email,
                    password_hash, is_active, created_at
                )
                VALUES (%s, %s, %s, %s, TRUE, NOW())
                RETURNING id
                """,
                (first_name.strip(), last_name.strip(), email.strip(), password_hash)
            )

            user_id = cur.fetchone()[0]

            #attribue son role
            cur.execute(
                """
                INSERT INTO user_roles (user_id, role_id)
                VALUES (%s, %s)
                """,
                (user_id, role[0])
            )

            return user_id


if __name__ == "__main__":
    patients = get_patients()

    for patient in patients:
        print(patient)

