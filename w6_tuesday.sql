-- Review of SQL SELECT processing
SELECT Nest_ID, AVG(3.14/6*Width*Width*Length) AS Avg_volume
    FROM Bird_eggs
    WHERE Nest_ID LIKE '14%'
    GROUP BY Nest_ID
    HAVING Avg_volume > 10000
    ORDER BY Avg_volume DESC
    LIMIT 3 OFFSET 17;

-- Can group by whole expression
SELECT substring(Nest_ID, 1, 3), AVG(3.14/6*Width*Width*Length) AS Avg_volume
    FROM Bird_eggs
    WHERE Nest_ID LIKE '14%'
    GROUP BY substring(Nest_ID, 1, 3)
    HAVING Avg_volume > 10000
    ORDER BY Avg_volume DESC;

-- Joins: creates a new mega-table
CREATE TABLE a (col INT);
INSERT INTO a VALUES (1), (2), (3), (4);
CREATE TABLE b(col INT);
INSERT INTO b VALUES (0), (1);
SELECT * FROM a;
SELECT * FROM b;

-- Returns every possible combination of two columns
SELECT * FROM a JOIN b ON TRUE;

-- Only returns join where the two columms match
SELECT * FROM a JOIN b ON a.col = b.col;

-- Returns NULL rows
SELECT * FROM a JOIN b ON NULL;

-- Any rows that equal each other or a = b+1
SELECT * FROM a JOIN b ON a.col = b.col or a.col = b.col+1;

-- Outer join adds in any rows not included by condition
SELECT * FROM a LEFT JOIN b ON a.col = b.col OR a.col = b.col+1;
    -- Adding row 3 and 4 because they aren't included in the join, so database is keeping track of if rows appear or not