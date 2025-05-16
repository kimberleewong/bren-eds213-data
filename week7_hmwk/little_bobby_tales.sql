-- Part 1: Explain exactly how Little Bobby Tables’ “name” can cause a catastrophe. Explain why his name has two hyphens (--) at the end.
    -- Little Bobby Tables' "name" causes catastrophe because the the semicolon after Robert') completes that INSERT, but the DROP TABLE Students; is also carried out effectively deleting the entire Students table. His name has the two hyphens at the end because it comments out the rest of the query.

-- Part 2: Suppose instead the school system executed the query

SELECT *
    FROM Students WHERE name = '%s';

-- What “name” would Little Bobby Tables use to destroy things in that case?

    -- Robert'; DROP TABLE Students;-- 
        -- By removing the paranthesis, this query would still run and effectively destroy the table. 

-- Part 3: Hack your bird database! Let’s imagine that your Shiny application, in response to user input, executes the query

SELECT * FROM Species WHERE Code = '%s';
-- where a species code (supplied by the application user) is directly substituted for the query’s %s using Python interpolation. For example, an innocent user might input “wolv”. Craft an input that a devious user could use to:

-- Add Taylor Swift to the Personnel table
-- Yet still return the results of the query SELECT * FROM Species WHERE Code = 'wolv' (devious!)

wolv'; INSERT INTO Personnel (name) VALUES ('Taylor Swift');-- 

    -- This line would deviously add Taylor Swift to the personnel table while still returning the result from the SELECT * FROM Species WHERE Code = 'wolv' query.