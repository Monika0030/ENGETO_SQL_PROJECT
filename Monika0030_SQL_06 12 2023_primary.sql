CREATE OR REPLACE VIEW primary1 AS
SELECT 
	p.payroll_year AS payroll_year, 
	p.value AS payroll, 
	cpib.name AS category
FROM czechia_payroll p
LEFT JOIN czechia_payroll_industry_branch cpib ON p.industry_branch_code = cpib.code
WHERE p.value_type_code = 5958
GROUP BY cpib.name, p.payroll_year;

CREATE OR REPLACE VIEW primary2 AS
SELECT 
	cp.date_from AS date_from, 
	cp.value AS price, 
	cpc.name AS product, 
	cpc.price_value AS quantity, 
	cpc.price_unit AS unit
FROM czechia_price cp
LEFT JOIN czechia_price_category cpc ON cp.category_code = cpc.code;

CREATE OR REPLACE TABLE monsimko_primary AS
SELECT 
	p1.payroll_year AS payroll_year, 
	p1.payroll AS payroll, 
	p1.category AS category, p2.price AS price, 
	p2.product AS product, p2.quantity AS quantity, 
	p2.unit AS unit
FROM primary1 p1
LEFT JOIN primary2 p2 ON p1.payroll_year = year(p2.date_from);
