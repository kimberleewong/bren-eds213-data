.mode table
.nullvalue -NULL-

-- Part 1: Create trigger to insert egg number when a new row is inserted

CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
        BEGIN
            UPDATE Bird_eggs
            SET Egg_num = (
                SELECT IFNULL(MAX(Egg_num), 0) + 1
                FROM Bird_eggs
                WHERE Nest_ID = new.Nest_ID AND Egg_num IS NOT NULL
         )
        WHERE Nest_ID = new.Nest_ID AND Egg_num IS NULL;
END;

-- Test out trigger by inserting new data
INSERT INTO Bird_eggs
    (Book_page, Year, Site, Nest_ID, Length, Width)
    VALUES ('b14.6', 2014, 'eaba', '14eabaage01', 12.34, 56.78);

-- Look at that eggs from the nest_id I just inserted
SELECT * FROM Bird_eggs WHERE Nest_ID = '14eabaage01';
    -- Great!!! It worked, and the new data has an egg_num of 4

-- Test out trigger when using a new Nest_ID with no eggs in it
INSERT INTO Bird_eggs
    (Book_page, Year, Site, Nest_ID, Length, Width)
    VALUES ('b14.6', 2014, 'eaba', 'test_id', 12.34, 56.78);

-- View that row
SELECT * FROM Bird_eggs WHERE Nest_ID = 'test_id'; 
    -- Yay! Also worked.

-- Part 2: Let's update the trigger to fill in book_page, year, and site as well

-- Drop original trigger, so we can add on
DROP TRIGGER egg_filler;

CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
        BEGIN
            
            UPDATE Bird_eggs
            SET Egg_num = (
                SELECT IFNULL (MAX(Egg_num), 0) + 1 
                FROM Bird_eggs
                WHERE Nest_ID = new.Nest_ID AND Egg_num IS NOT NULL)
            WHERE Nest_ID = new.Nest_ID AND Egg_num IS NULL;
            
            UPDATE Bird_eggs
            SET Book_page = (
                SELECT Book_page
                FROM Bird_nests
                WHERE Nest_ID = NEW.Nest_ID) 
            WHERE Nest_ID = NEW.Nest_ID AND Book_page IS NULL;
            
            UPDATE Bird_eggs
            SET Year = (
                SELECT Year
                FROM Bird_nests
                WHERE Nest_ID = NEW.Nest_ID) 
            WHERE Nest_ID = NEW.Nest_ID AND Year IS NULL;
            
            UPDATE Bird_eggs
            SET Site = (
                SELECT Site
                FROM Bird_nests
                WHERE Nest_ID = NEW.Nest_ID) 
            WHERE Nest_ID = NEW.Nest_ID AND Site IS NULL;
END;

-- Test out new trigger by adding more data
INSERT INTO Bird_eggs
    (Nest_ID, Length, Width)
    VALUES ('14eabaage01', 12.35, 57.78);

-- Check to see if trigger worked with new data
SELECT * FROM Bird_eggs WHERE Nest_ID = '14eabaage01';
    -- Yes! Filled in Book_page, Year, Site, and Egg_num