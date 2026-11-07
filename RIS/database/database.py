
import os
from pathlib import Path

import psycopg
from dotenv import load_dotenv
from dotenv import dotenv_values

import sqlite3
import requests
from datetime import date

ORTHANC_URL = "http://localhost:8042"
AUTH = ("orthanc", "orthanc")



def init_db(path="bris.db"): # Initialize the database
    conn = sqlite3.connect(path)
    conn.execute("""
        CREATE TABLE IF NOT EXISTS exam_orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            accession_number TEXT UNIQUE,
            patient_id TEXT NOT NULL,
            last_name TEXT NOT NULL,
            first_name TEXT NOT NULL,
            birth_date TEXT,
            sex TEXT,
            modality TEXT NOT NULL,
            description TEXT,
            scheduled_date TEXT NOT NULL
        )
    """)
    conn.commit()
    return conn



def create_order(conn, patient_id, last_name, first_name, # Create a new exam order
                 birth_date, sex, modality, description):
    today = f"{date.today():%Y%m%d}"
    cur = conn.execute( 
        """INSERT INTO exam_orders #insert order into the db
           (patient_id, last_name, first_name, birth_date, sex,
            modality, description, scheduled_date)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?)""",
        (patient_id, last_name, first_name, birth_date, sex,
         modality, description, today),
    )
    order_id = cur.lastrowid 

    # Generate a unique accession number based on the current date and order ID
    accession = f"ACC-{today}-{order_id:04d}"
    conn.execute(
        "UPDATE exam_orders SET accession_number = ? WHERE id = ?",
        (accession, order_id),
    )
    conn.commit()
    return accession



def push_worklist(conn, accession): # Push on Orthanc
    """Lit la commande en base et crÃ©e la worklist dans Orthanc."""
    row = conn.execute(
        """SELECT patient_id, last_name, first_name, birth_date, sex,
                  modality, description, scheduled_date
           FROM exam_orders WHERE accession_number = ?""",
        (accession,),
    ).fetchone()
    pid, last, first, birth, sex, modality, desc, sched = row

    payload = { 
        "Tags": {
            "PatientID": pid,
            "PatientName": f"{last}^{first}",
            "PatientBirthDate": birth,
            "PatientSex": sex,
            "AccessionNumber": accession,
            "RequestedProcedureID": accession,
            "ScheduledProcedureStepSequence": [{
                "Modality": modality,
                "ScheduledStationAETitle": "ANY",
                "ScheduledProcedureStepStartDate": sched,
                "ScheduledProcedureStepStartTime": "080000",
                "ScheduledProcedureStepDescription": desc,
                "ScheduledProcedureStepID": accession,
            }],
        }
    }
    r = requests.post(f"{ORTHANC_URL}/worklists/create",
                      json=payload, auth=AUTH, timeout=10)
    r.raise_for_status()
    return r.json()


if __name__ == "__main__":
    conn = init_db()
    acc = create_order(conn, "PID-001", "Adams", "Doe",
                       "19800422", "M", "CT", "CT Scan")
    print("Accession number :", acc)
    print(push_worklist(conn, acc))