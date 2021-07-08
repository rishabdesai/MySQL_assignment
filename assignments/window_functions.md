## Window Fuctions

(use claswork-db.sql)

* function used with **over()** clause are called as window function. 
* window function operate on group of rows but unlike GROUP BY  fuction, it do not reduce the rows.
* Windowing enable dividing data into multiple partitions, sorting each partition and performing window operations on each row. 
* types 
    * Aggregate ( sum(), avg(), max(), min(), count() etc )
    * Non-aggregate (row_number(), rank(), dense_rank(), first_value(), last_value(), lead(), lag() etc)
* Partition : Breaks up rows in to logical groups/ partitions. Rows can be partition by one or more columns.
* Order : Sorts row within a partition in asce or dec order. Order is useful for order-sensitive functions like rank() etc.
* Frame : Frame is a subset of current partition.


#### Q)display ename, job, deptno, sal, sum(sal).

```SQL
-- simple GROUP BY clause : using Group by clasue, you loose other information like ename, job, sal.
select deptno, sum(sal) from emp
group by deptno;

-- display total sal of all emp
select ename, job, deptno, sal, 
sum(sal) over() total
from emp;

-- display dept wise total sal of emp
select ename, job, deptno, sal, 
sum(sal) over(partition by deptno) total
from emp;

```

#### Q) Display serial number for emp table ( use of ROW_NUMBER() )

```SQL 

-- sr number 
select ROW_NUMBER() over() Sr,
ename, deptno, sal from emp;

-- partition by deptno
select ROW_NUMBER() over(partition by deptno) Sr,
ename, deptno, sal from emp;

```

#### Q) Find ranking based on salary ( use of RANK() )

```SQL 
select RANK() over(order by sal) rnk,
ename, deptno, job, sal from emp;

select DENSE_RANK() over(order by sal) rnk,
ename, deptno, job, sal from emp;

```

#### Q)print  - Row_number, rank, dense_rank for emp table

```SQL

select
row_number() over(order by sal) sr,
rank() over(order by sal) rnk,
dense_rank() over (order by sal) drnk,
ename, deptno, job, sal from emp;

-- above query also can be written as 
select
row_number() over(wnd) sr,
rank() over(wnd) rnk,
dense_rank() over (wnd) drnk,
ename, deptno, job, sal from emp
WINDOW wnd as (order by sal);

```

#### Q) partition table based on deptno, provide row number to table based on sal. ( use of FIRST_VALUE() )

```SQL

select row_number() over (wnd) sr,
ename, deptno, sal, 
FIRST_VALUE(ename) over (wnd) f_ename
from emp
window wnd as (partition by deptno order by sal);

```

#### Q) find cumulative diff between sal of emp (use of LEAD() )

```SQL

-- using lead() function
select
ROW_NUMBER() over(wnd) sr,
ename, deptno, sal,
LEAD(sal) over(wnd) next_sal,
LEAD(sal) over(wnd) - sal as diff
from emp
WINDOW wnd as (order by sal asc);

-- using lag() function
select
ROW_NUMBER() over(wnd) sr,
ename, deptno, sal,
lag(sal) over(wnd) next_sal,
lag(sal) over(wnd) - sal as diff
from emp
WINDOW wnd as (order by sal asc);

```

#### Q) compare hiring of each dept with last year dept

```SQL

-- 
select deptno, year(hire) yr, count(empno) cnt
from emp
group by deptno, yr;

-- 
with dept_emp_hire as (
select deptno, year(hire) yr, count(empno) cnt
from emp
group by deptno, yr)
select * from dept_emp_hire
order by deptno, yr;

-- answer
with dept_emp_hire as (
select deptno, year(hire) yr, count(empno) cnt
from emp
group by deptno, yr)
select deptno,
yr, lag(yr) over (partition by deptno order by yr) pre_year,
cnt, lag(cnt) over (partition by deptno order by yr) pre_count
from dept_emp_hire;
 
```
