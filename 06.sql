-- 6장 join

select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- natural join(잘 사용하지 않는다.)
-- 장점: 개발하기 편하다.
-- 단점: 동일한 이름을 가지는 column은 모두 join된다. 
--      공통 column이 보이지 않는다.
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

-- join ~ using
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id); -- record : 106

-- 과제] 위에서 누락된 1인의 이름을 조회하라.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments; -- record : 32
-- record가 차이나는 이유는 
-- natural join은 공통 column이 둘다 일치해야 한다.

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;


-- error : using column은 접두사를 사용할 수 없다.
select l.city, d.department_name
from locations l join departments d
using (location_id)
where l.location_id = 1400;  -- error

select l.location_id -- error
from locations l join departments d
using (location_id)
where location_id = 1400; 
--

-- manager_id
select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100; -- error : using이 아닌 공통 column에는 접두사가 필요하다.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where e.manager_id = 100; -- record: 14 

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100; -- record: 3
--

-- on
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 과제] 위 문장을, using 으로 refactoring 하라.
select employee_id, city, department_name
from employees join departments
using(department_id)
join locations
using(location_id);
--

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149;

-- 과제] Toronto 에 위치한 부서에서 일하는 사원들의
--      이름, 직업, 부서번호, 부서명을 조회하라.
select last_name, job_id, d.department_id, 
    department_name, city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id 
and l.city = 'Toronto';
--

-- non-equi join
select last_name, salary, e.job_id
from employees e join jobs j
on salary between min_salary and max_salary
and j.job_id = 'IT_PROG';


-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

-- 과제] 같은 부서에서 일하는 사원들의 부서번호, 이름, 동료의 이름을 조회하라.
select e.department_id dep, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

-- 과제] Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees d join employees e
on d.last_name = 'Davies'
and d.hire_date < e.hire_date
order by 2, 1;

-- 과제] 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저입사일을 조회하라.
select e.last_name 사원, e.hire_date 입사일, 
       m.last_name 매니저, m.hire_date "매니저 입사일"
from employees e join employees m
on m.employee_id = e.manager_id
and m.hire_date > e.hire_date
order by 2, 4;

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- outer join 
-- : department_id 가 없는 Grant도 나온다.
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

-- : department_id 가 없는 부서 레코드들이 포함이 된다.
select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

-- : 부서가 없는 사원, 사원이 없는 부서가 모두 포함이 된다.
select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

-- 과제] 사원들의 이름, 사번, 매니저명, 매니저의 사번을 조회하라.
--      King 사장도 테이블에 포함한다.
select e.last_name 이름, e.employee_id 사번, 
       m.last_name 매니저명, m.employee_id "매니저 사번"
from employees e left outer join employees m
on m.employee_id = e.manager_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id; -- right outer join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); -- left outer join

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;
