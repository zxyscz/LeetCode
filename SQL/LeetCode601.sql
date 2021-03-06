-----------------------------------------------------------------------
-- 	LeetCode 601. Human Traffic of Stadium
--
-- 	Hard
--
-- 	SQL Schema
--
--  X city built a new stadium, each day many people visit it and the stats 
--  are saved as these columns: id, visit_date, people
--
--  Please write a query to display the records which have 3 or more 
--  consecutive rows and the amount of people more than 100(inclusive).
--
--  For example, the table stadium:
--  +------+------------+-----------+
--  | id   | visit_date | people    |
--  +------+------------+-----------+
--  | 1    | 2017-01-01 | 10        |
--  | 2    | 2017-01-02 | 109       |
--  | 3    | 2017-01-03 | 150       |
--  | 4    | 2017-01-04 | 99        |
--  | 5    | 2017-01-05 | 145       |
--  | 6    | 2017-01-06 | 1455      |
--  | 7    | 2017-01-07 | 199       |
--  | 8    | 2017-01-08 | 188       |
--  +------+------------+-----------+
--  For the sample data above, the output is:
--
--  +------+------------+-----------+
--  | id   | visit_date | people    |
--  +------+------------+-----------+
--  | 5    | 2017-01-05 | 145       |
--  | 6    | 2017-01-06 | 1455      |
--  | 7    | 2017-01-07 | 199       |
--  | 8    | 2017-01-08 | 188       |
--  +------+------------+-----------+
--  Note:
--  Each day only have one row record, and the dates are increasing with 
--  id increasing.
--------------------------------------------------------------------
SELECT
    DISTINCT
    A.id,
    A.visit_date,
    A.people
FROM
    Stadium AS A
CROSS JOIN
(
    SELECT 
        A.id
    FROM
        Stadium AS A
    INNER JOIN
        Stadium AS B
    ON 
        A.id + 1 = B.id
    INNER JOIN
        Stadium AS C
    ON
        B.id + 1 = C.id
    WHERE
        A.people >= 100 AND B.people >= 100 AND C.people >= 100
) AS B
WHERE A.id >= B.id AND A.id <= B.id + 2
ORDER BY A.id