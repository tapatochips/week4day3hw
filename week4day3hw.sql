-- 1. List all customers who live in Texas (use
-- JOINs)
SELECT first_name, last_name FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE address.district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full
-- Name
SELECT CONCAT(customer.first_name, ' ', customer.last_name) as customer_name, payment.amount
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
WHERE payment.amount > 6.99;
--i use join to link the customer and payment tables together, i combined first and last name to a new column, then after that i use where to get the payment amount portion answered


-- 3. Show all customers names who have made payments over $175(use
-- subqueries)
SELECT CONCAT(customer.first_name, ' ', customer.last_name) as customer_name
FROM customer
WHERE customer.customer_id IN (
  SELECT payment.customer_id
  FROM payment
  WHERE payment.amount > 175
);
--here its essentially the same thing as question 2 except with the addtion of subqueries 


-- 4. List all customers that live in Nepal (use the city
-- table)
SELECT first_name, last_name FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE address.district = 'Nepal';
--this question is the same as question 1 so i just changed texas to nepal


-- 5. Which staff member had the most
-- transactions?
SELECT staff.first_name, staff.last_name, COUNT(payment.payment_id) as num_transactions
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY num_transactions DESC
LIMIT 1;
--once again i select the name, join the staff and payment table use count to count the num transactions and have it give me the employee who had the most.


-- 6. How many movies of each rating are
-- there?
SELECT rating, COUNT(*) as num_movies
FROM film
GROUP BY rating;
--i select rating from film and use count as num movies and group them by rating.

-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
SELECT CONCAT(customer.first_name, ' ', customer.last_name) as customer_name
FROM customer
WHERE customer.customer_id IN (
  SELECT payment.customer_id
  FROM payment
  WHERE payment.amount > 6.99
  GROUP BY payment.customer_id
  HAVING COUNT(*) = 1
);
--this question is very similar to question 3, we just add on group by and having count to get the names of customers who have only made a single payment above 6.99


-- 8. How many free rentals did our store give away?
SELECT SUM(payment.amount) as total_amount_charged
FROM rental
JOIN payment ON rental.rental_id = payment.rental_id
WHERE payment.amount = 0.00;
--quite possibly couldve of coded this wrong, however when i run it i get NULL, it is also quite possible for a store to not give out free stuff lol, so maybe its just my brain playing games on me.
