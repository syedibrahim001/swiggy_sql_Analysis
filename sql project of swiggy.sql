SELECT * FROM swiggydb.restaurants;

select customer_id,name,city
from customers
where city="delhi";


select city,avg(rating)
from restaurants
group by city;
having city="mumbai";


SELECT city, round(AVG(rating),2) AS average_rating
FROM restaurants
WHERE city = 'Mumbai'
GROUP BY city;

select distinct(o.customer_id),c.name
from orders as o
join customers as c
on o.customer_id=c.customer_id;

SELECT 
    o.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM 
    customers AS c
left JOIN 
    orders AS o ON c.customer_id = o.customer_id
GROUP BY 
    o.customer_id, c.name
ORDER BY 
    total_orders DESC;


#SELECT *,(SELECT AVG(rating) FROM restaurants) AS average_rating
#FROM restaurants
#limit 5;

select restaurant_id,name,avg(rating) as avg_rating
from restaurants 
group by restaurant_id,name
order by avg_rating desc
limit 5;

    
select r.restaurant_id,r.name,coalesce(sum(o.total_amount),0.00) as total_revenue
from restaurants as r
left join orders as o
on r.restaurant_id=o.restaurant_id
group by r.restaurant_id,r.name
order by restaurant_id ;


SELECT c.customer_id,c.name,count(o.order_id) as orders
FROM customers AS c
LEFT JOIN orders AS o 
ON c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id) =0;
    




select c.customer_id,c.name,count(o.order_id) order_count
from customers as c
left join orders as o
on c.customer_id=o.customer_id
where c.city="mumbai"
group by c.customer_id,c.name;

SELECT 
    order_id, customer_id, order_date
FROM
    orders
WHERE
    order_date >= NOW() - INTERVAL 90 DAY
ORDER BY order_date DESC;


#SELECT 
 #   COUNT(o.order_id) AS no_of_deliveries,  -- Counting orders instead of partner_id
 #   d.name, 
  #  u.status
#FROM
   # deliverypartners d
#JOIN
  #  orderdelivery o ON d.partner_id = o.partner_id
#JOIN
    #deliveryupdates u ON o.order_id = u.order_id  -- Removed the '#' assuming it's a typo
#WHERE 
 #   u.status = 'delivered'
#GROUP BY 
 #   d.name, u.status
#HAVING 
    #no_of_deliveries >= 1;  -- Using the alias correctly


SELECT deliverypartners.partner_id,deliverypartners.name, count(orderdelivery.order_id)
from deliverypartners JOIN orderdelivery ON deliverypartners.partner_id = orderdelivery.partner_id
GROUP BY deliverypartners.name,partner_id
HAVING count(orderdelivery.order_id) > 1;

#SELECT c.customer_id,c.name,COUNT(o.order_date) AS orderdate_count
#FROM customers AS c
#JOIN orders AS o
#ON o.customer_id = c.customer_id
#GROUP BY c.customer_id, c.name
#having COUNT(o.order_date)=3;

SELECT c.customer_id,c.name,COUNT(o.order_date) AS order_count
FROM customers AS c
JOIN orders AS o
ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
having COUNT(distinct o.order_date)=3;


select deliverypartners.partner_id,deliverypartners.name,deliverypartners.city,count(distinct orders.customer_id) orders
from deliverypartners 
join orderdelivery
on deliverypartners.partner_id=orderdelivery.partner_id
join orders
on orderdelivery.order_id=orders.order_id
group by deliverypartners.partner_id,deliverypartners.name,deliverypartners.city
order by orders desc
limit 1 ;

select c1.name as customer1,c2.name as customer2,c1.city as city1,c2.city as c2,restaurants.name
from customers as c1  
join orders as o1 
on c1.customer_id=o1.customer_id
join orders as o2
on o2.restaurant_id=o1.restaurant_id
join customers as c2 
on c1.city=c2.city
and c1.name<>c2.name and o2.customer_id=c2.customer_id
join restaurants 
on o1.restaurant_id=restaurants.restaurant_id
where o1.order_date<>o2.order_date




