# Common Table Expression

- a derived table

#### Q) For each salesperson display name, max order and customer number with max order.

```SQL

-- derived table query
 select e.empno, e.ename, e.sal, e.deptno
 from emp e
 inner join 
 (select deptno, max(sal) from emp
 group by deptno) as md (deptno, mxsal)
 on e.deptno = md.deptno
 where e.sal = md.mxsal;
 

-- above query using Common Table Expression
-- (use database classwork-db.sql)

with md (deptno, mxsal) as
(select deptno, max(sal) from emp
group by deptno)

select e.empno, e.ename, e.sal, e.deptno
from emp e
inner join md
on e.deptno = md.deptno
where e.sal = md.mxsal;

 ```

----

#### Find avg of dept-wise total sal

```SQL
select deptno, sum(sal) from emp 
group by deptno;

select avg(total) from (
select deptno, sum(sal) total from emp 
group by deptno) as dept_tatal;






```

