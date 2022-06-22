-- WHERE ���ǹ� : ��ȸ ��� ���� �����ϴ� ������(���� ������� �ϴ� ������)
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp         -- ��������� ���� �ش��ϴ� ��� �� ���
WHERE sex_cd = 2    -- �����ڵ� 2�� �ุ ���
;

-- PK�� WHERE�� ���������� ����� �ݵ�� �������� ��ȸ�ȴ�
SELECT
    emp_no, emp_nm, addr, sex_cd 
FROM tb_emp
WHERE emp_no = 1000000001
;

-- �񱳿�����
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101'    --VARCHAR2�� NUMBER�� �ڵ� ����ȯ
    AND birth_de <= '19991231'
;

-- BETWEEN ������ (�� WHERE AND ����� ���� ���)
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN '19900101' AND '19991231'
;

-- OR ������
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'  -- 100004���� 100005�� �� �� ���
    OR dept_cd = '100006'
;
-- IN ������ : OR�� ���� ���
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN ('100004', '100006')
;

-- NOT IN ������ : ��ȣ ���� �� �����ϰ� ���
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN ('100004', '100006')
;

-- LIKE ������ : �˻� �� ���
-- ���ϵ� ī�� ���� (% : 0���� �̻�,  _ : �� �� ����)
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '��__' -- �̻л� ã�ƿ���
;
SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE addr LIKE '%����%' -- �ּҿ� ���� ���� �� ã��
;

-- ������ �达�̸鼭, �μ��� 100003, 100004, 100006�� �߿� �ϳ��̸鼭, 
-- 90������ ����� ���, �̸�, ����, �μ��ڵ带 ��ȸ
SELECT
    emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE 1=1       -- ������ ���� ������ �־
    AND emp_nm LIKE '��%'    -- ù ���Ǻ��� �� ������ ����
    AND dept_cd IN ('100003', '100004', '100006')
    AND birth_de BETWEEN '19900101' AND '19991231'
;               -- �����ݷе� �����ؼ� ������ �� ������ ����, ������ ���ϴ�

-- ���� ��ġ �� ������(NOT EQUEL)
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp         
WHERE sex_cd != 2    -- !=, ^=, <>, NOT ���� ������ġ
    AND emp_no ^= 100000001
    AND emp_nm NOT LIKE '��%'
;
-- �����ڵ尡 1�� �ƴϸ鼭 ������ �̾��� �ƴ� �������
-- ���, �̸�, �����ڵ带 ��ȸ�ϼ���.
SELECT
    emp_no, emp_nm, sex_cd
FROM tb_emp         
WHERE 1=1
    AND sex_cd <> 1    
    AND emp_nm NOT LIKE '��%'
;

-- null�� ��ȸ(���� ��ǥ)
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp         
WHERE direct_manager_emp_no IS NULL
;
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp         
WHERE direct_manager_emp_no IS NOT NULL
;

-- ������ �켱���� : NOT > AND > OR
-- ������� �߿� �达�鼭 ���� �Ǵ� �ϻ꿡 ��� ������� ���� ��ȸ
SELECT
    emp_no, emp_nm, addr
FROM tb_emp         
WHERE 1=1                       -- ��ȣ�� ���� ������ AND ������ ���� �ϱ� ������
    AND emp_nm LIKE '��%'        -- (�达 AND %����%) OR (%�ϻ�%) �̷��� ��
    AND (addr LIKE '%����%' OR addr LIKE '%�ϻ�%') 
;