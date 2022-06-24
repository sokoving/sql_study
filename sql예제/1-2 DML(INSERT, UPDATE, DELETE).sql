-- SELECT, INSERT, UPDATE, DELETE
-- SELECT(Read)
    -- ��ȸ
    -- ��û�� ���� �����͸� �����ش�
-- INSERT(Create), UPDATE, DELETE
    -- ����
    -- �̻��� ���� ���ɼ��� ����
    -- yes or no


-- INSERT : ����
INSERT INTO board  -- �����͸� ������ �÷� �̸� ���
    (bno, title, content, writer, reg_date) -- �̸� ���� ��� ����
VALUES
    (2, '�����̾�~', '������~~~', '�Ѹ�', SYSDATE + 1); --�� ��ȣ�� ������ ����

COMMIT;

SELECT * FROM board;

    -- NOT NULL �������� ���� > ���� ����
INSERT INTO board
    (bno, content, writer)
VALUES
    (3, '������~~~', '�Ѹ�');
    
    -- PK�� UNIQUE �������� ���� > ���� ����
INSERT INTO board
    (bno, title, content, writer, reg_date)
VALUES
    (1, '�����̾�~', '������~~~', '�Ѹ�', SYSDATE + 1);
 
    -- reg_date�� NOT NULL �̾ �ڵ� ���� > ���� ����
INSERT INTO board
    (bno, title, writer)
VALUES
    (3, '������ȣȣȣ~', '�Ѹ�');

    -- column ���� ����
    -- ������ ��� �����͸� ������� ä���� �ϸ� �������� �ʴ� ����̴�
INSERT INTO board
VALUES
    (4, '�÷� ����', '����', '�ٵ� ��� �÷��� ������� ä���� ��, ��õ �� ��', SYSDATE+1); 
    
COMMIT;        
    
-- UPDATE : ����
UPDATE board
 SET title = '������ �����̾�~'
 WHERE bno = 1;  -- WHERE���� ���� PK�� ����. ���� ���� ������ Ű�� ��� ���� ������
 
UPDATE board
 SET writer = '������'         -- set���� ���� �÷��� �޸��� �����Ͽ� ������ �� �ִ�
 , content = '����������������'
 WHERE bno = 2;
    
    -- WHERE�� �����ϸ� ��ü �� �ϰ� ����
UPDATE board
 set writer = '���۳�';
 
    -- Ŀ�� �� �ϸ� �ѹ��� �� �ִ�(Ŀ���ϸ� ���� �Ұ�)
 ROLLBACK;
 
 -- DELETE : ������ ����
 DELETE FROM board -- SELECT * FROM�� �޸� DELETE FROM ���̿� �ƹ��͵� �� ��
  WHERE bno=1;
  
  -- ��ü ������ ����
    -- 1. WHERE���� ������ DELETE��
    -- �ѹ� ����, ���� Ŀ�� ����, �α� ����� ����
DELETE FROM board;

    -- 2. TRUMCATE TABLE
    -- �ѹ� �Ұ���, �ڵ� Ŀ��, �α׸� ���� �� ����, ���̺� ���� �ʱ� ���·� ����
    -- ����: ������ ����� ���� ����
TRUNCATE TABLE board;

    -- 3. DROP TABLE
    -- �ѹ� �Ұ���, �ڵ� Ŀ��, �α׸� ���� �� ������, ���̺� ���� �ʱ� ���·� ����
    -- �ű�� ����(�÷� ����)�� ���� ������
DROP TABLE board;