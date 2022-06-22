-- Q. employees 테이블에서 job_id가 it_prog인 사원의
-- first_name과 salary를 출력하세요
-- 조건 1) 비교하기 위한 값은 소문자로 입력
-- 조건 2) 이름은 앞 3글자까지만 출력하고 나머지는 *로 출력
-- 조건 3) 급여는 전체 10자리, 나머지는 *로 출력
-- 조건 4) first_name 별칭 name, salary 별칭 salary 

SELECT
    RPAD(substr(first_name, 1, 3), length(first_name), '*'), salary
FROM employees
WHERE lower(job_id) = 'it_prog'
;