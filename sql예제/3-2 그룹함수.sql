-- ���̺� ���� : CTAS (CREATE TABLE AS SELECT)
CREATE TABLE tb_emp_copy
AS
SELECT
    emp_no, emp_nm, addr
FROM tb_emp;

SELECT * FROM tb_emp_copy;

-- �� ���� : CVAS (CREATE VIEW AS SELECT)
CREATE VIEW tb_emp_view
AS
SELECT emp_no, emp_nm, addr, dept_cd
FROM tb_emp;

SELECT * FROM tb_emp;
SELECT * FROM tb_emp_view;

-- �׷��Լ� : GROUP BY���� �� �� �ִ� �׷��� �Լ�
-- 1. ROLLUP (col_a, col_b) : col_a�� �׷�����ؼ� ���, col_a 