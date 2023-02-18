CREATE OR REPLACE FUNCTION fnc_persons_male()
RETURNS TABLE(id BIGINT,
  name VARCHAR,
  age INTEGER,
  gender VARCHAR,
  address VARCHAR) AS $emp_audit$
 SELECT * FROM person WHERE gender = 'male';
$emp_audit$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION fnc_persons_female()
RETURNS TABLE(id BIGINT,
  name VARCHAR,
  age INTEGER,
  gender VARCHAR,
  address VARCHAR) AS $emp_audit$
 SELECT * FROM person WHERE gender = 'female';
$emp_audit$
LANGUAGE sql;

SELECT * FROM fnc_persons_male();
SELECT * FROM fnc_persons_female();