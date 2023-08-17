-- inner JOIN ��������(��������)
SELECT *
FROM �л�;
SELECT *
FROM ��������;

select *
from ����;

SELECT �л�.�й� -- �Ѵ� ������ �տ� ���̺� ���� �ٿ������� �ϳ��� ������ ������ �Ƚ��൵��
    ,�̸�
    ,����
    ,����������ȣ
    ,��������.�����ȣ
    ,����.�����̸�
FROM �л�,��������,����
where �л�.�й� = ��������.�й�
AND ��������.�����ȣ = ����.�����ȣ
AND �л�.�̸� ='�ּ���';

-- �ּ����� ���� �������� ����Ͻÿ�.
select �л�.�й�
    , �л�.�̸�
    , sum(����.����) as ��������
from �л�,��������,����
where �л�.�й� = ��������.�й�
AND ��������.�����ȣ = ����.�����ȣ
AND �л�.�̸� ='�ּ���'
group by �л�.�й�,�л�.�̸�;

/* OUTER JOIN �ܺ�����
    ��� ���ʿ� null �ִ���  ���� ���Խ��Ѿ� �Ҷ�
    (������ ���������̺��� ������ ���Խ��Ѿ��ϸ� �ƿ�����������)
*/
select �л�.�й�
    , �л�.�̸�
from �л�,��������    --null�� ���� ��ų ���̺���
where �л�.�й� = ��������.�й�(+) -- (+) <-- ���ʿ��� ���� ����(null�� �̴��� ���Խ�Ű�ڴ� �ƿ��� ����) 
AND �л�.�̸� ='������';

--�л��� �����̷� �Ǽ��� ����Ͻÿ�
-- ����л� ��� null�̸� 0���� 
select �л�.�й�
    ,�л�.�̸�
    ,count(��������.����������ȣ) as �����̷°Ǽ�
from �л�,��������
where �л�.�й� = ��������.�й�(+)
group by �л��й� ,�л�.�̸�
order by 3 desc;

--�л��� �����̷� �Ǽ�, �Ѽ��� ������ ����Ͻÿ�
select �л�.�й�
    ,�л�.�̸�
    ,count(��������.����������ȣ) as �����̷°Ǽ�
    ,NVL(sum(����.����),0) as �Ѽ�������
from �л�,��������,����
where �л�.�й� = ��������.�й�(+)
AND ��������.�����ȣ = ����.�����ȣ(+)
group by �л�.�й�
        ,�л�.�̸�
order by 3 desc;

SELECT �л�.�й� -- �Ѵ� ������ �տ� ���̺� ���� �ٿ������� �ϳ��� ������ ������ �Ƚ��൵��
    ,�̸�
    ,����
    ,����������ȣ
    ,��������.�����ȣ
    ,(select �����̸� --��Į�� ��������(������ ��밡��)
    FROM ����
    where �����ȣ = ��������.�����ȣ) as �����̸�
FROM �л�,��������
where �л�.�й� = ��������.�й�
AND �л�.�̸� ='�ּ���';

/* �л��� ������ �ο����� ����Ͻÿ� */
select ����
    ,count(*) as �л���
from �л�
group by ����
order by 2 desc;

/* �л��� ������� ���� ���� �л��� ����Ͻÿ� */
select  �й�
        ,�̸�
        ,avg(����) as���� 
from �л�
where ���� >(select avg (����)
            from �л�)
group by �й�,�̸�
order by 3 desc;

select *
from �л�;

select *
from ��������;

-- ���������� ���� �л�
select*
from �л�
where �й� not in(select �й�
                    from ��������);

-- �������� ����������Ű�����
select *
from �л�,��������
where �л�.�й� = ��������.�й�(+);

/* �ζ��� �� (FROM��)
   select ���� ���� ����� ��ġ ���̺�ó�� ��� 
*/
SELECT *
FROM
(SELECT ROWNUM AS RNUM
        ,�й�, �̸�, ����
FROM �л�) a  -- SELECT���� ���̺�ó�� ���(ROWNUM�� ���� ���̺� ������ �����ʴµ�  �ζ��κ�� ���� ���̺�� ����ϰ��ؼ� ������ �˻��ϰ��Ѵ�)
where a.RNUM BETWEEN 2 AND 5;

select *
from(SELECT ROWNUM AS RNUM
    ,a .*
FROM( SELECT employee_id
    , emp_name
    , salary
FROM employees
WHERE emp_name LIKE 'K%' --���ʿ� ���ǽ��̳� �������̸� �������������� �ۿ� ���� ��������� �ڿ��־ ������ �ȸ������� �ְų� ������ �����̵ȴ�(rnum�� ���� �ۿ� �Ἥ ������ ���� �����ϰ� ��ȣ�� �־���)
ORDER BY emp_name) a
)
where rnum BETWEEN 1 AND 10;

--�л��߿� ���� ���� 5�� ����Ͻÿ�.
select *
from(
        select ROWNUM AS ����
                ,a.*
        from (select �л�.�̸�,�л�.����,�л�.����
            FROM �л�
            order by ���� desc)a 
    )
where ����  BETWEEN 1 AND 5;


-- MEMBER, CART, PROD �� ����Ͽ� 
-- ���� īƮ���Ƚ��, ��ǰǰ��Ǽ�, ��ǰ���ż���, �ѱ��űݾ��� ����Ͻÿ�
-- �����̷��� ���ٸ� 0 <- ���� ��µǵ���

SELECT *
FROM MEMBER;

SELECT *
FROM  CART;

SELECT *
FROM  PROD;

SELECT MEMBER.mem_id,
    member.mem_name
    ,  count( DISTINCT cart_no) as īƮ���Ƚ��
    ,count(cart.cart_qty) as ��ǰǰ��Ǽ�
    ,NVL(sum(cart.cart_qty),0)as ��ǰ���ż���
    , NVL(sum(cart.cart_qty*prod.prod_sale),0) as �����ջ�ݾ�

FROM MEMBER, CART, PROD
where member.mem_id = cart.cart_member(+)
and cart.cart_prod =prod.prod_id(+)
group by member.mem_name,MEMBER.mem_id
order by �����ջ�ݾ� desc; 
    





