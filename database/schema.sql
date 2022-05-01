-- A MySQL version 5.7 database schema which can be used by either
-- AWS Aurora serverless using MySQL compatibility or used with an
-- AWS RDS instance

SET FOREIGN_KEY_CHECKS=0;

-- ORGANISATIONS
    DROP TABLE IF EXISTS mia_organisations;

    CREATE TABLE mia_organisations (
        ods_code            CHAR(6)   NOT NULL,
        organisation_name   VARCHAR(255) NOT NULL,

        PRIMARY KEY (ods_code)
    );


-- USERS
    DROP INDEX IF EXISTS idx_mia_users_email_session;
    DROP TABLE IF EXISTS mia_users;

    CREATE TABLE mia_users (
        email_account       CHAR(128)   NOT NULL,
        email_address       BLOB        NOT NULL,
        ods_code            CHAR(6)     NOT NULL,
        speciality          VARCHAR(50) NOT NULL,
        title               BLOB        NOT NULL,
        given_name          BLOB        NOT NULL,
        family_name         BLOB        NOT NULL,
        job_title           BLOB        NOT NULL,
        password_hash       CHAR(128)   NOT NULL,
        totp_secret         BLOB,
        totp_qr_code        BLOB,
        onboardingEmailSent TIMESTAMP,
        session_id          CHAR(128),

        PRIMARY KEY (email_account),
        FOREIGN KEY (ods_code) REFERENCES mia_organisations(ods_code)
    );

    CREATE INDEX idx_mia_users_email_session ON mia_users(email_account, session_id);


-- ENCOUNTERS
    DROP INDEX IF EXISTS idx_mia_encounters_dt_created;
    DROP INDEX IF EXISTS idx_mia_encounters_care_unit;
    DROP INDEX IF EXISTS idx_mia_encounters_care_unit_dt_created;
    DROP TABLE IF EXISTS mia_encounters;

    CREATE TABLE mia_encounters (
        encounter_id            CHAR(16)    NOT NULL,
        care_unit               CHAR(10)    NOT NULL,
        patient_id              CHAR(10)    NOT NULL,
        patient_birthDate       BLOB        NOT NULL,
        patient_familyName      BLOB        NOT NULL,
        patient_gender          CHAR(1)     NOT NULL,
        patient_givenName       BLOB        NOT NULL,
        patient_mobile_number   BLOB,
        created_by              CHAR(128),
        behaviour_description   BLOB,
        consent_diagnosis       CHAR(1)     NOT NULL DEFAULT 'N',
        consent_patient_record  CHAR(1)     NOT NULL DEFAULT 'N',
        consent_research        CHAR(1)     NOT NULL DEFAULT 'N',
        dt_consented            DATETIME,
        dt_created              DATETIME,
        dt_opened               DATETIME,
        dt_sms_sent             DATETIME,
        dt_submitted            DATETIME,
        dt_deleted              DATETIME,
        dt_sent_health_exchange DATETIME,
        dt_ack_health_exchange  DATETIME,

        PRIMARY KEY (encounter_id),
        FOREIGN KEY (created_by) REFERENCES mia_users(email_account)
    );

    CREATE INDEX idx_mia_encounters_care_unit ON mia_encounters(care_unit);
    CREATE INDEX idx_mia_encounters_care_unit_dt_created ON mia_encounters(care_unit, dt_created);


-- MEDIA
    DROP INDEX IF EXISTS idx_mia_media_dt_uploaded;
    DROP INDEX IF EXISTS idx_mia_media_mimetype;
    DROP TABLE IF EXISTS mia_media;

    CREATE TABLE mia_media (
        objectkey               CHAR(128)    NOT NULL,
        mimetype                CHAR(10)     NOT NULL,
        original_filename       VARCHAR(255) NOT NULL,
        file_exentions          VARCHAR(10)  NOT NULL,
        file_size               BIGINT       NOT NULL,
        encounter_id            CHAR(16)     NOT NULL,
        dt_uploaded             DATETIME,
        dt_deleted              DATETIME,
        image_width             INT NOT NULL DEFAULT 0,
        image_height            INT NOT NULL DEFAULT 0,

        PRIMARY KEY (objectkey),
        FOREIGN KEY (encounter_id) REFERENCES mia_encounters(encounter_id)
    );

    CREATE INDEX idx_mia_media_mimetype ON mia_media(encounter_id, mimetype);
    CREATE INDEX idx_mia_media_dt_uploaded ON mia_media(objectkey, dt_uploaded);



SET FOREIGN_KEY_CHECKS=1;
SHOW TABLES;
