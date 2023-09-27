use sakila;

-- Ej1
DELIMITER //

CREATE FUNCTION ObtenerCopias(film_id INT, store_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA BEGIN
  DECLARE copies_count INT;
  SELECT COUNT(*) INTO copies_count
  FROM inventory AS i
  WHERE i.film_id = film_id
  AND i.store_id = store_id;  
  RETURN copies_count;
  END;
//
DELIMITER;


SELECT ObtenerCopias(1, 1);

-- Ej2
select * from country;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerClientes;
CREATE PROCEDURE ObtenerClientes(IN p_pais VARCHAR(50), OUT p_lista_clientes VARCHAR(1000))
BEGIN
    DECLARE hecho INT DEFAULT 0;
    DECLARE nombre VARCHAR(255);
    DECLARE clientes_pais CURSOR FOR
        SELECT CONCAT(c.first_name, ' ', c.last_name)
        FROM customer c
        INNER JOIN address a ON c.address_id = a.address_id
        INNER JOIN city ci ON a.city_id = ci.city_id
        INNER JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = p_pais;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET hecho = 1; 
    SET p_lista_clientes= '';
    OPEN clientes_pais;
    FETCH clientes_pais INTO nombre;
    WHILE NOT hecho DO
        IF p_lista_clientes = '' THEN
            SET p_lista_clientes = nombre;
        ELSE
            SET p_lista_clientes = CONCAT(p_lista_clientes, ';', nombre);
        END IF;
        
        FETCH clientes_pais INTO nombre;
    END WHILE;
    
    CLOSE clientes_pais;
END //
DELIMITER ;

CALL ObtenerClientes('Argentina', @lista_clientes);
SELECT @lista_clientes;


-- Ej3

-- inventory_in_stock:
-- función SQL que requiere dos parámetros: p_film_id (que corresponde al ID de la película) y p_store_id
-- La función devuelve un valor booleano que señala si una película se encuentra disponible en una tienda en particular.

-- film_in_stock:
-- Este procedimiento es para comprobar la disponibilidad de una película en una tienda 
-- Si es asi, se traen los detalles tanto de la película como del inventario correspondiente.
