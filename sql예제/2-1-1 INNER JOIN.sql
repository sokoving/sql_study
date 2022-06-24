-- SELECT [DISTINCT] { ���̸� .... } 
-- FROM  ���̺� �Ǵ� �� �̸�
-- JOIN  ���̺� �Ǵ� �� �̸�
-- ON    ���� ����
-- WHERE ��ȸ ����
-- GROUP BY  ���� �׷�ȭ
-- HAVING    �׷�ȭ ����
-- ORDER BY  ������ �� [ASC | DESC];


-- ���̺� ���� > �� ���� ���̱� ���ؼ�

-- ����
 -- �ٸ� ���̺� �ִ� ���� �������� ��
 -- A�� B�� �����ϸ� 5��, ������ ���� �� ���� �ٸ���

-- ���� ���� �׽�Ʈ ������
CREATE TABLE TEST_A (  -- �Խ���
    id NUMBER(10) PRIMARY KEY -- �Խñ� ��ȣ
    , content VARCHAR2(200) -- �Խñ� ����
);
CREATE TABLE TEST_B ( -- ���
    b_id NUMBER(10) PRIMARY KEY -- ��� ��ȣ
    , reply VARCHAR2(100) -- ��� ����
    , a_id NUMBER(10) -- ���� �� ��ȣ(FK ���� �ʾ����� FK ������ ��)
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, '������', 1);
INSERT INTO TEST_B  VALUES (2, '������', 1);
INSERT INTO TEST_B  VALUES (3, '������', 2);
INSERT INTO TEST_B  VALUES (4, '������', 3);
COMMIT;

SELECT * FROM test_a;
SELECT * FROM test_b;

--# CROSS JOIN, ī�׽þ� ��(Cartesion product)
-- ���� ������ �������� ���� ����
-- ��� ���̺��� ũ�ν��Ǿ� ��ȸ�ȴ� 5�� (3*4)��
    -- FROM ���̺�A, ���̺�B
SELECT
    *
FROM test_a, test_b;

-- ���� 2. INNER JOIN (EQUI JOIN�� ����)
-- ���� ���ؼ� ������ ���� �ִ� �ุ ��ȯ
    -- SELECT ���̺�A.��, ���̺�B.��
    -- FROM ���̺�A, ���̺�B
    -- WHERE ���̺�A.�� = ���̺�B.��
SELECT
-- test_a.id, test_a.content, test_b.reply
    a.id, a.content, b.reply
FROM test_a A, test_b B
WHERE a.id = b.a_id -- ���� ����
;

-----------------------------------
SELECT * FROM tb_emp; -- ���, �̸�,  
SELECT * FROM tb_emp_certi;
SELECT * FROM tb_certi;
SELECT * FROM tb_dept;

--2�� ���̺� ����
-- ����� ��� ��ȣ, ��� �ڰ��� ��
SELECT 
    a.emp_no, b.certi_nm
FROM tb_emp_certi A, tb_certi B
WHERE a.certi_cd = b.certi_cd
ORDER BY a.emp_no
;

-- 3�� ���̺� ����
-- ����� ��� ��ȣ, ��� �̸�, ��� �ڰ��� ��
SELECT 
    a.emp_no, c.emp_nm,  b.certi_nm
FROM tb_emp_certi a, tb_certi b, tb_emp c
WHERE a.certi_cd = b.certi_cd
    AND a.emp_no = c.emp_no
ORDER BY a.emp_no
;

-- 4�� ���̺� ����
-- ����� ��� ��ȣ, ��� �̸�, �μ� �̸�, ��� �ڰ��� ��
SELECT 
    a.emp_no, c.emp_nm, d.dept_nm, b.certi_nm
FROM tb_emp_certi a, tb_certi b, tb_emp c, tb_dept d
WHERE a.certi_cd = b.certi_cd
    AND a.emp_no = c.emp_no
    AND c.dept_cd = d.dept_cd
ORDER BY a.emp_no
;

-- group by���� ����
-- �μ��� �� �ڰ��� ��� ��
SELECT 
    b.dept_cd, c.dept_nm, COUNT(a.certi_cd) "�μ��� �ڰ��� ��"
FROM tb_emp_certi a, tb_emp b, tb_dept c
WHERE a.emp_no = b.emp_no
    AND b.dept_cd = c.dept_cd
GROUP BY b.dept_cd, c.dept_nm
ORDER BY b.dept_cd
;

------------------------------------------------------------
-- ǥ�� ����
-- # INNER JOIN
-- 1. 2�� �̻��� ���̺��� ����� �÷��� ���� �������� ���յǴ� ���α��
-- 2. WHERE���� ���� �÷����� �������(=)�� ���� ���ε˴ϴ�.


-- ����Ŭ ����
 -- ������ ���̺�(n��)��ŭ ���� ����(n-1)�� �þ��
 -- �Ϲ� ���ǰ� ���� ������ �Բ� ������

-- ���νÿ� ��� �达 �� ����� (�����ȣ, �����, �ּ�, �μ��ڵ�, �μ���) ��ȸ
SELECT
    a.emp_no, a.emp_nm, a.addr, a.dept_cd, b.dept_nm
FROM tb_emp a, tb_dept b
WHERE a.addr LIKE '%����%'
    AND a.dept_cd = b.dept_cd
    AND a.emp_nm LIKE '��%'
ORDER BY a.emp_no
;

--# ǥ�� ���� (JOIN ON TABLE)
-- ���� ���� ������(ON��), �Ϲ� ���� ������(WHERE��)�� �и��ؼ� �ۼ��ϴ� ���
    -- 1. FROM�� ��, WHERE�� ��
    -- 2. JOIN Ű���� �ڿ��� ������ ���̺���� ���
        -- INNER JOIN���� INNER�� ���� ����
    -- 3. ON Ű���� �ڿ��� ���� ������ ���
        -- JOIN�� ON�� ���� �ٴѴ�
        -- ON���� �̿��ϸ� JOIN ������ �������̳� ���������� ���� �߰� ������ ����
        
-- ���νÿ� ��� �达 �� ����� (�����ȣ, �����, �ּ�, �μ��ڵ�, �μ���) ��ȸ
SELECT
    a.emp_no, a.emp_nm, a.addr, a.dept_cd, b.dept_nm
FROM tb_emp a 
JOIN tb_dept b
ON a.dept_cd = b.dept_cd
WHERE a.addr LIKE '%����%'
    AND a.emp_nm LIKE '��%'
ORDER BY a.emp_no
;


-- 1980���� ������� ���(emp), �����(emp), �μ���(dept), �ڰ�����(certi), �������(emp certi)�� ��ȸ

    -- ����Ŭ ����
SELECT
    e.emp_no, e.emp_nm, e.birth_de, d.dept_nm, c.certi_nm, ec.acqu_de
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE e.dept_cd = d.dept_cd
    AND ec.certi_cd = c.certi_cd
    AND e.emp_no = ec.emp_no
  AND e.birth_de BETWEEN '19800101' AND '19891231'
;

     -- ǥ�� �̳� ���� (JOIN �տ� �ƹ��͵� �� ���� �ڵ����� INNER JOIN ��)
SELECT
    E.emp_no, E.emp_nm, E.birth_de, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E 
JOIN tb_dept D 
ON E.dept_cd = D.dept_cd
JOIN tb_emp_certi EC 
ON E.emp_no = EC.emp_no
JOIN tb_certi C
ON EC.certi_cd = C.certi_cd
WHERE E.birth_de BETWEEN '19800101' AND '19891231'
;

-- JOIN ON �������� ī�׽þ� �� �����
SELECT
    * 
FROM test_a a, test_b b
;

SELECT
    * 
FROM test_a a
CROSS JOIN test_b b
;

--# NATRURAL JOIN
-- 1. ������ �̸��� ���� Į���鿡 ���� �ڵ����� ���� ������ �����ϴ� ���
    -- �ڵ����� 2�� �̻��� ���̺��� ���� �̸��� ���� Į���� ã�� INNER JOIN�� ����
-- 2. �̶� �̸��� ������ Ÿ���� ���� �÷��� ���εǸ�
    -- ALIAS�� ���̺���� �ڵ� ���� �÷� �տ� ǥ���ϸ� �� �˴ϴ�.
-- 3. SELECT * ������ ����ϸ� ���� �÷��� ���տ��� �� ���� ǥ��ȴ�
-- 4. ���� �÷��� n�� �̻��̸� ���� ������ n���� ó���ȴ�
    -- ���� ������ ������ �� ����

-- ��� ���̺�� �μ� ���̺��� ����(���, �����, �μ��ڵ�, �μ���)
    -- �̳� ����
SELECT
    a.emp_no, a.emp_nm, a.dept_cd, b.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON a.dept_cd = b.dept_cd
;
    -- ���߷� ����
SELECT
    emp_no, emp_nm, dept_cd, dept_nm
FROM tb_emp A
NATURAL JOIN tb_dept B
;

--# USING�� ���� (NATRURAL JOIN �Ļ�)
-- 1. NATRURAL JOIN������ �ڵ����� �̸��� Ÿ���� ��ġ�� ��� �÷��� ���� ������ �Ͼ����
--    USING�� ���۸� ���ϴ� Į���� ���ؼ��� ������ ���� ������ �ο��� �� �ִ�
-- 2. USING�������� ���� �÷��� ���� ALIAS�� ���̺���� ǥ���ϸ� �� �ȴ�
SELECT
    emp_no, emp_nm, dept_cd, dept_nm
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd) -- a.dept_cd = b.dept_cd �� ����
                -- ��ǥ�� �÷� ���� ����
;

-- INNER JOIN ON���� SELECT *
    -- Į�� �ߺ� ó�� �� �� (15��)
SELECT
    *
FROM tb_emp A
JOIN tb_dept B
ON a.dept_cd = b.dept_cd
;

-- NATRURAL JOIN ON���� SELECT *
    -- Į�� �ߺ� ó�� �� (14��)
SELECT
    *
FROM tb_emp A
NATURAL JOIN tb_dept B
;
-- INNER JOIN USING���� SELECT *
    -- Į�� �ߺ� ó�� �� (14��)
SELECT
    *
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd) -- a.dept_cd = b.dept_cd �� ����
                -- ��ǥ�� �÷� ���� ����
;