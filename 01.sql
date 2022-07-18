-- 1�� select
/*
table : record�� �����̴�.
column : table�� �������̴�.
record : table�� �������̴�. 
        select�� �ּҴ����̴�.
*/

-- table ������ Ȯ���Ѵ�.
desc departments 

-- ����] employees ������ Ȯ���϶�.
desc employees

select * from departments;

select department_id, location_id 
from departments;

select location_id, department_id
from departments;


select last_name, salary, salary + 300
from employees;

-- ����] ������� ����, ������ ��ȸ�϶�.
select employee_id, salary, salary*12
from employees;


-- �켱����
select last_name, salary, 12 * salary + 100
from employees;

select last_name, salary, 12 * (salary + 100)
from employees;


select last_name, job_id, commission_pct
from employees;

-- ������ �� �ϳ��� ���̶� null�̸� ����� null�� �ȴ�.
select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees;


-- ������ as�� ����Ѵ�.
select last_name as name, commission_pct comm
from employees;


-- ���� ��ҹ���, �����̽��� �����ϰ� ���� ��� ""�� ����Ѵ�.
select last_name "Name", salary * 12 "Annual Salary"
from employees;

-- ����] ������� ���, �̸�, ����, �Ի���(STARTDATE) �� ��ȸ�϶�.
select employee_id, last_name, job_id, hire_date startdate
from employees;

-- ����] ������� ���(EMP #), �̸�(Name), ����(Job), �Ի���(Hire Date)�� ��ȸ�϶�.
select employee_id "EMP #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;


-- �ΰ��� column�� �ϳ��� ��ĥ���� || �����ڸ� ����Ѵ�.
select last_name || job_id
from employees;

-- ''�� ����ϸ� ���ڻ���� �Է��� �� �ִ�.
select last_name || ' is ' || job_id
from employees;

select last_name || ' is ' || job_id as employee
from employees;

-- || �����ڿ����� null ���� emptyString���� ����Ѵ�.
select last_name || null
from employees;

select last_name || commission_pct
from employees;

-- �ڵ� ����ȯ
select last_name || salary
from employees;

select last_name || hire_date
from employees;

select last_name || salary * 12
from employees;

-- ����] ������� '�̸�, ����'(Emp and Title)�� ��ȸ�϶�.
select last_name || ', ' || job_id "Emp and Title"
from employees;

