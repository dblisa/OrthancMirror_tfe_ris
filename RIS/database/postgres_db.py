import os
import psycopg
from dotenv import load_dotenv

from datetime import date
from uuid import uuid4

from psycopg.errors import UniqueViolation


load_dotenv()

def get_connection():
    return psycopg.connect(
        host=os.getenv("POSTGRES_HOST", "127.0.0.1"),
        port=os.getenv("POSTGRES_PORT", "5433"),
        dbname=os.getenv("POSTGRES_DB", "ris_db"),
        user=os.getenv("POSTGRES_USER", "ris_user"),
        password=os.environ["POSTGRES_PASSWORD"]
    )


def get_patients():
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute("""
                SELECT patient_id, last_name, first_name
                FROM patients
                ORDER BY last_name
            """)
            return cur.fetchall()
def create_patient(patient_id, last_name, first_name, birth_date=None, sex=None):
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO patients
                    (patient_id, last_name, first_name, birth_date, sex)
                VALUES (%s, %s, %s, %s, %s)
                RETURNING id
                """,
                (patient_id, last_name, first_name, birth_date, sex)
            )
            return cur.fetchone()[0]

def create_appointment(exam_order_id, scheduled_at, notes=None):
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO appointments
                    (exam_order_id, scheduled_at, notes)
                VALUES (%s, %s, %s)
                RETURNING id
                """,
                (exam_order_id, scheduled_at, notes)
            )
            return cur.fetchone()[0]


def create_exam_order(patient_id, modality, description, scheduled_date):
    with get_connection() as conn:
        with conn.cursor() as cur:

            # Vérifier que le patient existe
            cur.execute(
                """
                SELECT last_name, first_name, birth_date, sex
                FROM patients
                WHERE patient_id = %s
                """,
                (patient_id,)
            )

            patient = cur.fetchone()

            if patient is None:
                raise ValueError("Patient introuvable")

            last_name, first_name, birth_date, sex = patient

            # Générer un numéro d'examen unique
            accession = f"ACC-{date.today():%Y%m%d}-{uuid4().hex[:12].upper()}"

            # Enregistrer la demande d'examen
            cur.execute(
                """
                INSERT INTO exam_orders (
                    accession_number,
                    patient_id,
                    last_name,
                    first_name,
                    birth_date,
                    sex,
                    modality,
                    description,
                    scheduled_date
                )
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING id
                """,
                (
                    accession,
                    patient_id,
                    last_name,
                    first_name,
                    birth_date,
                    sex,
                    modality,
                    description,
                    scheduled_date
                )
            )

            order_id = cur.fetchone()[0]

            return order_id, accession

import bcrypt


def authenticate_user(username, password):
    """
    Vérifie les identifiants d'un utilisateur RIS.

    Retourne les informations de l'utilisateur
    si l'authentification réussit, sinon None.
    """

    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                SELECT u.id, u.username, u.password_hash, r.name
                FROM users u
                JOIN roles r ON u.role_id = r.id
                WHERE u.username = %s
                """,
                (username,)
            )

            user = cur.fetchone()

    if user is None:
        return None

    user_id, username, password_hash, role = user

    if not bcrypt.checkpw(
        password.encode("utf-8"),
        password_hash.encode("utf-8")
    ):
        return None

    return {
        "id": user_id,
        "username": username,
        "role": role
    }



def create_user(username, email, password):
    if not username.strip() or not email.strip():
        raise ValueError("Username and email are required")

    if len(password) < 12:
        raise ValueError("Password must contain at least 12 characters")

    password_hash = bcrypt.hashpw(
        password.encode("utf-8"),
        bcrypt.gensalt()
    ).decode("utf-8")

    with get_connection() as conn:
        with conn.cursor() as cur:
            # Rôle provisoire non administrateur.
            # La table users impose un role_id.
            cur.execute(
                "SELECT id FROM roles WHERE name = %s",
                ("doctor",)
            )
            role = cur.fetchone()

            if role is None:
                raise ValueError("Default role not found")

            cur.execute(
                """
                INSERT INTO users
                    (username, email, password_hash, role_id)
                VALUES (%s, %s, %s, %s)
                RETURNING id
                """,
                (username.strip(), email.strip(),
                 password_hash, role[0])
            )

            return cur.fetchone()[0]


if __name__ == "__main__":
    patients = get_patients()

    for patient in patients:
        print(patient)

