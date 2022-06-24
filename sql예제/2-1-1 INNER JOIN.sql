-- SELECT [DISTINCT] { 열이름 .... } 
-- FROM  테이블 또는 뷰 이름
-- JOIN  테이블 또는 뷰 이름
-- ON    조인 조건
-- WHERE 조회 조건
-- GROUP BY  열을 그룹화
-- HAVING    그룹화 조건
-- ORDER BY  정렬할 열 [ASC | DESC];


-- 테이블 분할 > 행 수를 줄이기 위해서

-- 조인
 -- 다른 테이블에 있는 행을 가져오는 것
 -- A와 B를 조인하면 5행, 하지만 서로 열 수가 다르다

-- 조인 기초 테스트 데이터
CREATE TABLE TEST_A (  -- 게시판
    id NUMBER(10) PRIMARY KEY -- 게시글 번호
    , content VARCHAR2(200) -- 게시글 내용
);
CREATE TABLE TEST_B ( -- 댓글
    b_id NUMBER(10) PRIMARY KEY -- 댓글 번호
    , reply VARCHAR2(100) -- 댓글 내용
    , a_id NUMBER(10) -- 원본 글 번호(FK 걸진 않았지만 FK 역할을 함)
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, 'ㄱㄱㄱ', 1);
INSERT INTO TEST_B  VALUES (2, 'ㄴㄴㄴ', 1);
INSERT INTO TEST_B  VALUES (3, 'ㄷㄷㄷ', 2);
INSERT INTO TEST_B  VALUES (4, 'ㄹㄹㄹ', 3);
COMMIT;

SELECT * FROM test_a;
SELECT * FROM test_b;

--# CROSS JOIN, 카테시안 곱(Cartesion product)
-- 조인 조건을 설정하지 않은 조인
-- 모든 테이블끼리 크로스되어 조회된다 5행 (3*4)열
    -- FROM 테이블A, 테이블B
SELECT
    *
FROM test_a, test_b;

-- 조인 2. INNER JOIN (EQUI JOIN의 일종)
-- 동등 비교해서 동일한 값이 있는 행만 반환
    -- SELECT 테이블A.행, 테이블B.행
    -- FROM 테이블A, 테이블B
    -- WHERE 테이블A.행 = 테이블B.행
SELECT
-- test_a.id, test_a.content, test_b.reply
    a.id, a.content, b.reply
FROM test_a A, test_b B
WHERE a.id = b.a_id -- 조인 조건
;

-----------------------------------
SELECT * FROM tb_emp; -- 사번, 이름,  
SELECT * FROM tb_emp_certi;
SELECT * FROM tb_certi;
SELECT * FROM tb_dept;

--2개 테이블 조인
-- 사원의 사원 번호, 취득 자격증 명
SELECT 
    a.emp_no, b.certi_nm
FROM tb_emp_certi A, tb_certi B
WHERE a.certi_cd = b.certi_cd
ORDER BY a.emp_no
;

-- 3개 테이블 조인
-- 사원의 사원 번호, 사원 이름, 취득 자격증 명
SELECT 
    a.emp_no, c.emp_nm,  b.certi_nm
FROM tb_emp_certi a, tb_certi b, tb_emp c
WHERE a.certi_cd = b.certi_cd
    AND a.emp_no = c.emp_no
ORDER BY a.emp_no
;

-- 4개 테이블 조인
-- 사원의 사원 번호, 사원 이름, 부서 이름, 취득 자격증 명
SELECT 
    a.emp_no, c.emp_nm, d.dept_nm, b.certi_nm
FROM tb_emp_certi a, tb_certi b, tb_emp c, tb_dept d
WHERE a.certi_cd = b.certi_cd
    AND a.emp_no = c.emp_no
    AND c.dept_cd = d.dept_cd
ORDER BY a.emp_no
;

-- group by에서 조인
-- 부서별 총 자격증 취득 수
SELECT 
    b.dept_cd, c.dept_nm, COUNT(a.certi_cd) "부서별 자격증 수"
FROM tb_emp_certi a, tb_emp b, tb_dept c
WHERE a.emp_no = b.emp_no
    AND b.dept_cd = c.dept_cd
GROUP BY b.dept_cd, c.dept_nm
ORDER BY b.dept_cd
;

------------------------------------------------------------
-- 표준 조인
-- # INNER JOIN
-- 1. 2개 이상의 테이블이 공통된 컬럼에 의해 논리적으로 결합되는 조인기법
-- 2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 조인됩니다.


-- 오라클 조인
 -- 조인할 테이블(n개)만큼 조인 조건(n-1)이 늘어난다
 -- 일반 조건과 조인 조건이 함께 써진다

-- 용인시에 사는 김씨 성 사원의 (사원번호, 사원명, 주소, 부서코드, 부서명) 조회
SELECT
    a.emp_no, a.emp_nm, a.addr, a.dept_cd, b.dept_nm
FROM tb_emp a, tb_dept b
WHERE a.addr LIKE '%용인%'
    AND a.dept_cd = b.dept_cd
    AND a.emp_nm LIKE '김%'
ORDER BY a.emp_no
;

--# 표준 조인 (JOIN ON TABLE)
-- 조인 조건 서술부(ON절), 일반 조건 서술부(WHERE절)을 분리해서 작성하는 방법
    -- 1. FROM절 뒤, WHERE절 앞
    -- 2. JOIN 키워드 뒤에는 조인할 테이블명을 명시
        -- INNER JOIN에서 INNER는 생략 가능
    -- 3. ON 키워드 뒤에는 조인 조건을 명시
        -- JOIN과 ON은 같이 다닌다
        -- ON절을 이용하면 JOIN 이후의 논리연산이나 서브쿼리와 같은 추가 서술이 가능
        
-- 용인시에 사는 김씨 성 사원의 (사원번호, 사원명, 주소, 부서코드, 부서명) 조회
SELECT
    a.emp_no, a.emp_nm, a.addr, a.dept_cd, b.dept_nm
FROM tb_emp a 
JOIN tb_dept b
ON a.dept_cd = b.dept_cd
WHERE a.addr LIKE '%용인%'
    AND a.emp_nm LIKE '김%'
ORDER BY a.emp_no
;


-- 1980년대생 사원들의 사번(emp), 사원명(emp), 부서명(dept), 자격증명(certi), 취득일자(emp certi)를 조회

    -- 오라클 조인
SELECT
    e.emp_no, e.emp_nm, e.birth_de, d.dept_nm, c.certi_nm, ec.acqu_de
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE e.dept_cd = d.dept_cd
    AND ec.certi_cd = c.certi_cd
    AND e.emp_no = ec.emp_no
  AND e.birth_de BETWEEN '19800101' AND '19891231'
;

     -- 표준 이너 조인 (JOIN 앞에 아무것도 안 쓰면 자동으로 INNER JOIN 됨)
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

-- JOIN ON 구문으로 카테시안 곱 만들기
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
-- 1. 동일한 이름을 갖는 칼럼들에 대해 자동으로 조인 조건을 생성하는 기법
    -- 자동으로 2개 이상의 테이블에서 같은 이름을 가진 칼럼을 찾아 INNER JOIN을 수행
-- 2. 이때 이름과 데이터 타입이 같은 컬럼이 조인되며
    -- ALIAS나 테이블명을 자동 조인 컬럼 앞에 표기하면 안 됩니다.
-- 3. SELECT * 문법을 사용하면 공통 컬럼은 집합에서 한 번만 표기된다
-- 4. 공통 컬럼이 n개 이상이면 조인 조건이 n개로 처리된다
    -- 조인 조건을 지정할 수 없다

-- 사원 테이블과 부서 테이블을 조인(사번, 사원명, 부서코드, 부서명)
    -- 이너 조인
SELECT
    a.emp_no, a.emp_nm, a.dept_cd, b.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON a.dept_cd = b.dept_cd
;
    -- 내추럴 조인
SELECT
    emp_no, emp_nm, dept_cd, dept_nm
FROM tb_emp A
NATURAL JOIN tb_dept B
;

--# USING절 조인 (NATRURAL JOIN 파생)
-- 1. NATRURAL JOIN에서는 자동으로 이름과 타입이 일치는 모든 컬럼에 대해 조인이 일어나지만
--    USING을 사요앟면 원하는 칼럼에 대해서만 선택적 조인 조건을 부여할 수 있다
-- 2. USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 표기하면 안 된다
SELECT
    emp_no, emp_nm, dept_cd, dept_nm
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd) -- a.dept_cd = b.dept_cd 와 같음
                -- 쉼표로 컬럼 나열 가능
;

-- INNER JOIN ON에서 SELECT *
    -- 칼럼 중복 처리 안 함 (15열)
SELECT
    *
FROM tb_emp A
JOIN tb_dept B
ON a.dept_cd = b.dept_cd
;

-- NATRURAL JOIN ON에서 SELECT *
    -- 칼럼 중복 처리 함 (14열)
SELECT
    *
FROM tb_emp A
NATURAL JOIN tb_dept B
;
-- INNER JOIN USING에서 SELECT *
    -- 칼럼 중복 처리 함 (14열)
SELECT
    *
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd) -- a.dept_cd = b.dept_cd 와 같음
                -- 쉼표로 컬럼 나열 가능
;