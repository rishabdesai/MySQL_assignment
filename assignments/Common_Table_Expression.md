# Common Table Expression

- a derived table
- CTE is a virtual table returned from SELECT query (SQL-99)
- It can be used for CRUD operations
- Types
    - Non-recursive
    - Recursive

#### Q) For each salesperson display name, max order and customer number with max order.

```SQL

-- using derived table query
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

#### Q)Find avg of department-wise total sal

```SQL

-- option1: using derived table
select deptno, sum(sal) from emp 
group by deptno;

select avg(total) from (
select deptno, sum(sal) total from emp 
group by deptno) as dept_tatal;

-- option2: using CTE
with dept_total as (
select deptno, sum(sal) total from emp 
group by deptno)
select avg(total) from dept_total;

```

----

#### Q)Compare sal of each emp with avg(sal) in his dept and avg(sal) for his job.

```SQL
 -- avg sal for each job
 select job, avg(sal) jobAvgSal from emp
 group by job;

-- avg sal for each deptno
select deptno, avg(sal) deptnoAvgSal from emp
group by deptno;

-- using derived table
select e.ename, e.sal, e.job, e.deptno, jobAvgSal, deptnoAvgSal
from emp e
join (select job, avg(sal) jobAvgSal from emp
        group by job) as ej on e.job = ej.job
join(select deptno, avg(sal) deptnoAvgSal from emp
        group by deptno) as ed on e.deptno = ed.deptno; 


-- using CTE
with ej as (select job, avg(sal) jobAvgSal from emp
            group by job),
 ed as (select deptno, avg(sal) deptnoAvgSal from emp
        group by deptno)
select e.ename, e.sal, e.job, e.deptno, jobAvgSal, deptnoAvgSal
from emp e 
join ej on e.job = ej.job
join ed on e.deptno = ed.deptno;

```

----

## Recursive CTE

-- function calling itself

#### Q) print number 1 to 4 as a table.

```SQL
with recursive cte_seq(n) as 
(
    select 1                    -- anchor member
    union all
    select n+1 from cte_seq     -- recursive member
    where n <= 3                -- base condition
)
select * from cte_seq;

```

----

#### Q) print years from 1980 to 1990 where no emp is hired.

```SQL
-- count of emp hired year wise
select year(hire) yr, count(empno) cnt from emp
group by yr;

--using recursive query, generate sequence of years from 1980 to 1990
with recursive years(yr) as
(
    select 1980
    union all
    selecy yr+1 from years where yr <1990
)
select * from years;

-- years from 1980 to 1990 where no emp is hired
with recursive years(yr) as
(
    select 1980
    union all
    select yr+1 from years where yr <1990
)
select yr from years
where yr not in(select year(hire) from emp);

```

----

#### Q) print list of years where no emp is hired in last 40 years.

```SQL
with recursive years(yr) as
(
    select year(now()) - 40
    union all
    select yr+1 from years where yr < year(now())
)
select yr from years
where yr not in(select year(hire) from emp);

```

----

#### Q) print fibonacci series up to 100 

```SQL
with recursive fib(a,b) as (
select 1,1
union all
select b,a+b from fib where b<=100
)
select a from fib;

```

#### print level of hierarchy of emp table
(DFS in tree structure)

```SQL
with recursive emp_hierarchy as
(
    select empno, ename, mgr, deptno, 1 as level 
    from emp where mgr is null
    union all
    select e.empno, e.ename, e.mgr, e.deptno, level+1 as level 
    from emp e 
    join emp_hierarchy eh
    on e.mgr = eh.empno 
)
select * from emp_hierarchy;
```

----

## Multiple CTEs referring to each other

#### Q) Print emp with minimun salary in each dept

```SQL
-- min sal dept wise
with md as (
select deptno, min(sal) minsal from emp
group by deptno)
select * from md;

-- emp with minimun salary in each dept. 
-- here inside 'me' we are referring to 'md'
with 
md as (
select deptno, min(sal) minsal from emp
group by deptno),
me as (
    select empno, sal from emp e join md
    on e.deptno = md.deptno
    where e.sal = md.minsal
)
select * from me;

```

----

## DML with CTE

#### Q) reduce sal of emp with min sal in each dept by 100.

```SQL
with 
md as (
select deptno, min(sal) minsal from emp
group by deptno),
me as (
    select empno, sal from emp e join md
    on e.deptno = md.deptno
    where e.sal = md.minsal
)
update emp set sal=sal-100
where empno in (select empno from me);
```

----

#### Q) delete emp with min sal in each dept

```SQL
with 
md as (
select deptno, min(sal) minsal from emp
group by deptno),
me as (
    select empno, sal from emp e join md
    on e.deptno = md.deptno
    where e.sal = md.minsal
)
delete from emp 
where empno in(select empno from me);

```
