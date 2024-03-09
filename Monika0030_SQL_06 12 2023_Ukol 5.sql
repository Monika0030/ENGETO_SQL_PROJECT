CREATE OR REPLACE VIEW mspayroll5_1 AS
SELECT 
ms.price_year AS price_year,
	ms2.price_year AS previous_year,
	(((ms.avg_price / ms2.avg_price) - 1) * 100) AS price_difference,
	(((ms.avg_payroll / ms2.avg_payroll) - 1) * 100) AS payroll_difference
FROM ms_payroll4_3 ms 
JOIN ms_payroll4_3 ms2 ON ms.price_year = ms2.price_year + 1;    


CREATE OR REPLACE VIEW mspayroll5_2 AS
SELECT 
	ec.year AS country_year,
	co.country AS country,
	ec.GDP AS gdp
FROM countries co 
LEFT JOIN economies ec ON co.country = ec.country
WHERE (ec.GDP IS NOT NULL OR ec.gini IS NOT NULL)        
	AND ec.country = 'Czech Republic'
ORDER BY country, ec.year;

SELECT 
	ms11.price_year AS price_year, 
	ms11.previous_year AS previous_year,
	ms11.price_difference AS price_difference,
	ms11.payroll_difference AS payroll_difference,
	ms13.payroll_difference AS paydif_next,
	ms13.price_difference AS pridif_next,
	ms22.gdp as prev_gdp,
	ms21.gdp as gdp,
	(((ms21.gdp / ms22.gdp) * 100) - 100)  AS gdp_difference
FROM mspayroll5_1 ms11 
JOIN mspayroll5_1 ms12 on ms11.price_year = ms12.price_year + 1 
JOIN mspayroll5_1 ms13 on ms11.price_year = ms13.price_year -1
JOIN mspayroll5_2 ms21 on ms21.country_year = ms11.price_year
JOIN mspayroll5_2 ms22 on ms21.country_year = ms22.country_year + 1 AND ms21.country = ms22.country;     

