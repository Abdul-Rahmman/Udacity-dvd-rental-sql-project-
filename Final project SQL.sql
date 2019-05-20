/*Q1-For total amount what is the percentage for each category ? *\


WITH T1 AS(SELECT c.name category_name, 
           SUM(p.amount) category_amount
           FROM category c
           JOIN film_category fc
           ON c.category_id = fc.category_id
           JOIN film f
           ON f.film_id = fc.film_id
           JOIN inventory i
           ON i.film_id = f.film_id
           JOIN rental r
           ON r.inventory_id = i.inventory_id
           JOIN payment p
           ON p.rental_id = r.rental_id
           GROUP BY 1           
                        )
SELECT T1.category_name,
ROUND(T1.category_amount/(select 
      SUM(payment.amount)
      FROM payment)*100,2) As The_profit_percentage_for_each_category
FROM T1

/*---------------------------------------------------------------------*\

/*Q2-Rank the top 10 customer based on their payments ?*\



WITH T1 AS(SELECT c.first_name || ' ' || c.last_name AS name ,
          SUM(ROUND(p.amount,0)) AS total_amount
          FROM customer c 
          JOIN payment p
          ON c.customer_id = p.customer_id
          GROUP BY 1)
          
SELECT T1.name,T1.total_amount,
       RANK()OVER(ORDER BY T1.total_amount DESC)
FROM T1
LIMIT 10

/*---------------------------------------------------------------------*\


/*Q3-What are top 5 categorys revnue For the store that have most revnue ? *\

WITH T1 AS(SELECT s.store_id Store,
           SUM(p.amount) Total_Amount
           FROM store s
           JOIN staff st
           ON s.store_id = st.store_id
           JOIN payment p
           ON p.staff_id = st.staff_id
           GROUP BY 1
           ORDER BY 2 desc
           LIMIT 1),

T2 AS (SELECT c2.name category,
       st2.store_id store,
       SUM(p2.amount) total_amount
       FROM category c2
       JOIN film_category fc2
       ON c2.category_id=fc2.category_id
       JOIN film f2
       ON fc2.film_id=f2.film_id
       JOIN inventory i2
       ON i2.film_id=f2.film_id
       JOIN rental r2
       ON r2.inventory_id=i2.inventory_id
       JOIN payment p2
       ON p2.rental_id=r2.rental_id
       JOIN staff st2
       ON st2.staff_id=p2.staff_id
       JOIN T1 s2
       ON s2.Store=st2.store_id
       GROUP BY 1,2
       LIMIT 5)

SELECT *
FROM T2

/*---------------------------------------------------------------------*\







