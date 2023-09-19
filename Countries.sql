---Introduce Data
SELECT *
FROM Projects.dbo.All_Countries

--Identify null/missing values
SELECT *
FROM Projects.dbo.All_Countries
WHERE country is NULL
ORDER by country

---Extra informationon country, capital, population and gdp
SELECT country, capital_city, population, gdp
FROM Projects.dbo.All_Countries

---Update 'Americas' as 'North America' and 'South America'
SELECT country, continent
FROM Projects.dbo.All_Countries

	-- Countries in North America
UPDATE Projects.dbo.All_Countries
SET continent = 'North America'
WHERE country IN (
    'Antigua and Barbuda',
    'The Bahamas',
    'Barbados',
    'Belize',
	'Canada',
	'Costa Rica',
    'Cuba',
	'Dominica',
    'Dominican Republic',
    'El Salvador',
    'Grenada',
    'Guatemala',
    'Haiti',
    'Honduras',
    'Jamaica',
    'Mexico',
    'Nicaragua',
    'Panama',
    'St. Kitts and Nevis',
    'St. Lucia',
    'St. Vincent and the Grenadines',
    'Trinidad and Tobago',
    'United States'
);
	
	-- Countries in South America
UPDATE Projects.dbo.All_Countries
SET continent = 'South America'
WHERE country IN (
    'Argentina',
    'Bolivia',
    'Brazil',
    'Chile',
    'Colombia',
    'Ecuador',
    'Guyana',
    'Paraguay',
    'Peru',
    'Suriname',
    'Uruguay',
    'Venezuela'
);

SELECT country, continent
FROM Projects.dbo.All_Countries


---Continent, avg_gdp and max_population
SELECT continent, AVG(gdp) AS avg_gdp, MAX(population) AS max_population
FROM Projects.dbo.All_Countries
GROUP BY continent
ORDER BY avg_gdp DESC;

---inflation by country
SELECT country, inflation
FROM Projects.dbo.All_Countries
WHERE inflation > 5
ORDER BY inflation DESC;

---Revenue %
SELECT country, health_expenditure_pct_gdp, tax_revenue_pct_gdp
FROM Projects.dbo.All_Countries
WHERE health_expenditure_pct_gdp > tax_revenue_pct_gdp;

---Population analysis
SELECT country, population_male, population_female,
       population_male + population_female AS total_population
FROM Projects.dbo.All_Countries
ORDER BY total_population DESC;

---Energy distribution
SELECT country, electricty_production_renewable_pct,
       electricty_production_nuclear_pct, electricty_production_coal_pct
FROM Projects.dbo.All_Countries
ORDER BY electricty_production_renewable_pct DESC;

---Healthcare and demographics
SELECT country, life_expectancy, health_expenditure_capita,
       hospital_beds, median_age
FROM Projects.dbo.All_Countries
WHERE life_expectancy > 75 AND median_age > 30;

---birth rate, death rate and life expentancy
SELECT country, life_expectancy, health_expenditure_capita, 
	   birth_rate, death_rate, fertility_rate
FROM Projects.dbo.All_Countries

---environmental impacts
SELECT country, co2_emissions, forest_area, greenhouse_other_emissions
FROM Projects.dbo.All_Countries
WHERE co2_emissions > 500 AND forest_area > 30;

---political and government 
SELECT country, democracy_type, democracy_score,
       women_parliament_seats_pct
FROM Projects.dbo.All_Countries
WHERE democracy_score > 6 AND women_parliament_seats_pct > 20;

---Military prowess
SELECT country, armed_forces, military_expenditure_pct_gdp
FROM Projects.dbo.All_Countries
ORDER by armed_forces DESC

---economic and labour statistics
SELECT country, gdp, unemployment_pct, self_employed_pct
FROM Projects.dbo.All_Countries
WHERE gdp > 1000 AND unemployment_pct < 5;

---unemployment and gdp
SELECT country, self_employed_pct, vulnerable_employment_pct, unemployment_pct, gdp
FROM Projects.dbo.All_Countries