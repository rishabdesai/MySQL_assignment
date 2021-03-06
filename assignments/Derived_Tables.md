# Derived Table

(use claswork-db.sql)

- Derived table is a virtual table returned from a **sub-query inside FROM clause** of outer query.
- Also called as **Inline View**
- The derived table must have an alias.
- derived tables make expession more readable than joins and corelated sub-queries.
- It overcome limitations of groupby clause.

----

#### Q1) categories emp in three parts - rich, poor, middle

```SQL
select empno, ename, sal, 
CASE
when sal < 1500 then 'poor'
when sal >2500 then 'rich'
else 'middle'
end as 'category'
from emp;
```

----

#### Q2) Count emp in each category

- Option-1) using Views (not recommended)

   ```SQL
    --step1 - create view
   create view v_empCategory as
    select empno,ename, sal, 
    CASE
    when sal < 1500 then 'poor'
    when sal >2500 then 'rich'
    else 'middle'
    end as 'category'
    from emp;
 
    -- step2 - add above view to GROUP BY clause
   select category, count(empno)
   from v_empCategory 
   group by category;
   ```

- Option-2) using **derived table**  (Recommended)
Derived table is sub-query in **FROM clause**

  ```SQL
  select category, count(empno) from
      (select empno,ename, sal, 
      CASE
      when sal < 1500 then 'poor'
      when sal >2500 then 'rich'
      else 'middle'
      end as 'category'
      from emp) as emp_cat
    group by category;
  ```

----

#### Q3) count emp in each dept & each category

 ```SQL
 
 -- step1) create join of emp and dept table
 select dname, empno,ename, sal, 
    CASE
    when sal < 1500 then 'poor'
    when sal >2500 then 'rich'
    else 'middle'
    end as 'category' from emp e
    inner join dept d 
    on d.deptno = e.deptno;

-- step2) add to group by clause 
 select dname, category, count(empno)
 from
 (select dname, empno,ename, sal, 
    CASE
    when sal < 1500 then 'poor'
    when sal >2500 then 'rich'
    else 'middle'
    end as 'category' from emp e
    inner join dept d 
    on d.deptno = e.deptno) as emp_cat
    group by dname, category;

 ```

----

#### Q4) find emp with maximum sal in each dept

 ```SQL
 -- step1 find max sal of each dept
 select deptno, max(sal) from emp
 group by deptno;

 -- step2. use above as derived table
 select e.empno, e.ename, e.sal, e.deptno
 from emp e
 inner join 
 (select deptno, max(sal) mxsal from emp
 group by deptno) as md
 on e.deptno = md.deptno
 where e.sal = md.mxsal;

 ```

above code can also be written as:

 ```SQL
 select e.empno, e.ename, e.sal, e.deptno
 from emp e
 inner join 
 (select deptno, max(sal) from emp
 group by deptno) as md (deptno, mxsal)
 on e.deptno = md.deptno
 where e.sal = md.mxsal;
 
 ```

 above code also can be solved using corelated sub-query

  ```SQL

  select e.empno, e.ename, e.sal, e.deptno from emp e
  where e.sal =(select max(sal) from emp me where me.deptno = e.deptno);

  ```
