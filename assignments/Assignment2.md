## assignment no 2

(Refer database - sales-db.sql)

- Write a select command that produces the order number, amount, and date for all rows in the Orders table

```SQL
select onum, amt, odate from orders;
```

- Write a query that displays the Salespeople table with the columns in the following order: city, sname, snum, comm.

```SQL
select city,sname, snum, comm from salespeople;
```

- Write a query that produces all rows from the Customers table for which the salesperson’s number is 1001

```SQL
select * from customers where snum=1001;
```

- Write a select command that produces the rating followed by the name of each customer in San Jose.

```SQL
select rating,cname from customers where city="San Jose";
```

- Write a query that will produce the snum values of all salespeople from the Orders table (with the duplicate values suppressed)

```SQL
select distinct snum from orders;
```

- Write a query that will give you all orders for more than Rs. 1,000.

```SQL
select * from orders where amt > 1000;
```

- Write a query that will give you the names and cities of all salespeople in London with a commission above 0.10

```SQL
select sname, city from salespeople where comm > 0.1 and city="london";
```

- Write a query on the Customers table whose output will exclude all customers with a rating <= 100, unless they are located in Rome.

```SQL
select * from customers where rating <=100 and city = "rome"; 
```

- Write a query that selects all orders except those with zeroes or NULLs in the amt field.

```SQL
select * from orders where amt is not null and amt !=0;
```

- Write a SELECT statement to get top 3 orders by amount

```SQL
select * from orders order by amt desc limit 3;
```

- Get the lowest amount order on 4th Oct 1990

```SQL
select * from orders where odate ="1990-10-04" order by amt limit 1;
```

- Get the onum and amount of the lowest amount order on 4th Oct 1990 by customer 2006


- Print the name and city of the salesman with lowest commission

```SQL
select sname, city from salespeople order by comm limit 1;
```

- Write a select command that produces the rating followed by the name of each customer in San Jose.

```SQL
select rating, cname from customers where city="san jose";
```

- Write a query that will give you the names and cities of all salespeople in London with a commission above 0.10.

```SQL
select sname, city from salespeople where city='london' and comm> .1;
```

- Write three different queries that would produce all orders taken on October 3rd and 4th, 1990.

```SQL
select * from orders where odate = '1990-10-03' or odate='1990-10-04';
select * from orders where odate in('1990-10-03','1990-10-04');
select * from orders where odate between '1990-10-03' and '1990-10-04';
```

- Write a query that will produce all the customers whose names begin with a letter from ‘A’ to ‘G’

```SQL
select * from customers where cname between 'a' and 'h';
```

- What is a simpler way to write this query?
SELECT SNUM, SNAME, CITY, COMM FROM SALESPEOPLE WHERE (COMM >=.12 AND COMM <=.14)

```SQL
select snum, sname, city , comm from salespeople where comm between .12 and .14;
```