
-- Repository layer : ���� �����Ͱ� ����Ǵ� ����
--  �� ��ü, ������ ��ü, ����Ƽ ��ü
CREATE TABLE score (
    stu_num NUMBER(10), --�л� �Ϸù�ȣ
    stu_name VARCHAR2(20) NOT NULL, -- �л� �̸�
    kor NUMBER(3) NOT NULL, -- ���� ����
    eng NUMBER(3) NOT NULL, -- ���� ����
    math NUMBER(3) NOT NULL, -- ���� ����
    total NUMBER(3), -- ���� ���� ����
    average NUMBER(5,2), -- ���� ���� ���
    CONSTRAINT pk_score PRIMARY KEY (stu_num)
);

-- ���ӵ� ���� ����
CREATE SEQUENCE seq_score;
  -- �ߺ� ���� �Ϸù�ȣ �����
  -- sequence ���̺��� ��������� seq_score.nextval�� �ϸ� ������� ������
  -- �Խñ� ��ȣ ���� �� ���� �� ��

SELECT * FROM score;

commit;




INSERT INTO score VALUES (seq_score.nextval,  'ȫ�浿', 90, 90, 90, 270, 90);
INSERT INTO score VALUES (seq_score.nextval,  '��ö��', 80, 80, 80, 240, 80);
INSERT INTO score VALUES (seq_score.nextval,  '�ڿ���', 100, 100, 100, 300, 100);
COMMIT;


SELECT AVG(AVERAGE) AS avg_class
from score;



----trainee record table
CREATE TABLE trainee (
    tr_num NUMBER(10), --�л� ���̵�
    tr_name VARCHAR2(20) NOT NULL, -- �л� �̸�
    tr_sex char(1) NOT NULL, -- �л� ����
    run100 NUMBER(3, 1) NOT NULL, -- 100m �޸��� ���
    run1000 NUMBER(3) NOT NULL, -- 1000m �޸��� ���
    situp NUMBER(2) NOT NULL, -- ��������Ű�� ���
    pushUp NUMBER(2) NOT NULL, -- �ȱ������ ���
    rightGrip NUMBER(2) NOT NULL, -- ������ �Ƿ� ���
    leftGrip NUMBER(2) NOT NULL, -- �޼� �Ƿ� ���

    CONSTRAINT pk_trainee PRIMARY KEY (tr_num)
);

CREATE SEQUENCE seq_trainee;

INSERT INTO trainee VALUES (seq_trainee.nextval, '�ֽ�ö', 'M', 15, 250, 50, 50, 50, 50);
INSERT INTO trainee VALUES (seq_trainee.nextval, '�̿���', 'M', 13.5, 235, 45, 44, 56, 55);
INSERT INTO trainee VALUES (seq_trainee.nextval, '���¿�', 'F', 16, 260, 40, 39, 44, 50);
INSERT INTO trainee (tr_num, tr_name, tr_sex, run100, run1000, situp, pushup, rightgrip, leftgrip) VALUES (seq_trainee.nextval, '���ҿ�', 'F', 15.5, 255, 48, 49, 56, 57);
commit;

SELECT
    * FROM trainee;
    
UPDATE trainee SET run100 = 16.5, run1000 = 287, situp = 61, pushup = 61, rightgrip = 59, leftgrip = 55 WHERE tr_num = 5
;
commit;

DELETE FROM trainee WHERE tr_num=7;