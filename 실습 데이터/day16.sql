/* PL/SQL ������ ���� ������ ����� Ư¡�� ��� ����ϱ� ����.
   DB���ο��� ����Ǳ� ������ �ӵ��� �������� ����.
*/ -- �⺻ ������ ���(Block)�̶�� �ϸ� �̸���, �����, ����η� ������.
 -- �̸��δ� ����� ��Ī�� ���µ� ������ ���� �͸� ����� �ȴ�.

 DECLARE             -- �̸�����
 vi_num NUMBER;  -- vi_num NUMBERA :=100; �̷��� �ѹ��� �����ص���
 BEGIN                 -- begin���� ���� end�� �ݾ�����Ѵ� 
  vi_num :=100; -- := �Ҵ��� �ǹ�
  DBMS_OUTPUT.PUT_LINE(vi_num); -- �ܼ� ����Ʈ
  END;
  -- ������ ������ ���� �� ����
  
DECLARE
 vs_emp_name VARCHAR2(80);
 vs_dep_name departments.department_name%TYPE; --���̺� �ִ� SELECT ���� �������ִ�
BEGIN
 SELECT a.emp_name, b.department_name
 INTO vs_emp_name, vs_dep_name --��°���� ������ ��¹�
 FROM employees a, departments b
 WHERE a.department_id = b.department_id
 AND a.employee_id = 100;
 DBMS_OUTPUT.PUT_LINE(vs_emp_name || ':' || vs_dep_name);
END;

-- IF��
DECLARE
 vn_user_num NUMBER := TO_NUMBER(:userNm); -- ���ε� (�������� ���� ������ ���)
 vn_com_num NUMBER := 10;
BEGIN
 IF vn_user_num > vn_com_num THEN -- ���� 1
    DBMS_OUTPUT.PUT_LINE('user ���ڰ� �� ŭ');
 ELSIF vn_user_num = vn_com_num THEN -- ����2
     DBMS_OUTPUT.PUT_LINE('����');
     ELSE
     DBMS_OUTPUT.PUT_LINE('USER ���ڰ� �� ����');
 END IF; --IF �� ����  END IF�� ����.
END;

-- ������ �ʿ������ BEGIN
BEGIN
    DBMS_OUTPUT.PUT_LINE('3 * 3 = ' || 3 * 3 );
END;

/*
    ���Ի��� ���Խ��ϴ�. ^^
    �����й��� ���� ���� �й��� ã�� +1�� �Ͽ� �й��� ���� �� �л����̺� �������ּ���
    ���� ���� ù �л��̶�� �ش� �⵵�� 000001�� �ٿ��� �й��� ����.
    
    1. ���س⵵
    2. �й��� MAX��
    3. 2.�й��� ���ڸ� 4�ڸ� ���س⵵ �� 
    4. ���ǹ�
    5. INSERT
*/

SELECT TO_CHAR(SYSDATE,'yyyy')
FROM dual;

SELECT MAX(�й�)
FROM �л�;

DECLARE
    vs_nm �л�.�̸�%TYPE := :nm;
    vs_subject �л�.����%TYPE := :sub;
    vn_year VARCHAR2(4) := TO_CHAR(SYSDATE,'YYYY');
    vn_max_num NUMBER;
    vn_make_num NUMBER;
BEGIN
    SELECT MAX(�й�)
    INTO vn_max_num
    FROM �л�;
    
    IF vn_year = SUBSTR(vn_max_num,1,4) THEN
    vn_make_num := vn_max_num +1;
    ELSE
    vn_make_num := TO_NUMBER(vn_year || '000001');
    END IF;
    INSERT INTO �л�(�й�, �̸�, ����)
    VALUES (vn_make_num, vs_nm, vs_subject);
    COMMIT;
END;
select *
from �л�;

/*
    LOOP ��
    �ܼ�LOOP���� EXIT(Ż������) �ʼ�
    WHILE �� ���ۿ� ������ true�̸� LOOP����
    FOR �� IN �ʱ갪.. �ִ밪 1�� �ʱ갩���� �ִ밪���� ����
*/
DECLARE
 vn_gugdan NUMBER :=3;
 vn_i NUMBER :=1;
BEGIN
    LOOP
    DBMS_OUTPUT.PUT_LINE(vn_gugdan || '*' ||vn_i || '='|| vn_gugdan*vn_i);
    vn_i := vn_i + 1;
    EXIT WHEN vn_i > 9; --Ż������
    END LOOP;
END;

-- 2~9�� ���
DECLARE
 vn_gugdan NUMBER :=1;
 vn_i NUMBER :=1;
BEGIN
 LOOP
    vn_gugdan := vn_gugdan +1;
     DBMS_OUTPUT.PUT_LINE(vn_gugdan || '��');
    LOOP
    DBMS_OUTPUT.PUT_LINE(vn_gugdan || '*' ||vn_i || '='|| vn_gugdan*vn_i);
    vn_i := vn_i + 1;
    EXIT WHEN vn_i > 9; --Ż������
    END LOOP;
    vn_i := 1;
    EXIT WHEN vn_gugdan > 8; --Ż������
    END LOOP;
END;

-- 5�� �� �ȳ����� ��
DECLARE
 vn_gugdan NUMBER :=1;
 vn_i NUMBER :=1;
BEGIN
 LOOP
    vn_gugdan := vn_gugdan +1;
    CONTINUE WHEN vn_gugdan = 5; --�ش� ���� �϶� �Ʒ� �ǳʶ�
     DBMS_OUTPUT.PUT_LINE(vn_gugdan || '��');
     
    LOOP
    DBMS_OUTPUT.PUT_LINE(vn_gugdan || '*' ||vn_i || '='|| vn_gugdan*vn_i);
    vn_i := vn_i + 1;
    EXIT WHEN vn_i > 9; --Ż������
    END LOOP;
    vn_i := 1;
    EXIT WHEN vn_gugdan > 8; --Ż������
    END LOOP;
END;

-- FOR ��
BEGIN 
 FOR i IN 1..9 -- 1~9���� 1������  i�� ������ �����ϰ� �ٸ��� �҈��� �� �� ����.
--  FOR i IN REVERSE 1..9 �� 9~1 ���� 1�� ����
 LOOP
    DBMS_OUTPUT.PUT_LINE(2 || '*' || i|| '=' || 2 * i);
 END LOOP;
END;

/*
    oracle ����� ���� �Լ� pl/sql�� �ۼ� 
    ����Ŭ �Լ��� ������ ���ϰ��� 1�� �־����.
*/
-- �̸��� �Է¹޾� �й��� �����ϴ� �Լ� �ۼ�
-- input:varchar2, output:number
CREATE OR REPLACE FUNCTION fn_get_hakno (nm VARCHAR2)
 RETURN NUMBER
IS  --�̸��ִ� ��� �ۼ��� ����� IS�� ����
 vn_hakno NUMBER;
BEGIN
    SELECT �й�
    INTO vn_hakno
    FROM �л�
    WHERE �̸� = nm;
    RETURN vn_hakno;
END;

SELECT fn_get_hakno('�ּ���') --���� ����������Լ� ����� �����(���� �Լ� ó�� �����)
FROM dual;

-- �л��̸��� �Է¹޾� �Ѽ��� ������ �����ϴ� �Լ��� ����ÿ�
-- input:varhcar2, output:number
-- 1.�̸����� �������� ���ϴ� select�� �ۼ�
-- 2.pl/sql�� Ȱ���Ͽ� �Լ� �ۼ�
select *
from ����;

-- 1.�̸����� �������� ���ϴ� select��
select sum(����) as ������
from �л�,��������,����
where �л�.�й� = ��������.�й�
 AND ��������.�����ȣ = ����.�����ȣ
 and �л�.�̸� = '�ּ���';
 
-- 2.pl/sql�� Ȱ���Ͽ� �Լ� 
 CREATE OR REPLACE FUNCTION fn_get_grades (nm VARCHAR2)
 RETURN NUMBER
IS  --�̸��ִ� ��� �ۼ��� ����� IS�� ����
 vn_grades NUMBER;
BEGIN
    SELECT sum(����) 
        INTO vn_grades
        FROM �л�,��������,����
        WHERE �л�.�й� = ��������.�й�
     AND ��������.�����ȣ = ����.�����ȣ
     and �л�.�̸� = nm;
    RETURN vn_grades; 
END;
SELECT fn_get_grades(a.�̸�) as ������ --���� ����������Լ� ����� �����(���� �Լ� ó�� �����)
        ,a.*
FROM �л� a;
 
-- d-day�� �Է¹޾�(YYYYMMDD)
-- �������� input:20230829 RETURN : 1�ϳ���
-- ���� ���� ������ ǥ�� INPUT: 202308  RETURN 1: 1������
-- �� �����ϴ� �Լ��� �ۼ��Ͻÿ�.
-- INPUT: VARCHAR2, OUTPUT: VARCHAR2;

SELECT 
    CASE WHEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')) - to_number('20230810') >=0 THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')) - to_number('20230810')||'�� ����'
        WHEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')) - to_number('20230810') <0 THEN ABS(TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')) - to_number('20230810'))||'�� ����'
    end
FROM dual;


CREATE OR REPLACE FUNCTION fn_get_hakno (nm VARCHAR2)
 RETURN VARCHAR2
IS  --�̸��ִ� ��� �ۼ��� ����� IS�� ����
 vn_hakno varchar2(100);
BEGIN
    SELECT 
    CASE WHEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')) - to_number(nm) >=0 THEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')) - to_number(nm)||'�� ����'
        WHEN TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')) - to_number(nm) <0 THEN ABS(TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')) - to_number(nm))||'�� ����'
    end
    INTO vn_hakno
    FROM dual;
    RETURN vn_hakno;
END;

SELECT fn_get_hakno('20230830')
    ,fn_get_hakno('20230827')
    ,fn_get_hakno('20231226')
FROM dual;


