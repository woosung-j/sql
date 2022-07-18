-- 6�� join

select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- natural join(�� ������� �ʴ´�.)
-- ����: �����ϱ� ���ϴ�.
-- ����: ������ �̸��� ������ column�� ��� join�ȴ�. 
--      ���� column�� ������ �ʴ´�.
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

-- join ~ using
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id); -- record : 106

-- ����] ������ ������ 1���� �̸��� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments; -- record : 32
-- record�� ���̳��� ������ 
-- natural join�� ���� column�� �Ѵ� ��ġ�ؾ� �Ѵ�.

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;


-- error : using column�� ���λ縦 ����� �� ����.
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
where manager_id = 100; -- error : using�� �ƴ� ���� column���� ���λ簡 �ʿ��ϴ�.

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

-- ����] �� ������, using ���� refactoring �϶�.
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

-- ����] Toronto �� ��ġ�� �μ����� ���ϴ� �������
--      �̸�, ����, �μ���ȣ, �μ����� ��ȸ�϶�.
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

-- ����] ���� �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ �̸��� ��ȸ�϶�.
select e.department_id dep, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

-- ����] Davies ���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select e.last_name, e.hire_date
from employees d join employees e
on d.last_name = 'Davies'
and d.hire_date < e.hire_date
order by 2, 1;

