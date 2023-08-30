
-- Exercise 1: Find all the film titles that are not in the inventory.
SELECT title
FROM film
WHERE film_id NOT IN (SELECT DISTINCT film_id FROM inventory);

-- Exercise 2: Find all the films that are in the inventory but were never rented.
SELECT f.title, i.inventory_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

-- Exercise 3: Generate a report with customer rental details.
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    r.store_id,
    f.title,
    r.rental_date,
    r.return_date
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
ORDER BY r.store_id, c.last_name;

-- Exercise 4: Show sales per store (revenue from rented films).
SELECT s.store_id, SUM(p.amount) AS `Ventas totales`
FROM store AS s
INNER JOIN inventory AS i ON s.store_id = i.store_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
INNER JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY s.store_id;

-- Exercise 5: Find the actor who has appeared in the most films.
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS nombre, COUNT(fa.film_id) AS cantidad
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY cantidad DESC
LIMIT 1;
