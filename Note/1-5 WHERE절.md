# WHERE 조건절
- -- WHERE 조건문 : 조회 결과 행을 제한하는 조건절(행을 대상으로 하는 조건절)
  SELECT
  emp_no, emp_nm, addr, sex_cd
  FROM tb_emp         -- 여기까지만 쓰면 해당하는 모든 행 출력
  WHERE sex_cd = 2    -- 성별코드 2인 행만 출력
  ;

-- PK로 WHERE절 동등조건을 만들면 반드시 단일행이 조회된다
SELECT
emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE emp_no = 1000000001
;

-- 비교연산자
SELECT
emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101'    --VARCHAR2가 NUMBER로 자동 형변환
AND birth_de <= '19991231'
;

-- BETWEEN 연산자 (위 WHERE AND 연산과 같은 결과)
SELECT
emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN '19900101' AND '19991231'
;

-- OR 연산자
SELECT
emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'  -- 100004번과 100005번 둘 다 출력
OR dept_cd = '100006'
;
-- IN 연산자 : OR과 같은 결과
SELECT
emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN ('100004', '100006')
;

-- NOT IN 연산자 : 괄호 안의 행 제외하고 출력
SELECT
emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN ('100004', '100006')
;

-- LIKE 연산자 : 검색 시 사용
-- 와일드 카드 맵핑 (% : 0글자 이상,  _ : 단 한 글자)
SELECT
emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이__' -- 이뿅뿅 찾아오기
;
SELECT
emp_no, emp_nm, addr
FROM tb_emp
WHERE addr LIKE '%용인%' -- 주소에 용인 들어가는 행 찾기
;

-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에 하나이면서,
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회
SELECT
emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE 1=1       -- 무조건 참인 조건을 넣어서
AND emp_nm LIKE '김%'    -- 첫 조건부터 줄 단위로 구분
AND dept_cd IN ('100003', '100004', '100006')
AND birth_de BETWEEN '19900101' AND '19991231'
;               -- 세미콜론도 개행해서 넣으면 줄 단위로 수정, 삭제가 편하다

-- 부정 일치 비교 연선자(NOT EQUEL)
SELECT
emp_no, emp_nm, addr, sex_cd
FROM tb_emp         
WHERE sex_cd != 2    -- !=, ^=, <>, NOT 전부 부정일치
AND emp_no ^= 100000001
AND emp_nm NOT LIKE '김%'
;
-- 성별코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의
-- 사번, 이름, 성별코드를 조회하세요.
SELECT
emp_no, emp_nm, sex_cd
FROM tb_emp         
WHERE 1=1
AND sex_cd <> 1    
AND emp_nm NOT LIKE '이%'
;

-- null값 조회(시험 별표)
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

-- 연산자 우선순위 : NOT > AND > OR
-- 사원정보 중에 김씨면서 수원 또는 일산에 사는 사원들의 정보 조회
SELECT
emp_no, emp_nm, addr
FROM tb_emp         
WHERE 1=1                       -- 괄호로 묶지 않으면 AND 연산을 먼저 하기 때문에
AND emp_nm LIKE '김%'        -- (김씨 AND %수원%) OR (%일산%) 이렇게 됨
AND (addr LIKE '%수원%' OR addr LIKE '%일산%')
;