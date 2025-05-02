-- GOAL: Find out who floated the eggs in saltwater from 1998 to 2008 (inclusive) and therefore messed up the data. There were 36 nests they worked on.

-- View needed tables
SELECT * FROM Bird_nests;
SELECT * FROM Personnel;


SELECT Name, COUNT(*) AS Num_floated_nests
    FROM Bird_nests JOIN Personnel 
        ON Bird_nests.Observer = Personnel.Abbreviation
        WHERE Site = 'nome'
            AND Year BETWEEN 1998 AND 2008
            AND ageMethod = 'float'
    GROUP BY Name
    HAVING COUNT(*) = 36;