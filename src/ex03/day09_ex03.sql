drop trigger trg_person_insert_audit on person;
drop trigger trg_person_update_audit on person;
drop trigger trg_person_delete_audit on person;
drop function fnc_trg_person_update_audit();
drop function fnc_trg_person_delete_audit();
drop function fnc_trg_person_insert_audit();

truncate person_audit;

CREATE OR REPLACE FUNCTION fnc_trg_person_audit()
RETURNS TRIGGER AS $emp_audit$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO person_audit SELECT now(), 'D',  OLD.*;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO person_audit SELECT now(), 'U', OLD.*;
            RETURN OLD;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO person_audit SELECT  now(), 'I', NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$emp_audit$
LANGUAGE plpgsql;

CREATE TRIGGER trg_person_audit
AFTER UPDATE OR INSERT OR DELETE ON person
    FOR EACH ROW EXECUTE FUNCTION fnc_trg_person_audit();

insert into person(id, name, age, gender, address) values (10, 'Damir', 22, 'male', 'Irkutsk');
update person set name = 'Bulat' where id = 10;
update person set name = 'Damir' where id = 10;
delete from person where id = 10;