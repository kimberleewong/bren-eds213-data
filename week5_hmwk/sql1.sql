-- Find which sites have no egg data using the following three methods: Code NOT IN, Join and WHERE, EXCEPT

-- 1. Using Code NOT IN clause
SELECT Code FROM Site
    WHERE Code NOT IN (
        SELECT Site
        FROM Bird_eggs
        WHERE Site IS NOT NULL
    )
    ORDER BY Code;
    


-- 2. Using Join and WHERE Clause 
SELECT Code FROM Site 
    LEFT JOIN Bird_eggs 
    ON Site.Code = Bird_eggs.Site
    WHERE Egg_num IS NULL
    ORDER BY Code;


-- 3. Using EXCEPT operation
SELECT Code FROM Site
    EXCEPT
    SELECT Site 
    FROM Bird_eggs 
    WHERE Site IS NOT NULL
    ORDER BY Code;