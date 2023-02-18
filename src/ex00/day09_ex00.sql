CREATE TABLE person_audit
(
    created     TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    type_event  CHAR(1)                  NOT NULL DEFAULT 'I',
    row_id      BIGINT                   NOT NULL,
    name        VARCHAR,
    age         INTEGER,
    gender      VARCHAR,
    address     VARCHAR,

    CONSTRAINT ch_type_event CHECK (type_event IN ('I', 'D', 'U'))
);

CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
RETURNS TRIGGER AS $person_audit$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO person_audit SELECT now(), 'I', NEW.*;
            RETURN NEW;
        END IF;
    RETURN NULL;
    END;
$person_audit$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_insert_audit
AFTER INSERT ON person
    FOR EACH ROW EXECUTE FUNCTION fnc_trg_person_insert_audit();

INSERT INTO person(id, name, age, gender, address) VALUES (10, 'Danil', 22, 'male', 'Irkutsk');

