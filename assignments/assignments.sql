/* assignment no 2*/

select onum, amt, odate from orders;
select city,sname, snum, comm from salespeople;
select * from customers where snum=1001;
select rating,cname from customers where city="San Jose";
select distinct snum from orders;
select * from orders where amt > 1000;
select sname, city from salespeople where comm > .1 and city="london";
select * from customers where rating <=100 and city = "rome"; 
select * from orders where amt is not null and amt !=0;
select * from orders order by amt desc limit 3;
select * from orders where odate ="1990-10-04" order by amt limit 1;
select sname, city from salespeople order by comm limit 1;
select rating, cname from customers where city="san jose";
select sname, city from salespeople where city='london' and comm> .1;

select * from orders where odate = '1990-10-03' or odate='1990-10-04';
select * from orders where odate in('1990-10-03','1990-10-04');
select * from orders where odate between '1990-10-03' and '1990-10-04';

select * from customers where cname between 'a' and 'h';

select snum, sname, city , comm from salespeople where (comm>= .12 and comm <= .14);
select snum, sname, city , comm from salespeople where comm between .12 and .14;

/* assignment no 3*/

select lower(cname) from customers where cname between 'a' and 'n';
select cname from customers where cname like "%a" or cname like "%e" or cname like "%i"or cname like "%o" or cname like "%u";
select concat(cname,concat(" - ",city)), rating from customers;
select cname from customers where length(cname) > length(city);
select amt, round(amt,1),ceil(amt), truncate(amt,-2) from orders;
select date_format(odate, "%e - %M - %Y %W") from orders where monthname(odate)='october';
select amt,odate, datediff('1990-12-31',odate),cnum,snum from orders where right(cnum,1) = right(snum,1);
select count(*) from orders where odate ="1990-10-03";
select count(*) from customers where city is not null;
select avg(ifnull(comm,0)) from salespeople where city='london';


/* assignment no 4*/

select distinct(city), avg(comm) from salespeople group by city order by avg(comm) desc limit 1;
select distinct(city), avg(rating) from customers group by city;  -- to complete;

select  count(cname),s.snum, s.city, c.city, s.snum
from salespeople s
inner join customers c
group by s.sum ;
 
 
/* assignment no 5 */
use sales;

 -- Q1) Write a query that lists each order number followed by the name of the customer who made the order
 select o.onum, c.cname from orders o 
 inner join customers c
 on c.cnum = o.cnum;
 
 -- Q2) Write a query that gives the names of both the salesperson and the customer for each 
 -- order along with the order number. 
 select o.onum, s.sname, c.cname from orders o
 inner join customers c on o.cnum = c.cnum
 inner join salespeople s on o.snum = s.snum;
 
 -- Q3) Write a query that produces all customers serviced by salespeople with a commission above
-- 12%. Output the customer's name, the salesperson's name, and the salesperson's rate of commission
select c.cname, s.sname, s.comm from customers c
inner join salespeople s
on c.snum = s.snum
where s.comm > .12;

-- Q4) Write a query that calculates the amount of the salesperson's commission on each order by a
-- customer with a rating above 100

select o.onum, s.comm, c.rating from orders o
inner join salespeople s on o.snum = s.snum
inner join customers c on o.cnum = c.cnum
where c.rating >100
order by onum;

-- Q5) Write a query that produces all pairs of salespeople who are living in the same city. Exclude
-- combinations of salespeople with themselves as well as duplicate rows with the order reversed.

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


-- Q6) For which order salesman got maximum commission? Display order details along with
-- salesman name, commission and total commission (comm * oamt).

select o.onum, s.sname, o.amt, s.comm, o.amt*s.comm  TC from orders o
inner join salespeople s
order by s.comm desc
limit 1;


-- Q7) Which salesman are handling more than one customers? Display name of salesman and
-- number of customers

select s.sname, count(c.cname) from salespeople s
inner join customers c
on s.snum = c.snum
group by s.sname
order by count(c.cname) desc;


-- Q8) What is name of customer and salesman of the maximum amount order?
select o.amt, s.sname, c.cname from orders o
inner join salespeople s on o.snum = s.snum
inner join customers c on c.cnum = o.cnum
order by amt desc
limit 1;


/* assignment on interview Questions*/
create table t1 (c1 int);
insert into tableA values(1),(2),(3);


/* assignment no 6*/

show tables;
use sales;
select * from customers;
select * from orders;
select * from salespeople;

-- q1) Write a query that uses a subquery to obtain all orders for the customer named Cisneros
select * from orders where cnum= (select cnum from customers where cname ='Cisneros');

-- q2) Write a query that selects the total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table 

select snum, sum(amt) from orders
group by snum
having sum(amt) > (select max(amt) from orders)
order by snum;

-- q3) Write a query that selects all customers whose ratings are equal to or greater than ANY customers of ‘Serres’ (salesman)

select * from customers where rating >= (select min(rating) from salespeople s
join customers c
on s.snum = c.snum
where sname='Serres'
group by s.snum);

-- q4) Write a query that will find all salespeople who have no customers located in their city.

select s.sname, s.city sCity, c.city cCity from  salespeople s 
join customers c
on s.snum = c.snum
where s.city != c.city
order by sname;

-- ***q5) Write a query that selects all orders for amounts greater than any for the customers in London.


-- q6) Extract all the orders of Motika (salesman)
select * from orders where snum=(select snum from salespeople where sname='Motika');

-- ****q7) Select all orders that had amounts that were greater that at least one of the orders from ‘1990-10-04’.

select * from orders where amt in (select amt from orders where odate='1990-10-04');

-- q8) Select customers who have a greater rating than any other customer in Rome
select * from customers where rating >=(select rating from customers where city='Rome');

-- q9) Write a query that produces the names and ratings of all customers who have above average(amt) orders

select c.cname, c.rating, o.amt from customers c join orders o on c.snum=o.snum 
where o.amt > (select avg(amt) from orders) ;

-- 10. Find all the orders of the salespeople servicing customers in London.
select c.city, o.onum from customers c join orders o on c.cnum=o.cnum;
select o.onum, s.sname from orders o join salespeople s on o.snum=s.snum;

select s.sname, c.city, o.onum, o.amt from orders o 
join salespeople s on o.snum=s.snum
join customers c on o.cnum=c.cnum
where c.city='London';

-- 11. Find names and numbers of all salesperson who have more than one customer.
select s.sname, count(cname) from orders o 
join salespeople s on o.snum=s.snum
join customers c on o.cnum=c.cnum
group by s.sname
having count(cname) >1;

-- 12. Find salespeople number, name and city who have multiple customers.


-- 13. Find all orders with amounts smaller than any amount for a customer in San Jose.
select distinct c.cnum, min(o.amt) from customers c 
join orders o on c.cnum= o.cnum
where c.city='San Jose'
group by c.cnum;

-- 14. Select those customers whose rating are higher than every customer in Paris.

-- 15. Insert a new order on today’s date from customer Hoffman by salesman Peel of amount 1000 and onum 4001.
insert into orders values(4001,1000.00, curdate(),(select cnum from customers where cname='Hoffman'),(select snum from salespeople where sname='Peel'));

-- ***16. Insert a new order on today’s date from customer Liu by his salesman amount same as largest amount in orders and onum equal to max onum + 1.

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




-- 17. Delete the order with highest onum.

delete from orders where onum = (select maxonum from (select max(onum) as maxonum from orders) as mn);

-- 18. Postpone the order with onum 4001 by one month.


-- 19. Delete the order of Hoffman with amount 1000.




