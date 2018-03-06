USE pubs

/*1.-*/
SELECT * 
FROM stores
ORDER BY stor_name
/*2.-*/
SELECT au_lname,au_fname,phone,city,state
FROM authors
ORDER BY au_lname
/*3.-*/
SELECT au_lname,au_fname,phone,city,state
FROM authors
WHERE state = 'CA'
ORDER BY au_lname
/*4.-*/
SELECT title,type,pub_id,ytd_sales
FROM titles
WHERE ytd_sales > '8000' AND ytd_sales < 15000
ORDER BY title
/*5.-*/
SELECT title,type,pub_name,ytd_sales
FROM titles t INNER JOIN publishers p ON t.pub_id = p.pub_id
WHERE ytd_sales > '8000' AND ytd_sales < 15000
ORDER BY title
/*6.-*/
SELECT title,type,pub_name,ytd_sales,a.au_fname
FROM publishers p INNER JOIN titles t ON p.pub_id = t.pub_id INNER JOIN titleauthor ti ON  t.title_id = ti.title_id 
INNER JOIN authors a ON ti.au_id = a.au_id
WHERE ytd_sales > '8000' AND ytd_sales < 15000
ORDER BY title
/*7.-*/
SELECT au_fname,au_lname,title
FROM titles t INNER JOIN titleauthor ti ON t.title_id = ti.title_id INNER JOIN authors a ON ti.au_id = a.au_id
ORDER BY au_lname
/*8.-*/
SELECT title,type,ord_num,ord_date,stor_id
FROM titles t INNER JOIN sales s ON t.title_id = s.title_id
WHERE s.ord_date = '14/09/94'
/*9.-*/
SELECT title,type,ord_num,ord_date,st.stor_name
FROM titles t INNER JOIN sales s ON t.title_id = s.title_id INNER JOIN stores st ON s.stor_id = st.stor_id
WHERE s.ord_date = '14/09/94'
/*10.-*/
SELECT stor_name,state,ord_num,ord_date,title
FROM titles t INNER JOIN sales s ON t.title_id = s.title_id INNER JOIN stores st ON s.stor_id = st.stor_id
WHERE state = 'WA'
/*11.-*/
SELECT COUNT(au_id) AS 'Número d autors'
FROM authors
WHERE state = 'MD'