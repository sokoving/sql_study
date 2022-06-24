-- SELECT(조회) 기본
SELECT
    emp_no, emp_nm -- 컬럼 이름
FROM tb_emp; -- 테이블 이름

SELECT
    certi_nm, certi_cd -- 테이블 컬럼 순서와 상관없다
FROM tb_certi;

SELECT
    *   -- 테이블의 모든 컬럼 조회
FROM tb_dept;

    
    -- SELECT DISTINCT : 중복값을 제외하고 조회 > 중복 제외 6행 출력
        -- SELECT ALL이 기본값 > 중복 포함 20행 전부 출력됨
SELECT DISTINCT
    issue_insti_nm  
FROM tb_certi;
        -- 주의사항: 컬럼이 복수 이상이면 열 단위로 중복 체크
SELECT DISTINCT
    certi_cd, issue_insti_nm  
FROM tb_certi;

    -- 열 별칭(column alias) 지정
SELECT
    certi_cd AS "자격증 코드"  -- "띄어쓰기가 있을 경우 쌍따옴표"
    , certi_nm AS 자격증명      -- 띄어쓰기 없을 경우 쌍따옴표 생략 가능
    , issue_insti_nm 발급기관명 -- AS 항상 생략 가능
FROM tb_certi;

    -- 문자열 결합 연산자 ||
    -- ex) SQLD(100001) - 한국데이터베이스진흥원
SELECT
    certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm AS "자격증 정보"
FROM tb_certi;

    -- dual
    -- 오라클에서 제공하는 더미 테이블
    -- 단순 연산 결과를 조회할 때 사용한다
SELECT
    3 * 6 AS "연산 결과"
FROM dual;

SELECT
    SYSDATE AS "현재 날짜"
FROM dual;
    