-- 집합 연산자
-- ## UNION
-- 1. 합집합 연산의 의미입니다.
-- 2. 첫번째 쿼리와 두번째 쿼리의 중복정보는 한번만 보여줍니다.
-- 3. 첫번째 쿼리의 열의 개수와 타입이 두번째 쿼리의 열수와 타입과 동일해야 함.
-- 4. ORDER BY문이 없어도 자동으로 정렬이 일어남 (첫번째 컬럼 오름차가 기본값)
-- 5. 열 별칭은 첫 번재 쿼리의 것을 선택
-- 6. ORDER BY는 마지막 쿼리 뒤에 붙임
-- JOIN : 컬럼을 더함
-- UNION : 행을 더함

-- 60년대생과 70년대생을 UNION
-- 첫번째 컬럼인 사번 오름차 정렬
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

-- 이름과 생일이 같은 이관심 중복 제거(사번은 다름)
-- 첫번째 컬럼인 이름 오름차 정렬
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

-- 열 별칭 선택, ORDER BY
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
-- 1. UNION과 같이 두 테이블로 수직으로 합쳐서 보여줍니다.
-- 2. UNION과는 달리 중복된 데이터도 한번 더 보여줍니다.
-- 3. 자동 정렬 기능을 지원하지 않아 성능상 유리합니다.

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
-- 1. 첫번째 쿼리와 두번째 쿼리에서 중복된 행만을 출력합니다.
-- 2. 교집합의 의미입니다.

-- SQLD 자격증을 땄으면서 용인에 사는 사람
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
WHERE A.addr LIKE '%용인%';


SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 
-- 1. 두번째 쿼리에는 없고 첫번째 쿼리에만 있는 데이터를 보여줍니다.
-- 2. 차집합의 개념입니다.

-- 전체 사원 중 100001번, 100004번 부서 그리고 남자가 아닌 사원
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1'
;


-- # 계층형 쿼리
-- START WITH : 계층의 첫 단계를 어디서 시작할 것인가에 대한 조건
         -- tree 구조의 root를 지정하는 조건
         -- ex) 상사가 null인 사람부터 계층형 쿼리 시작
-- CONNECT BY PRIOR 자식 = 부모
    -- 순방향 탐색, 부모에서 자식 순으로 탐색
-- CONNECT BY 자식 = PRIOR 부모
    -- 역방향 탐색, 자식에서 부모 순으로 탐색
-- ORDER SIBLINGS BY : 같은 레벨끼리의 정렬을 정함

SELECT 
    LEVEL AS LVL, -- 가상 컬럼 LEVETL
    -- 계층구조를 시각화하기 위한 LPAD , 이름을 같은 행에 넣기 위한 문자 결합연산 ||
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
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
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
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
-- 1. 하나의 테이블에 자기 자신의 테이블을 조인하는 기법
-- 2. 자기 자신 테이블에서 pk와 fk 를 동등조인한다

SELECT
     a.emp_no "사원 번호"
     , a.emp_nm "사원 이름"
     , a.addr "사원 주소"
     , a.direct_manager_emp_no "상사 사원 번호"
     , b.emp_nm "상사 이름"
     , a.addr " 상사 주소"
FROM tb_emp A 
LEFT OUTER JOIN tb_emp B 
ON a.direct_manager_emp_no = b.emp_no
ORDER BY a.emp_no
;


--fk 설정
alter table tb_emp
add CONSTRAINT fk_tb_emp_no
foreign key (direct_manager_emp_no)
references tb_emp(emp_no)
;