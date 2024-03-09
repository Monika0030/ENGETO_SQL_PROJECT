CREATE OR REPLACE VIEW ms_payroll4_1 AS
SELECT 
	year(cp2.date_from) AS price_year, 
	AVG(cp2.value) AS avg_price
FROM czechia_price cp2 
JOIN czechia_price_category cpc ON cpc.code = cp2.category_code 
GROUP BY year(cp2.date_from);

CREATE OR REPLACE VIEW ms_payroll4_2 AS
SELECT 
	p.payroll_year AS payroll_year, 
	AVG(p.value) AS avg_payroll 
FROM czechia_payroll p
RIGHT JOIN czechia_payroll_industry_branch cpib ON p.industry_branch_code = cpib.code
WHERE p.value_type_code = 5958
GROUP BY p.payroll_year;                                       

CREATE OR REPLACE VIEW ms_payroll4_3 AS
SELECT 
	ms.price_year AS price_year, 
	ms.avg_price AS avg_price, 
	ms2.avg_payroll AS avg_payroll
FROM ms_payroll4_1 ms 
LEFT JOIN ms_payroll4_2 ms2 ON ms.price_year = ms2.payroll_year;   

CREATE OR REPLACE VIEW ms_payroll4_4 AS
SELECT 
	ms.price_year AS price_year,
	ms2.price_year AS previous_year,
	(((ms.avg_price / ms2.avg_price) - 1) * 100) AS price_difference,
	(((ms.avg_payroll / ms2.avg_payroll) - 1) * 100) AS payroll_difference
FROM ms_payroll4_3 ms 
JOIN ms_payroll4_3 ms2 ON ms.price_year = ms2.price_year + 1
WHERE (((ms.avg_price / ms2.avg_price) - 1) * 100) - (((ms.avg_payroll / ms2.avg_payroll) - 1) * 100) >= 10;



