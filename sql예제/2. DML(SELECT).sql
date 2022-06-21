-- SELECT(��ȸ) �⺻
SELECT
    emp_no, emp_nm -- �÷� �̸�
FROM tb_emp; -- ���̺� �̸�

SELECT
    certi_nm, certi_cd -- ���̺� �÷� ������ �������
FROM tb_certi;

SELECT
    *   -- ���̺��� ��� �÷� ��ȸ
FROM tb_dept;

    
    -- SELECT DISTINCT : �ߺ����� �����ϰ� ��ȸ > �ߺ� ���� 6�� ���
        -- SELECT ALL�� �⺻�� > �ߺ� ���� 20�� ���� ��µ�
SELECT DISTINCT
    issue_insti_nm  
FROM tb_certi;
        -- ���ǻ���: �÷��� ���� �̻��̸� �� ������ �ߺ� üũ
SELECT DISTINCT
    certi_cd, issue_insti_nm  
FROM tb_certi;

    -- �� ��Ī(column alias) ����
SELECT
    certi_cd AS "�ڰ��� �ڵ�"  -- "���Ⱑ ���� ��� �ֵ���ǥ"
    , certi_nm AS �ڰ�����      -- ���� ���� ��� �ֵ���ǥ ���� ����
    , issue_insti_nm �߱ޱ���� -- AS �׻� ���� ����
FROM tb_certi;

    -- ���ڿ� ���� ������ ||
    -- ex) SQLD(100001) - �ѱ������ͺ��̽������
SELECT
    certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm AS "�ڰ��� ����"
FROM tb_certi;

    -- dual
    -- ����Ŭ���� �����ϴ� ���� ���̺�
    -- �ܼ� ���� ����� ��ȸ�� �� ����Ѵ�
SELECT
    3 * 6 AS "���� ���"
FROM dual;

SELECT
    SYSDATE AS "���� ��¥"
FROM dual;
    