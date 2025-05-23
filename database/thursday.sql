-- From last time, wound up:
SELECT DISTINCT Location
    FROM Site
    ORDER BY Location ASC
    LIMIT 3;

-- Filtering 
SELECT * FROM Site WHERE Area < 200;
-- Can be arbitrary expressions
SELECT * FROM Site WHERE Area < 200 AND Latitude > 60;
-- Not equa, classic operator is <>, but nowadays most databases support !=
SELECT * FROM Site WHERE Location <> 'Alaska, USA';
-- LIKE for string matching, uses % as wildcard character (not *)
SELECT * FROM Site WHERE Location LIKE '%Canada'; -- Any site that ends in Canada
-- Is this case sensitive matchin or not? Depends on the batabase 
SELECT * FROM Site WHERE Location LIKE '%canada'; 
-- LIKE is primitive matching, but nowadays everyone supports regex
-- Common pattern databases provide tons of functions
-- Regex for selecting any location that has 'west' in it
SELECT * FROM Site WHERE regexp_matches(Location, '.*west.*');

-- Select expression; i.e. you can do computation
SELECT Site_name, Area FROM Site;
Select Site_name, Area*2.47 FROM Site; -- convert to acres
SELECT Site_name, Area*2.47 AS Area_acres FROM Site; -- Can rename the column!


-- You can use your database as a calculator
SELECT 2+2; 

-- String concatenation operator: classic one is ||, others via functions
SELECT Site_name || 'in' || Location FROM Site;

-- AGGREGATION AND GROUPING
SELECT COUNT(*) FROM Species; 
-- ^^ * means number of rows
SELECT COUNT(Scientific_name) FROM Species;
-- ^^ counts number of non-NULL values
-- can also count # of distinct values
SELECT DISTINCT Relevance FROM Species;
SELECT COUNT(DISTINCT Relevance) FROM Species;

-- moving on to arithmetic operations
SELECT AVG(Area) FROM Site;
SELECT AVG(Area) FROM Site WHERE Location LIKE '%Alaska%';
-- MIN, MAX

-- A quiz: what happens when you do this?:
-- Suppose we want the largest site and its name
SELECT Site_name, MAX(Area) FROM Site;

-- Intro to grouping
SELECT Location, MAX(Area)
    FROM Site
    GROUP BY Location;

SELECT Location, COUNT(*), MAX(Area)
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location;

-- A WHERE clause limites the rows that are going into the expression at the beginning
-- A HAVING filters the groups
SELECT Location, COUNT(*) AS Count, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location
    HAVING COUNT > 1;

-- NULL processing
-- NULL indicates the absence of data in a table
-- But in an expression, it means unknown
SELECT COUNT(*) FROM Bird_nests;
SELECT COUNT(*) FROM Bird_nests WHERE floatAGE > 5;
SELECT COUNT(*) FROM Bird_nests WHERE floatAGE <= 5;
-- How can we find out which rows are null?
SELECT COUNT(*) FROM Bird_nests WHERE floatAGE = NULL;
-- The *only* way to find NULL values:
SELECT COUNT(*) FROM Bird_nests WHERE floatAGE IS NULL;
SELECT COUNT(*) FROM Bird_nests WHERE floatAGE IS NOT NULL;

-- Joins
SELECT * FROM Camp_assignment LIMIT 10;
SELECT * FROM Personnel;

SELECT * FROM Camp_assignment JOIN Personnel
    ON Observer = Abbreviation
    LIMIT 10;

-- What happens?
SELECT * FROM Camp_assignment CROSS JOIN Personnel;

-- You may need to qualify column names
SELECT * FROM Camp_assignment JOIN Personnel
    On Camp_assignment.Observer = Personnel.Abbreviation
    LIMIT 10;

-- another way is to use aliases
SELECT * FROM Camp_assignment AS CA JOIN Personnel AS P
    ON CA.Observer = P.Abbreviation
    LIMIT 10;

-- relational algebra and nested queries and subqueries
SELECT COUNT(*) FROM Bird_nests;
SELECT COUNT(*) FROM (SELECT COUNT(*) FROM Bird_nests);

-- create temp tables
CREATE TEMP TABLE nest_count AS SELECT COUNT(*) FROM Bird_nests;
.table
SELECT * FROM nest_count;
DROP TABLE nest_count;
-- another place to nest queries, in IN clauses
SELECT Observer FROM Bird_nests;
SELECT * FROM Personnel ORDER BY Abbreviation;
SELECT * FROM Bird_nests 
    WHERE Observer In (
        SELECT Abbreviation FROM Personnel
            WHERE Abbreviation LIKE 'a%'
    );