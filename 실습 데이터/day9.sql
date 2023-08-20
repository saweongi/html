SELECT *
FROM member a, cart b, prod c
WHERE a.mem_id = b.cart_member(+)
AND b.cart_prod = c.prod_id(+)
order by 6 desc;

/*������ ANSI OUTER JOIN*/
SELECT *
FROM member a
LEFT OUTER JOIN cart b
ON(a.mem_id = b.cart_member)
LEFT OUTER JOIN prod c
ON(b.cart_prod = c.prod_id);

CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));

INSERT INTO exp_goods_asia VALUES ('�ѱ�', 1, '�������� ������');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 2, '�ڵ���');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 4, '����');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 6,  '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 7,  '�޴���ȭ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 8,  'ȯ��źȭ����');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 9,  '�����۽ű� ���÷��� �μ�ǰ');
INSERT INTO exp_goods_asia VALUES ('�ѱ�', 10,  'ö �Ǵ� ���ձݰ�');

INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 1, '�ڵ���');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 2, '�ڵ�����ǰ');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 3, '��������ȸ��');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 4, '����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 5, '�ݵ�ü������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 6, 'ȭ����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 7, '�������� ������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 8, '�Ǽ����');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 9, '���̿���, Ʈ��������');
INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 10, '����');

COMMIT;

SELECT goods
FROM exp_goods_asia
where country = '�ѱ�'
union  --�� ����(�������鼭 �ߺ��� ������)
SELECT goods
FROM exp_goods_asia
where country = '�Ϻ�';

SELECT seq, goods
FROM exp_goods_asia
where country = '�ѱ�'
union  --�� ����(�������鼭 �ߺ��� ������)
SELECT seq, goods
FROM exp_goods_asia
where country = '�Ϻ�'
union  --����  �̷��� �׳� ���ϼ�������
select 10, '��ǻ��'
FROM dual;

SELECT goods
FROM exp_goods_asia
where country = '�ѱ�'
union ALL  --��ü�� �� ������(�ߺ� ���Ŵ¾ȵ�)
SELECT goods
FROM exp_goods_asia
where country = '�Ϻ�';

SELECT goods
FROM exp_goods_asia
where country = '�ѱ�'
INTERSECT  --������(����� �ֵ鸸 ��Ÿ��)
SELECT goods
FROM exp_goods_asia
where country = '�Ϻ�';

SELECT goods
FROM exp_goods_asia
where country = '�ѱ�'
except --������(���������� �Ʒ��� ��)
SELECT goods
FROM exp_goods_asia
where country = '�Ϻ�';

-- ������ ����
-- oracle ������ ��� �÷��� ���� Ÿ���� ���ƾ���.
-- ������ ������ select������ ���
SELECT To_CHAR(department_id) as �μ�
      , COUNT(*) �μ���������
FROM employees
GROUP BY department_id
UNION
SELECT '��ü'
    ,COUNT(*) AS ��ü������
    FROM employees;
 
-- EXISTS�� �����ϴ��� ���ϴ��� �� �� �ְ� �Ѵ�. 
-- ���� �����̶�� ��.
-- job_history ���̺� �����ϴ� �μ����
SELECT a.department_id
 , a.department_name
 FROM departments a
 WHERE EXISTS (SELECT * --select�� �ǹ̾��� where�� ���뿡 �ش�Ǵ� �����Ͱ� �����ϴ����� üũ
                FROM job_history b
                WHERE a.department_id = b.department_id);

-- job_history ���̺� �����ϴ� �ʴ� �μ� ���
SELECT a.department_id
 , a.department_name
 FROM departments a
 WHERE  NOT EXISTS (SELECT * --select�� �ǹ̾��� where�� ���뿡 �ش�Ǵ� �����Ͱ� �����ϴ����� üũ
                FROM job_history b
                WHERE a.department_id = b.department_id);
                
-- ���������� ���� �л���ȸ
SELECT *
FROM �л� a
WHERE NOT EXISTS (SELECT *
                    FROM �������� b
                    WHERE b.�й� = a.�й�);

/* ���� ǥ���� '�˻�', 'ġȯ' �ϴ� ������ �����ϰ� ó�� �� �� �ֵ��� �ϴ¼���.
    oracle�� 10g���� ���
    (JAVA, python, JS �� ����ǥ���� ��밡��) ���ݾ� �ٸ�
    .(dot) or []�� ��� ���� 1���ڸ� �ǹ���
    ^ <-- ������ �ǹ��� ^[0-9] <-- ���ڷ� �����ϴ� ^q <-q�� �����ϴ�
    [^0-9] <-- ���ȣ ���� ^ <-- not�� �ǹ���
*/
--REGEXP_LIKE : ���Խ� ������ �˻�
SELECT *
FROM member
WHERE  REGEXP_LIKE(mem_comtel, '^..-');

--������ 3�� ���� �� @����(abc@gmail.com)
SELECT *
FROM member
WHERE  REGEXP_LIKE(mem_mail ,'^[a-zA-Z]{3}@');

/* �ݺ�������
 * : 0���̻�
 + : 1���̻�
 ? : 0,1��
 {n} : n��
 {n,} : n�� �̻�
 {n,m} : n���̻� m������
 */
 SELECT *
FROM member
WHERE  REGEXP_LIKE(mem_mail ,'^[a-zA-Z]{3,5}@');

-- mem_add2 ���ڶ��⹮�� ������ �����͸� ����Ͻÿ�
SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'. .'); --��� ���ڵ� 

SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'[��-�R] [0-9]'); --�ѱ�

SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'[��-�R]$'); --�ѱ� ������ $ -> q$ -> q�γ�����

--�ѱ۸� �ִ� �ּҰ˻�
SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'^[��-�R]+$');

--�ѱ��� ���� �ּҰ˻�
SELECT mem_name
    , mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2,'^[^��-�R]+$');

-- | <--�Ǵ�
-- () <-- ���ϱ׷�
-- J�ν����ϸ�, ����° ���ڰ� M�Ǵ� N�� �����̸� ��ȸ
SELECT emp_name
FROM employees
WHERE REGEXP_LIKE(emp_name, '^J.(n|m)');

--REGEXP_SUBSTR ����ǥ���� ������ ��ġ�ϴ� ���ڿ� ��ȯ
-- �̸��� @�� �������� �հ� �ڸ� ����Ͻÿ�
                                --����, ������ġ, ��Ī����
SELECT REGEXP_SUBSTR(mem_mail, '[^@]+',1,1) as mem_id
    , REGEXP_SUBSTR(mem_mail, '[^@]+',1,2) as mem_domain
FROM member;
--����
SELECT REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 1) AS a
    , REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 2) AS b
    ,REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 3) AS c
from dual;
SELECT REGEXP_SUBSTR('pang su hi 1234','[0-9]') --default 1,1
    ,REGEXP_SUBSTR('pang su hi 1234','[^0-9]')
    ,REGEXP_SUBSTR('pang su hi 1234','[^0-9]+')
FROM dual;

--���⸦ �������� 2��° �����ϴ� �ּҸ� ����Ͻÿ�
--�ѱ� �������� 2���� �����ϴ� �ּҸ� ����Ͻÿ�
select REGEXP_SUBSTR(mem_add1,'[^ ]+',1,2) AS �߰�
    ,REGEXP_SUBSTR(mem_add1,'[��-��]+',1,2) AS �߰�2
from member;

--  8~ 14 ���� �ؽ�Ʈ �����ϴ� ������ ���
SELECT*
FROM(
    SELECT 'abcd1234' as id FROM dual
    UNION
    SELECT 'Abcd123456' as id FROM dual
    UNION
    SELECT 'A1234' as id FROM dual
    UNION
    SELECT 'A123456789cdefg' as id FROM dual
)
where REGEXP_LIKE(id,'^[a-zA-Z0-9]{8,14}$');

