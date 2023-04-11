/*  1-Show title and special_features of films that are PG-13
    2-Get a list of all the different films duration.
    3-Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
    4-Show title, category and rating of films that have 'Behind the Scenes' as special_features
    5-Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
    6-Show the address, city and country of the store with id 1
    7-Show pair of film titles and rating of films that have the same rating.
    8-Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).*/

USE sakila;
select title,special_features from film where rating="PG-13";

select title,length from film;

select title,rental_rate,replacement_cost from film where replacement_cost between 20 and 24;

select f.title, f.rating , c.name from film f inner join film_category fc on f.film_id=fc.film_id join category c on fc.category_id=c.category_id where special_features = "Behind the Scenes";

select a.first_name, a.last_name, f.title from actor a join film_actor fa on a.actor_id = fa.actor_id join film f on fa.film_id = f.film_id where f.title = 'ZOOLANDER FICTION';

select a.address,c.city,co.country from store s join address a on a.address_id=s.address_id join city c on a.city_id=c.city_id join country co on c.country_id=co.country_id where s.store_id = "1";

select f1.title,f2.title,f2.rating from film f1,film f2 where f1.rating=f2.rating and f1.title<>f2.title;

select s.first_name as "Nombre", s.last_name as "Apellido", f.title as "Titulo de Pelicula" from staff s join store st on s.staff_id = st.store_id join inventory i on st.store_id = i.store_id join film f on i.film_id = f.film_id where st.store_id = 2;
