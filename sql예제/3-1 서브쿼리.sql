-- # 1 단일행 서브쿼리
-- ## 1-1 서브쿼리의 조회 결과가 1건 이하인 경우

-- 부서 코드가 100004번인 부서의 사원정보 조회
SELECT
 emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
;

-- 사원 이나라가 속해 있는 부서 사원들의 정보를 조회
    -- 서브쿼리를 쓰지 않느다면 먼저 이나라의 부서번호를 확인한 뒤
    -- 부서코드 100004번의 부서 사원 정보를 조회하는 두 단계를 거쳐야 한다
SELECT dept_cd FROM tb_emp WHERE emp_nm = '이나라'; -- 100004

    -- (단일행) 서브쿼리를 쓴다면
SELECT
 emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '이나라')
;

-- ## 1-2 단일행 비교연산자는 단일행 서브쿼리만 비교해야 한다
    -- 단일행 비교연산자: =, <>, >, >=, <, <=
-- 사원 이관심이 속해 있는 부서 사원들의 정보를 조회
    -- > 이관심이 동명이인이라 다중행이 출력되어 에러가 난다
SELECT
 emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '이관심')
;

-- 20200525에 받은 급여가 회사 전체의 20200525일 
-- 전체 평균 급여보다 높은 사원들의 정보 조회
    -- 1. a와 b를 조인하여 사람별 받은 급여와 날짜 조회
    -- 2. where로 pay_de를 20200525로 제한
SELECT
    a.emp_no, a.emp_nm, b.pay_de, b.pay_amt
FROM tb_emp A
JOIN tb_sal_his B
ON a.emp_no = b.emp_no
WHERE b.pay_de = '20200525'
ORDER BY a.emp_no, b.pay_de
;
    -- 3. 회사 전 사원의 20200526 급여 평균
SELECT
    AVG(pay_amt)
FROM tb_sal_his
WHERE pay_de = '20200525'
;

    -- 4. 2의 AND 조건으로 3을 서브쿼리로 넣음
SELECT
    a.emp_no, a.emp_nm, b.pay_de, b.pay_amt --b.pay_de, b.pay_amt는 join으로 나온 새로은 테이블
FROM tb_emp A
JOIN tb_sal_his B
ON a.emp_no = b.emp_no
WHERE b.pay_de = '20200525'
    AND b.pay_amt > (
                    SELECT
                        AVG(pay_amt)    -- b.pay_amt와 서브쿼리의 pay_amt는 다른 테이블
                    FROM tb_sal_his
                    WHERE pay_de = '20200525'
                    )
ORDER BY a.emp_no, b.pay_de
;


-- # 2 다중행 서브쿼리
-- 조회 건수가 0건 이상인 서브쿼리
-- ## 2-1 다중행 연산자
-- 1. IN  : 메인쿼리의 비교조건이 서브쿼리 결과중에 하나라도 일치하면 참
    -- EX) salary IN (200, 300, 400) 샐러리가 200이거나 300이거나 400이어야 참
    --      250 IN (200, 300, 400) - 거짓
-- 2. ANY, SOME : 메인쿼리의 비교조건이 서브쿼리의 검색결과 중 하나 이상 일치하면 참
    -- EX) salary > ANY (200, 300, 400) 샐러리가 200이나 300, 400보다 크면 참
    --      250 > ANY (200, 300, 400) - 참
-- 3. ALL : 메인쿼리의 비교조건이 서브쿼리의 검색결과와 모두 일치하면 참
    -- EX) salary > ANY (200, 300, 400) 샐러리가 200보다 크고 300보다 크코 400보다 커야 참
    --      250 > ALL (200, 300, 400) - 거짓
-- 4. EXISTS : 메인쿼리의 비교조건이 서브쿼리의 결과 중 만족하는 값이 하나라도 존재하면 참

-- 한국데이터베이스진흥원에서 발급한 자격증을 가지고 있는
-- 사원의 사원번호화 이름과 자격증 개수를 조회
SELECT
    certi_cd
FROM tb_certi
WHERE issue_insti_nm = '한국데이터베이스진흥원'
;

SELECT
    a.emp_no, a.emp_nm, COUNT(b.certi_cd) "자격증 수"
FROM tb_emp A
JOIN tb_emp_certi B
ON a.emp_no = b.emp_no
--WHERE B.certi_cd IN (
WHERE B.certi_cd = ANY (
--WHERE B.certi_cd = ALL (
                     SELECT certi_cd
                     FROM tb_certi
                     WHERE issue_insti_nm = '한국데이터베이스진흥원'
                    )
GROUP BY a.emp_no, a.emp_nm -- GROUTP BY에서 명시하지 않은 컬럼은 SELECT에 쓸 수 없다
ORDER BY a.emp_no
;

-- ## 2-2 EXISTS문 : 메인쿼리의 비교조건이 서브쿼리의 결과 중 만족하는 값이 하나라도 존재하면 참
SELECT A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS (
            SELECT 1    -- 공집합인지 아닌지만 확인, 컬럼은 상관없다
            FROM tb_emp B
            WHERE addr LIKE '%강남%'
                AND a.dept_cd = b.dept_cd
            )
;


-- # 3. 다중 컬럼 서브쿼리
    -- 서브쿼리의 조회 컬럼이 2개 이상인 서브쿼리
    
-- 부서원이 2명 이상인 부서 중에서 각 부서의 가장 연장자의
-- 사번과 이름 생년월일과 부서코드를 조회
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

-- # 4. 인라인 뷰 서브쿼리 (FROM 절에 쓰는 서브쿼리)
-- 각 사원의 사번과 이름, 평균 급여 정보를 조회

SELECT
    a.emp_no, a.emp_nm, b.pay_avg
--FROM tb_emp A, tb_sal_his B     -- 내역 테이블은 크기가 너무 커서 계산할 때마다 불러오면 과부화
FROM tb_emp A, (                  -- 서브쿼리에 group by로 먼저 테이블 크기를 줄여놓은 뒤에 조인하자
                SELECT emp_no, AVG(pay_amt) AS pay_avg
                FROM tb_sal_his
                GROUP BY emp_no
                ) B
WHERE a.emp_no = b.emp_no
--GROUP BY a.emp_no, a.emp_nm
ORDER BY a.emp_no
;

-- # 5 스칼라 서브쿼리 (SELECT절에 쓰는 서브쿼리)
-- 사원의 사번, 사원명, 성별코드, 부서명, 생년월일, 보유자격증명 조회
    -- 단순 데이터 하나 불러오는 거 때문에 조인을 해야 한다구?
    -- 조인 하지 말구 셀렉트에서 서브쿼리로 바로 불러오자
SELECT 
    A.emp_no
    , A.emp_nm
    , (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
    , A.birth_de
    , A.sex_cd
FROM tb_emp A
;