ALTER SESSION SET "_ORACLE_SCRIPT" =true; 
--���� ��Ÿ�Ϸ� ���ĸ���� ���� �������� ��ũ��Ʈ�� �����ؾ���
--���๮�� ; <-- ������ �ν���
--������ ctrl + enter or ���� ��ư

--����ڸ� : java, ��Г�ȣ : oracle
CREATE USER java IDENTIFIED BY oracle;

--���� ����
GRANT CONNECT, RESOURCE TO java;

--���̺� �����̽� ���� ����
GRANT UNLIMITED TABLESPACE TO java;