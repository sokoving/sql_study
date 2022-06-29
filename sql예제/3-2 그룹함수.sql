-- 테이블 복사 : CTAS (CREATE TABLE AS SELECT)
CREATE TABLE tb_emp_copy
AS
SELECT
    emp_no, emp_nm, addr
FROM tb_emp;

SELECT * FROM tb_emp_copy;

-- 뷰 생성 : CVAS (CREATE VIEW AS SELECT)
CREATE VIEW tb_emp_view
AS
SELECT emp_no, emp_nm, addr, dept_cd
FROM tb_emp;

SELECT * FROM tb_emp;
SELECT * FROM tb_emp_view;

-- 그룹함수 : GROUP BY절에 쓸 수 있는 그룹핑 함수
-- 1. ROLLUP (col_a, col_b) : col_a로 그룹바이해서 통계, col_a 