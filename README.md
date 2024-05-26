ZADÁNÍ PROJEKTU
Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.
Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.
Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.
Datové sady, které je možné použít pro získání vhodného datového podkladu
Primární tabulky:
1.	czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
2.	czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
3.	czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
4.	czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
5.	czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
6.	czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
7.	czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.
Číselníky sdílených informací o ČR:
1.	czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
2.	czechia_district – Číselník okresů České republiky dle normy LAU.
Dodatečné tabulky:
1.	countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
2.	economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.



POSTUP
Primary
VIEW msp_payroll_category vytvoří jen data týkající se platů.
VIEW msp_food_average data týkající se cen. 
Finalní datový zdroj monsimko_primary je pak vytvořen kombinací těchto dvou VIEW. 
Důvodem je dlouhé zpracování příkazu, když jsem všechny tabulky kombinovala najednou. Tímto zadáním se zkrátila doba zpracování. 

Secondary
Kombinace tabulek s údaji o ekonomikách a státech.

První úkol
VIEW ms_payroll_industry vytváří tabulku s průměrnými platy v jednotlivých odvětvích. 
V následujícím SELECT pak joinujeme tabulku jen samu se sebou (mp.payroll_year = mp2.payroll_year + 1), čímž si můžeme vedle sebe zobrazit hodnoty pro současný a předchozí rok. 
Podmínka WHERE pak ukazuje rok a odvětví, kdy průměrné mzdy byly proti předchozímu roku nižší.

Druhý úkol
VIEW ms_payroll_foodprice skládá dohromady informace o platech a potravinách, abychom je mohli následně porovnat. 
VIEW ms_bread_milk_only pak ze stejného VIEW vybírá jen hodnoty pro mléko a chléb, což jsou jediné dvě informace, které nás zajímají. Důvod rozložení do dvou VIEW je pomalost dotazů, pokud bychom vše dali do jednoho souhrnného SELECT. Finální SELECT pak porovnává, kolik kg chleba a kolik litrů mléka si je možné koupit v prvním a posledním dostupném roce mezd.





Třetí úkol
VIEW ms_food_year nabízí informace o cenách potravin v jednotlivých letech. V následném SELECT pak joinujeme tabulku samu se sebou, abychom si vedle sebe mohli porovnat předchozí a současná data. Protože dotaz je pouze na zdražování, přidala jsem podmínku: 
odchylka musí být >0 (některé potraviny totiž v průběhu let zlevňovaly) a srovnala jsem výsledky podle velikosti odchylky vzestupně.

Čtvrtý úkol
Na začátku tohoto úkolu si vytvoříme tři pomocné VIEWs. 
ms_avgprice_year zobrazuje informace o průměrných cenách v rámci jednoho roku (průměrná cena napříč všemi potravinami), 
ms_avgpayroll_year průměrné mzdy napříč všemi odvětvími. 
ms_avgprice_avgpayroll_year pak kombinuje tyto dvě tabulky a slučuje je do jedné, kde vidíme průměrné hodnoty pro mzdy i potraviny v konkrétním roce. 
Ve finálním SELECT pak třetí VIEW joinujeme samo se sebou, abychom mohli zobrazit hodnoty pro vývoj mezi lety. 
Podmínkou WHERE si porovnáme rozdíl mezi růstem cen a růstem mezd.

Pátý úkol
V tomto úkolu využijeme VIEW ms_payroll4_3 z minulého úkolu, ve kterém jsme zobrazovali průměrné hodnoty pro mzdy a potraviny v jednotlivých letech. 
Ve VIEW ms_yearlydifferences z těchto hodnot vypočítáme odchylky. 
Ve VIEW ms_gdp_year si vytvoříme podobnou tabulku jako v sekundárním datovém podkladu. 
Ve finálném SELECT pak tyto tabulky zkombinujeme a první VIEW zároveň opět joinujeme samo se sebou, abychom mohli vedle sebe zobrazit hodnoty z vice let. 





VÝSLEDKY
1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Tuto hypotézu nelze stoprocentně potvrdit ani vyvrátit. Ačkoliv obecně mzdy ve všech odvětvích měly vzrůstající tendenci, docházelo v některých odvětvích k drobným poklesům v průběhu let. Ač tedy mzdy ve všech odvětvích vzrostly, nedocházelo u žádného odvětví ke stabilnímu neustálemu růstu.
2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
Jednalo se o 1136 kg chleba a 1370 l mléka v roce 2006 a 1295 kg chleba a 1644 l mléka v roce 2018, spotřebitelé si tedy polepšili.
3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
Nejpomaleji zdražoval mezi lety 2008 a 2009 rostlinný roztíratelný tuk, zhruba o 0,016 %. Některé potraviny však ještě zlevňovaly, Rajská jablka červená kulatá mezi roky 2006 a 2007 dokonce o něco přes 30%.

4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Můžeme potvrdit, že růst potravin nikdy nebyl vyšší než 10 %. Mezi lety 2008 a 2009 se však hranici 10 % výrazně přiblížil.

5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
Pro výpočet růstu HDP používáme geometrický průměr. Z vyhodnocených dat nelze vysloveně prokázat, že by růst HDP měl vliv na růst cen potravin a výšku mezd. V roce 2009, kdy HDP meziročně kleslo, klesaly sice i ceny, ale mzdy rostly v daném i následujícím roce. Naopak v letech 2012 a 2013 HDP lehce klesalo, ale ceny rostly o více než 5 % ročně. Přímou úměru mezi těmito jevy tedy nelze prokázat.
