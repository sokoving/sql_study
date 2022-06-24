SELECT * FROM employees;
-- 1. employees���̺�� departments���̺��� inner join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.

-- INNER JOIN�� ������: department_id�� null�̸� ��ȸ���� �ʴ´�
-- 107�� �� 106�� ��ȸ��
SELECT
    e.employee_id, e.first_name, e.last_name, e.department_id, d.department_name
FROM employees E
INNER JOIN departments D
ON e.department_id = d.department_id
;

-- 2. employees���̺�� departments���̺��� natural join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.

-- NATURAL JOIN�� ������: ��� ���� �÷��� �ڵ����� ���ε� �ǵ���� ��ȸ���� �ʴ´�
SELECT
    employee_id, first_name, last_name, department_id, department_name
FROM employees
NATURAL JOIN departments
-- JOIN departments
-- ON E.department_id = D.department_id
-- ON E.manager_id = D.manager_id
    -- department_id, manager_id ��� ������ �ุ ��µȴ�
;

-- 3. employees���̺�� departments���̺��� using���� ����Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT
    employee_id, first_name, last_name, department_id, department_name
FROM employees
JOIN departments
USING (department_id)
;

-- 4. employees���̺�� departments���̺�� locations ���̺��� 
--    join�Ͽ� employee_id, first_name, department_name, city�� ��ȸ�ϼ���
SELECT
    e.employee_id, e.first_name, d.department_name, l.city
FROM employees E
JOIN departments D
ON e.department_id = d.department_id
JOIN locations L
ON d.location_id = l.location_id
;