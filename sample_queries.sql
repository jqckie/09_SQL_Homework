-- 1a. display first and last names from actor
USE sakila;
SELECT 
    first_name, last_name
FROM
    actor;

-- 1b. create a column actor_name out of all caps first + last name
-- if "Error Code: 1060. Duplicate column name 'actor_name'"
-- UNCOMMENT line 11 and re-run
-- ALTER TABLE actor DROP COLUMN actor_name;
ALTER TABLE actor ADD COLUMN actor_name VARCHAR(50);
UPDATE actor 
SET 
    actor_name = UPPER(CONCAT(first_name, ' ', last_name));
SELECT 
    actor_name
FROM
    actor;

-- 2a. find the ID number, first name, and last name of actors with first name "Joe"
SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    first_name = 'Joe';

-- 2b. find all actors whose last name contain the letters GEN:
SELECT 
    *
FROM
    actor
WHERE
    last_name LIKE '%GEN%';

-- 2c. find actors with LI in their last name, sorted by last name ascending then first name ascending
SELECT 
    *
FROM
    actor
WHERE
    last_name LIKE '%LI%'
ORDER BY last_name ASC , first_name ASC;

-- 2d. return id and country names for Afghanistan, Bangladesh, and China via IN
SELECT 
    country_id, country
FROM
    country
WHERE
    country IN ('Afghanistan' , 'Bangladesh', 'China');

-- 3a. add new column named description with blob type & show column list
ALTER TABLE actor 
ADD description BLOB;
SHOW COLUMNS FROM actor;

-- 3b. delete column description & show column list
ALTER TABLE actor
DROP COLUMN description;
SHOW COLUMNS FROM actor;

-- 4a. return last names of all actors with their counts
SELECT 
    last_name, COUNT(1) AS count
FROM
    actor
GROUP BY last_name
ORDER BY count DESC;

-- 4b. return last names of all actors where >= 2 actors share the last name
SELECT 
    last_name, COUNT(1) AS count
FROM
    actor
GROUP BY last_name
HAVING COUNT(*) >= 2
ORDER BY count DESC;

-- 4c. change first name for groucho williams to harpo
UPDATE actor 
SET 
    first_name = 'HARPO'
WHERE
    first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
-- NOTE: if actor_name column is still present, that should be updated as well

-- 4d. change first name for harpo williams back to groucho
UPDATE actor 
SET 
    first_name = 'GROUCHO'
WHERE
    first_name = 'HARPO' AND last_name = 'WILLIAMS';
-- NOTE: if actor_name column is still present, that should be updated as well

-- 5a. display settings for the address table
SHOW CREATE TABLE address;

-- 6a. return first name, last name, and address for each staff member by using join
SELECT 
    staff.first_name, staff.last_name, address.address
FROM
    staff
        LEFT JOIN
    address ON staff.address_id = address.address_id;

-- 6b.  display totals by staff member for august 2005 sales using join
SELECT 
    s.first_name, s.last_name, SUM(p.amount) AS 'Total'
FROM
    staff AS s
        JOIN
    payment AS p ON s.staff_id = p.staff_id
		AND p.payment_date LIKE '2005-08%'
GROUP BY s.staff_id;

-- 6c. return all films with a count of actors in each film
SELECT 
    film.title, COUNT(film_actor.actor_id)
FROM
    film
        RIGHT JOIN
    film_actor USING (film_id)
GROUP BY film.title;

-- 6d. display the number of hunchback impossible in inventory
SELECT 
    COUNT(film_id) AS 'Hunchback Impossible Inventory'
FROM
    inventory
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'Hunchback Impossible');

-- 6e. return totals paid by each customer in last name order
SELECT 
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS 'Total'
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY customer_id
ORDER BY last_name ASC;

-- 7a. return all movies beginning with K or Q that have language of english via subqueries
SELECT 
    title
FROM
    film
WHERE
    title LIKE 'K%'
        OR title LIKE 'Q%'
        AND language_id = (SELECT 
            language_id
        FROM
            language
        WHERE
            name = 'English');

-- 7b. display all actor names for alone trip
SELECT 
    actor.first_name, actor.last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));
                    
-- 7c. return the names and email addresses of all Canadian customers via joins
SELECT 
    first_name, last_name, email
FROM
    customer
WHERE
    address_id IN (SELECT 
            address_id
        FROM
            address
        WHERE
            city_id IN (SELECT 
                    city_id
                FROM
                    city
                WHERE
                    country_id IN (SELECT 
                            country_id
                        FROM
                            country
                        WHERE
                            country = 'Canada')));

-- 7d.  find all movies categorized as family films
SELECT 
    title as 'Family Films'
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'Family'));

-- 7e. list the most frequently rented movies in descending order
SELECT film.title as 'Movie', COUNT(rental.rental_id) as 'Total Rentals'
FROM film
	JOIN inventory
	USING (film_id)
		JOIN rental
		USING (inventory_id)
GROUP BY film.title
ORDER BY COUNT(rental.rental_id) DESC;

-- 7f. display how much business, in dollars, each store brought in.
-- can we assume the amounts listed are in USD, or would we be converting from canadian/australian dollars?
SELECT 
    staff.store_id AS 'Store #',
    SUM(payment.amount) AS 'Business'
FROM
    staff
        JOIN
    payment USING (staff_id)
GROUP BY staff.store_id;

-- 7g. display for each store its store ID, city, and country.
SELECT 
    store.store_id AS 'Store',
    city.city AS 'City',
    country.country AS 'Country'
FROM
    store
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
        JOIN
    country USING (country_id);


-- 7h. list the top five genres in gross revenue in descending order
SELECT category.name as 'Genre', SUM(payment.amount) as 'Gross Revenue'
FROM category
	JOIN film_category
	USING (category_id)
		JOIN inventory
		USING (film_id)
			JOIN rental
			USING (inventory_id)
				JOIN payment
                USING(rental_id)
GROUP BY category.name
ORDER BY SUM(payment.amount)
LIMIT 5;

-- 8a. Use the solution from the problem above to create an easy way of viewing the Top five genres by gross revenue.. 
CREATE VIEW top_five_genres 
AS SELECT category.name as 'Genre', SUM(payment.amount) as 'Gross Revenue'
FROM category
	JOIN film_category
	USING (category_id)
		JOIN inventory
		USING (film_id)
			JOIN rental
			USING (inventory_id)
				JOIN payment
                USING(rental_id)
GROUP BY category.name
ORDER BY SUM(payment.amount)
LIMIT 5;

-- 8b. display top_five_genres view
SELECT * FROM top_five_genres;

-- 8c. delete top_five_genres view
DROP VIEW top_five_genres;
