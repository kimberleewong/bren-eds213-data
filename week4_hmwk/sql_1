-- Part 1:
    -- Create table with column of REAL type
CREATE TEMP TABLE my_table (
    data REAL
);

    -- Insert some numbers
INSERT INTO my_table (data)
VALUES
(3),
(4),
(NULL),
(0),
(4),
(7);
-- You can insert multiple rows at once, you don't need a new insert everytime. You do need to separate with commas (and I think parantheses). 

    -- View my_table
SELECT * FROM my_table;

    -- Try doing AVG on column
SELECT AVG(data)
FROM my_table;

-- If the function ignored the NULL, then the average of the five numbers (3, 4, 0, 4, 7) would be 3.6. I think that if the function included the NULL in the calculation, it could either NULL the entire result or it could consider NULL as 0 and bring down the average. What really happened is that the AVG() ignored the NULL value, and had a result of 3.6


-- Part 2:

    -- Which of these queries is correct?
SELECT SUM(data)/COUNT(*) FROM my_table;

SELECT SUM(data)/COUNT(data) FROM my_table;

-- The second option is correct in terms of what the AVG() function does. Because the first option is counting all of the rows, it includes NULL as a count of 1 even though the sum is still 18. Because of this, the average is 18/6 as opposed to  18/5. The second option correctly ignores the NULL when it counts the data column the same way the AVG() function did. 