create database joins;
use joins;
create table tableA (col1 int);
insert into tableA values(1),(2),(3),(4);
truncate table tableA;

create table tableB (col1 int);
insert into tableB values(6);

select * from tablea;
select * from tableb;



select * from tablea 
left outer join tableb
on tablea.colA=tableb.colB
union
select * from tablea 
RIGHT outer join tableb
on tablea.colA=tableb.colB;

alter table tableb rename column col1 to colB;

insert into tableA values(11),(22),(33);

-- new tables;

create table emp (eno int, ename varchar(30), deptno int);
insert into emp values(1, 'arun',1);
insert into emp values(2, 'ali',1);
insert into emp values(3, 'kiran',1);
insert into emp values(4, 'jack',2);
insert into emp values(5, 'thomas',null);

create table dept(deptno int, dname varchar(30));
insert into dept values(1, 'trn');
insert into dept values(2, 'exp');
insert into dept values(3, 'mktg');


select * from emp;
select * from dept;

-- equi join/natural join / inner join;
select e.eno, e.ename,d.deptno, d.dname 
from emp e
inner join dept d
on e.deptno = d.deptno;

-- left outer join;
select e.eno, e.ename,d.deptno, d.dname 
from emp e
left outer join dept d
on e.deptno = d.deptno;

-- right outer join;
select e.eno, e.ename,d.deptno, d.dname 
from emp e
right outer join dept d
on e.deptno = d.deptno;

-- full outer join;
select e.eno, e.ename,d.deptno, d.dname 
from emp e
left outer join dept d
on e.deptno = d.deptno
union
select e.eno, e.ename,d.deptno, d.dname 
from emp e
right outer join dept d
on e.deptno = d.deptno;
