Data Model Table for Snow_survey

```sql
CREATE TABLE Snow_survey (
    Site TEXT NOT NULL, 
    Year INTEGER NOT NULL,
    "Date" TEXT NOT NULL,
    Plot TEXT NOT NULL,
    Location TEXT,
    Snow_cover REAL NOT NULL CHECK (Snow_cover BETWEEN 0 AND 100),
    Water_cover REAL NOT NULL CHECK (Water_cover BETWEEN 0 AND 100),
    Land_cover REAL NOT NULL CHECK (Land_cover BETWEEN 0 AND 100),
    Total_cover REAL NOT NULL CHECK (Total_cover = Snow_cover + Water_cover + Land_cover),
    Observer TEXT NOT NULL,
    Notes TEXT, 
    PRIMARY KEY(Site, "Date", Plot),
    FOREIGN KEY (Site) REFERENCES Site(Code),
    FOREIGN KEY (Observer) REFERENCES Personnel(Abbreviation)
);
```

- For Date and Year, I originally chose for the type to be date, but after exploring the dataframe I saw that those types were actually object and integer respectively. I chose to use that in my table so that it is consistent.

- I chose for Date to be in quotes because it is a reserved word in SQL and therefore might cause errors.

- I chose Site, Date, and Plot as my primary keys because they can best identify each observation, and I also used Site and Observer as foreign keys because they reference other dataframes, such as personnel.csv and site.csv.

- I tried to best follow SQL syntax, and I also put them in the order they are in the dataframe.