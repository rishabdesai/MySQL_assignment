
## Assignment-5

(Refer database - sales-db.sql)

 -- Q1) Write a query that lists each order number followed by the name of the customer who made the order

 ```SQL
 select o.onum, c.cname from orders o 
 inner join customers c
 on c.cnum = o.cnum;
 ```

 -- Q2) Write a query that gives the names of both the salesperson and the customer for each order along with the order number.

 ```SQL
 select o.onum, s.sname, c.cname from orders o
 inner join customers c on o.cnum = c.cnum
 inner join salespeople s on o.snum = s.snum;
 ```

 -- Q3) Write a query that produces all customers serviced by salespeople with a commission above 12%. Output the customer's name, the salesperson's name, and the salesperson's rate of commission

 ```SQL
select c.cname, s.sname, s.comm from customers c
inner join salespeople s
on c.snum = s.snum
where s.comm > .12;
```

-- Q4) Write a query that calculates the amount of the salesperson's commission on each order by a customer with a rating above 100

```SQL
select o.onum, s.comm, c.rating from orders o
inner join salespeople s on o.snum = s.snum
inner join customers c on o.cnum = c.cnum
where c.rating >100
order by onum;
```

-- Q5) Write a query that produces all pairs of salespeople who are living in the same city. Exclude combinations of salespeople with themselves as well as duplicate rows with the order reversed.

```SQL
select sname, city  from salespeople 
order by city;

select  sa.sname A, s.sname B, s.city  from salespeople sa
inner join salespeople s
on sa.city = s.city  
where (sa.sname != s.sname);


select  sa.sname A, s.sname B, s.city  
from salespeoples sa 
inner join salespeoples s 
on sa.city = s.city 
where (sa.sname != s.sname);

select  sa.sname A, s.sname B, s.city  from salespeople sa
inner join salespeople s
on sa.city = s.city  
where (sa.sname < s.sname);
```

-- Q6) For which order salesman got maximum commission? Display order details along with salesman name, commission and total commission (comm * oamt).

```SQL
select o.onum, s.sname, o.amt, s.comm, o.amt*s.comm  TC from orders o
inner join salespeople s
order by s.comm desc
limit 1;
```

-- Q7) Which salesman are handling more than one customers? Display name of salesman and number of customers

```SQL
select s.sname, count(c.cname) from salespeople s
inner join customers c
on s.snum = c.snum
group by s.sname
order by count(c.cname) desc;
```

-- Q8) What is name of customer and salesman of the maximum amount order?

```SQL
select o.amt, s.sname, c.cname from orders o
inner join salespeople s on o.snum = s.snum
inner join customers c on c.cnum = o.cnum
order by amt desc
limit 1;
```
