-- �����Լ�(������ �Լ�)
-- ���� ���� ��� �Լ��� ����

SELECT * FROM tb_sal_his;

-- GRUOUP BY�� �ұ׷�ȭ���� ������ ���� �Լ��� ��ü�Լ��� �������� �����Ѵ�
SELECT
    COUNT(pay_amt) "�� ��� ��"
    , SUM(pay_amt) "���� �Ѿ�"
    , AVG(pay_amt) "��� ���޾�"
FROM tb_sal_his
-- ������ �Լ� > tb_sal_his�� �� ��(984��)��ŭ ��µȴ�
-- ���� �Լ� > tb_sal_his�� ��� ���� ������ 1������ ��µȴ�
;

-- COUNT(*) : null�� ������ ��ü �� ��(null�� �����ϴ� ������ �����Լ�)
-- COUNT(ǥ����) : null�� ������ �� ��(��� �����Լ��� null�� �����ϰ� ����Ѵ�)
SELECT
    COUNT(*) AS "�� ��� ��"
    , COUNT(direct_manager_emp_no) "dmen"
    , MIN(birth_de) "�ֿ����� ����"
    , MAX(birth_de) "�ֿ����� ����"
FROM tb_emp;

SELECT * FROM tb_emp
ORDER BY dept_cd;

-- GROUP BY : ������ Į���� �ұ׷�ȭ �� �� �����Լ� ����
-- GROUP BY�� ������ �÷��� �����Լ��� SELECT���� �� �� �ִ� (���� �÷� �ƴϸ� ��ȸ X)
-- null�� �൵ �׷�ȭ�Ѵ�
-- GROUP BY�� SELECT���� ���� �۵��ϱ� ������ �� ��Ī�� �� �� ����

-- �μ����� ���� � ����� �������, �������� ������� �μ��� �� ��� ���� ��ȸ
SELECT
--  emp_nm      -- �̸��� �� �� ����
    dept_cd     -- �׷�ȭ�� dept_cd�� �� �� ����
    , MAX(birth_de) �ֿ�����
    , MIN(birth_de) �ֿ�����
    , COUNT(emp_no) ������
FROM tb_emp
GROUP BY dept_cd -- �μ� �ڵ尡 ���� �ೢ�� ��� ��� ����
ORDER BY dept_cd
;

-- ����� ���� �޿� ���ɾ� ��ȸ
SELECT 
    emp_no ���
    , SUM(pay_amt) �������ɾ�
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

-- �����Լ��� ������ �Լ��� �μ��� �� �� �ִ�
-- �����Լ��� �ٽ� �����Լ��� ������ �� ��(���� ó���� �ʿ�)
-- WHERE
-- ������ ���� �ִٸ� GROUP BY ���� �ؾ� �Ѵ�
-- WHERE���� �����Լ� ��� �� ��
-- FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY

-- 2019�⿡ ������� 
-- �޿��� ���� ���� �޾��� ��, ���� ���� �޾��� ��,
-- ��������� �� �޾Ҵ���, ������ ������ ��ȸ
SELECT 
    emp_no ���
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') �ְ���ɾ�
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') �������ɾ�
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') ��ռ��ɾ�
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') ����
--  , ROUND(pay_amt, 2)  -- ������ �Լ��� �� �� ����
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;


-- HAVING
-- �׷�ȭ�� ������� ������ �ɾ� �� ���� ����
-- WHERE ��, ORDER BY �� (GROUP BY ��, �� ����)

-- �μ����� ���� � ����� �������, �������� ������� �μ��� �� ��� ���� ��ȸ
-- ����� 1���� �μ��� ������ ��ȸ�ϰ� ���� ���� ��
SELECT
    dept_cd
    , MAX(birth_de) �ֿ�����
    , MIN(birth_de) �ֿ�����
    , COUNT(emp_no) ������
FROM tb_emp
GROUP BY dept_cd 
HAVING NOT COUNT (emp_no) = 1
ORDER BY dept_cd
;

-- ������� �޿��� ���� ���� �޾��� ��, ���� ���� �޾��� ��, ��������� �� �޾Ҵ��� ��ȸ
-- ��� �޿��� 450�� �� �̻��� ����� ��ȸ
SELECT 
    emp_no ���
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') �ְ���ɾ�
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') �������ɾ�
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') ��ռ��ɾ�
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') ����
--  , ROUND(pay_amt, 2)  -- ������ �Լ��� �� �� ����
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

-- ������� 2019�� �� ��� ���ɾ��� 450�� �� �̻��� �����
-- ��� ��ȣ�� 2019�� ���� ��ȸ
SELECT
    emp_no
    , TO_CHAR(ROUND(AVG(pay_amt)), 'L999,999,999') ��ռ��ɾ�
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') ����
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;


SELECT
    emp_no
    , sex_cd
    , dept_cd
FROM tb_emp
ORDER BY dept_cd
;

-- GROUP BY�� �÷��� ������ �ָ� �÷��� ��� ��ġ�ϴ� �ೢ�� �׷��Ѵ�
SELECT 
    dept_cd
    , COUNT(*)
FROM tb_emp
GROUP BY dept_cd, sex_cd
ORDER BY dept_cd
;

-- ORDER BY : ����
-- ASC : ������ ����(�⺻��) , DESC : ������ ����
-- �׻� SELECT ���� �� �������� ��ġ
-- �׷�ȭ�� �÷��� �����Լ��� ������ �� �ִ�

-- GROUP BY�� �÷��� ������ �ָ� �÷��� ��� ��ġ�ϴ� �ೢ�� �׷��Ѵ�
SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
--ORDER BY emp_no ASC -- ASC �⺻��, ���� ����
ORDER BY emp_no DESC  -- DESC ǥ�� �ʼ�
;

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm ASC -- �̸����� ����
--ORDER BY emp_nm DESC  -- �����ڵ� ���� A-Z, ��-�R
;

-- ������ ������ ��ǥ�� ������ ����
SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC -- dept_cd�� ������ emp_nm�� ������ ����
;

-- ��Ī���ε� ���� ����
SELECT 
    emp_no ���
    , emp_nm �̸�
    , addr �ּ�
FROM tb_emp
ORDER BY �̸� ASC
;

-- �÷� �����ε� ���� ����
SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, 2 DESC 
;

-- ��� �ᵵ ��
SELECT 
    emp_no ���
    , emp_nm �̸�
    , dept_cd �ּ�
FROM tb_emp
ORDER BY 1 ASC, emp_nm DESC, �ּ� ASC
;


-- ������� 2019�� �� ��� ���ɾ��� 450�� �� �̻��� �����
-- ��� ��ȣ�� 2019�� ���� ��ȸ
SELECT
    emp_no
    , TO_CHAR(ROUND(AVG(pay_amt)), 'L999,999,999') ��ռ��ɾ�
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') ����
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
--ORDER BY SUM(pay_amt) DESC
ORDER BY ��ռ��ɾ�
--ORDER BY 3 DESC
;
