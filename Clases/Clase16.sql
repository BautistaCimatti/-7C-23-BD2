-- Activo: 1682515061137@@127.0.0.1@3306@sakila
-- 1. Insertar un nuevo empleado, pero con un email nulo. Explicar lo que ocurre.
CREATE TABLE
    `employees` (
        `employeeNumber` int(11) NOT NULL,
        `lastName` varchar(50) NOT NULL,
        `firstName` varchar(50) NOT NULL,
        `extension` varchar(10) NOT NULL,
        `email` varchar(100) DEFAULT NULL, -- Cambiado de NOT NULL a DEFAULT NULL
        `officeCode` varchar(10) NOT NULL,
        `reportsTo` int(11) DEFAULT NULL,
        `jobTitle` varchar(50) NOT NULL,
        PRIMARY KEY (`employeeNumber`)
    );

INSERT INTO
    employees (
        employeeNumber,
        lastName,
        firstName,
        extension,
        email,
        officeCode,
        reportsTo,
        jobTitle
    )
VALUES (
        100,
        'Francisco',
        'Giayetto',
        'x123',
        NULL, -- Aquí se puede insertar un valor NULL en la columna email
        '----',
        NULL,
        'ADMIN'
    );
-- Habrá un error si la columna email no se cambia a DEFAULT NULL

-- 2. Insertar y actualizar empleados
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES (100, 'Smith', 'sr', 'x321', 'srsmith@mail.com', '---', 11, 'ADMIN');
UPDATE employees SET employeeNumber = employeeNumber - 20; -- Cambia el valor de employeeNumber restando 20
SELECT * FROM employees;
UPDATE employees SET employeeNumber = employeeNumber + 20; -- Cambia el valor de employeeNumber sumando 20

-- 3. Agregar una columna de edad a la tabla de empleados con restricción de rango
ALTER TABLE employees
ADD COLUMN age INT CHECK (age >= 16 AND age <= 70);

-- 4. Describir la integridad referencial entre las tablas film, actor y film_actor en la base de datos sakila.
-- Esto ya está bien explicado.

-- 5. Agregar columna lastUpdate a la tabla de empleados y usar triggers para mantenerla actualizada
ALTER TABLE employees
ADD COLUMN lastUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE employees
ADD COLUMN lastUpdateUser VARCHAR(50);

DELIMITER //
CREATE TRIGGER update_lastUpdate
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_lastUpdateUser
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    SET NEW.lastUpdateUser = USER(); -- Corregido para actualizar lastUpdateUser
END;
//
DELIMITER ;

-- 6. Encontrar todos los triggers en la base de datos sakila relacionados con la tabla film_text.
SHOW TRIGGERS LIKE 'film_text';
-- No se encontraron resultados para los triggers relacionados con la tabla film_text.

