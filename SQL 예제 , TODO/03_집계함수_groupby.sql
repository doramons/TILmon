/* **************************************************************************
����(Aggregation) �Լ��� GROUP BY, HAVING
************************************************************************** */

/* ************************************************************
�����Լ�, �׷��Լ�, ������ �Լ�
- �μ�(argument)�� �÷�.
  - sum(): ��ü�հ�
  - avg(): ���
  - min(): �ּҰ�
  - max(): �ִ밪
  - stddev(): ǥ������
  - variance(): �л�
  - count(): ����
        - �μ�: 
            - �÷���: null�� ������ ����
            -  *: �� ���(null�� ����)

- count(*) �� �����ϰ� ��� �����Լ��� null�� ���� ����Ѵ�.
- sum, avg, stddev, variance: number Ÿ�Կ��� ��밡��.
- min, max, count :  ��� Ÿ�Կ� �� ��밡��.
************************************************************* */

-- EMP ���̺��� �޿�(salary)�� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, ���������� ��ȸ 

select sum(salary)"���հ�",
       round(avg(salary),2)"���",
       min(salary)"�ּҰ�",
       max(salary)"�ִ밪",
       round(stddev(salary),2)"ǥ������",
       round(variance(salary),2)"�л�",
       count(*) "��������"
from emp;

-- EMP ���̺��� ���� �ֱ� �Ի���(hire_date)�� ���� ������ �Ի����� ��ȸ

select max(hire_date) "�����ֱ�",
       min(hire_date) "���������"
from emp;


-- EMP ���̺��� �μ�(dept_name) �� ������ ��ȸ

select count(dept_name)
from emp;

-- emp ���̺��� job ������ ���� ��ȸ

select count(distinct job)
from emp;

--TODO:  Ŀ�̼� ����(comm_pct)�� �ִ� ������ ���� ��ȸ

select count(comm_pct)
from emp;

select count(*) "Ŀ�̼� ������ �ִ� ���� ��"
from emp
where comm_pct is not null;

--TODO: Ŀ�̼� ����(comm_pct)�� ���� ������ ���� ��ȸ

select count(*) "Ŀ�̼� ������ ���� ���� ��"
from emp
where comm_pct is null;

select count(*) - count(comm_pct)
from emp;

--TODO: ���� ū Ŀ�̼Ǻ���(comm_pct)�� �� ���� ���� Ŀ�̼Ǻ����� ��ȸ

select max(comm_pct),
       min(comm_pct)
from emp;

--TODO:  Ŀ�̼� ����(comm_pct)�� ����� ��ȸ. 
--�Ҽ��� ���� 2�ڸ����� ���

select round(avg(nvl(comm_pct,0)),2)-- Ŀ�̼� ���� ����� ������ ���� ���� Ŀ�̼� ���,Ŀ�̼� ������ ���� ����� �ڵ����� nulló�� �Ǳ⶧���� 0���� ó���ϰ� �� �Ŀ� avg��
       round(avg(comm_pct),2) --Ŀ�̼��� �ִ� ������� ���
from emp;

--TODO: ���� �̸�(emp_name) �� ���������� �����Ҷ� ���� ���߿� ��ġ�� �̸��� ��ȸ.

select max(emp_name)
from emp;

--TODO: �޿�(salary)���� �ְ� �޿��װ� ���� �޿����� ������ ���

select max(salary),
       min(salary),
       max(salary)-min(salary)
from emp;

--TODO: ���� �� �̸�(emp_name)�� ����� ���� ��ȸ.

select max(length(emp_name))
from emp;


--TODO: EMP ���̺��� �μ�(dept_name)�� �������� �ִ��� ��ȸ. 
-- ���������� ����

select count(distinct dept_name) --null�� ���� ��
from emp;

select count(distinct nvl(dept_name, 'a')) --null�����ϰ� ��
from emp;


/* *****************************************************
group by ��
- Ư�� �÷�(��)�� ������ ���� ������ �� ������ �����÷��� �����ϴ� ����.
	- ��) ������ �޿����. �μ�-������ �޿� �հ�. ���� �������
- ����: group by �÷��� [, �÷���]
	- �÷�: �з���(������, �����) - �μ��� �޿� ���, ���� �޿� �հ�
	- select�� where �� ������ ����Ѵ�.
	- select ������ group by ���� ������ �÷��鸸 �����Լ��� ���� �� �� �ִ�
*******************************************************/

-- ����(job)�� �޿��� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, �������� ��ȸ

select job,
       sum(salary),
       round(avg(salary),2),
       min(salary),
       max(salary),
       round(stddev(salary),2),
       round(variance(salary),2),
       count(*)
from emp
group by job;

-- �Ի翬�� �� �������� �޿� ���.

select extract(year from hire_date)"�Ի翬��",
       round(avg(salary),2)
from emp
group by extract(year from hire_date);
    

-- �μ���(dept_name) �� 'Sales'�̰ų� 'Purchasing' �� �������� ������ (job) �������� ��ȸ

select dept_name,
       job,
       count(*)
from emp
where dept_name in ('Sales','Purchasing')
group by dept_name,job
order by dept_name;

-- �μ�(dept_name), ����(job) �� �ִ� ��ձ޿�(salary)�� ��ȸ.

select dept_name,
       job,
       max(salary)
from emp
group by dept_name, job
order by dept_name;

-- �޿�(salary) ������ �������� ���. �޿� ������ 10000 �̸�,  10000�̻� �� ����.

select case when salary<10000 then '10000�̸�'
            when salary >= 10000 then '10000�̻�' end "�޿�����",
       count(*)
from emp
group by case when salary<10000 then '10000�̸�'
            when salary >= 10000 then '10000�̻�' end;



--TODO: �μ���(dept_name) �������� ��ȸ

select dept_name,
       count(*)
from emp
group by dept_name
order by count(*) desc;

--TODO: ������(job) �������� ��ȸ. �������� ���� �ͺ��� ����.

select job,
       count(*)
from emp
group by job
order by count(*) desc;

--TODO: �μ���(dept_name), ����(job)�� ������, �ְ�޿�(salary)�� ��ȸ. �μ��̸����� �������� ����.

select dept_name,
       job,
       count(*),
       max(salary)
from emp
group by dept_name, job
order by dept_name;

--TODO: EMP ���̺��� �Ի翬����(hire_date) �� �޿�(salary)�� �հ��� ��ȸ. 
--(�޿� �հ�� �ڸ������� , �� �����ÿ�. ex: 2,000,000)

select extract(year from hire_date) "�Ի翬��",
       to_char(sum(salary), 'L9,999,999')"�޿��հ�"
from emp
group by extract(year from hire_date);

--TODO: ����(job)�� �Ի�⵵(hire_date)�� ��� �޿�(salary)�� ��ȸ

select job ����,
       to_char(hire_date, 'yyyy') �Ի�⵵,
       round(avg(salary),2) ��ձ޿�
from emp
group by job,
       to_char(hire_date, 'yyyy');

--TODO: �μ���(dept_name) ������ ��ȸ�ϴµ� �μ���(dept_name)�� null�� ���� �����ϰ� ��ȸ.

select dept_name,
       count(*)
from emp
where dept_name is not null
group by dept_name;

--TODO �޿� ������ �������� ���. �޿� ������ 5000 �̸�, 5000�̻� 10000 �̸�, 10000�̻� 20000�̸�, 20000�̻�. 

select case when salary<5000 then '5000�̸�'
            when salary between 5000 and 9999.99 then '5000�̻� 10000 �̸�'
            when salary>= 10000 and salary <20000 then '10000�̻� 20000�̸�'
            else '20000 �̻�' end "�޿����",
       count(*)
from emp
group by case when salary<5000 then '5000�̸�'
            when salary between 5000 and 9999.99 then '5000�̻� 10000 �̸�'
            when salary>= 10000 and salary <20000 then '10000�̻� 20000�̸�'
            else '20000 �̻�' end;

/* **************************************************************
having ��
- �������� ���� �� ���� ����
- group by ���� order by ���� �´�.
- ����
    having ��������  --�����ڴ� where���� �����ڸ� ����Ѵ�. �ǿ����ڴ� �����Լ�(�� ���)
************************************************************** */
-- �������� 10 �̻��� �μ��� �μ���(dept_name)�� �������� ��ȸ

select dept_name,
       count(*)
from emp
group by dept_name
having count(*) >=10;


--TODO: 15�� �̻��� �Ի��� �⵵�� (�� �ؿ�) �Ի��� �������� ��ȸ.

select to_char(hire_date, 'yyyy') �Ի�⵵,
       count(*)
from emp
group by to_char(hire_date, 'yyyy')
having count(*) >= 15;


--TODO: �� ����(job)�� ����ϴ� ������ ���� 10�� �̻��� ����(job)��� ��� �������� ��ȸ

select job,
       count(*)
from emp
group by job
having count(*) >= 10;


--TODO: ��� �޿���(salary) $5000�̻��� �μ��� �̸�(dept_name)�� ��� �޿�(salary), �������� ��ȸ

select dept_name,
       round(avg(salary),2),
       count(*)
from emp
group by dept_name
having avg(salary) >= 5000;


--TODO: ��ձ޿��� $5,000 �̻��̰� �ѱ޿��� $50,000 �̻��� �μ��� �μ���(dept_name), ��ձ޿��� �ѱ޿��� ��ȸ

select dept_name,
       round(avg(salary),2),
       sum(salary)
from emp
group by dept_name
having avg(salary)>=5000 and sum(salary)>=50000;

       


--TODO ������ 2�� �̻��� �μ����� �̸��� �޿��� ǥ�������� ��ȸ

select dept_name,
       round(stddev(salary),2),
       count(*)
from emp
group by dept_name
having count(*) >=2;


/* **************************************************************
- rollup : group by�� Ȯ��.
  -  group by�� ���� ��� ��������(�߰����質 ������)�� �κ� ���迡 �߰��ؼ� ��ȸ�Ѵ�.
  - ���� : group by rollup(�÷��� [,�÷���,..])



- grouping(), grouping_id()
  - rollup �̿��� ����� �÷��� �� ���� ���迡 �����ߴ��� ���θ� ��ȯ�ϴ� �Լ�.
  - case/decode�� �̿��� ���̺��� �ٿ� �������� ���� �� �ִ�.
  - ��ȯ��
	- 0 : ������ ���
	- 1 : ���� ���� ���.
 

- grouping() �Լ� 
 - ����: grouping(groupby�÷�)
 - select ���� ���Ǹ� rollup�̳� cube�� �Բ� ����ؾ� �Ѵ�.
 - group by�� �÷��� �����Լ��� ���迡 �����ߴ��� ���θ� ��ȯ
	- ��ȯ�� 0 : ������(�κ������Լ� ���), ��ȯ�� 1: ���� ����(���������� ���)
 - ���� �������� �κ������� ��������� �˷��ִ� �� �� �ִ�. 



- grouping_id
  - ����: grouping_id(groupby �÷�, ..)
  - ������ �÷��� ���迡 ���Ǿ����� ���� 2����(0: ���� ����, 1: ������)�� ��ȯ �ѵ� 10������ ��ȯ�ؼ� ��ȯ�Ѵ�.
 
************************************************************** */

-- EMP ���̺��� ����(job) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.

select job,
       round(avg(salary),2)
from emp
group by rollup(job); --��ü ����� ���� groupby job�� ó���ϰ� ���� group by���� ���� ��ü ����� ���� �ؿ� ����

-- EMP ���̺��� ����(JOB) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
-- ���� �÷���  �Ұ質 �Ѱ��̸� '�����'��  �Ϲ� �����̸� ����(job)�� ���




-- EMP ���̺��� �μ�(dept_name), ����(job) �� salary�� �հ�� �������� �Ұ�� �Ѱ谡 �������� ��ȸ




--# �Ѱ�/�Ұ� ���� ��� :  �Ѱ�� '�Ѱ�', �߰������ '��' �� ���
--TODO: �μ���(dept_name) �� �ִ� salary�� �ּ� salary�� ��ȸ




--TODO: ���_id(mgr_id) �� ������ ���� �Ѱ踦 ��ȸ�Ͻÿ�.


       

--TODO: �Ի翬��(hire_date�� year)�� �������� ���� ���� �հ� �׸��� �Ѱ谡 ���� ��µǵ��� ��ȸ.




--TODO: �μ���(dept_name), �Ի�⵵�� ��� �޿�(salary) ��ȸ. �μ��� ����� �����谡 ���� �������� ��ȸ



