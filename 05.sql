-- 5장 group function
-- record가 group이다.
-- single function은 param으로 record가 1개 이하로 들어간다.
-- single function은 param = null 일 때 null을 return한다.
-- group function은 param으로 record가 0개 이상으로 들어간다.
-- group function은 param = null 일 때 무시한다.

-- avg() 평균, max() 최고값, min() 최저값, sum() 합계

select avg(salary), max(salary), min(salary), sum(salary)
from employees;

-- min: 오래된 날짜, max: 최근 날짜
-- ex) 비밀번호 변경한지 90일이 지났다. max(date)
select min(hire_date), max(hire_date)
from employees;

-- 과제] 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary) 차액
from employees;

-- group record 갯수.
select count(*)
from employees;

-- 과제] 70번 부서원이 몇명인지 조회하라.
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

select count(manager_id)
from employees;

select avg(commission_pct)
from employees;

-- 과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct, 0))
from employees;


select avg(salary)
from employees;

-- distinct : 중복을 제거한다. 
select avg(distinct salary)
from employees;

-- all : 기본값, 생략이 가능하다.
select avg(all salary)
from employees;

-- 과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

select count(distinct manager_id)
from employees;


-- group by : 그룹을 만든다.
select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

-- 과제] 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id;

-- having: group by 조건을 사용한다.
-- group이 가진 field를 사용한다.
select department_id, max(salary)
from employees
group by department_id
having department_id > 50; -- 그룹을 먼저 만들고, 조건을 검색한다.

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error 별명은 사용할 수 없다.

select department_id, max(salary)
from employees
where department_id > 50
group by department_id; -- 조건을 먼저 검색하고 나온 결과로 그룹을 만든다.

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; -- error 조건에 group function이 있으면 having을 사용해야 한다.


select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;


-- 과제] 매니저별 관리 직원들 중 최소월급을 조회하라.
--      최소 월급이 $6,000 초과여야 한다.
select manager_id, min(salary)
from employees
group by manager_id
having min(salary) > 6000 and manager_id is not null
order by 2 desc;


select max(avg(salary))
from employees
group by department_id;

select sum(max(avg(salary)))
from employees
group by department_id; -- error: group function is nested too deeply.

select department_id, round(avg(salary))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees; -- error: not a single-group group function

-- 과제] 2001년, 2002년, 2003년도별 입사자 수를 찾는다.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

-- 과제] 직업별, 부서별 월급합을 조회하라.
--      부서는 20, 50, 80 이다.
select job_id,
    sum(decode(department_id, 20, salary)) "20번 부서",
    sum(decode(department_id, 50, salary)) "50번 부서",
    sum(decode(department_id, 80, salary)) "80번 부서"
from employees
where department_id in (20, 50, 80)
group by job_id;

select job_id, 
    sum(case department_id when 20 then salary else null end) "20번 부서",
    sum(case department_id when 50 then salary else null end) "50번 부서",
    sum(case department_id when 80 then salary else null end) "80번 부서"
from employees
where department_id in (20, 50, 80)
group by job_id;

