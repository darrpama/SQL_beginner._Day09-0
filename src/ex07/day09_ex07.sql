CREATE FUNCTION func_minimum(VARIADIC arr numeric[]) RETURNS NUMERIC AS $emp_audit$
    SELECT min($1[i]) FROM generate_subscripts($1, 1) g(i);
$emp_audit$ LANGUAGE sql;

SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);