-- ���� 101��
DROP TABLE ǰ�����׸�_101;
DROP TABLE �򰡴���ǰ_101;
DROP TABLE �򰡰��_101;

CREATE TABLE ǰ�����׸�_101 (
    ���׸�ID CHAR(7)
    , ���׸�� VARCHAR2(50)
    , CONSTRAINT ǰ�����׸�_101_PK PRIMARY KEY (���׸�ID)
);

CREATE TABLE �򰡴���ǰ_101 (
    ��ǰID CHAR(7)
    , ��ǰ�� VARCHAR2(50)
    , CONSTRAINT �򰡴���ǰ_101_PK PRIMARY KEY (��ǰID)
);

CREATE TABLE �򰡰��_101 (
    ��ǰID CHAR(7)
    , ��ȸ�� NUMBER
    , ���׸�ID CHAR(7)
    , �򰡵�� CHAR(1)
    , ������ CHAR(8)
    , CONSTRAINT �򰡰��_101_PK PRIMARY KEY (��ǰID, ��ȸ��, ���׸�ID)
);

INSERT INTO ǰ�����׸�_101 VALUES ('101', '�����ڷ�');
INSERT INTO ǰ�����׸�_101 VALUES ('102', '����ü�');

INSERT INTO �򰡴���ǰ_101 VALUES ('101', '�ڹټ���');
INSERT INTO �򰡴���ǰ_101 VALUES ('102', '���̽����');

INSERT INTO �򰡰��_101 VALUES ('101', 1, '101', 'S', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 2, '101', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 3, '101', 'B', '20220629');

INSERT INTO �򰡰��_101 VALUES ('101', 1, '102', 'B', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 2, '102', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 3, '102', 'S', '20220629');

INSERT INTO �򰡰��_101 VALUES ('102', 1, '101', 'S', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 2, '101', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 3, '101', 'B', '20220629');

INSERT INTO �򰡰��_101 VALUES ('102', 1, '102', 'B', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 2, '102', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 3, '102', 'S', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 4, '102', 'C', '20220629');

COMMIT;

SELECT * FROM "�򰡰��_101"
;    

SELECT * FROM  "�򰡴���ǰ_101"
;

SELECT * FROM "ǰ�����׸�_101"
;

