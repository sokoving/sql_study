-- Q. employees ���̺��� job_id�� it_prog�� �����
-- first_name�� salary�� ����ϼ���
-- ���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է�
-- ���� 2) �̸��� �� 3���ڱ����� ����ϰ� �������� *�� ���
-- ���� 3) �޿��� ��ü 10�ڸ�, �������� *�� ���
-- ���� 4) first_name ��Ī name, salary ��Ī salary 

SELECT
    RPAD(substr(first_name, 1, 3), length(first_name), '*'), salary
FROM employees
WHERE lower(job_id) = 'it_prog'
;