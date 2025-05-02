-- GOAL: Find who worked with whom based on camp assignment and time, while only having unique pairings (aka people aren't paired with themselves)

    -- Original table
SELECT A.Site, A.Observer AS Observer_1, B.Observer AS Observer_2  
    FROM Camp_assignment A JOIN Camp_assignment B 
        ON A.Site = B.Site
        AND ((A.Start <= B.End)  AND (A.End >= B.Start))
        WHERE (A.Site = 'lkri' AND A.Observer < B.Observer);


-- Bonus problem table
SELECT A.Site, P1.Name AS Name1, P2.Name AS Name2
    FROM Camp_assignment A JOIN Camp_assignment B 
        ON A.Site = B.Site
        AND ((A.Start <= B.End) AND (A.End >= B.Start))
    JOIN Personnel P1 ON A.Observer = P1.Abbreviation
    JOIN Personnel P2 ON B.Observer = P2.Abbreviation
        WHERE (A.Site = 'lkri' AND A.Observer < B.Observer)
    ORDER BY Name2 ASC;