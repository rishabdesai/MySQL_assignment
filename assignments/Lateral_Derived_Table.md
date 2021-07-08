# Lateral Derived Table

(use claswork-db.sql, sales-db.sql)

- It can refer the columns of preceding tables in same FROM clause (MySQL 8.0.14 and above version)
- This feature is added in SQL-99
- Systax is similar to derived tables with LATERAL keyword before it.

----

#### Q1) dispaly ename, sal, dname using join with derived table.

```SQL
select e.ename, e.sal, d.dname from emp e
join (select d.dname from dept d where d.deptno = e.deptno) as d;

-- error in above code: SQL92 dont allow accessing earlier table (in FROM clause) reference inside the dereived table.
-- This limitation is removed in SQL99 adding concept of LATERAL derived tables.

select e.ename, e.sal, d.dname from emp e
join LATERAL (select d.dname from dept d where d.deptno = e.deptno) as d;
```

----

#### Q2) For each salesperson- display name, max order and customer number with max order.  

```SQL
use sales-db;
select o.snum, max(o.amt) from orders o
group by o.snum;

-- using joins
select s.sname, max(o.amt) 
from salespeople s, orders o
where s.snum = o.snum
group by s.sname;

-- above query using sub-query
select s.sname,
(select max(o.amt) from orders o
where o.snum = s.snum) maxAmount
from salespeople s;

select s.sname,
(select max(o.amt) maxAmt from orders o
where o.snum = s.snum) mo,
(select o.cnum from orders o 
where o.snum = s.snum
and o.amt = (select max(o.amt) from orders o
where o.snum = s.snum)) mc
from salespeople s;

-- using LATERAL derived table, we can access earlier table/derivd table column.
-- we can use LATERAL keyword with derived table only. (derived table is sub-query in FROM clause)
select s.sname, mo.maxamt, mc.maxcnum from 
salespeople s,
lateral (select max(o.amt) maxamt from orders o
where o.snum = s.snum) mo,
lateral (select o.cnum maxcnum from orders o where o.snum = s.snum
and o.amt = mo.maxamt) mc;

-- above can also be written by replacing comma with JOIN keyword :
-- corss join beween three tables ( salespeople, mo and mc) as no condition on join provided.
-- similar to CROSS APPLY (join of table with derived table) in MS-SQL server
select s.sname, mo.maxamt, mc.maxcnum from 
salespeople s
JOIN
lateral (select max(o.amt) maxamt from orders o
where o.snum = s.snum) mo
JOIN
lateral (select o.cnum maxcnum from orders o where o.snum = s.snum
and o.amt = mo.maxamt) mc;


-- to make aboce query as LEFT outer join
-- similar to OUTER APPLY (join join of a table with derived table) IN MS-SQL server
select s.sname, mo.maxamt, mc.maxcnum from 
salespeople s
JOIN
lateral (select max(o.amt) maxamt from orders o
where o.snum = s.snum) mo on 1=1
JOIN
lateral (select o.cnum maxcnum from orders o where o.snum = s.snum
and o.amt = mo.maxamt) mc on 1=1;

```
