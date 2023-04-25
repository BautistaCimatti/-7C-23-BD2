/*
List all the actors that share the last name. Show them in order
Find actors that don't work in any film
Find customers that rented only one film
Find customers that rented more than one film
List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'*/
 
USE sakila;
 
#1)-
select first_name, last_name 
FROM actor a 
WHERE EXISTS (
SELECT * 
FROM actor b
WHERE
	a.last_name=b.last_name
	AND a.actor_id<>b.actor_id) ORDER BY a.last_name;

#2)-
select first_name,last_name
FROM actor a
WHERE NOT EXISTS
(select *
 FROM film_actor fa
 WHERE a.actor_id=fa.actor_id);
  
#3)-
select first_name,last_name
FROM customer c
WHERE 1 =
(select count(*)
 FROM rental r
 WHERE c.customer_id=r.customer_id);
 
#4)-
select first_name,last_name
FROM customer c
WHERE 1 <
(select count(*)
 FROM rental r
 WHERE c.customer_id=r.customer_id);

#5)-
select first_name, last_name 
FROM actor a 
WHERE EXISTS (
SELECT * 
FROM film f INNER JOIN film_actor fa ON f.film_id=fa.film_id
WHERE
	f.film_id=fa.film_id and
	a.actor_id=fa.actor_id and
	(f.title="BETRAYED REAR" or
	f.title="CATCH AMISTAD"));

#6)-
select first_name, last_name 
FROM actor a 
WHERE EXISTS (
SELECT title
FROM film f INNER JOIN film_actor fa ON f.film_id=fa.film_id
WHERE
	f.film_id=fa.film_id and
	a.actor_id=fa.actor_id and f.title="BETRAYED REAR")
AND NOT EXISTS (
SELECT title
FROM film f INNER JOIN film_actor fa ON f.film_id=fa.film_id
WHERE
	f.film_id=fa.film_id and
	a.actor_id=fa.actor_id and f.title="CATCH AMISTAD");
	
#7)-
select first_name, last_name 
FROM actor a 
WHERE EXISTS (
SELECT title
FROM film f INNER JOIN film_actor fa ON f.film_id=fa.film_id
WHERE
	f.film_id=fa.film_id and
	a.actor_id=fa.actor_id and
	f.title="BETRAYED REAR")
AND EXISTS(
SELECT title
FROM film f INNER JOIN film_actor fa ON f.film_id=fa.film_id
WHERE
	f.film_id=fa.film_id and
	a.actor_id=fa.actor_id and
	f.title="CATCH AMISTAD");	
	
#8)-
SELECT actor_id, first_name, last_name
FROM actor a
WHERE NOT EXISTS(
SELECT title
FROM film f INNER JOIN film_actor fa ON f.film_id = fa.film_id
WHERE
	f.film_id = fa.film_id
	AND a.actor_id = fa.actor_id
	AND (f.title = 'BETRAYED REAR'
	     OR f.title = 'CATCH AMISTAD'));
