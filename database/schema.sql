-- A MySQL version 5.7 database schema which can be used by either
-- AWS Aurora serverless using MySQL compatibility or used with an
-- AWS RDS instance

SET FOREIGN_KEY_CHECKS=0;

-- USERS
    DROP INDEX IF EXISTS idx_mia_users_user_name;
    DROP TABLE IF EXISTS mia_users;

    CREATE TABLE mia_users (
        user_name               VARCHAR(15)  NOT NULL UNIQUE,
        organisation_ods_code   CHAR(3)      NOT NULL,
        title                   VARCHAR(15)  NOT NULL,
        given_name              VARCHAR(50)  NOT NULL,
        family_name             VARCHAR(50)  NOT NULL,
        email                   VARCHAR(255) NOT NULL,
        password_hash           VARCHAR(128) NOT NULL
    );

    CREATE INDEX idx_mia_users_user_name ON mia_users(user_name);


-- ENCOUNTERS
    DROP INDEX IF EXISTS idx_mia_encounters_dt_created;
    DROP TABLE IF EXISTS mia_encounters;

    CREATE TABLE mia_encounters (
        encounter_id            CHAR(16)     NOT NULL UNIQUE,
        patient_id              CHAR(10)     NOT NULL,
        patient_birthDate       DATE         NOT NULL,
        patient_familyName      VARCHAR(50)  NOT NULL,
        patient_gender          CHAR(1)      NOT NULL,
        patient_givenName       VARCHAR(50)  NOT NULL,
        patient_mobile_number   CHAR(13),
        created_by_user_name    VARCHAR(15),
        behaviour_description   TEXT,
        dt_consented            DATETIME,
        dt_created              DATETIME,
        dt_opened               DATETIME,
        dt_sms_sent             DATETIME,
        dt_submitted            DATETIME,
        dt_sent_health_exchange DATETIME,
        dt_ack_health_exchange  DATETIME,

        FOREIGN KEY (created_by_user_name) REFERENCES mia_users(user_name)
    );

    CREATE INDEX idx_mia_encounters_dt_created ON mia_encounters(dt_created);


-- MEDIA
    DROP INDEX IF EXISTS idx_mia_media_dt_uploaded;
    DROP TABLE IF EXISTS mia_media;

    CREATE TABLE mia_media (
        objectkey               CHAR(128)    NOT NULL UNIQUE,
        mimetype                CHAR(10)     NOT NULL,
        original_filename       VARCHAR(255) NOT NULL,
        file_exentions          VARCHAR(10)  NOT NULL,
        file_size               BIGINT       NOT NULL,
        encounter_id            CHAR(16)     NOT NULL,
        dt_uploaded             DATETIME,
        dt_deleted              DATETIME,

        FOREIGN KEY (encounter_id) REFERENCES mia_encounters(encounter_id)
    );

    CREATE INDEX idx_mia_media_dt_uploaded ON mia_media(objectkey, dt_uploaded);


SET FOREIGN_KEY_CHECKS=1;