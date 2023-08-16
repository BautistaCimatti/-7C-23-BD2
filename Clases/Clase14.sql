1)
SELECT CONCAT(first_name, ' ', last_name) AS customer_name,
       address,
       city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Argentina';

2)
SELECT film.title,
       language.name AS language,
       CASE
           WHEN film.rating = 'G' THEN 'General Audience'
           WHEN film.rating = 'PG' THEN 'Parental Guidance Suggested'
           WHEN film.rating = 'PG-13' THEN 'Parents Strongly Cautioned'
           WHEN film.rating = 'R' THEN 'Restricted'
           WHEN film.rating = 'NC-17' THEN 'Adults Only'
       END AS rating
FROM film
JOIN language ON film.language_id = language.language_id;

3)
SELECT
    CONCAT(ac.first_name, ' ', ac.last_name) AS actor,
    f.title,
    f.release_year
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor ac ON fa.actor_id = ac.actor_id
WHERE CONCAT(ac.first_name, ' ', ac.last_name) LIKE CONCAT('%', UPPER(TRIM('KIRSTEN AKROYD')), '%');

4)
SELECT
    f.title,
    r.rental_date,
    c.first_name,
    CASE
        WHEN r.return_date IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS 'Returned'
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN customer c ON r.customer_id = c.customer_id
WHERE MONTH(r.rental_date) = 5 OR MONTH(r.rental_date) = 6
ORDER BY r.rental_date;

5)
CAST:
La función CAST se utiliza para convertir un valor de un tipo de dato a otro. 

Ejemplo:
SELECT title, CAST(length AS DECIMAL(5, 2)) AS duration_decimal
FROM film;

CONVERT:
La funcion CONVERT hace lo mismo que la funcion CAST. Pero tambien permite la conversión de conjuntos de caracteres.

Ejemplo:
SELECT title, CONVERT(description USING latin1) AS description_latin1
FROM film
LIMIT 10;

6)
NVL: 
Esta función devuelve la primera expresión no nula. Es específica de Oracle y no disponible en MySQL. 

ISNULL: 
Esta función comprueba si una expresión es nula y devuelve un valor especificado si es verdadera. No esta disponible en MySQL.

IFNULL: 
Esta función devuelve la primera expresión si no es nula, de lo contrario, devuelve la segunda expresión. Si esta en MYSQL.

Ejemplo:
SELECT title,
       IFNULL(length, 'Desconocida') AS duracion
FROM film;

COALESCE: 
Devuelve la primera expresión no nula entre sus argumentos. Si esta en MYSQL

Ejemplo:
SELECT title,
       COALESCE(length, 'Desconocida') AS duracion,
       COALESCE(replacement_cost, 0.00) AS costo_reemplazo
FROM film;












