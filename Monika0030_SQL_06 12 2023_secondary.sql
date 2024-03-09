CREATE OR REPLACE TABLE monsimko_secondary AS
SELECT 
	ec.year AS country_year,
	co.country AS country,
	ec.GDP AS gdp
FROM countries co 
LEFT JOIN economies ec ON co.country = ec.country
WHERE (ec.GDP IS NOT NULL OR ec.gini IS NOT NULL)
ORDER BY country, ec.year;
