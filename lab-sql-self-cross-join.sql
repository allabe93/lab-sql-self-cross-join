-- 1. Get all pairs of actors that worked together.
select fa1.actor_id, fa2.actor_id, fa1.film_id
from sakila.film_actor fa1
join sakila.film_actor fa2
on fa1.actor_id > fa2.actor_id
and fa1.film_id = fa2.film_id;

-- 2. Get all pairs of customers that have rented the same film more than one time.
select r1.customer_id, r2.customer_id, r2.film_id

from (select r.customer_id, i.film_id, count(r.rental_id)
from rental r join inventory i
on r.inventory_id = i.inventory_id
group by r.customer_id, i.film_id
having count(r.rental_id) > 1) as r1

join

(select r.customer_id, i.film_id, count(r.rental_id) 
from rental r join inventory i
on r.inventory_id = i.inventory_id
group by r.customer_id, i.film_id
having count(r.rental_id) > 1) as r2

on r1.film_id = r2.film_id and r1.customer_id > r2.customer_id;

-- A more complete and complex way to give solution to the exercise 2:
select r1.customer_id, r1.first_name, r1.last_name, r2.customer_id, r2.first_name, r2.last_name, r2.film_id, f.title

from (select r.customer_id, c.first_name, c.last_name, i.film_id, count(r.rental_id)
from rental r join inventory i
on r.inventory_id = i.inventory_id
join customer c using (customer_id)
group by r.customer_id, i.film_id
having count(r.rental_id) > 1) as r1

join

(select r.customer_id, c.first_name, c.last_name, i.film_id, count(r.rental_id) 
from rental r join inventory i
on r.inventory_id = i.inventory_id
join customer c using (customer_id)
group by r.customer_id, i.film_id
having count(r.rental_id) > 1) as r2

join customer c using (customer_id)
join film f using (film_id)

on r1.film_id = r2.film_id and r1.customer_id > r2.customer_id;

-- 3. Get all possible pairs of actors and films.
select * from (select distinct title from sakila.film) sub1
cross join (select distinct actor_id from sakila.film_actor) sub2;






