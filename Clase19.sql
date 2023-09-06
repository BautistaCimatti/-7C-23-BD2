--Create a user data_analyst

CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'pepe1234';


--Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.

GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';


--Login with this user and try to create a table. Show the result of that operation.

mysql -u data_analyst -p pepe1234
CREATE TABLE tabla (
  id INT PRIMARY KEY,
  name VARCHAR(20)
);
--El usuario no tiene permisos para crear tablas.


--Try to update a title of a film. Write the update script.

UPDATE sakila.film
SET title = 'Harry Potter' WHERE film_id = 1234;


--With root or any admin user revoke the UPDATE permission. Write the command

REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';


--Login again with data_analyst and try again the update done in step 4. Show the result.

mysql -u data_analyst -p pepe1234

UPDATE sakila.film
SET title = 'Harry Potter' WHERE film_id = 1234;

--El usuario ahora ya no tiene permisos para actualizar tablas.
