1-

CREATE VIEW list_of_customers AS
SELECT c.customer_id, 
	c.first_name, 
	c.last_name, 
	a.`address`, 
	a.postal_code, 
	a.phone, 
	ci.city, 
	co.country, 
	if (c.active, 'active', '') AS `status`,
	c.store_id
FROM customer c
JOIN `address` a USING(address_id)
JOIN city ci USING(city_id)
JOIN country co USING(country_id);

SELECT * FROM list_of_customers;

2-

CREATE VIEW film_details AS
SELECT f.film_id,
	f.title,
	f.description,
	ca.name,
	f.rental_rate,
	f.length,
	f.rating,
	group_concat(
		concat(
		    a.fist_name,
		    ' ',
		    a.last_name
		)
		ORDER BY
		    a.fist_name SEPARATOR ', '
	) AS actors
FROM film f
JOIN film_category fc USING(film_id)
JOIN category ca USING(category_id)
JOIN film_actor fa USING(film_id)
JOIN actor a USING(actor_id)
GROUP BY f.film_id, ca.name;

SELECT * FROM film_details;

3-

CREATE VIEW sales_by_film_category AS
SELECT
    ca.name AS category,
    sum(p.amount) AS total_sales
FROM payment p
JOIN rental r USING(rental_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
JOIN film_category fc USING(film_id)
JOIN category ca USING(category_id)
GROUP BY ca.`name`
ORDER BY total_sales;

SELECT * FROM sales_by_film_category;

4-

CREATE VIEW actor_information AS
SELECT
    a.actor_id as actor_id,
    a.first_name as first_name,
    a.last_name as last_name,
    COUNT(film_id) as films
FROM actor a
JOIN film_actor fa USING(actor_id)
GROUP BY
    a.actor_id,
    a.first_name,
    a.last_name;

SELECT * FROM actor_information;    

5-

Esta vista es responsable de devolver la siguiente información de un actor:

    ID del actor
    Nombre del actor
    Apellido del actor
    Lista de películas en las que ha actuado, ordenadas por categoría
    Nombre de las películas en las que ha actuado, dentro de cada categoría

6-

Una materialized view es una tabla que contiene una instantánea de los resultados de una consulta. Las materialized views se pueden utilizar para mejorar el rendimiento de las consultas que se ejecutan con frecuencia, ya que el motor de base de datos no tiene que volver a ejecutar la consulta cada vez que se necesita.
Las materialized views pueden ser una herramienta muy útil para mejorar el rendimiento de las consultas en MySQL. Sin embargo, es importante tener en cuenta que las materialized views pueden ocupar mucho espacio en la base de datos, por lo que es importante crearlas solo cuando sea necesario.
		    
