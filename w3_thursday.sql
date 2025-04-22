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

-- introduction to grouping
SELECT Location, MAX(Area)
    From Site
    GROUP BY Location;
    