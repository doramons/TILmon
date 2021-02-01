/* *************************************
�Լ� - ���ڿ����� �Լ�
 UPPER()/ LOWER() : �빮��/�ҹ��� �� ��ȯ
 INITCAP(): �ܾ� ù���ڸ� �빮�� ������ �ҹ��ڷ� ��ȯ
 LENGTH() : ���ڼ� ��ȸ
 LPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� ���ʺ��� "ä�ﰪ"���� ä���.
 RPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� �����ʺ��� "ä�ﰪ"���� ä���.
 SUBSTR(��, ����index, ���ڼ�) - "��"���� "����index"��° ���ں��� ������ "���ڼ�" ��ŭ�� ���ڿ��� ����. ���ڼ� ������ ������. 
 REPLACE(��, ã�����ڿ�, �����ҹ��ڿ�) - "��"���� "ã�����ڿ�"�� "�����ҹ��ڿ�"�� �ٲ۴�.
 LTRIM(��): �ް��� ����
 RTRIM(��): �������� ����
 TRIM(��): ���� ���� ����
 ************************************* */
 select upper('abc')
 from dual;
 
 select upper(emp_name)
 from emp;
 
 select emp_name from emp;
 
 select upper('abcDE') "�ҹ��ڸ� �빮�ڷ�",
        lower('AbcDE') "�빮�ڸ� �ҹ��ڷ�",
        initcap('aabcde abcde abcde') "�ܾ��� ù ���ڸ� �빮��"
 from dual;

select length('abcdef') "���ڼ�"
from dual;

select * from emp
where length(emp_name) =3;

select lpad('abc',10, '+') "A",
       length(lpad('abc',10)),
       rpad('abc',10) "B"
from dual;

select substr('123456789',2,5) -- 2��° ���ں��� 5���ڸ� ��ȸ
from dual;

select replace('010-1111-2222', '1111', '####') from dual;
select trim('     abc    ') "A" from dual;
select ltrim('     abc    ') "B" from dual;
select rtrim('      abc      ') "C" from dual;

--EMP ���̺��� ������ �̸�(emp_name)�� ��� �빮��, �ҹ���, ù���� �빮��, �̸� ���ڼ��� ��ȸ

select upper(emp_name) "�빮���̸�",
       lower(emp_name) "�ҹ����̸�",
       initcap(emp_name) "ù���ڸ��빮��",
       length(emp_name) "�̸����ڼ�"
from emp;

-- TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �μ�(dept_name)�� ��ȸ. �� �����̸�(emp_name)�� ��� �빮��, �μ�(dept_name)�� ��� �ҹ��ڷ� ���.
-- UPPER/LOWER

select emp_id, upper(emp_name), salary, lower(dept_name)
from emp;

--(�Ʒ� 2���� �񱳰��� ��ҹ��ڸ� Ȯ���� �𸣴� ����)
--TODO: EMP ���̺��� ������ �̸�(emp_name)�� PETER�� ������ ��� ������ ��ȸ�Ͻÿ�.

select * from emp
where upper(emp_name) = 'PETER';

--TODO: EMP ���̺��� ����(job)�� 'Sh_Clerk' �� ��������  ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ

select emp_id, emp_name, job, salary
from emp
where initcap(job) = 'Sh_Clerk';

--TODO: ���� �̸�(emp_name) �� �ڸ����� 15�ڸ��� ���߰� ���ڼ��� ���ڶ� ��� ������ �տ� �ٿ� ��ȸ. ���� �µ��� ��ȸ

select lpad(emp_name,15)
from emp;
    
--TODO: EMP ���̺��� ��� ������ �̸�(emp_name)�� �޿�(salary)�� ��ȸ.
--(��, "�޿�(salary)" ���� ���̰� 7�� ���ڿ��� �����, ���̰� 7�� �ȵ� ��� ���ʺ��� �� ĭ�� '_'�� ä��ÿ�. EX) ______5000) -LPAD() �̿�

select emp_name, lpad(salary, 7,'-')
from emp;

select lpad('1234',10, '_')

from dual;

SELECT LPAD('abc', 5, '_') FROM dual;

-- TODO: EMP ���̺��� �̸�(emp_name)�� 10���� �̻��� �������� �̸�(emp_name)�� �̸��� ���ڼ� ��ȸ

select emp_name, length(emp_name)
from emp
where length(emp_name) >=10;
 

/* *************************************
�Լ� - ���ڰ��� �Լ�
 - ���: ����, �Ǽ� ��� ���ü� ����
 round(��, �ڸ���) : �ڸ������Ͽ��� �ݿø� (��� - �Ǽ���, ���� - ������, �⺻�� : 0)
 trunc(��, �ڸ���) : �ڸ������Ͽ��� ����(��� - �Ǽ���, ���� - ������, �⺻��: 0)
 - ���: �����θ� ����
 ceil(��) : �ø�
 floor(��) : ����
 mod(�����¼�, �����¼�) : �������� ������ ����
 
************************************* */
select round(15.2345,2),
       round(15.2345,1),
       round(15.5345,0),
       round(15.5312, -1)
from dual;

select trunc(12.5351,2),
       trunc(12.5351,-1)
from dual;

select ceil(13.45)
from dual;
select floor(15.24)
from dual;

select mod(5,3)
from dual;

--TODO: EMP ���̺��� �� ������ ���� ����ID(emp_id), �̸�(emp_name), �޿�(salary) �׸��� 15% �λ�� �޿�(salary)�� ��ȸ�ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--(��, 15% �λ�� �޿��� �ø��ؼ� ������ ǥ���ϰ�, ��Ī�� "SAL_RAISE"�� ����.)

select emp_id, emp_name, salary, ceil(salary*1.15) "SAL_RAISE" from emp;

--TODO: ���� SQL������ �λ� �޿�(sal_raise)�� �޿�(salary) ���� ������ �߰��� ��ȸ (����ID(emp_id), �̸�(emp_name), 15% �λ�޿�, �λ�� �޿��� ���� �޿�(salary)�� ����)

select emp_id, emp_name, salary*1.15 ,salary*1.15-salary
from emp;

-- TODO: EMP ���̺��� Ŀ�̼��� �ִ� �������� ����_ID(emp_id), �̸�(emp_name), Ŀ�̼Ǻ���(comm_pct), Ŀ�̼Ǻ���(comm_pct)�� 8% �λ��� ����� ��ȸ.
--(�� Ŀ�̼��� 8% �λ��� ����� �Ҽ��� ���� 2�ڸ����� �ݿø��ϰ� ��Ī�� comm_raise�� ����)

select emp_id, emp_name, comm_pct, round(comm_pct*1.08,2) "comm_raise"
from emp;


/* *************************************
�Լ� - ��¥���� ��� �� �Լ�

Date +- ���� : ��¥ ���.
months_between(d1, d2) -����� ������(d1�� �ֱ�, d2�� ����)
add_months(d1, ����) - �������� ���� ��¥. ������ ��¥�� 1���� �Ĵ� ���� ������ ���� �ȴ�. 
next_day(d1, '����') - d1���� ù��° ������ ������ ��¥. ������ �ѱ�(locale)�� �����Ѵ�.
last_day(d) - d ���� ��������.
extract(year|month|day from date) - date���� year/month/day�� ����
************************************* */
select sysdate,--�Ű������� ���� ��쿡�� ��ȣ�� ġ�� ���� Ű����ó�� �������� �Լ��� cf ���̽㿡���� �Ű������� ���� �Լ��� �Լ�() �̷��� ��
       to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') -- ��ȸ�Ҷ� ���ٴ� insert �Ҷ� �� ���� ����
from dual;
--to_char(date��, '��¥����') date�� ���ڿ��� ��ȯ
select  sysdate +10 "10�� ��"
from dual;

select months_between(sysdate, '2020/12/28')||'����',
       months_between(sysdate, '2019/10/28')||'����',
       ceil(months_between(sysdate, '2020/12/26'))||'����'
from dual;

select add_months(sysdate, 2), --���: 2������
       add_months(sysdate, -2), --����: 2������
       add_months('2021/01/31',1) -- �������� �������� ��� �Ĵ� �� ���� ������ ���� ���� (2�� 28�� �����ٰ��ؼ� 3�� 3�� �̷��� ������x)
from dual;

select next_day(sysdate, '�ݿ���'),
       next_day(sysdate, '������') -- ���ƿ��� �ش� ������ ���� ���� ��¥�� �˷���
from dual;


select last_day(sysdate) from dual; -- �� ���� ������ ��¥ ��ȸ
select extract(year from sysdate),
       extract(month from sysdate),
       extract(day from sysdate)
from dual;

select * from emp
where extract(month from hire_date) = 11;

--TODO: EMP ���̺��� �μ��̸�(dept_name)�� 'IT'�� �������� '�Ի���(hire_date)�� ���� 10����', �Ի��ϰ� '�Ի��Ϸ� ���� 10����',  �� ��¥�� ��ȸ. 

select hire_date -10 "�Ի�10����",hire_date "�Ի���",hire_date+10 "�Ի�10����"
from emp
where dept_name = 'IT';

--TODO: �μ��� 'Purchasing' �� ������ �̸�(emp_name), �Ի� 6�������� �Ի���(hire_date), 6������ ��¥�� ��ȸ.

select emp_name,
       add_months(hire_date, -6) "6������",
       hire_date, 
       add_months(hire_date, 6) "6������"
from emp
where dept_name = 'Purchasing';

--TODO: EMP ���̺��� �Ի��ϰ� �Ի��� 2�� ��, �Ի��� 2�� �� ��¥�� ��ȸ.

select hire_date,
       add_months(hire_date, -2),
       add_months(hire_date,2)
from emp;

-- TODO: �� ������ �̸�(emp_name), �ٹ� ������ (�Ի��Ͽ��� ��������� �� ��)�� ����Ͽ� ��ȸ.
--(�� �ٹ� �������� �Ǽ� �� ��� ������ �ݿø�. �ٹ������� ������������ ����.)

select emp_name,
       round(months_between(sysdate, hire_date),0)||'����'
from emp;

--TODO: ���� ID(emp_id)�� 100 �� ������ �Ի��� ���� ù��° �ݿ����� ��¥�� ���Ͻÿ�.

select next_day(hire_date, '�ݿ���')
from emp
where emp_id = 100;

/* *************************************
�Լ� - ��ȯ �Լ�

##############	#							############	#						############	#
#								# = to_char() =>	#							#<=to_char()=	#							#
#   Number Ÿ��		    #							#  Character Ÿ��		#						#  Date Ÿ��			#
#								# <=to_number()=	#							#=to_date()=>	#							#
###############							############	#						############	#
to_�ٲܵ�����Ÿ��()
ex. ���ڿ��� �ٲٴ� �Լ� : to_char() 
    ���ڷ� �ٲٴ� �Լ�: to_number()(Ư�� ������ ������ �ִ� ���ڿ��� ���ڷ� �ٲ�)
    ��¥�� �ٲٴ� �Լ�: to_date()

to_char() : ������, ��¥���� ���������� ��ȯ
to_number() : �������� ���������� ��ȯ 
to_date() : �������� ��¥������ ��ȯ

to_xxxx(��, ����)


����(format)���� 
���� :
    0, 9 : ���ڰ� �� �ڸ��� ����. (9: ������ �����ڸ��� �������� ä��, 0�� 0���� ä��) - �Ǽ��� ���� �ڸ��� �Ѵ� 0���� ä���.
           fm���� �����ϸ� 9�� ��� ������ ����.
        ex. 0000.0000 => 12.12 : 0012.1200
            9999.9999 => 12.12 : 12.1200
    . : ����/�Ǽ��� ������.
    ,: ������ ����������
    'L', '$' : ��ȭǥ��. L; ������ȭ��ȣ
�Ͻ� : yyyy : ���� 4�ڸ�, yy: ���� 2�ڸ�(2000���), rr: ����2�ڸ�(50�̻�:90���, 50�̸�:2000���)
     , mm: �� 2�ڸ�  (11, 05)
     , dd: �� 2�ڸ�
     , hh24: �ð�(00 ~ 23) 2�ڸ�, hh(01 ~ 12)
     , mi: �� 2�ڸ�
     , ss: �� 2�ڸ�
     , day(����), 
     , am �Ǵ� pm : ����/����
************************************* */
select 10+to_number('1,000','9,999') from dual;
select to_char(10000000,'999,999,999') from dual;
'100,000,000'

select to_char(salary, '99,999')
from emp;

select 10+to_number('1,000.53','9,999.99')
from dual;

select to_char(12345678, '999,999,999'),
       to_char(12345678, 'fm999,999,999') - ������ ���ְڴ� �ϸ� fm�� �ٿ��ָ��
from dual;
999,999,999

select to_char(12345678, '999,999,999'),
       to_char(12345678, 'fm999,999,999'),
       to_char(12345678, '999,999'),
       to_char(100000,'$999,999'),
       to_char(100000, 'L999,999')
from dual;

select to_char(1234.567, '0,000.000'),
       to_char(1234.56, '000,000.000'),
       to_char(1234.56, '999,999.999')
from dual;

select sysdate
from dual;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
       to_char(sysdate, 'yyyy'),
       to_char(sysdate, 'dy'),
       to_char(sysdate,'day'),
       to_char(sysdate, 'dd'),
       to_char(sysdate, 'hh24:mi:ss'),
       to_char(sysdate, 'yyyy"��" mm"��" dd"��"')
from dual;

select to_date('2000/10', 'yyyy/mm') from dual; --dd���� default���� 01�� ���
    

       


-- EMP ���̺��� ����(job)�� "CLERK"�� ���� �������� ID(emp_id), �̸�(name), ����(job), �޿�(salary)�� ��ȸ
--(�޿��� ���� ������ , �� ����ϰ� �տ� $�� �ٿ��� ���.)

select emp_id, emp_name, job, to_char(salary, 'fm$999,999.00') "salary"
from emp
where job like '%CLERK%';

-- ���ڿ� '20030503' �� 2003�� 05�� 03�� �� ���.

select to_char(to_date('20030503','yyyymmdd'), 'yyyy"��" mm"��" dd"��"') -- ���ڿ� ���¸� ��¥�� �ٲٰ� �װ� �ٽ� ���ڿ��� �ٲ�
from dual;

--��¥ : char(8) yyyymmdd
--�Ͻ� : char(15) yyyymmddhmiss

-- TODO: �μ���(dept_name)�� 'Finance'�� �������� ID(emp_id), �̸�(emp_name)�� �Ի�⵵(hire_date) 4�ڸ��� ����Ͻÿ�. (ex: 2004);
--to_char()

select emp_id, emp_name, to_char(hire_date, 'yyyy') -- extract(year from hire_date) �� �ᵵ ��
from emp
where dept_name = 'Finance';

--TODO: �������� 11���� �Ի��� �������� ����ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ
--to_char()

select emp_id, emp_name, hire_date
from emp
where extract(month from hire_date) = 11;

--TODO: 2006�⿡ �Ի��� ��� ������ �̸�(emp_name)�� �Ի���(yyyy-mm-dd ����)�� �Ի���(hire_date)�� ������������ ��ȸ
--to_char()

select emp_name, to_char(hire_date, 'yyyy-mm-dd')
from emp
order by hire_date;

--TODO: 2004�� 05�� ���� �Ի��� ���� ��ȸ�� �̸�(emp_name)�� �Ի���(hire_date) ��ȸ

select emp_name, hire_date
from emp
where to_char(hire_date, 'yyyymm') >= '200405';

--TODO: ���ڿ� '20100107232215' �� 2010�� 01�� 07�� 23�� 22�� 15�� �� ���. (dual ���Ժ� ���)

select to_char(to_date('20100107232215','yyyymmddhh24miss'),'yyyy"��" mm"��" dd"��" hh24"��" mi"��" ss"��"')
from dual;


/* *************************************
�Լ� - null ���� �Լ� 
NVL(expr, �⺻��) : expr ���� null�̸� �⺻����, null�� �ƴϸ� expr�� ��ȯ
NVL2(expr, nn, null) - expr�� null�� �ƴϸ� nn, ���̸� ����°
nullif(ex1, ex2) ���� ������ null, �ٸ��� ex1

************************************* */
select NVL(null, 0),    
       NVL(null, '����'), --null�̶� '����' ��ȯ
       NVL(20,0) -- null �� �ƴ϶� 20 ��ȯ
from dual;

select nullif(10,10),
       nullif(10,20)
from dual;

-- EMP ���̺��� ���� ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼Ǻ���(comm_pct)�� ��ȸ. �� Ŀ�̼Ǻ����� NULL�� ������ 0�� ��µǵ��� �Ѵ�..

select emp_id,
       emp_name,
       salary, 
       NVL(comm_pct,0)
from emp;


--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), ����(job), �μ�(dept_name)�� ��ȸ. �μ��� ���� ��� '�μ��̹�ġ'�� ���.

select emp_id "ID",
       emp_name "�̸�",
       job "����", 
       NVL(dept_name,'�μ��̹�ġ') "�μ�"
from emp;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼� (salary * comm_pct)�� ��ȸ. Ŀ�̼��� ���� ������ 0�� ��ȸ�Ƿ� �Ѵ�.

select emp_id,
       emp_name, 
       salary, 
       NVL2(comm_pct,salary*comm_pct,0)
from emp;

/* *************************************
DECODE�Լ��� CASE ��
-�����
decode(�÷�, [�񱳰�, ��°�, ...] , else���) --�Լ�

case�� ����� -- ����
case �÷� when �񱳰� then ��°�
              [when �񱳰� then ��°�]
              [else ��°�]
              end
              
case�� ���ǹ�
case when ���� then ��°�
       [when ���� then ��°�]
       [else ��°�]
       end

************************************* */
IF �÷� = 10 THEN 'A'
ELSE IF �÷� = 20 THEN 'B'
ELSE IF �÷� = 30 THEN 'C'
ELSE 'D'

decode(�÷�, 10,'A', 20, 'B',30,'C', 'D')

select emp_name, decode(dept_name, 'Shipping', '���', 'Sales','����', 'Purchasing', '����', 'Marketing' , '������', null,'�μ�����', dept_name)
from emp;
--EMP���̺��� �޿��� �޿��� ����� ��ȸ�ϴµ� �޿� ����� 10000�̻��̸� '1���', 10000�̸��̸� '2���' ���� �������� ��ȸ

select salary,
    case when salary >=10000 then '1���'
        else '2���'
    end "salary grade"
from emp;

--decode()/case �� �̿��� ����
-- �������� ��� ������ ��ȸ�Ѵ�. �� ������ ����(job)�� 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' ������� ������������ �Ѵ�. (������ JOB�� �������)

select * 
from emp
order by decode(job, 'ST_CLERK', '1', 'IT_PROG', '2','PU_CLERK','3','SA_MAN','4',job);
-- �÷���ſ� order by�� decode�� �̿��Ͽ� ��� ���� �ٲ㼭 ����

select *
from emp
order by case job when 'ST_CLERK' then '1'
                  when 'IT_PROG' then '2'
                  when 'PU_CLERK' then '3'
                  when 'SA_MAN' then '4'
                  else job end asc;

--TODO: EMP ���̺��� ����(job)�� 'AD_PRES'�ų� 'FI_ACCOUNT'�ų� 'PU_CLERK'�� �������� ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ. 
-- ����(job)�� 'AD_PRES'�� '��ǥ', 'FI_ACCOUNT'�� 'ȸ��', 'PU_CLERK'�� ��� '����'�� ��µǵ��� ��ȸ

select emp_id, emp_name, decode(job, 'AD_PRES','��ǥ','FI_ACCOUNT', 'ȸ��','PU_CLERK', '����')
from emp
where job in ('AD_PRES', 'FI_ACCOUNT', 'PU_CLERK');


--TODO: EMP ���̺��� �μ��̸�(dept_name)�� �޿� �λ���� ��ȸ. 
--�޿� �λ���� �μ��̸��� 'IT' �̸� �޿�(salary)�� 10%�� 'Shipping' �̸� �޿�(salary)�� 20%�� 'Finance'�̸� 30%�� �������� 0�� ���
-- decode �� case���� �̿��� ��ȸ

select dept_name,
       decode(dept_name, 'IT', salary*0.1,
                        'Shipping', salary*0.2,
                        'Finance', salary*0.3,0) "�λ�ȱ޿�2"
from emp;

select dept_name,
       case dept_name 
       when 'IT' then salary*0.1
       when 'Shipping' then salary*0.2
       when 'Finance' then salary*0.3
       else 0
       end "�λ�� �޿�2"
from emp;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �λ�� �޿��� ��ȸ�Ѵ�. 
--�� �޿� �λ����� �޿��� 5000 �̸��� 30%, 5000�̻� 10000 �̸��� 20% 10000 �̻��� 10% �� �Ѵ�.

select emp_id,
       emp_name,
       salary,
       case when salary < 5000 then salary*1.3
       when salary >=5000 and salary < 10000 then salary*1.2
       when salary >= 10000 then salary*1.1
       end "�λ�� �޿�"
from emp;
       



