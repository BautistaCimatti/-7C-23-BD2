use sakila;

#Find the films with less duration, show the title and rating.

select title, special_features, length, rating from film where length=(select min(length) from film);

#Write a query that returns the tiltle of the film which duration is the lowest. If there are more than one film with the lowest durtation, the query returns an empty result set.

select title,length from film
where length<all (select min(length) from film);
  
#Generate a report with list of customers showing the lowest payments done by each of them. Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.

select c.first_name,c.last_name,a.address,(select min(amount) from payment p where c.customer_id=p.customer_id ) as paga_min
from customer c join address a on c.address_id = a.address_id order by c.first_name;

#Generate a report that shows the customers information with the highest payment and the lowest payment in the same row.

select c.first_name, c.last_name, a.address, (select min(amount) from payment p where c.customer_id = p.customer_id) as paga_minima, 
(select max(amount) from payment p where c.customer_id = p.customer_id) as paga_maxima
from customer c join address a on c.address_id=a.address_id order by c.first_name;
