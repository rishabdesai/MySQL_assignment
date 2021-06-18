
## Assignment-3

(Refer database - sales-db.sql)

- Find all customers having name starting from 'A' to 'M'. Print all names in lower case

```SQL
select lower(cname) from customers where cname between 'a' and 'n';
```

- Find all customers having name ending with 'a', 'e', 'i', 'o', 'u'. Print all names in upper case

```SQL
select cname from customers where cname like "%a" or cname like "%e" or cname like "%i"or cname like "%o" or cname like "%u";
```

- Display customer name and city in a single column separated by '-'. Also print customer rating in another column

```SQL
select concat(cname,concat(" - ",city)), rating from customers;
```

- Display all the customers whose name length is more than their city name length

```SQL
select cname from customers where length(cname) > length(city);
```

- Display order amount, order amount rounded up to single place of decimal, whole number smaller than order amount, whole number greater than order amount, order amounts rounded in multiple of 100

```SQL
select amt, round(amt,1),ceil(amt), truncate(amt,-2) from orders;
```

- Get all the orders in the month of October (irrespective of year and date). Also print order date
in format 03-Oct-1990 and weekday of the order.

```SQL
select date_format(odate, "%e - %M - %Y %W") from orders where monthname(odate)='october';
```

- Print order amount, order date, difference in number of days between order date and year end (31-Dec-1990), cnum and snum for all orders where last digit of cnum and snum is same.

```SQL
select amt,odate, datediff('1990-12-31',odate),cnum,snum from orders where right(cnum,1) = right(snum,1);
```

- Write a query that counts all orders for October 3.

```SQL
select count(*) from orders where odate ="1990-10-03";
```

- Write a query that counts the number of different non-NULL city values in the Customers table

```SQL
select count(*) from customers where city is not null;
```

- Find average commission of salespeople in London

```SQL
select avg(ifnull(comm,0)) from salespeople where city='london';
```
