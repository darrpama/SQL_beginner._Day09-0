CREATE OR REPLACE FUNCTION fnc_fibonacci(IN pstop INTEGER DEFAULT 10)
RETURNS SETOF INTEGER LANGUAGE SQL AS $$
    WITH RECURSIVE t(a,b) AS (
            VALUES(0,1)
        UNION ALL
            SELECT b, a + b AS a FROM t
            WHERE b < pstop
       )
    SELECT a FROM t;
$$;

SELECT * FROM fnc_fibonacci(100);
SELECT * FROM fnc_fibonacci();