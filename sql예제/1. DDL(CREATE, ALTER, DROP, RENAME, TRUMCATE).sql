-- DDL: ������ ���Ǿ�
    -- CREATE, ALTER, DROP, RENAME, TRUNCATE

-- CREATE TABLE: ���̺��� ����
CREATE TABLE board (
    bno NUMBER(10)  -- �۹�ȣ 10�ڸ� ����
    , title VARCHAR2(200) NOT NULL -- ������ : 200byte����, �ʼ� �ۼ�
    , writer VARCHAR2(40) NOT NULL -- �ۼ��� : �ʼ� �ۼ�, �ߺ� ���(��� �� �ϸ� �� ����� ���� �� �� ��)
    , content CLOB  -- �� ���� : VARCHAR2�� �ִ� 4000byte����, �� �� ���� ������ CLOB Ÿ������
    , reg_date DATE DEFAULT SYSDATE -- �ۼ� ���� : �ý��� ��¥ �ڵ� ����
    , view_count NUMBER(10) DEFAULT 0 -- ��ȸ�� : 0 �ڵ� ����
);

-- SELECT : ���̺� ��ȸ
SELECT * FROM board;


-- ALTER : �����ͺ��̽��� ������ ����(��°�� �ܿ��)
    -- PK  ����(PK ��ü�� NOT NULL UNIQUE�� �ڵ����� �ɸ�)
ALTER TABLE board
ADD CONSTRAINT pk_board_bno
PRIMARY KEY (bno);


-- ������ �߰�
INSERT INTO board
    (bno, title, writer, content)
VALUES 
    (1, '�ȴ�?', '�ٲٱ��', '�����Ͼ����� ������');
    
INSERT INTO board
    (bno, title, writer)
VALUES 
    (2, '���ִ� ����', '����ȣȣ');

COMMIT;

SELECT * FROM board;


-- �������� ����
    -- �Խù� ����� ���� = 1 : M
    -- �Խù� �ϳ��� ��� ���� ��

    -- ��� ���̺� ����
CREATE TABLE reply (
    rno NUMBER(10)
    , r_content VARCHAR2(400)
    , r_writer VARCHAR2(40) NOT NULL
    , bno NUMBER(10) -- �ڽ� ���̺��� �θ� ���̺��� pk�� ������ �־�� �Ѵ�
    , CONSTRAINT pk_reply_rno PRIMARY KEY (rno) -- PK ����
);

    -- �ܷ�Ű(FOREIGN KEY) ���� : ���̺� ���� ���� ���� ����
ALTER TABLE reply
ADD CONSTRAINT fk_reply_bno
FOREIGN KEY (bno)
REFERENCES board (bno);

SELECT * FROM reply;

-- �÷� ����
    -- �÷� �߰�
ALTER TABLE reply
ADD (r_reg_date DATE DEFAULT SYSDATE);

    -- �÷� ����
ALTER TABLE board
DROP COLUMN view_count;

    -- �÷� ����
ALTER TABLE board
MODIFY (title VARCHAR2(500));

-- ���̺� ����
DROP TABLE reply;
    -- ���̺� ���� ����(�ѹ� �Ұ�)
    -- ������ ���� ��� ��� ���ư�, ������ ��ġ�� ���ٸ� ���� �Ұ�
TRUNCATE TABLE reply;
    -- ���̺� ���� ��ü ����(������ ����� ���, �ѹ� �Ұ�)
    -- board�� ������ �� ������ reply�� ��� �� ���� ������ �� �ϸ� �浹��
    

