-- COVID 19 Milestone Project
SELECT *
FROM covid_cases
ORDER BY location, date;

SELECT *
FROM covidvaccinations
ORDER BY location, date;

-- Standardise date formate
UPDATE covid_cases
SET date = date_format(str_to_date(date, '%d/%m/%Y'), '%Y/%m/%d');

UPDATE covidvaccinations
SET date = date_format(str_to_date(date, '%d/%m/%Y'), '%Y/%m/%d');

-- Finding the start and last date of covid cases recorded
SELECT MIN(date) AS start_date, MAX(date) AS last_date
FROM covid_cases
WHERE new_cases >= 1;

-- Insert '0' into blank cells in new_vaccnations column
SELECT new_vaccinations, char_length(new_vaccinations) as char_len, Count(*)
FROM covidvaccinations
group by char_len;

UPDATE covidvaccinations
SET new_vaccinations = '0'
WHERE char_length(new_vaccinations) = 0;

-- Finding the first vaccination date recorded
SELECT MIN(date) AS first_vacc
FROM covidvaccinations
WHERE new_vaccinations <> '0';

-- Insert '0' into blank cells in new_deaths column
SELECT new_deaths, char_length(new_deaths) as char_len, Count(*)
FROM covid_cases
group by char_len;

UPDATE covid_cases
SET new_deaths = '0'
WHERE char_length(new_deaths) = 0;

-- Finding the first death occurred 
SELECT MIN(date) AS first_death
FROM covid_cases
WHERE new_deaths <> '0';

-- Check for duplicate rows
SELECT *, count(date) AS numRow
FROM covid_cases
GROUP BY location, date
HAVING numRow >1
order by date;

SELECT *, count(date) AS numRow
FROM covidvaccinations
GROUP BY location, date
HAVING numRow >1
order by date;

-- Looking at iso_code in covid_cases table to determine if they are its primary key
SELECT iso_code, count(iso_code) AS numIso_code
FROM covid_cases
GROUP BY iso_code
HAVING numIso_code>1
ORDER BY numIso_code;
-- iso_code is representative code of the country, and there are duplicates and hence this table does not contain primary key.

-- Check the above records for any duplicates
SELECT *
FROM covid_cases
WHERE iso_code IN (
					SELECT iso_code
                    FROM covid_cases
                    GROUP BY iso_code
                    HAVING count(iso_code) >1
                    )
ORDER BY iso_code;
-- Matching iso_code occurs on the same location but difference date

-- Find the daily total cases of each country
SELECT location, population, date, new_cases,
SUM(new_cases) OVER (Partition by location ORDER BY date ) as DailyTotal_cases
FROM covid_cases 
WHERE iso_code NOT LIKE ('OWID%');

-- Create a new table for daily total cases of each country
CREATE TABLE covid_cases2
SELECT *,
SUM(new_cases) OVER (Partition by location ORDER BY date ) as DailyTotal_cases
FROM covid_cases 
WHERE iso_code NOT LIKE ('OWID%');

-- Check newly inserted values in DailyTotal_cases column
SELECT continent,location, population, date, new_cases, DailyTotal_cases
FROM covid_cases2
WHERE iso_code NOT LIKE ('OWID%'); 

-- Create table for DailyTotal_cases 
CREATE table DailyTotal_cases
SELECT continent,location, population, date, new_cases, DailyTotal_cases
FROM covid_cases2
WHERE iso_code NOT LIKE ('OWID%'); 

-- Find the daily total death of each country
SELECT location, population, date, new_deaths,
SUM(CAST(new_deaths AS UNSIGNED)) OVER (Partition by location ORDER BY date ) as DailyTotal_deaths
FROM covid_cases2 
WHERE iso_code NOT LIKE ('OWID%')
ORDER BY location, date;

-- 7 days moving average cases
SELECT
       a.date,
       a.new_cases,
      ( SELECT AVG(b.new_cases)
                FROM covid_cases2 AS b
                WHERE DATEDIFF(a.date, b.date) <=7) as mvgAvg_cases
     FROM covid_cases2 AS a
     ORDER BY a.date;

-- Create a new column for daily total deaths of each country
ALTER TABLE covid_cases2
ADD COLUMN DailyTotal_deaths int;

-- Create table for DailyTotal_deaths 
CREATE table DailyTotal_deaths
SELECT continent,location, date, new_deaths, DailyTotal_deaths
FROM covid_cases2
WHERE iso_code NOT LIKE ('OWID%'); 

-- Insert values into the new column DailyTotal_deaths
UPDATE covid_cases2 AS cc JOIN
(SELECT location, date, (SUM(CAST(new_deaths AS UNSIGNED)) OVER (Partition by location ORDER BY date )) AS DT_deaths
FROM covid_cases2 
WHERE iso_code NOT LIKE ('OWID%') 
ORDER BY location, date) AS cc1
ON cc.location = cc1.location 
AND cc.date = cc1.date
SET cc.DailyTotal_deaths = cc1.DT_deaths
WHERE cc.DailyTotal_deaths IS NULL;

-- Check newly inserted values in DailyTotal_deaths column
SELECT location, population, date, new_deaths, DailyTotal_deaths
FROM covid_cases2; 

-- 7 days moving average death
SELECT
       a.date,
       a.new_deaths,
      ( SELECT AVG(b.new_deaths)
                FROM covid_cases2 AS b
                WHERE DATEDIFF(a.date, b.date) <=7) as mvgAvg_death
     FROM covid_cases2 AS a
     ORDER BY a.date;

-- Find the daily total vaccination of each country
SELECT location, date, new_vaccinations,
SUM(CAST(new_vaccinations AS UNSIGNED)) OVER (Partition by location ORDER BY date ) as DailyTotal_vaccinations
FROM covidvaccinations
WHERE iso_code NOT LIKE ('OWID%');

-- Create a new table for daily total vaccinations of each country
CREATE TABLE covidvacc2
SELECT continent,location, date, new_vaccinations,
SUM(CAST(new_vaccinations AS UNSIGNED)) OVER (Partition by location ORDER BY date ) as DailyTotal_vaccinations
FROM covidvaccinations
WHERE iso_code NOT LIKE ('OWID%');

-- Check newly inserted values in DailyTotal_vaccinationss column
SELECT location, date, new_vaccinations, DailyTotal_vaccinations
FROM covidvacc2; 

