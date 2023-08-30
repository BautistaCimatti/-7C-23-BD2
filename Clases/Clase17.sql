/************************************************************
Query 1: Using IN and NOT IN with Postal Codes
************************************************************/

-- Using IN
SELECT a.address, a.postal_code, ci.city, co.country
FROM address AS a
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE a.postal_code IN ('27777', '16123', '16121');
-- Execution time: 12ms

-- Using NOT IN
SELECT a.address, a.postal_code, ci.city, co.country
FROM address AS a
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE a.postal_code NOT IN ('27777', '16123', '16121');
-- Execution time: 5ms

-- Creating an index
CREATE INDEX PostalCode ON address(postal_code);
-- After index creation, first query execution time: 4ms
-- After index creation, second query execution time: 4ms

-- The index improves query performance by allowing the database
-- to access the data better without scanning the full table.


/************************************************************
Query 2: Searching Actor Names
************************************************************/

-- Searching first names
SELECT first_name
FROM actor
ORDER BY first_name;
-- Execution time: 12ms

-- Searching last names
SELECT last_name
FROM actor
ORDER BY last_name;
-- Execution time: 4ms

-- The difference in execution time is bc of an existing index already made
-- on "last_name" but not on "first_name".


/************************************************************
Query 3: Searching Film Descriptions
************************************************************/

-- Searching description using LIKE
SELECT description
FROM film
WHERE description LIKE "%movie%"
ORDER BY description;
-- Execution time: 80ms

-- Creating a FULLTEXT index
CREATE FULLTEXT INDEX FullText_index ON film(description);

-- Searching description using MATCH ... AGAINST
SELECT description
FROM film
WHERE MATCH(description) AGAINST("movie");
-- Execution time: 13ms

-- Explanation: The FULLTEXT index speeds up the search using MATCH ... AGAINST.