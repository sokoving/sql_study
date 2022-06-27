-- ���� ������
-- ## UNION
-- 1. ������ ������ �ǹ��Դϴ�.
-- 2. ù��° ������ �ι�° ������ �ߺ������� �ѹ��� �����ݴϴ�.
-- 3. ù��° ������ ���� ������ Ÿ���� �ι�° ������ ������ Ÿ�԰� �����ؾ� ��.
-- 4. ORDER BY���� ��� �ڵ����� ������ �Ͼ (ù��° �÷� �������� �⺻��)
-- 5. �� ��Ī�� ù ���� ������ ���� ����
-- 6. ORDER BY�� ������ ���� �ڿ� ����
-- JOIN : �÷��� ����
-- UNION : ���� ����

-- 60������ 70������ UNION
-- ù��° �÷��� ��� ������ ����
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;

-- �̸��� ������ ���� �̰��� �ߺ� ����(����� �ٸ�)
-- ù��° �÷��� �̸� ������ ����
SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;

-- �� ��Ī ����, ORDER BY
SELECT
    emp_nm EN, birth_de BD
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
    emp_nm EN2, birth_de BD2
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
ORDER BY BD DESC
;


-- ## UNION ALL
-- 1. UNION�� ���� �� ���̺�� �������� ���ļ� �����ݴϴ�.
-- 2. UNION���� �޸� �ߺ��� �����͵� �ѹ� �� �����ݴϴ�.
-- 3. �ڵ� ���� ����� �������� �ʾ� ���ɻ� �����մϴ�.

SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;

SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;


-- ## INTERSECT
-- 1. ù��° ������ �ι�° �������� �ߺ��� �ุ�� ����մϴ�.
-- 2. �������� �ǹ��Դϴ�.

-- SQLD �ڰ����� �����鼭 ���ο� ��� ���
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE C.certi_nm = 'SQLD'
INTERSECT
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%����%';


SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%����%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 
-- 1. �ι�° �������� ���� ù��° �������� �ִ� �����͸� �����ݴϴ�.
-- 2. �������� �����Դϴ�.

-- ��ü ��� �� 100001��, 100004�� �μ� �׸��� ���ڰ� �ƴ� ���
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1'
;


-- # ������ ����
-- START WITH : ������ ù �ܰ踦 ��� ������ ���ΰ��� ���� ����
         -- tree ������ root�� �����ϴ� ����
         -- ex) ��簡 null�� ������� ������ ���� ����
-- CONNECT BY PRIOR �ڽ� = �θ�
    -- ������ Ž��, �θ𿡼� �ڽ� ������ Ž��
-- CONNECT BY �ڽ� = PRIOR �θ�
    -- ������ Ž��, �ڽĿ��� �θ� ������ Ž��
-- ORDER SIBLINGS BY : ���� ���������� ������ ����

SELECT 
    LEVEL AS LVL, -- ���� �÷� LEVETL
    -- ���������� �ð�ȭ�ϱ� ���� LPAD , �̸��� ���� �࿡ �ֱ� ���� ���� ���տ��� ||
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no
ORDER SIBLINGS BY A.emp_no
;


SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    a.direct_manager_emp_no
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.emp_no = '1000000037'
CONNECT BY A.emp_no = PRIOR A.direct_manager_emp_no;


-- # SELF JOIN
-- 1. �ϳ��� ���̺� �ڱ� �ڽ��� ���̺��� �����ϴ� ���
-- 2. �ڱ� �ڽ� ���̺��� pk�� fk �� ���������Ѵ�

SELECT
     a.emp_no "��� ��ȣ"
     , a.emp_nm "��� �̸�"
     , a.addr "��� �ּ�"
     , a.direct_manager_emp_no "��� ��� ��ȣ"
     , b.emp_nm "��� �̸�"
     , a.addr " ��� �ּ�"
FROM tb_emp A 
LEFT OUTER JOIN tb_emp B 
ON a.direct_manager_emp_no = b.emp_no
ORDER BY a.emp_no
;


--fk ����
alter table tb_emp
add CONSTRAINT fk_tb_emp_no
foreign key (direct_manager_emp_no)
references tb_emp(emp_no)
;