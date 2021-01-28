/* *************************************

Select �⺻ ���� - ������, �÷� ��Ī

*************************************** */
--EMP ���̺��� ��� �÷��� ��� �׸��� ��ȸ.

select * from emp;

--EMP ���̺��� ���� ID(emp_id), ���� �̸�(emp_name), ����(job) �÷��� ���� ��ȸ.
select emp_id, emp_name , job from emp;

--EMP ���̺��� ����(job) � ����� �����Ǿ����� ��ȸ. - ������ ���� �ϳ����� ��ȸ�ǵ��� ó��.

select distinct job from emp;

--EMP ���̺��� �μ���(dept_name)�� � ����� �����Ǿ����� ��ȸ - ������ ���� �ϳ����� ��ȸ�ǵ��� ó��.

select distinct dept_name from emp;

--EMP ���̺��� emp_id�� ����ID, emp_name�� �����̸�, hire_date�� �Ի���, salary�� �޿�, dept_name�� �ҼӺμ� ��Ī���� ��ȸ�Ѵ�.

select emp_id "����ID", emp_name "�����̸�", hire_date "�Ի���", salary "�޿�", dept_name "�ҼӺμ�" from emp;     

/* 
������ 
 ������ �� �÷��� ��� ���鿡 �Ϸ������� ����ȴ�.
 ���� �÷��� ������ ��ȸ�� �� �ִ�.

- �÷� + �� : �÷��� ��簪�� ���Ѵ�.
- �÷� * �÷� : 


*/


--EMP ���̺��� ������ �̸�(emp_name), �޿�(salary) �׸���  �޿� + 1000 �� ���� ��ȸ.

select emp_name,salary, salary+1000 from emp;

--EMP ���̺��� �Ի���(hire_date)�� �Ի��Ͽ� 10���� ���� ��¥�� ��ȸ.

select hire_date , hire_date +10 "�Ի� 10�� ��" from empl;

-- TODO: EMP ���̺��� ����(job)�� � ����� �����Ǿ����� ��ȸ - ������ ���� �ϳ����� ��ȸ�ǵ��� ó��

select distinct job from emp;


--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼�_PCT(comm_pct), �޿��� Ŀ�̼�_PCT�� ���� ���� ��ȸ.

select emp_id, emp_name, salary, comm_pct, comm_pct*salary from emp;

--TODO:  EMP ���̺��� �޿�(salary)�� �������� ��ȸ. (���ϱ� 12)

select salary*12 "����" from emp;

--TODO: EMP ���̺��� �����̸�(emp_name)�� �޿�(salary)�� ��ȸ. �޿� �տ� $�� �ٿ� ��ȸ.

select emp_name , '$'||salary from emp;


--TODO: EMP ���̺��� �Ի���(hire_date) 30����, �Ի���, �Ի��� 30�� �ĸ� ��ȸ

select hire_date-30 "�Ի��� 30����", hire_date "�Ի���", hire_date+30 "�Ի��� 30�� ��" from emp;





/* *************************************
Where ���� �̿��� �� �� ����
************************************* */
--EMP ���̺��� ����_ID(emp_id)�� 110�� ������ �̸�(emp_name)�� �μ���(dept_name)�� ��ȸ

select emp_name, dept_name from emp
where emp_id = 110;

 
--EMP ���̺��� 'Sales' �μ��� ������ ���� �������� ID(emp_id), �̸�(emp_name), �μ���(dept_name)�� ��ȸ.

select emp_id, emp_name, dept_name from emp
where dept_name != 'Sales';


--EMP ���̺��� �޿�(salary)�� $10,000�� �ʰ��� ������ ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ

select emp_id, emp_name, salary from emp
where salary > 10000;

 
--EMP ���̺��� Ŀ�̼Ǻ���(comm_pct)�� 0.2~0.3 ������ ������ ID(emp_id), �̸�(emp_name), Ŀ�̼Ǻ���(comm_pct)�� ��ȸ.

select emp_id, emp_name, comm_pct from emp
where comm_pct between 0.2 and 0.3;


--EMP ���̺��� Ŀ�̼��� �޴� ������ �� Ŀ�̼Ǻ���(comm_pct)�� 0.2~0.3 ���̰� �ƴ� ������ ID(emp_id), �̸�(emp_name), Ŀ�̼Ǻ���(comm_pct)�� ��ȸ.

select emp_id, emp_name, comm_pct from emp
where comm_pct not between 0.2 and 0.3;


--EMP ���̺��� ����(job)�� 'IT_PROG' �ų� 'ST_MAN' �� ������  ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ.

select emp_id, emp_name, job from emp
where job in ('IT_PROG','ST_MAN');


--EMP ���̺��� ����(job)�� 'IT_PROG' �� 'ST_MAN' �� �ƴ� ������  ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ.

select emp_id, emp_name, job from emp
where job not in ('IT_PROG','ST_MAN');


--EMP ���̺��� ���� �̸�(emp_name)�� S�� �����ϴ� ������  ID(emp_id), �̸�(emp_name)

select emp_id, emp_name from emp
where emp_name like 'S%';


--EMP ���̺��� ���� �̸�(emp_name)�� S�� �������� �ʴ� ������  ID(emp_id), �̸�(emp_name)

select emp_id, emp_name from emp
where emp_name not like 'S%';


--EMP ���̺��� ���� �̸�(emp_name)�� en���� ������ ������  ID(emp_id), �̸�(emp_name)�� ��ȸ

select emp_id, emp_name
from emp
where emp_name like '%en';


--EMP ���̺��� ���� �̸�(emp_name)�� �� ��° ���ڰ� ��e���� ��� ����� �̸��� ��ȸ

select emp_name
from emp
where emp_name like '__e%';


-- EMP ���̺��� ������ �̸��� '%' �� ���� ������ ID(emp_id), �����̸�(emp_name) ��ȸ

select emp_id, emp_name
from emp
where emp_name like '%\%%' escape '\';


--EMP ���̺��� �μ���(dept_name)�� null�� ������ ID(emp_id), �̸�(emp_name), �μ���(dept_name)�� ��ȸ.

select emp_id, emp_name, dept_name
from emp
where dept_name is null;


--�μ���(dept_name) �� NULL�� �ƴ� ������ ID(emp_id), �̸�(emp_name), �μ���(dept_name) ��ȸ

select emp_id,emp_name, dept_name
from emp
where dept_name is not null;


--TODO: EMP ���̺��� ����(job)�� 'IT_PROG'�� �������� ��� �÷��� �����͸� ��ȸ. 

select * from emp
where job = 'IT_PROG';

--TODO: EMP ���̺��� ����(job)�� 'IT_PROG'�� �ƴ� �������� ��� �÷��� �����͸� ��ȸ. 

select * from emp
where job <> 'IT_PROG';

--TODO: EMP ���̺��� �̸�(emp_name)�� 'Peter'�� �������� ��� �÷��� �����͸� ��ȸ

select * from emp
where emp_name = 'Peter';

--TODO: EMP ���̺��� �޿�(salary)�� $10,000 �̻��� ������ ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ

select emp_id, emp_name, salary
from emp
where salary >= 10000;

--TODO: EMP ���̺��� �޿�(salary)�� $3,000 �̸��� ������ ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ

select emp_id, emp_name, salary from emp
where salary < 3000;

--TODO: EMP ���̺��� �޿�(salary)�� $3,000 ������ ������ ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ

select emp_id, emp_name, salary from emp
where salary <= 3000;

--TODO: �޿�(salary)�� $4,000���� $8,000 ���̿� ���Ե� �������� ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ

select emp_id, emp_name, salary from emp
where salary between 4000 and 8000;

--TODO: �޿�(salary)�� $4,000���� $8,000 ���̿� ���Ե��� �ʴ� ��� ��������  ID(emp_id), �̸�(emp_name), �޿�(salary)�� ǥ��

select emp_id, emp_name, salary
from emp
where salary not between 4000 and 8000;

--TODO: EMP ���̺��� 2007�� ���� �Ի��� ��������  ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ.

select emp_id, emp_name, hire_date
from emp
where hire_date >= '2007/01/01';

--TODO: EMP ���̺��� 2004�⿡ �Ի��� �������� ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ.

select emp_id, emp_name, hire_date
from emp
where hire_date between '2004/01/01' and '2004/12/31';
--where extract(year from hire_date) = 2004;
--extract(year|month|day from date) : date���� year,month,day�� ����
--extract(month from hire_date) : hire_date���� month���� ����

--TODO: EMP ���̺��� 2005�� ~ 2007�� ���̿� �Ի�(hire_date)�� �������� ID(emp_id), �̸�(emp_name), ����(job), �Ի���(hire_date)�� ��ȸ.

select emp_id, emp_name, job, hire_date
from emp
--where hire_date between '2005/01/01' and '2007/12/31';
where extract(year from hire_date) between 2005 and 2007;





--TODO: EMP ���̺��� ������ ID(emp_id)�� 110, 120, 130 �� ������  ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ

select emp_id, emp_name, job
from emp
where emp_id in (110,120,130);

--TODO: EMP ���̺��� �μ�(dept_name)�� 'IT', 'Finance', 'Marketing' �� �������� ID(emp_id), �̸�(emp_name), �μ���(dept_name)�� ��ȸ.

select emp_id, emp_name,dept_name
from emp
where dept_name in ('IT','Finance','Marketing');

--TODO: EMP ���̺��� 'Sales' �� 'IT', 'Shipping' �μ�(dept_name)�� �ƴ� �������� ID(emp_id), �̸�(emp_name), �μ���(dept_name)�� ��ȸ.

select emp_id, emp_name, dept_name
from emp
where dept_name not in ('Sales','IT','Shipping');

--TODO: EMP ���̺��� �޿�(salary)�� 17,000, 9,000,  3,100 �� ������ ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ.

select emp_id, emp_name, job,salary from emp
where salary in (17000,9000,3100);

--TODO EMP ���̺��� ����(job)�� 'SA'�� �� ������ ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ

select emp_id, emp_name, job
from emp
where job like '%SA%';

--TODO: EMP ���̺��� ����(job)�� 'MAN'�� ������ ������ ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ

select emp_id, emp_name, job
from emp
where job like '%MAN';
-- MAN���� �����ϴ°� : 'MAN%'
-- MAN�� �����ϴ� �� : '%MAN%'
-- MAN���� �����°� : '%MAN'


--TODO. EMP ���̺��� Ŀ�̼��� ����(comm_pct�� null��) ��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary) �� Ŀ�̼Ǻ���(comm_pct)�� ��ȸ

select emp_id, emp_name, salary, comm_pct
from emp
where comm_pct is null;

--TODO: EMP ���̺��� Ŀ�̼��� �޴� ��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary) �� Ŀ�̼Ǻ���(comm_pct)�� ��ȸ

select emp_id, emp_name, salary, comm_pct
from emp
where comm_pct is not null;

--TODO: EMP ���̺��� ������ ID(mgr_id) ���� ������ ID(emp_id), �̸�(emp_name), ����(job), �ҼӺμ�(dept_name)�� ��ȸ

select emp_id, emp_name, job, dept_name
from emp
where mgr_id is null;


--TODO : EMP ���̺��� ����(salary * 12) �� 200,000 �̻��� �������� ��� ������ ��ȸ.

select * from emp
where salary*12 >= 200000;


/* *************************************
 WHERE ������ �������� ���
 AND OR
 
 �� and �� -> ��: ��ȸ ��� ��
 ���� or ���� -> ����: ��ȸ ��� ���� �ƴ�.
 
 ���� �켱���� : and > or
 
 where ����1 and ����2 or ����3
 1. ���� 1 and ����2
 2. 1��� or ����3
 
 or�� ���� �Ϸ��� where ����1 and (����2 or ����3)
 **************************************/
-- EMP ���̺��� ����(job)�� 'SA_REP' �̰� �޿�(salary)�� $9,000 �� ������ ������ ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ.

select emp_id, emp_name, job, salary
from emp
where job = 'SA_REP' and salary = 9000;


-- EMP ���̺��� ����(job)�� 'FI_ACCOUNT' �ų� �޿�(salary)�� $8,000 �̻����� ������ ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ.

select emp_id, emp_name, job, salary
from emp
where job = 'FI_ACCOUNT' or salary >= 8000;

--TODO: EMP ���̺��� �μ�(dept_name)�� 'Sales��'�� ����(job)�� 'SA_MAN' �̰� �޿��� $13,000 ������ 
--      ������ ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary), �μ�(dept_name)�� ��ȸ

select emp_id, emp_name, job, salary, dept_name
from emp
where dept_name = 'Sales' and job = 'SA_MAN' and salary <= 13000;

--TODO: EMP ���̺��� ����(job)�� 'MAN'�� ���� ������ �߿��� �μ�(dept_name)�� 'Shipping' �̰� 2005������ �Ի��� 
--      ��������  ID(emp_id), �̸�(emp_name), ����(job), �Ի���(hire_date), �μ�(dept_name)�� ��ȸ

select emp_id, emp_name, job, hire_date, dept_name
from emp
where job like '%MAN%' and dept_name = 'Shipping' and hire_date >= '2005/01/01';

--TODO: EMP ���̺��� �Ի�⵵�� 2004���� ������� �޿��� $20,000 �̻��� 
--      �������� ID(emp_id), �̸�(emp_name), �Ի���(hire_date), �޿�(salary)�� ��ȸ.
select emp_id, emp_name, hire_date, salary
from emp
where extract(year from hire_date) = 2004 or salary >= 20000;


--TODO : EMP ���̺���, �μ��̸�(dept_name)��  'Executive'�� 'Shipping' �̸鼭 �޿�(salary)�� 6000 �̻��� ����� ��� ���� ��ȸ. 

select * from emp
where dept_name in ('Executive','Shipping') and salary >=6000;

--TODO: EMP ���̺��� ����(job)�� 'MAN'�� ���� ������ �߿��� �μ��̸�(dept_name)�� 'Marketing' �̰ų� 'Sales'�� 
--      ������ ID(emp_id), �̸�(emp_name), ����(job), �μ�(dept_name)�� ��ȸ

select emp_id, emp_name, job, dept_name
from emp
where job like '%MAN%' and dept_name in ('Marketing','Sales');


--TODO: EMP ���̺��� ����(job)�� 'MAN'�� ���� ������ �� �޿�(salary)�� $10,000 ������ �ų� 2008�� ���� �Ի��� 
--      ������ ID(emp_id), �̸�(emp_name), ����(job), �Ի���(hire_date), �޿�(salary)�� ��ȸ

select emp_id, emp_name, job, hire_date, salary
from emp
where job like '%MAN%' and ( salary <=10000 or hire_date >= '2008/01/01');

/* *************************************
order by�� �̿��� ����
- select���� ���� �������� ���� ����.
- order by ���ı����÷� ���Ĺ�� [, ���ı����÷� ���Ĺ��,...]
- ���ı����÷�
	- �÷��̸�.
	- select���� ����� ����.
	- ��Ī�� ���� ��� ��Ī.
- ���Ĺ��
	- asc : �������� (�⺻-��������)
	- desc : ��������
- ���ڿ�: Ư������< ���� < �빮�� < �ҹ��� < �ѱ�
- date : ���� < �̷�	

NULL ��
ASC : ������.  order by �÷��� asc nulls first
DESC : ó��.   order by �÷��� desc nulls last
-- nulls first, nulls last ==> ����Ŭ ����.

************************************* */

-- �������� ��ü ������ ���� ID(emp_id)�� ū ������� ������ ��ȸ

select * from emp
order by emp_id desc;

-- �������� id(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� 
-- ����(job) ������� (A -> Z) ��ȸ�ϰ� ����(job)�� ���� ��������  �޿�(salary)�� ���� ������� 2�� �����ؼ� ��ȸ.

select emp_id, emp_name, job, salary
from emp
order by job , salary desc;
order by 3, 4 desc; -- select ���� �������� �ؼ� 3��°(job), 4��°(salary) �÷� ���� ���� **���̺��� �÷� ������ �ƴ�

--�μ����� �μ���(dept_name)�� ������������ ������ ��ȸ�Ͻÿ�.

select dept_name from emp
order by dept_name asc;

--TODO: �޿�(salary)�� $5,000�� �Ѵ� ������ ID(emp_id), �̸�(emp_name), �޿�(salary)�� �޿��� ���� �������� ��ȸ

select emp_id, emp_name, salary
from emp
where salary > 5000
order by salary desc;

--TODO: �޿�(salary)�� $5,000���� $10,000 ���̿� ���Ե��� �ʴ� ��� ������  ID(emp_id), �̸�(emp_name), �޿�(salary)�� �̸�(emp_name)�� ������������ ����

select emp_id, emp_name, salary
from emp
where salary not between 5000 and 10000
order by emp_name;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), ����(job), �Ի���(hire_date)�� �Ի���(hire_date) ��(��������)���� ��ȸ.

select emp_id, emp_id, emp_name, job, hire_date
from emp
order by hire_date;

--TODO: EMP ���̺��� ID(emp_id), �̸�(emp_name), �޿�(salary), �Ի���(hire_date)�� �޿�(salary) ������������ �����ϰ� �޿�(salary)�� ���� ���� �Ի���(hire_date)�� ������ ������ ����.

select emp_id, emp_name, salary, hire_date
from emp
order by 3,4;
