SELECT *
FROM Projects.dbo.Countries_by_Density

--Identify null/missing values
SELECT *
FROM Projects.dbo.Countries_by_Density
WHERE country is NULL
ORDER by country

--identify duplicates
SELECT country, COUNT(*) as duplicate_count
FROM Projects.dbo.Countries_by_Density
GROUP by country
HAVING COUNT(*) != 1 

SELECT TOP 5 *
FROM Projects.dbo.Countries_by_Density
ORDER by density DESC

--Calculate current popuation density 
SELECT
    country,
    pop2023,
    area,
    pop2023 / area AS PopulationDensity
FROM Projects.dbo.Countries_by_Density
ORDER by PopulationDensity DESC

--Calculate projected popuation density in 2050
SELECT
	country,
    pop2050,
    area,
    pop2050 / area AS PopulationDensity2050
FROM Projects.dbo.Countries_by_Density
ORDER by PopulationDensity2050 DESC

--Compare growth rate and density
SELECT 
	growthRate,
	density,
	pop2023,
	country
FROM Projects.dbo.Countries_by_Density
ORDER by growthRate DESC
