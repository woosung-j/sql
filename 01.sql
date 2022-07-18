-- 1장 select
/*
table : record의 집합이다.
column : table의 세로줄이다.
record : table의 가로줄이다. 
        select의 최소단위이다.
*/

-- table 구조를 확인한다.
desc departments 

-- 과제] employees 구조를 확인하라.
desc employees

select * from departments;

select department_id, location_id 
from departments;

select location_id, department_id
from departments;


select last_name, salary, salary + 300
from employees;

-- 과제] 사원들의 월급, 연봉을 조회하라.
select employee_id, salary, salary*12
from employees;


-- 우선순위
select last_name, salary, 12 * salary + 100
from employees;

select last_name, salary, 12 * (salary + 100)
from employees;


select last_name, job_id, commission_pct
from employees;

-- 연산자 중 하나의 값이라도 null이면 결과는 null이 된다.
select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees;


-- 별명은 as를 사용한다.
select last_name as name, commission_pct comm
from employees;


-- 별명 대소문자, 스페이스를 구분하고 싶을 경우 ""를 사용한다.
select last_name "Name", salary * 12 "Annual Salary"
from employees;

-- 과제] 사원들의 사번, 이름, 직업, 입사일(STARTDATE) 을 조회하라.
select employee_id, last_name, job_id, hire_date startdate
from employees;

-- 과제] 사원들의 사번(EMP #), 이름(Name), 직업(Job), 입사일(Hire Date)을 조회하라.
select employee_id "EMP #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;


-- 두개의 column을 하나로 합칠때는 || 연산자를 사용한다.
select last_name || job_id
from employees;

-- ''를 사용하면 문자상수를 입력할 수 있다.
select last_name || ' is ' || job_id
from employees;

select last_name || ' is ' || job_id as employee
from employees;

-- || 연산자에서는 null 값을 emptyString으로 취급한다.
select last_name || null
from employees;

select last_name || commission_pct
from employees;

-- 자동 형변환
select last_name || salary
from employees;

select last_name || hire_date
from employees;

select last_name || salary * 12
from employees;

-- 과제] 사원들의 '이름, 직업'(Emp and Title)을 조회하라.
select last_name || ', ' || job_id "Emp and Title"
from employees;

