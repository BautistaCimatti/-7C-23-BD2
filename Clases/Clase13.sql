USE sakila;

1----------

insert into Customer (store_id, first_name, last_name, email, address_id, active, create_date, last_update)
values (1, 'Jorge', 'Gonzalez', 'jgonzalez@gmail.com',
        (select max(A.address_id)
         from   Address as A
                  inner join City as Ci on A.city_id = Ci.city_id
                  inner join Country Co on Ci.country_id = Co.country_id
         where  Co.country = 'UNITED STATES'), 1, current_time(), CURRENT_TIMESTAMP());


2----------

insert into rental(rental_date,inventory_id,customer_id,return_date,staff_id)
select
    now(), i.inventory_id, c.customer_id, null, s.staff_id
from inventory as i
join film as f using(film_id)
join customer as c on c.customer_id = 1
join staff as s on s.store_id = 2
where f.title = 'ACE GOLDFINGER';

3----------

UPDATE film
SET release_year = 
    CASE rating
        WHEN 'G' THEN '2001'
        WHEN 'PG' THEN '2002'
        WHEN 'PG-13' THEN '2003'
        WHEN 'R' THEN '2004'
	ELSE release_year END;

4----------

select f.film_id
from film as f
inner join inventory as i on i.film_id = f.film_id
inner join rental as r on i.inventory_id = r.inventory_id
where r.return_date > current_date()
order by r.rental_date desc
limit 1;

5----------

DELETE FROM film
WHERE film_id = 1;
#Error por vinculacion y dependencias de foreign keys
#Opcion funcional:
DELETE FROM   rental
WHERE inventory_id   IN   ( SELECT  inventory_id FROM inventory WHERE film_id=1  );

DELETE FROM payment
WHERE   rental_id IN  (SELECT   rental_id  FROM  rental   WHERE  inventory_id   IN   (SELECT  inventory_id FROM inventory WHERE film_id=1));
DELETE FROM film_actor
WHERE film_id=1;
DELETE FROM film_category
WHERE film_id=1;
DELETE FROM inventory
WHERE film_id=1;
DELETE FROM film
WHERE film_id=1;
ROLLBACK;

6---------

insert into RENTAL (RENTAL_DATE, INVENTORY_ID, CUSTOMER_ID, RETURN_DATE, STAFF_ID)
values (current_date(), (select I.INVENTORY_ID
                         from INVENTORY as I
                         where not exists(select *
                                          from RENTAL as R
                                          where R.INVENTORY_ID = I.INVENTORY_ID
                                            and R.RETURN_DATE < current_date())
                         limit 1), 1, current_date(), 1);
                         
insert into PAYMENT (CUSTOMER_ID, STAFF_ID, RENTAL_ID, AMOUNT, PAYMENT_DATE)
values (1, 1, (select last_insert_id()), 10.2, current_date());


