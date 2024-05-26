-- question_3

CREATE OR REPLACE VIEW ms_food_year AS
SELECT 
	cpc.name AS product, 
	year(cp2.date_from) AS price_year, 
	AVG (cp2.value) AS price
FROM czechia_price cp2 
JOIN czechia_price_category cpc ON cpc.code = cp2.category_code 
GROUP BY year(cp2.date_from), cpc.name;

SELECT 
	ms.price_year AS price_year,
  	ms2.price_year AS previous_year,
   	ms.product AS product,
   (((ms.price / ms2.price) - 1) * 100) AS difference
FROM ms_food_year ms 
JOIN ms_food_year ms2 ON ms.price_year = ms2.price_year + 1 AND ms.product = ms2.product
WHERE (((ms.price / ms2.price) - 1) * 100) > 0
GROUP BY ms.product, ms.price_year, ms2.price_year
ORDER BY (((ms.price / ms2.price) - 1) * 100) ASC;


