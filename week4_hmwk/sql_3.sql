-- Mission: list the scientific names of bird species in descending order of their maximum average egg volumes
.tables

-- Create temporary table that has the average volumes by Nest_ID
CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG((3.14/6) * (Width*Width) * Length) AS Avg_volume
        FROM Bird_eggs
        GROUP BY Nest_ID;

-- Make sure Averages table looks how I want it to
SELECT(*) FROM Averages;

-- Check out Bird_nests before join
SELECT(*) FROM Bird_nests;

-- Create new temporary table that joins Averages table with Bird_nests to get species names 
CREATE TEMP TABLE Species_volume AS
SELECT Species, MAX(Avg_volume) AS max_avg_volume
    FROM Bird_nests JOIN Averages USING (Nest_ID)
    GROUP BY Species
    ORDER BY max_avg_volume DESC;

-- Check out the Species table before join
SELECT(*) FROM Species

-- Final query that joins Species_volume with Species to get the scientific names instead of species name 
SELECT Scientific_name, max_avg_volume
    FROM Species_volume JOIN Species 
    ON Species = Code
    ORDER BY max_avg_volume DESC;

-- Put these here for when I need to rerun the temporary tables I created
DROP TABLE Averages;
DROP TABLE Species_volume;
