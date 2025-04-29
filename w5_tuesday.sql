-- EXPORTING data from a database

-- The whole database
EXPORT DATABASE 'export_adsn';

-- One table
COPY Species TO 'species_test.csv' (HEADER, DELIMITER ',');

-- specific query
COPY (SELECT COUNT(*) FROM Species) TO 'species_count.csv' (HEADER, DELIMITER ',');


-- WRAP UP IN CLASS FROM HMWK 3
-- Are there dup;icate sci names?
SELECT COUNT(*) FROM Species;
SELECT COUNT(DISTINCT Scientific_name) FROM Species;
SELECT Scientific_name, COUNT(*) AS Num_name_occurrences
    FROM Species
    GROUP BY Scientific_name
    HAVING Num_name_occurrences > 1;

CREATE TEMP TABLE t AS (
SELECT Scientific_name, COUNT(*) AS Num_name_occurrences
    FROM Species
    GROUP BY Scientific_name
    HAVING Num_name_occurrences > 1
    );

SELECT * FROM t;
SELECT * FROM Species s JOIN t
    ON s.Scientific_name = t.Scientific_name
    OR (s.Scientific_name IS NULL AND t.Scientific_name IS NULL);

-- Inserting data
INSERT INTO Species VALUES ('abcd', 'thing', 'scientific_name', NULL);
SELECT * FROM Species;

-- You can explicitly label columns
INSERT INTO Species
    (Common_name, Scientific_name, Code, Relevance)
    VALUES
    ('thing 2', 'another sci name', 'efgh', NULL);
SELECT * FROM Species;

-- Can take advantage of default values
INSERT INTO Species
    (Common_name, Code)
    VALUES
    ('thing 3', 'ijkl');
SELECT * FROM Species;

-- UPDATEs and DELETEs will demolish entire table unless limited by WHERE
DELETE FROM Bird_eggs 

-- Strategies to save yourself
-- Doing a SELECT first
SELECT * FROM Bird_eggs WHERE Nest_ID LIKE 'z%';
    -- Check if this looks right, then replace SELECT * FROM with DELETE FROM
    
SELECT * FROM Bird_nests;

-- Try to create a copy of the table
CREATE TABLE nest_temp AS (SELECT * FROM Bird_nests);
DELETE FROM nest_temp WHERE Site = 'chur';

-- Other ideas, put x in front
xDELETE FROM ... WHERE ...;
