SELECT *
FROM Projects.dbo.Population_by_Country
ORDER by country_code

--Identify null/missing values
SELECT *
FROM Projects.dbo.Population_by_Country
WHERE value is NULL
ORDER by country_code

--identify duplicates in country_code
SELECT country_code, COUNT(*) as duplicate_count
FROM Projects.dbo.Population_by_Country
GROUP by country_code
HAVING COUNT(*) > 1 

--identify duplicates that are not 62
SELECT country_code, COUNT(*) as duplicate_count
FROM Projects.dbo.Population_by_Country
GROUP by country_code
HAVING COUNT(*) != 62

--identify duplicates in country_name
SELECT country_name, COUNT(*) as duplicate_count
FROM Projects.dbo.Population_by_Country
GROUP by country_name
HAVING COUNT(*) > 1 
ORDER by country_name

--identify duplicates that are not 62
SELECT country_name, COUNT(*) as duplicate_count
FROM Projects.dbo.Population_by_Country
GROUP by country_name
HAVING COUNT(*) != 62
ORDER by country_name

--calculate population growth
SELECT country_code, country_name, year, value,
	LAG(value) OVER(PARTITION by country_name ORDER by year) AS prev_population,
	(value - LAG(value) OVER (PARTITION by country_name ORDER by year)) AS population_growth
FROM Projects.dbo.Population_by_Country

--calculate population growth by percentage
SELECT country_code, country_name, year, value,
	LAG(value) OVER(PARTITION by country_name ORDER by year) AS prev_population,
	((value - LAG(value) OVER (PARTITION by country_name ORDER by year)) / LAG(value) OVER(PARTITION by country_name ORDER by year)) *100 AS population_growth_percentage
FROM Projects.dbo.Population_by_Country

--calculate average population by country
SELECT country_name, AVG(value) as avg_population
FROM Projects.dbo.Population_by_Country
GROUP by country_name
ORDER by avg_population
