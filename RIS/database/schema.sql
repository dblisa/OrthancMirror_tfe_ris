
//psql ris_db lancer dans le terminal 
CREATE TABLE "patients" (
  "patient_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "national_id" varchar UNIQUE,
  "last_name" varchar NOT NULL,
  "first_name" varchar NOT NULL,
  "birthday" date,
  "gender" varchar,
  "phone_number" varchar,
  "email" varchar,
  "address" varchar
);

CREATE TABLE "exam_requests" (
  "exam_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "patient_id" int,
  "accession_number" varchar UNIQUE,
  "referring_user_id" int,
  "request_date" timestamptz,
  "exam_type" varchar,
  "body_region" varchar,
  "clinical_indication" text
);

CREATE TABLE "users" (
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar UNIQUE,
  "password_hash" varchar,
  "is_active" bool,
  "created_at" timestamptz
);

CREATE TABLE "roles" (
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" varchar UNIQUE,
  "description" varchar
);

CREATE TABLE "user_roles" (
  "user_id" int,
  "role_id" int,
  PRIMARY KEY ("user_id", "role_id")
);

CREATE TABLE "departments" (
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" varchar UNIQUE,
  "description" varchar
);

CREATE TABLE "user_department_access" (
  "user_id" int,
  "department_id" int,
  PRIMARY KEY ("user_id", "department_id")
);

CREATE TABLE "resources" (
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "department_id" int,
  "name" varchar,
  "resource_type" varchar,
  "modality" varchar,
  "is_active" bool
);

CREATE TABLE "appointments" (
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "exam_request_id" int,
  "resource_id" int,
  "start_time" timestamptz,
  "end_time" timestamptz,
  "status" varchar,
  "created_at" timestamptz,
  "created_by" int
);

ALTER TABLE "exam_requests"
ADD FOREIGN KEY ("patient_id")
REFERENCES "patients" ("patient_id")
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "exam_requests"
ADD FOREIGN KEY ("referring_user_id")
REFERENCES "users" ("id")
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "user_roles"
ADD FOREIGN KEY ("user_id")
REFERENCES "users" ("id")
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "user_roles"
ADD FOREIGN KEY ("role_id")
REFERENCES "roles" ("id")
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "user_department_access"
ADD FOREIGN KEY ("user_id")
REFERENCES "users" ("id")
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "user_department_access"
ADD FOREIGN KEY ("department_id")
REFERENCES "departments" ("id")
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "resources"
ADD FOREIGN KEY ("department_id")
REFERENCES "departments" ("id")
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "appointments"
ADD FOREIGN KEY ("resource_id")
REFERENCES "resources" ("id")
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "appointments"
ADD FOREIGN KEY ("exam_request_id")
REFERENCES "exam_requests" ("exam_id")
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "appointments"
ADD FOREIGN KEY ("created_by")
REFERENCES "users" ("id")
DEFERRABLE INITIALLY IMMEDIATE;
