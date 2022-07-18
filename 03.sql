-- 3�� single function
/*
SQL(Structured Query Language)
Function : PL/SQL(Procedure Language/SQL)
*/

desc dual
select * from dual;

-- lower : �ҹ��ڷ� ��ȯ�Ѵ�.
select lower('SQL Course')
from dual;

-- upper : �빮�ڷ� ��ȯ�Ѵ�.
select upper('SQL Course')
from dual;

-- initcap �� �ܾ��� ù���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
select initcap('SQL course')
from dual;


select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';


select last_name
from employees
where lower(last_name) = lower('higgins');

-- concat : ���ڿ� �ΰ��� ��ģ��.
select concat('Hello', 'World')
from dual;

-- substr : ���ڸ� �и��Ѵ�.
-- substr(String, startIndex(min: 1), endIndex(max: length))
select substr('HelloWorld', 2, 5)
from dual;

-- length : ���� ���̸� return �Ѵ�.
select length('Hello')
from dual;

-- instr ���ڰ� �ִ��� �˻��Ѵ�.
-- instr(String, ã�� ����) return ã�� ������ ó�� �߰ߵ� index
-- ���ڰ� ���� ��� 0�� return �Ѵ�.
select instr('Hello', 'l')
from dual;
select inStr('Hello', 'w')
from dual;

-- lpad : �ʵ��� ���ڿ��� ���� ���̷� ������ش�.
select lpad(salary, 5, '*')
from employees;

-- rpad : �ʵ��� ���ڿ��� ���� ���̷� ������ش�.
select rpad(salary, 5, '*')
from employees;

-- replace : ���ڿ��� ��ü�Ѵ�.
select replace('JACK and JUE', 'J', 'BL')
from dual;

-- trim : ���ڸ� �����Ѵ�. ù ���ڿ� ������ ���ڸ� ó���Ѵ�.
select trim('H' from 'Hello')
from dual;

select trim('l' from 'Hello')
from dual;

select trim (' ' from ' Hello ')
from dual;

-- ����] �� query ���� ' '�� trim ������ ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a')
from employees
where substr(job_id, 4) = 'PROG';

-- ����] �Ʒ� ���忡��, where ���� like�� refactoring�϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a')
from employees
where job_id like '%PROG';

-- ����] �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ�϶�.
--    �̸� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����Ѵ�.
select initcap(last_name), length(last_name)
from employees
where last_name like 'A%' or
    last_name like 'J%' or
    last_name like 'M%';
    
select substr('Hello', -1)
from dual;


-- round : �ݿø�
select round(45.926, 2)
from dual;

-- trunc : ����
select trunc(45.926, 2)
from dual;

-- mod : ������
select mod(1600, 300)
from dual;

select round(45.923, 0), round(45.923)
from dual;

select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, mod(salary, 5000)
from employees;

-- ����] ������� �̸�, ����, 15.5% �λ�� ����(New Salary, ����), �λ��(Increase)�� ��ȸ�϶�.
select last_name, salary, 
    round(salary * 1.155) as "New Salary",
    round(salary * 1.155) - salary as "Increase"
from employees;


-- sysdate : server date
select sysdate
from dual;

select sysdate + 1
from dual;

select sysdate - sysdate
from dual;


select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- ����] 90�� �μ� ������� �̸�, �ټӳ���� ��ȸ�϶�.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;


-- months_between : �� ��¥ ���̸� ���� ǥ���Ѵ�.
select months_between('2022/12/31', '2020/12/30')
from dual;

-- add_months : ���� ���Ѵ�.
select add_months('2022/07/14', 1)
from dual;

-- next_day : ������ ������ ���Ѵ�.
select next_day('2022/07/14', 6)
from dual;

select next_day('2022/07/14', 'friday')
from dual;

-- ���� ������ ���Ѵ�.
select last_day('2022/07/14')
from dual;


-- ����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�.
--      ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date)
from employees
where trunc((sysdate - hire_date) / 365) > 20;

-- ����] ������� �̸�, ���ޱ׷����� ��ȸ�϶�.
--      �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�.
select last_name as �̸�, 
    lpad(' ', (salary / 1000) + 1, '*') as ���ޱ׷���
from employees;

-- ����] �� �׷����� ���� ���� �������� �����϶�.
select last_name as �̸�, 
    lpad(' ', (salary / 1000) + 1, '*') as ���ޱ׷���
from employees
order by salary desc;


