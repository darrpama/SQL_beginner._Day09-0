DROP FUNCTION fnc_persons_female();
DROP FUNCTION fnc_persons_male();

CREATE OR REPLACE FUNCTION fnc_persons(IN pgender varchar default 'female')
RETURNS TABLE(id BIGINT,
  name VARCHAR,
  age INTEGER,
  gender VARCHAR,
  address VARCHAR) AS $emp_audit$
 SELECT * FROM person WHERE gender = pgender;
$emp_audit$
LANGUAGE sql;

SELECT * FROM fnc_persons(pgender := 'male');
SELECT * FROM fnc_persons();