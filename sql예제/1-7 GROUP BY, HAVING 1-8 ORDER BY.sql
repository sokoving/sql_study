-- 집계함수(다중행 함수)
-- 여러 행을 묶어서 함수를 적용

SELECT * FROM tb_sal_his;

-- GRUOUP BY로 소그룹화하지 않으면 집계 함수는 전체함수를 기준으로 집계한다
SELECT
    COUNT(pay_amt) "총 사원 수"
    , SUM(pay_amt) "지금 총액"
    , AVG(pay_amt) "평균 지급액"
FROM tb_sal_his
-- 단일행 함수 > tb_sal_his의 행 수(984행)만큼 출력된다
-- 집계 함수 > tb_sal_his의 모든 행을 연산해 1행으로 출력된다
;

-- COUNT(*) : null을 포함한 전체 행 수(null을 포함하는 유일한 집계함수)
-- COUNT(표현식) : null을 제외한 행 수(모든 집계함수는 null을 제외하고 계산한다)
SELECT
    COUNT(*) AS "총 사원 수"
    , COUNT(direct_manager_emp_no) "dmen"
    , MIN(birth_de) "최연장자 생일"
    , MAX(birth_de) "최연소자 생일"
FROM tb_emp;

SELECT * FROM tb_emp
ORDER BY dept_cd;

-- GROUP BY : 지정된 칼럼을 소그룹화 한 후 집계함수 적용
-- GROUP BY로 지정한 컬럼과 집계함수만 SELECT에서 쓸 수 있다 (지정 컬럼 아니면 조회 X)
-- null인 행도 그룹화한다
-- GROUP BY는 SELECT보다 먼저 작동하기 때문에 열 별칭을 쓸 수 없다

-- 부서별로 가장 어린 사람의 생년월일, 연장자의 생년월이 부서별 총 사원 수를 조회
SELECT
--  emp_nm      -- 이름은 볼 수 없음
    dept_cd     -- 그룹화한 dept_cd는 볼 수 있음
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd -- 부서 코드가 같은 행끼리 묶어서 통계 내기
ORDER BY dept_cd
;

-- 사원별 누적 급여 수령액 조회
SELECT 
    emp_no 사번
    , SUM(pay_amt) 누적수령액
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

-- 집계함수는 단일행 함수의 인수가 될 수 있다
-- 집계함수를 다시 집계함수로 묶으면 안 됨(별도 처리가 필요)
-- WHERE
-- 제한할 행이 있다면 GROUP BY 전에 해야 한다
-- WHERE에는 집계함수 사용 못 함
-- FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY

-- 2019년에 사원별로 
-- 급여를 제일 많이 받았을 때, 제일 적게 받았을 때,
-- 평균적으로 얼마 받았는지, 연봉이 얼마인지 조회
SELECT 
    emp_no 사번
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') 최고수령액
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') 최저수령액
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') 평균수령액
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') 연봉
--  , ROUND(pay_amt, 2)  -- 단일행 함수는 쓸 수 없다
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;


-- HAVING
-- 그룹화된 결과에서 조건을 걸어 행 수를 제한
-- WHERE 뒤, ORDER BY 앞 (GROUP BY 앞, 뒤 가능)

-- 부서별로 가장 어린 사람의 생년월일, 연장자의 생년월이 부서별 총 사원 수를 조회
-- 사원이 1명인 부서의 정보는 조회하고 싶지 않을 때
SELECT
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd 
HAVING NOT COUNT (emp_no) = 1
ORDER BY dept_cd
;

-- 사원별로 급여를 제일 많이 받았을 때, 제일 적게 받았을 때, 평균적으로 얼마 받았는지 조회
-- 평균 급여가 450만 원 이상의 사람만 조회
SELECT 
    emp_no 사번
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') 최고수령액
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') 최저수령액
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') 평균수령액
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') 연봉
--  , ROUND(pay_amt, 2)  -- 단일행 함수는 쓸 수 없다
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

-- 사원별로 2019년 월 평균 수령액이 450만 원 이상인 사람의
-- 사원 번호와 2019년 연봉 조회
SELECT
    emp_no
    , TO_CHAR(ROUND(AVG(pay_amt)), 'L999,999,999') 평균수령액
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') 연봉
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

-- GROUP BY에 컬럼을 복수로 주면 컬럼이 모두 일치하는 행끼리 그룹한다
SELECT 
    dept_cd
    , COUNT(*)
FROM tb_emp
GROUP BY dept_cd, sex_cd
ORDER BY dept_cd
;

-- ORDER BY : 정렬
-- ASC : 오름차 정렬(기본값) , DESC : 내림차 정렬
-- 항상 SELECT 절의 맨 마지막에 위치
-- 그룹화한 컬럼과 집계함수만 정렬할 수 있다

-- GROUP BY에 컬럼을 복수로 주면 컬럼이 모두 일치하는 행끼리 그룹한다
SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
--ORDER BY emp_no ASC -- ASC 기본값, 생략 가능
ORDER BY emp_no DESC  -- DESC 표기 필수
;

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm ASC -- 이름으로 정렬
--ORDER BY emp_nm DESC  -- 유니코드 순서 A-Z, 가-힣
;

-- 차순위 정렬은 쉼표로 구분해 쓴다
SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC -- dept_cd가 같으면 emp_nm로 내림차 정렬
;

-- 별칭으로도 정렬 가능
SELECT 
    emp_no 사번
    , emp_nm 이름
    , addr 주소
FROM tb_emp
ORDER BY 이름 ASC
;

-- 컬럼 순서로도 정렬 가능
SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, 2 DESC 
;

-- 섞어서 써도 됨
SELECT 
    emp_no 사번
    , emp_nm 이름
    , dept_cd 주소
FROM tb_emp
ORDER BY 1 ASC, emp_nm DESC, 주소 ASC
;


-- 사원별로 2019년 월 평균 수령액이 450만 원 이상인 사람의
-- 사원 번호와 2019년 연봉 조회
SELECT
    emp_no
    , TO_CHAR(ROUND(AVG(pay_amt)), 'L999,999,999') 평균수령액
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
--ORDER BY SUM(pay_amt) DESC
ORDER BY 평균수령액
--ORDER BY 3 DESC
;
