--- question_1

CREATE OR REPLACE VIEW ms_payroll_industry AS
SELECT 
	p.payroll_year AS payroll_year, 
	cpib.name AS category, 
	AVG (p.value) AS avg_payroll 
FROM czechia_payroll p
RIGHT JOIN czechia_payroll_industry_branch cpib ON p.industry_branch_code = cpib.code
GROUP BY p.payroll_year, cpib.name;


SELECT 
	mp.payroll_year AS payroll_year, 
	mp2.payroll_year AS previous_year, 
	mp.category AS category, mp.avg_payroll AS avg_payroll, 
	mp2.avg_payroll AS previous_payroll  
FROM ms_payroll_industry mp
JOIN ms_payroll_industry mp2
ON mp.payroll_year = mp2.payroll_year + 1 AND mp.category = mp2.category
WHERE mp2.avg_payroll > mp.avg_payroll;

