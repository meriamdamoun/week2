UPDATE language SET name= 'Korean' 
WHERE language_id= 3

-- foreign keys defined for the customer table is language_id/address_id/store_id
-- When inserting into the customer table, you must ensure that the foreign key references are valid

drop if exists customer_review
-- we can't drop customer_review cuz it has foreign keys from other tables

SELECT * FROM rental

SELECT COUNT(*) FROM rental WHERE return_date is null

SELECT * FROM film

SELECT f.film_id, f.title, f.description, f.rental_rate
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NULL
ORDER BY f.rental_rate DESC
LIMIT 30;

select * from film

SELECT title 
FROM film f 
JOIN film_actor ac ON f.film_id = ac.film_id 
JOIN actor a ON ac.actor_id = a.actor_id 
WHERE a.first_name = 'Penelope'  AND a.last_name = 'Monroe' AND f.description LIKE '%Sumo Wrestler%';


SELECT title 
FROM film f
JOIN film_category ca ON  ca.film_id = f.film_id
JOIN category c on c.category_id = ca.category_id
WHERE c.name = 'Documentary' AND f.rating = 'R' AND f.length < 60

SELECT  f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON c.customer_id = r.customer_id
JOIN payment p ON p.rental_id = r.rental_id
WHERE c.first_name = 'Matthew' and c.last_name='Mahan'
AND p.amount > 4.00
AND return_date BETWEEN '2005-07-28' AND '2005-08-01'



SELECT f.title, f.replacement_cost
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON c.customer_id = r.customer_id
WHERE c.first_name = 'Matthew' 
AND c.last_name = 'Mahan'
AND (f.title ILIKE '%boat%' OR f.description ILIKE '%boat%') 
ORDER BY f.replacement_cost DESC 
LIMIT 1;
