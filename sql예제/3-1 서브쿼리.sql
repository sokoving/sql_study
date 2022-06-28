-- # 1 ������ ��������
-- ## 1-1 ���������� ��ȸ ����� 1�� ������ ���

-- �μ� �ڵ尡 100004���� �μ��� ������� ��ȸ
SELECT
 emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
;

-- ��� �̳��� ���� �ִ� �μ� ������� ������ ��ȸ
    -- ���������� ���� �ʴ��ٸ� ���� �̳����� �μ���ȣ�� Ȯ���� ��
    -- �μ��ڵ� 100004���� �μ� ��� ������ ��ȸ�ϴ� �� �ܰ踦 ���ľ� �Ѵ�
SELECT dept_cd FROM tb_emp WHERE emp_nm = '�̳���'; -- 100004

    -- (������) ���������� ���ٸ�
SELECT
 emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '�̳���')
;

-- ## 1-2 ������ �񱳿����ڴ� ������ ���������� ���ؾ� �Ѵ�
    -- ������ �񱳿�����: =, <>, >, >=, <, <=
-- ��� �̰����� ���� �ִ� �μ� ������� ������ ��ȸ
    -- > �̰����� ���������̶� �������� ��µǾ� ������ ����
SELECT
 emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '�̰���')
;

-- 20200525�� ���� �޿��� ȸ�� ��ü�� 20200525�� 
-- ��ü ��� �޿����� ���� ������� ���� ��ȸ
    -- 1. a�� b�� �����Ͽ� ����� ���� �޿��� ��¥ ��ȸ
    -- 2. where�� pay_de�� 20200525�� ����
SELECT
    a.emp_no, a.emp_nm, b.pay_de, b.pay_amt
FROM tb_emp A
JOIN tb_sal_his B
ON a.emp_no = b.emp_no
WHERE b.pay_de = '20200525'
ORDER BY a.emp_no, b.pay_de
;
    -- 3. ȸ�� �� ����� 20200526 �޿� ���
SELECT
    AVG(pay_amt)
FROM tb_sal_his
WHERE pay_de = '20200525'
;

    -- 4. 2�� AND �������� 3�� ���������� ����
SELECT
    a.emp_no, a.emp_nm, b.pay_de, b.pay_amt --b.pay_de, b.pay_amt�� join���� ���� ������ ���̺�
FROM tb_emp A
JOIN tb_sal_his B
ON a.emp_no = b.emp_no
WHERE b.pay_de = '20200525'
    AND b.pay_amt > (
                    SELECT
                        AVG(pay_amt)    -- b.pay_amt�� ���������� pay_amt�� �ٸ� ���̺�
                    FROM tb_sal_his
                    WHERE pay_de = '20200525'
                    )
ORDER BY a.emp_no, b.pay_de
;


-- # 2 ������ ��������
-- ��ȸ �Ǽ��� 0�� �̻��� ��������
-- ## 2-1 ������ ������
-- 1. IN  : ���������� �������� �������� ����߿� �ϳ��� ��ġ�ϸ� ��
    -- EX) salary IN (200, 300, 400) �������� 200�̰ų� 300�̰ų� 400�̾�� ��
    --      250 IN (200, 300, 400) - ����
-- 2. ANY, SOME : ���������� �������� ���������� �˻���� �� �ϳ� �̻� ��ġ�ϸ� ��
    -- EX) salary > ANY (200, 300, 400) �������� 200�̳� 300, 400���� ũ�� ��
    --      250 > ANY (200, 300, 400) - ��
-- 3. ALL : ���������� �������� ���������� �˻������ ��� ��ġ�ϸ� ��
    -- EX) salary > ANY (200, 300, 400) �������� 200���� ũ�� 300���� ũ�� 400���� Ŀ�� ��
    --      250 > ALL (200, 300, 400) - ����
-- 4. EXISTS : ���������� �������� ���������� ��� �� �����ϴ� ���� �ϳ��� �����ϸ� ��

-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ�
-- ����� �����ȣȭ �̸��� �ڰ��� ������ ��ȸ
SELECT
    certi_cd
FROM tb_certi
WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
;

SELECT
    a.emp_no, a.emp_nm, COUNT(b.certi_cd) "�ڰ��� ��"
FROM tb_emp A
JOIN tb_emp_certi B
ON a.emp_no = b.emp_no
--WHERE B.certi_cd IN (
WHERE B.certi_cd = ANY (
--WHERE B.certi_cd = ALL (
                     SELECT certi_cd
                     FROM tb_certi
                     WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
                    )
GROUP BY a.emp_no, a.emp_nm -- GROUTP BY���� ������� ���� �÷��� SELECT�� �� �� ����
ORDER BY a.emp_no
;

-- ## 2-2 EXISTS�� : ���������� �������� ���������� ��� �� �����ϴ� ���� �ϳ��� �����ϸ� ��
SELECT A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS (
            SELECT 1    -- ���������� �ƴ����� Ȯ��, �÷��� �������
            FROM tb_emp B
            WHERE addr LIKE '%����%'
                AND a.dept_cd = b.dept_cd
            )
;


-- # 3. ���� �÷� ��������
    -- ���������� ��ȸ �÷��� 2�� �̻��� ��������
    
-- �μ����� 2�� �̻��� �μ� �߿��� �� �μ��� ���� ��������
-- ����� �̸� ������ϰ� �μ��ڵ带 ��ȸ
SELECT
    a.emp_no, a.emp_nm, a.birth_de, a.dept_cd, b.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON a.dept_cd = b.dept_cd
WHERE(a.dept_cd, a.birth_de) In (
                                SELECT
                                    dept_cd, MIn(birth_de)
                                FROM tb_emp
                                GROUP BY dept_cd
                                HAVING COUNT(*) >= 2
                                )
ORDER BY a.dept_cd
;

-- # 4. �ζ��� �� �������� (FROM ���� ���� ��������)
-- �� ����� ����� �̸�, ��� �޿� ������ ��ȸ

SELECT
    a.emp_no, a.emp_nm, b.pay_avg
--FROM tb_emp A, tb_sal_his B     -- ���� ���̺��� ũ�Ⱑ �ʹ� Ŀ�� ����� ������ �ҷ����� ����ȭ
FROM tb_emp A, (                  -- ���������� group by�� ���� ���̺� ũ�⸦ �ٿ����� �ڿ� ��������
                SELECT emp_no, AVG(pay_amt) AS pay_avg
                FROM tb_sal_his
                GROUP BY emp_no
                ) B
WHERE a.emp_no = b.emp_no
--GROUP BY a.emp_no, a.emp_nm
ORDER BY a.emp_no
;

-- # 5 ��Į�� �������� (SELECT���� ���� ��������)
-- ����� ���, �����, �����ڵ�, �μ���, �������, �����ڰ����� ��ȸ
    -- �ܼ� ������ �ϳ� �ҷ����� �� ������ ������ �ؾ� �Ѵٱ�?
    -- ���� ���� ���� ����Ʈ���� ���������� �ٷ� �ҷ�����
SELECT 
    A.emp_no
    , A.emp_nm
    , (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
    , A.birth_de
    , A.sex_cd
FROM tb_emp A
;