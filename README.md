# SQL Sample Queries

## Instructions

* Open [sample_queries.sql](sample_queries.sql) to review sample queries from the Sakila DB

## Details

* 1a. Displaying the first and last names of all actors from the table `actor`.

* 1b. Displaying the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.

* 2a. Finding the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 

* 2b. Finding all actors whose last name contain the letters `GEN`:

* 2c. Finding all actors whose last names contain the letters `LI` and sorting the results by last name then first name

* 2d. Displaying the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China

* 3a. Creating a column in the table `actor` named `description` and use the data type `BLOB`

* 3b.Deleting the `description` column.

* 4a. Listing the last names of actors, as well as how many actors have that last name.

* 4b. Listing last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

* 4c. Writing a query to locate the actor `GROUCHO WILLIAMS` and updating the actor's name to `HARPO WILLIAMS`

* 4d. Writing a follow-up query to undo the name change from `GROUCHO WILLIAMS` to `HARPO WILLIAMS`

* 5a. Writing a query to recreate the schema of the `address` table. 

* 6a. Using `JOIN` to display the first and last names, as well as the address, of each staff member from the tables `staff` and `address`

* 6b. Using `JOIN` to display the total amount rung up by each staff member in August of 2005 from the tables `staff` and `payment`.

* 6c. Listing each film and the number of actors who are listed for that film from the tables `film_actor` and `film` via inner join.

* 6d. Listing the number of copies of the film `Hunchback Impossible` exist in the inventory system.

* 6e. Using the tables `payment` and `customer` and the `JOIN` command to list the total paid by each customer, and displaying the results alphabetically by customer last name

* 7a. Using subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.

* 7b. Using subqueries to display all actors who appear in the film `Alone Trip`.

* 7c. Using joins to retrieve the names and email addresses of all Canadian customers.

* 7d. Identifying all movies categorized as _family_ films.

* 7e. Displaying the most frequently rented movies in descending order.

* 7f. Querying to display how much business, in dollars, each store brought in.

* 7g. Querying to display for each store its store ID, city, and country.

* 7h. Listing the top five genres in gross revenue in descending order using the tables category, film_category, inventory, payment, and rental.

* 8a. Creating a view for the previous query. 

* 8b. Displaying the newly created `top_five_genres` view.

* 8c. Deleting the newly created `top_five_genres` view. 
