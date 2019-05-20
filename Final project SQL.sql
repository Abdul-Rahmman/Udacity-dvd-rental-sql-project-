


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



