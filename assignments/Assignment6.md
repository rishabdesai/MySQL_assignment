## Assignment-6

-- q1) Write a query that uses a subquery to obtain all orders for the customer named Cisneros

```SQL
select * from orders where cnum= (select cnum from customers where cname ='Cisneros');
```

-- q2) Write a query that selects the total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table 

```SQL
select snum, sum(amt) from orders
group by snum
having sum(amt) > (select max(amt) from orders)
order by snum;
```

-- q3) Write a query that selects all customers whose ratings are equal to or greater than ANY customers of ‘Serres’ (salesman)

```SQL
select * from customers where rating >= (select min(rating) from salespeople s
join customers c
on s.snum = c.snum
where sname='Serres'
group by s.snum);
```

-- q4) Write a query that will find all salespeople who have no customers located in their city.

```SQL
select s.sname, s.city sCity, c.city cCity from  salespeople s 
join customers c
on s.snum = c.snum
where s.city != c.city
order by sname;
```

-- ***q5) Write a query that selects all orders for amounts greater than any for the customers in London.


-- q6) Extract all the orders of Motika (salesman)

```SQL
select * from orders where snum=(select snum from salespeople where sname='Motika');
```

-- ****q7) Select all orders that had amounts that were greater that at least one of the orders from ‘1990-10-04’.

```SQL
select * from orders where amt in (select amt from orders where odate='1990-10-04');
```

-- q8) Select customers who have a greater rating than any other customer in Rome

```SQL
select * from customers where rating >=(select rating from customers where city='Rome');
```

-- q9) Write a query that produces the names and ratings of all customers who have above average(amt) orders

```SQL
select c.cname, c.rating, o.amt from customers c join orders o on c.snum=o.snum 
where o.amt > (select avg(amt) from orders) ;
```

-- 10. Find all the orders of the salespeople servicing customers in London.

```SQL
select c.city, o.onum from customers c join orders o on c.cnum=o.cnum;
select o.onum, s.sname from orders o join salespeople s on o.snum=s.snum;

select s.sname, c.city, o.onum, o.amt from orders o 
join salespeople s on o.snum=s.snum
join customers c on o.cnum=c.cnum
where c.city='London';
```

-- 11. Find names and numbers of all salesperson who have more than one customer.

```SQL
select s.sname, count(cname) from orders o 
join salespeople s on o.snum=s.snum
join customers c on o.cnum=c.cnum
group by s.sname
having count(cname) >1;
```

-- 12. Find salespeople number, name and city who have multiple customers.


-- 13. Find all orders with amounts smaller than any amount for a customer in San Jose.

```SQL
select distinct c.cnum, min(o.amt) from customers c 
join orders o on c.cnum= o.cnum
where c.city='San Jose'
group by c.cnum;
```

-- 14. Select those customers whose rating are higher than every customer in Paris.

-- 15. Insert a new order on today’s date from customer Hoffman by salesman Peel of amount 1000 and onum 4001.

```SQL
insert into orders values(4001,1000.00, curdate(),(select cnum from customers where cname='Hoffman'),(select snum from salespeople where sname='Peel'));
```

-- ***16. Insert a new order on today’s date from customer Liu by his salesman amount same as largest amount in orders and onum equal to max onum + 1.

```SQL
select max(onum)+1 from orders;
select max(amt) from orders;
select curdate();
select cnum from customers where cname='Liu';
select snum from customers where cname='Liu';

select * from orders;


set @one =(select max(onum)+1 from orders);
set @two =(select max(amt) from orders);
set @three = curdate();
set @four = (select cnum from customers where cname='Liu');
set @five = (select snum from customers where cname='Liu');

insert into orders values(@one, @two, @three, @four, @five);
delete from orders where onum is null;
select * from orders;
```

-- 17. Delete the order with highest onum.

```SQL
delete from orders where onum = (select maxonum from (select max(onum) as maxonum from orders) as mn);
```

-- 18. Postpone the order with onum 4001 by one month.

-- 19. Delete the order of Hoffman with amount 1000.
