-- 5�� group function
-- record�� group�̴�.
-- single function�� param���� record�� 1�� ���Ϸ� ����.
-- single function�� param = null �� �� null�� return�Ѵ�.
-- group function�� param���� record�� 0�� �̻����� ����.
-- group function�� param = null �� �� �����Ѵ�.

-- avg() ���, max() �ְ�, min() ������, sum() �հ�

select avg(salary), max(salary), min(salary), sum(salary)
from employees;

-- min: ������ ��¥, max: �ֱ� ��¥
-- ex) ��й�ȣ �������� 90���� ������. max(date)
select min(hire_date), max(hire_date)
from employees;

-- ����] �ְ���ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary) ����
from employees;

-- group record ����.
select count(*)
from employees;

-- ����] 70�� �μ����� ������� ��ȸ�϶�.
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

select count(manager_id)
from employees;

select avg(commission_pct)
from employees;

-- ����] ������ ��� Ŀ�̼����� ��ȸ�϶�.
select avg(nvl(commission_pct, 0))
from employees;


select avg(salary)
from employees;

-- distinct : �ߺ��� �����Ѵ�. 
select avg(distinct salary)
from employees;

-- all : �⺻��, ������ �����ϴ�.
select avg(all salary)
from employees;

-- ����] ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

select count(distinct manager_id)
from employees;


-- group by : �׷��� �����.
select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

-- ����] ������ ������� ��ȸ�϶�.
select job_id, count(employee_id)
from employees
group by job_id;

-- having: group by ������ ����Ѵ�.
-- group�� ���� field�� ����Ѵ�.
select department_id, max(salary)
from employees
group by department_id
having department_id > 50; -- �׷��� ���� �����, ������ �˻��Ѵ�.

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error ������ ����� �� ����.

select department_id, max(salary)
from employees
where department_id > 50
group by department_id; -- ������ ���� �˻��ϰ� ���� ����� �׷��� �����.

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; -- error ���ǿ� group function�� ������ having�� ����ؾ� �Ѵ�.


select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;


-- ����] �Ŵ����� ���� ������ �� �ּҿ����� ��ȸ�϶�.
--      �ּ� ������ $6,000 �ʰ����� �Ѵ�.
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

-- ����] 2001��, 2002��, 2003�⵵�� �Ի��� ���� ã�´�.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

-- ����] ������, �μ��� �������� ��ȸ�϶�.
--      �μ��� 20, 50, 80 �̴�.
select job_id,
    sum(decode(department_id, 20, salary)) "20�� �μ�",
    sum(decode(department_id, 50, salary)) "50�� �μ�",
    sum(decode(department_id, 80, salary)) "80�� �μ�"
from employees
where department_id in (20, 50, 80)
group by job_id;

select job_id, 
    sum(case department_id when 20 then salary else null end) "20�� �μ�",
    sum(case department_id when 50 then salary else null end) "50�� �μ�",
    sum(case department_id when 80 then salary else null end) "80�� �μ�"
from employees
where department_id in (20, 50, 80)
group by job_id;

