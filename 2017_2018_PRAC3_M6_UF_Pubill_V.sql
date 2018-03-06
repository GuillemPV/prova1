USE pubs_copia


/*1.-*/
SELECT (a.au_fname + ' ' + a.au_lname) AS 'Nom Complet',a.address,a.phone, COUNT (a.au_id) AS 'QuantsSon'
FROM authors a INNER JOIN titleauthor t ON a.au_id = t.au_id
INNER JOIN titles ti ON t.title_id = ti.title_id
WHERE ti.title LIKE '%of%'
GROUP BY au_fname,au_lname,address, phone WITH ROLLUP
/*Resultat: Son 3 autors,13 linies*/
/*2.-*/
SELECT SUM(qty*price) AS 'Import',ord_date,st.stor_id
FROM sales s INNER JOIN
titles t ON s.title_id = t.title_id INNER JOIN
stores st ON s.stor_id = st.stor_id
WHERE st.state NOT LIKE 'WA' AND DATEPART(YEAR, ord_date ) % 2 = 0
GROUP BY ord_date,st.stor_id
HAVING SUM(qty*price) > 100
/*Resultat: 4 linies*/
/*3.-*/
SELECT AVG(qty*price) AS 'Import',p.city,DATEPART (YEAR,ord_date) AS 'Any',DATEPART (MONTH,ord_date) AS 'Mes'
FROM sales s INNER JOIN
titles t ON s.title_id = t.title_id INNER JOIN
publishers p ON t.pub_id = p.pub_id
WHERE (qty*price) > 130
GROUP BY city,DATEPART (MONTH,ord_date),DATEPART (YEAR,ord_date) WITH ROLLUP
/*Resultat: 22 linies*/
/*4.-*/
SELECT COUNT(qty*price) AS 'Total', MAX(qty*price) AS 'Màxim',MIN(qty*price) AS 'Mínim', MAX(qty*price) / 2 AS 'Mitjà',city
FROM sales s INNER JOIN
titles t ON s.title_id = t.title_id INNER JOIN
stores st ON s.stor_id = st.stor_id
GROUP BY city,st.stor_id WITH ROLLUP
HAVING MAX(qty*price) / 2 > 100
/*Resultat: 11 linies*/
/*5.-*/
SELECT t.type,SUM(qty*price) AS 'Total'
FROM sales s INNER JOIN
titles t ON s.title_id = t.title_id
WHERE DAY(pubdate) < 16
GROUP BY type WITH ROLLUP
ORDER BY type ASC
/*Resultat: 6 linies, Total 4194*/
/*6.-*/
SELECT p.pub_name, MONTH(s.ord_date) AS Mes,COUNT(s.title_id) AS 'Numero de Llibres Venuts'
FROM sales s INNER JOIN
titles t ON s.title_id = t.title_id INNER JOIN 
publishers p ON t.pub_id = p.pub_id
WHERE YEAR(s.ord_date) = 1993
GROUP BY p.pub_name,MONTH(s.ord_date) WITH ROLLUP

/*Resultat: 11 linies,Numero de llibres venuts 10*/
/*7.-*/
SELECT p.pub_name, AVG(price) AS 'Preu Mitg'
FROM publishers p INNER JOIN
titles t ON p.pub_id = t.pub_id INNER JOIN
sales s ON t.title_id = s.title_id
WHERE  DATEPART(MONTH,t.pubdate) BETWEEN 7 AND 12 AND DATEPART(YEAR,t.pubdate) = 1991
GROUP BY p.pub_name
/*Resultat: 2 linies*/
/*8.-*/
SELECT t.title,SUM(qty*price) AS 'Import de vendes'
FROM sales s INNER JOIN
titles t ON s.title_id = t.title_id
WHERE DATEDIFF (DAY,t.pubdate,s.ord_date) <= 365
GROUP BY t.title
ORDER BY 'Import de vendes' ASC
/*Resultat: Lines 2*/
/*9.-*/
SELECT au_fname + ' ' + au_lname AS 'Nom Complet',DATEPART (YEAR,ord_date) AS 'Any',
SUM(qty*price) AS 'Import',CAST(((SUM(s.qty * t.price)) * 0.01) AS DECIMAL(10,2)) AS '1% de les vendes'
FROM authors a INNER JOIN
titleauthor ti ON a.au_id = ti.au_id INNER JOIN
titles t ON ti.title_id = t.title_id INNER JOIN
sales s ON t.title_id = s.title_id
GROUP BY DATEPART (YEAR,s.ord_date),au_fname + ' ' + au_lname WITH ROLLUP
ORDER BY au_fname + ' ' + au_lname,DATEPART (YEAR,s.ord_date)
/*Resultat: 26 linies, Import 10609,10*/
/*10.-*/
SELECT p.pub_name,COUNT(t.title) AS 'Número de llibres'
FROM publishers p INNER JOIN
titles t ON t.pub_id = p.pub_id
WHERE t.price > 10
GROUP BY p.pub_name
ORDER BY COUNT(t.title) DESC
/*Resultat: 3 linies*/
/*11.-*/
SELECT p.pub_name,t.title_id + t.title AS 'Titol', SUM(qty * price) AS 'Import', AVG(qty * price) AS 'Preu Mitj', MAX(qty * price) AS 'Import Maxim',
MIN(qty * price) AS 'Import Mínim', COUNT(qty * price) AS 'Numero total de vendes'
FROM sales s INNER JOIN
titles t ON s.title_id = t.title_id INNER JOIN
publishers p ON t.pub_id = p.pub_id
WHERE s.ord_date = '29/05/1993'
GROUP BY p.pub_name,t.title_id + t.title WITH ROLLUP
/*Resultat: 7 linies, Import 1106.40,Preu mitj 276.60,Import Maxim 43.80,Import Minim 175,Numero total de vendes 4*/