.table

-- There are lots of "dot-commands" in DuclDB
.help
.help show
.show
--.exit will exit duckdb, or ctrl + d

-- Start with SQL
SELECT * FROM Site;
-- SQL is case insensitive, but upperacse is the tradition
select * from site;

-- Can return on a line, the semicolon is the end of the statement

-- A multi-line statement
SELECT *
    FROM Site;
-- Need to select the whole thing to get it to run

-- SELECT *: all rows, all columns (star means all rows, we never constrained the columns)

-- LIMIT clause, limit num rows
SELECT *
    FROM Site
    LIMIT 3;

-- can be combined with OFFSET clause
SELECT * FROM Site
    LIMIT 3 
    OFFSET 3;
-- Don't give me the first three, start with the next three after that

-- Selecting distinct items
SELECT * FROM Bird_nests LIMIT 1;
SELECT Species FROM Bird_nests;
SELECT DISTINCT Species FROM Bird_nests; -- only 19 distinct species
SELECT DISTINCT Species, Observer FROM Bird_nests;

--  add ordering
SELECT DISTINCT Species, Observer 
    FROM Bird_nests
    ORDER BY Species DESC; -- descending order
-- Order alphabetically by species

-- Look at the site table
SELECT * FROM Site;

-- Select the distinct locations from the site table
-- Are they returned in order? If not, order them

SELECT DISTINCT Location 
    FROM Site
    ORDER BY Location ASC;

-- Add a limit clause to return three results
-- Q: was the LIMIt applied before the resutls were order, or after?

SELECT DISTINCT Location 
    FROM Site
    ORDER BY Location ASC
    LIMIT 3;
-- After 