CREATE TABLE Snow_cover(
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1990 AND 2018),
    Date DATE NOT NULL,
    Plot VARCHAR NOT NULL,
    Location VARCHAR NOT NULL,
    Snow_cover REAL CHECK (Snow_cover BETWEEN 0 AND 130), 
    Water_cover REAL CHECK (Water_cover BETWEEN 0 AND 130),
    Land_cover REAL CHECK (Land_cover BETWEEN 0 AND 130),
    Total_cover REAL CHECK (Total_cover BETWEEN 0 AND 130),
    Observer VARCHAR,
    Notes VARCHAR,
    PRIMARY KEY(Site, Plot, Location, Date),
    FOREIGN KEY(Site) REFERENCES Site(Code)
);



COPY Snow_cover FROM '../ASDN_csv/snow_survey_fixed.csv' (header TRUE, nullstr "NA");

SELECT (*) FROM Snow_cover;

-- Ask 1: What is the average snow cover at each site
SELECT Site, AVG(Snow_cover) AS Avg_snow_cover FROM Snow_cover  
    GROUP BY SITE
    ORDER BY Avg_snow_cover;

-- Ask 2: Top 5 most snowy sites
SELECT Site, AVG(Snow_cover) AS Avg_snow_cover FROM Snow_cover  
    GROUP BY SITE
    ORDER BY Avg_snow_cover DESC
    LIMIT 5;

-- Ask 3: Save this as a VIEW
CREATE VIEW Site_avg_snow_cover AS (
  SELECT Site, AVG(Snow_cover) AS Avg_snow_cover FROM Snow_cover  
    GROUP BY SITE
    ORDER BY Avg_snow_cover DESC
    LIMIT 5 
);

CREATE TEMP TABLE Site_avg_snow_cover_table AS (
    SELECT Site, AVG(Snow_cover) AS Avg_snow_cover FROM Snow_cover  
    GROUP BY SITE
    ORDER BY Avg_snow_cover DESC
    LIMIT 5 
);

-- DANGER ZONE AKA updating data
-- We found that 0s at Plot = 'brw0' with snow_cover == 0 are actually no data (NULL)

-- Make backup and test on backup
CREATE TEMP TABLE Snow_cover_backup AS (SELECT * FROM Snow_cover);
UPDATE Snow_cover_backup SET Snow_cover = NULL WHERE Plot = 'brw0' AND Snow_cover = 0;

-- Update data
UPDATE Snow_cover SET Snow_cover = NULL WHERE Plot = 'brw0' AND Snow_cover = 0;