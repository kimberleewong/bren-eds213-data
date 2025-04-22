-- Continuing with SQL
-- Somewhat arbitray but illustrative query
SELECT Nest_ID, COUNT(*) FROM Bird_eggs
   GROUP BY Nest_ID;
.maxrows 8
SELECT Species FROM Bird_nests WHERE Site = 'nome';
SELECT Species, COUNT(*) AS Nest_count
   FROM Bird_nests
   WHERE Site = 'nome'
   GROUP BY Species
   ORDER BY Species
   LIMIT 2;
-- can nest queries
SELECT Scientific_name, Nest_count FROM
   (SELECT Species, COUNT(*) AS Nest_count
   FROM Bird_nests
   WHERE Site = 'nome'
   GROUP BY Species
   ORDER BY Species
   LIMIT 2) JOIN Species ON Species = Code;
-- outer joins
CREATE TEMP TABLE a (cola INTEGER, common INTEGER);
   INSERT INTO a VALUES (1, 1), (2, 2), (3, 3);
   SELECT * FROM a;
   CREATE TEMP TABLE b (common INTEGER, colb INTEGER);
   INSERT INTO b VALUES (2, 2), (3, 3), (4, 4), (5, 5);
   SELECT * FROM b;
-- the joins we've been doing so far have been "inner" joins
SELECT * FROM a JOIN b USING (common);
-- same thing as saying
SELECT * FROM a JOIN b ON a.common = b.common;

-- by doing an "outer" join --- either "left" or "right" --- we'll add certain missing rows
SELECT * FROM a LEFT JOIN b ON a.common = b.common;
SELECT * FROM a RIGHT JOIN b ON a.common = b.common;

-- A running example; what species do *not* have nest data?
SELECT COUNT(*) FROM Species;
SELECT COUNT(DISTINCT Species) FROM Bird_nests;

-- method 1
SELECT Code FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
SELECT Code FROM Species
    WHERE Code NOT IN (SELECT Species FROM Bird_nests);

-- method 2
SELECT Code, Species, FROM Species LEFT JOIN Bird_nests
    ON Code = Species
    WHERE Nest_ID IS NULL;

-- It's also possible to join a table with itself. a so-called "self-join"

-- Understanding a limitation of DuckDB
SELECT Nest_ID, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

-- Let's add in observer
SELECT Nest_ID, Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

SELECT * FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'

-- DuckDB solution 1:
SELECT Nest_ID, Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING(Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID, Observer;

-- DuckDB solution 2:
SELECT Nest_ID, ANY_VALUE(Observer) as Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING(Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

-- Views: virtual table
CREATE VIEW my_nests AS
SELECT Nest_ID, ANY_VALUE(Observer) as Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING(Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

.tables
SELECT * FROM my_nests;
SELECT Nest_ID, Name, Num_eggs
    FROm my_nests JOIN Personnel
    ON Observer = Abbreviation;

-- view
-- temp table
-- what's the diff?
CREATE TEMP TABLE my_nests_as_temp_table AS
SELECT Nest_ID, ANY_VALUE(Observer) as Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING(Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

.tables
-- temp table is fixed, but view dynamically updates
    -- temp table:
        -- if something is computationally rigorous and you just wanna save smth once
    -- view:
        -- good for convenience

-- What about modifications(inserts, updates, deletes) on a view? Possible?
-- It depends
-- Whether it's theoretically possible
-- How smart the database is

-- Last topic: set operations
-- UNION, UNION ALL, INTERSECT, EXCEPT

SELECT * FROM Bird_eggs LIMIT 5;

SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length*25.4 AS Length, Width*25.4 AS Width 
    FROM Bird_eggs
    WHERE Book_page LIKE 'B14%'
UNION
SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length, Width 
    FROM Bird_eggs
    WHERE Book_page NOT LIKE 'B14%';

-- Method 3 for running example
SELECT Code FROM Species
EXCEPT
SELECT DISTINCT Species FROM Bird_nests;