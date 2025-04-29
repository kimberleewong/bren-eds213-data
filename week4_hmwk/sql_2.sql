-- Part 1: 
    -- Explain what's wrong with the query:

SELECT Site_name, MAX(Area) FROM Site;

    -- To help you answer this question, you may want to consider:
    -- To the database, the above query is no different from:

SELECT Site_name, AVG(Area) FROM Site;
SELECT Site_name, COUNT(*) FROM Site;
SELECT Site_name, SUM(Area) FROM Site;

-- The reason the query doesn't work is because the query is attempting to take an entire column (Site_name) and combine it with the aggregated function (MAX(Area)). MAX(Area) returns one value, but the database is confused on which Site_name to return with that value. 


-- Part 2: 
    -- Find Site_name with largest area by ordering and showing only first one
SELECT Site_name, Area
    FROM Site
    ORDER BY Area DESC
    LIMIT 1;

-- Part 3:
    -- Do the same as part 2 but use a nested query. 
SELECT Site_name, Area 
FROM Site 
WHERE Area = (SELECT MAX(Area) FROM Site);