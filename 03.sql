-- 3장 single function
/*
SQL(Structured Query Language)
Function : PL/SQL(Procedure Language/SQL)
*/

desc dual
select * from dual;

-- lower : 소문자로 변환한다.
select lower('SQL Course')
from dual;

-- upper : 대문자로 변환한다.
select upper('SQL Course')
from dual;

-- initcap 각 단어의 첫글자만 대문자로 변환한다.
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

-- concat : 문자열 두개를 합친다.
select concat('Hello', 'World')
from dual;

-- substr : 글자를 분리한다.
-- substr(String, startIndex(min: 1), endIndex(max: length))
select substr('HelloWorld', 2, 5)
from dual;

-- length : 글자 길이를 return 한다.
select length('Hello')
from dual;

-- instr 문자가 있는지 검색한다.
-- instr(String, 찾을 문자) return 찾을 문자의 처음 발견된 index
-- 문자가 없을 경우 0을 return 한다.
select instr('Hello', 'l')
from dual;
select inStr('Hello', 'w')
from dual;

-- lpad : 필드의 문자열을 같은 길이로 만들어준다.
select lpad(salary, 5, '*')
from employees;

-- rpad : 필드의 문자열을 같은 길이로 만들어준다.
select rpad(salary, 5, '*')
from employees;

-- replace : 문자열을 교체한다.
select replace('JACK and JUE', 'J', 'BL')
from dual;

-- trim : 문자를 삭제한다. 첫 문자와 마지막 문자만 처리한다.
select trim('H' from 'Hello')
from dual;

select trim('l' from 'Hello')
from dual;

select trim (' ' from ' Hello ')
from dual;

-- 과제] 위 query 에서 ' '가 trim 됐음을 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a')
from employees
where substr(job_id, 4) = 'PROG';

-- 과제] 아래 문장에서, where 절을 like로 refactoring하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a')
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
--    이름 첫글자는 대문자, 나머지는 소문자로 출력한다.
select initcap(last_name), length(last_name)
from employees
where last_name like 'A%' or
    last_name like 'J%' or
    last_name like 'M%';
    
select substr('Hello', -1)
from dual;


-- round : 반올림
select round(45.926, 2)
from dual;

-- trunc : 버림
select trunc(45.926, 2)
from dual;

-- mod : 나머지
select mod(1600, 300)
from dual;

select round(45.923, 0), round(45.923)
from dual;

select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, mod(salary, 5000)
from employees;

-- 과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라.
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

-- 과제] 90번 부서 사원들의 이름, 근속년수를 조회하라.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;


-- months_between : 두 날짜 차이를 월로 표시한다.
select months_between('2022/12/31', '2020/12/30')
from dual;

-- add_months : 월을 더한다.
select add_months('2022/07/14', 1)
from dual;

-- next_day : 다음주 요일을 구한다.
select next_day('2022/07/14', 6)
from dual;

select next_day('2022/07/14', 'friday')
from dual;

-- 월의 말일을 구한다.
select last_day('2022/07/14')
from dual;


-- 과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라.
--      월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where trunc((sysdate - hire_date) / 365) > 20;

-- 과제] 사원들의 이름, 월급그래프를 조회하라.
--      그래프는 $1000 당 * 하나를 표시한다.
select last_name as 이름, 
    lpad(' ', (salary / 1000) + 1, '*') as 월급그래프
from employees;

-- 과제] 위 그래프를 월급 기준 내림차순 정렬하라.
select last_name as 이름, 
    lpad(' ', (salary / 1000) + 1, '*') as 월급그래프
from employees
order by salary desc;


