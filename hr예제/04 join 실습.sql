SELECT * FROM employees;
-- 1. employees테이블과 departments테이블을 inner join하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.

-- INNER JOIN의 문제점: department_id가 null이면 조회되지 않는다
-- 107명 중 106명만 조회됨
SELECT
    e.employee_id, e.first_name, e.last_name, e.department_id, d.department_name
FROM employees E
INNER JOIN departments D
ON e.department_id = d.department_id
;

-- 2. employees테이블과 departments테이블을 natural join하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.

-- NATURAL JOIN의 문제점: 모든 동일 컬럼이 자동으로 조인돼 의도대로 조회되지 않는다
SELECT
    employee_id, first_name, last_name, department_id, department_name
FROM employees
NATURAL JOIN departments
-- JOIN departments
-- ON E.department_id = D.department_id
-- ON E.manager_id = D.manager_id
    -- department_id, manager_id 모두 동일한 행만 출력된다
;

-- 3. employees테이블과 departments테이블을 using절을 사용하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.
SELECT
    employee_id, first_name, last_name, department_id, department_name
FROM employees
JOIN departments
USING (department_id)
;

-- 4. employees테이블과 departments테이블과 locations 테이블을 
--    join하여 employee_id, first_name, department_name, city를 조회하세요
SELECT
    e.employee_id, e.first_name, d.department_name, l.city
FROM employees E
JOIN departments D
ON e.department_id = d.department_id
JOIN locations L
ON d.location_id = l.location_id
;