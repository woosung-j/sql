-- 4장 datatype conversion
-- 명시적 data type 변환
-- Number <--> Character <--> Date

-- 자동 형 변환(char > date 변환)
select hire_date
from employees
where hire_date = '2003/06/17';

-- 자동 형 변환(char > number 변환)
select salary
from employees
where salary = '7000';

-- 자동 형 변환(date > char)
select hire_date || ''
from employees;

-- 자동 형 변환(number > char)
select salary || ''
from employees;

-- to_char: 문자로 변환한다.
select to_char(sysdate, 'yyyy-mm-dd')
from dual;

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month DDsp Day(Dy)')
from dual;

select to_char(sysdate, 'd')
from dual;

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'DD Month RR')
from employees;

-- fm : 공백 문자를 최소화한다.
select to_char(hire_date, 'fmDD Month RR')
from employees;

select to_char(hire_date)
from employees;

-- 과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사하고 3개월 후 첫번째 월요일이다.
--      날짜는 YYYY.MM.DD 로 표시한다.
select last_name, 
    to_char(hire_date, 'YYYY.MM.DD') as hire_date, 
    to_char(next_day(add_months(hire_date, 3), 'mon'), 'YYYY.MM.DD') as review_date
from employees;

select last_name, hire_date, 
    to_char(hire_date, 'day'), 
    to_char(hire_date, 'd')
from employees;
-- 과제] 위 테이블을 월요일부터 입사일순 오름차순 정렬하라.
select last_name, hire_date, 
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1, 'd');


-- 숫자를 문자로 명시적 변환
select to_char(salary)
from employees;

select to_char(salary, '$99,999.99'), 
    to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select to_char(salary, 'fm$99,999.99'), 
    to_char(salary, 'fm$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
    '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
    '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237, 'L9,999')
from dual;


select last_name, hire_date
from employees
where hire_date = to_date('May 24, 2007', 'Mon dd, yyyy');


select last_name, hire_date
from employees
where hire_date = to_date('May 24, 2007', 'Mon dd yy');

-- fx: Format extract, 형식을 정확히 일치해야 한다.
select last_name, hire_date
from employees
where hire_date = to_date('May 24, 2007', 'fxMon dd, yyyy');


select to_number('1237') + 55
from dual;

-- 구분기호가 있으면 형식을 같이 입력한다.
select to_number('1,237', '9,999') + 55
from dual;

-- 과제] <이름> earns <$,월급> monthly but wants <$,월급x3>. 로 조회하라.
select last_name || ' earns ' || to_char(salary, 'fm$99,999') ||
    ' monthly but wants ' || to_char(salary * 3, 'fm$99,999') || '.'
from employees;


-- nvl 함수 : null값을 대체한다.
select nvl(null, 1)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- 과제] 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id, 
    salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

-- 과제] 사원들의 이름, 커미션율을 조회하라.
--      커미션이 없으면, No Commission 을 출력한다.
select last_name, nvl(to_char(commission_pct, 'fm0.000'), 'No Commission')
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

-- nullif : 두개 param 값이 같으면 null을 리턴한다.
--                    다르면 첫번째 param을 리턴한다.
select first_name, last_name, 
    nullif(length(first_name), length(last_name))
from employees;

select to_char(null), to_number(null), to_date(null)
from dual;

-- coalesce : 처음으로 null이 아닌 값이 나오면 return 한다.
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;


-- decode (기준값, 비교값, 리턴값)
-- 기준값 = 비교값 일 때 리턴값을 리턴한다.
-- 비교값 - 리턴값 이 한쌍이다.
-- 마지막 param은 위에 일치하는 값이 없을 때 리턴한다..
select last_name, salary,
    decode(trunc(salary / 2000), 
        0, 0.00, 
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
        0.45 
        ) tax_rate
from employees
where department_id = 80;

select decode(salary, 'a', 1)
from employees;

select decode(salary, 'a', 1, 0)
from employees;

-- error, invalid number
-- decode는 기준값과 비교값의 타입이 다르면 기준값의 타입을 변경한다.
select decode(job_id, 1, 1)
from employees;

select decode(hire_date, 'a', 1)
from employees;

-- error hire_date를 숫자로 바꿀 수 없다.
select decode(hire_date, 1, 1)
from employees;

-- 과제] 사원들의 직업, 직업별 등급을 조회하라.
--      기본 등급은 null 이다.
--      IT_PROG     A
--      AD_PRES     B
--      ST_MAN      C
--      ST_CLERK    D
select last_name, job_id, decode(job_id, 
                'IT_PROG', 'A',
                'AD_PRES', 'B',
                'ST_MAN', 'C',
                'ST_CLERK', 'D') grade
from employees;


-- case문
-- case <var> when <value> then <return>
-- else <return> end
--
-- case when <var> '>' <value> then <return>
-- end
--
-- var 과 value의 type은 같아야 한다.
-- return값의 type은 같아야 한다.
select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when '1' then 1
                   when '2' then 2
                   else 0 
       end grade
from employees;

select case salary when 1 then '1'
                   when 2 then '2'
                   else '0' 
       end grade
from employees;

-- error
select case salary when '1' then '1'
                   when 2 then '2'
                   else '0' 
       end grade
from employees;

-- error
select case salary when 1 then '1'
                   when 2 then '2'
                   else 0
       end grade
from employees;

-- error
select case salary when 1 then 1
                   when 2 then '2'
                   else '0' 
       end grade
from employees;

select last_name, salary,
    case when salary < 5000 then 'low'
         when salary < 10000 then 'medium'
         when salary < 20000 then 'high'
         else 'good'
    end grade
from employees
order by salary desc;


-- 과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.
select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by
    case day
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end;


-- 과제] 2005년 이전에 입사한 사원들에겐 100만원 상품권,
--      2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권금액을 조회하라.
select last_name 이름, hire_date 입사일,
    case when hire_date < '2006/01/01' then '100만원'
         else '10만원'
    end 상품권금액
from employees
order by hire_date;

