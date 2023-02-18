CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(IN pperson VARCHAR DEFAULT 'Dmitriy',
IN pprice INT DEFAULT 500, IN pdate DATE DEFAULT '2022-01-08'::DATE)

RETURNS TABLE(pizzeria varchar) AS $emp_audit$
BEGIN
    RETURN QUERY (SELECT DISTINCT pizzeria.name FROM pizzeria
    JOIN menu ON pizzeria.id = menu.pizzeria_id
    JOIN person_order ON menu.id = person_order.menu_id
    JOIN person ON person.id = person_order.person_id
    JOIN person_visits ON person.id = person_visits.person_id
    WHERE person.name = pperson AND menu.price < pprice AND person_order.order_date = pdate
      AND person_visits.visit_date = pdate);
END;
$emp_audit$
LANGUAGE plpgsql;

SELECT * FROM fnc_person_visits_and_eats_on_date(pprice := 800);
SELECT * FROM fnc_person_visits_and_eats_on_date(pperson := 'Anna', pprice := 1300, pdate := '2022-01-01');