CREATE OR REPLACE VIEW ms_payroll2 AS  
SELECT 
	cp.payroll_year AS payroll_year, 
	cp.value AS payroll, cpib.name AS category, 
	cp2.value AS price, cpc.name AS product, 
	cpc.price_value AS quantity, 
	cpc.price_unit AS unit 
FROM czechia_payroll cp 
LEFT JOIN czechia_price cp2 
	ON cp.payroll_year = year(cp2.date_from)
LEFT JOIN czechia_price_category cpc 
	ON cpc.code = cp2.category_code 
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code
WHERE cp.value_type_code = 5958;

CREATE OR REPLACE VIEW ms_payroll2_2 AS  
SELECT 
	payroll_year, 
	payroll, 
	category, 
	price, 
	product, 
	quantity, 
	unit
FROM ms_payroll2
WHERE product LIKE '%mléko%' OR product LIKE '%chléb%'
GROUP BY category, payroll_year, product;

SELECT 
	payroll_year, 
	product, 
	AVG (payroll), 
	AVG (price), 
	(AVG (payroll) / AVG (price)) AS avg
FROM ms_payroll2_2
WHERE payroll_year IN (2006, 2018)
GROUP BY payroll_year, product;
