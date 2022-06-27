-- 74��
DROP TABLE emp_74;
DROP TABLE dept_74;

create table emp_74(
    A char(2)
    , B char(2)
    , C char(2)
    , CONSTRAINT pk_emp_a PRIMARY KEY (A)
);

create table dept_74(
    C char(2)
    , D char(2)
    , E char(2)
    , CONSTRAINT pk_dept_74 PRIMARY key (C)
);


ALTER TABLE emp_74
add CONSTRAINT fk_emp74
FOREIGN key (C)
REFERENCES dept_74 (C)
;

insert into dept_74 VALUES ('w', 1, 10);
insert into dept_74 VALUES ('z', 4, 11);
insert into dept_74 VALUES ('v', 2, 22);
commit;


insert into emp_74 VALUES (1, 'b', 'w');
insert into emp_74 VALUES (3, 'd', 'w');
insert into emp_74 VALUES (5, 'y', 'y');
commit;

SELECT * FROM dept_74;
SELECT * FROM emp_74;

SELECT
    *
FROM emp_74 E
--INNER JOIN dept_74 D
--LEFT OUTER JOIN dept_74 D
--RIGHT OUTER JOIN dept_74 D
FULL OUTER JOIN dept_74 D
on e.c = d.c
;



-- 86��
drop table ȸ���⺻����_86;

CREATE TABLE ȸ���⺻����_86 (
    user_id VARCHAR2(200) PRIMARY KEY
);

CREATE TABLE ȸ��������_86 (
    user_id VARCHAR2(200)
    
);

ALTER TABLE ȸ��������_86
ADD CONSTRAINT fk_user_id 
FOREIGN KEY (user_id)
references ȸ���⺻����_86 (user_id);

INSERT INTO ȸ���⺻����_86 VALUES ('abc01');
INSERT INTO ȸ���⺻����_86 VALUES ('abc02');
INSERT INTO ȸ���⺻����_86 VALUES ('abc03');
COMMIT;


INSERT INTO ȸ��������_86 VALUES ('abc01');
INSERT INTO ȸ��������_86 VALUES ('abc02');
INSERT INTO ȸ��������_86 VALUES ('abc03');
commit;

-- ���� 1
SELECT user_id FROM "ȸ���⺻����_86"
EXCEPT
SELECT user_id FROM "ȸ��������_86"
;

-- 93��
DROP TABLE ���ں�����_93;

CREATE TABLE ���ں�����_93 (
    ���� DATE,
    ����� NUMBER(5)
);

INSERT INTO ���ں�����_93 VALUES ('2015-11-01', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-02', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-03', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-04', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-05', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-06', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-07', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-08', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-09', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-10', 1000);
COMMIT;

SELECT * FROM ���ں�����_93;


--  1
SELECT A.����, SUM(A.�����) AS ���������
FROM ���ں�����_93 A
GROUP BY A.����
ORDER BY A.����
;

-- 2
SELECT
    B.����, SUM(B.�����) AS ���������
FROM ���ں�����_93 A
JOIN ���ں�����_93 B
ON (A.���� >= B.����)
GROUP BY B.����
ORDER BY B.����
;

-----------------------------------------------
-- �߰� ����

-- ���� 19
drop table tb_emp_19;
drop table tb_dept_19;

create table tb_dept_19(
   dept_no char(6)
   , deop_nm VARCHAR2(156) not null
   , CONSTRAINT tb_dept_19_pk PRIMARY KEY (dept_no)
);

INSERT into tb_dept_19 VALUES('D00001', 'Data�ð�ȭ��');
INSERT into tb_dept_19 VALUES('D00002', 'Data�÷�����');
INSERT into tb_dept_19 VALUES('D00003', 'Data�м���');

commit;

CREATE table tb_emp_19(
    emp_no char(6)
    , emp_nm varchar2(50) not null
    , dept_no char(6)
    , CONSTRAINT tb_emp_19_pk PRIMARY key (dept_no)
);

insert into tb_emp_19 VALUES ('E00001', '�̰��', 'D00001');
insert into tb_emp_19 VALUES ('E00002', '�̼���', 'D00001');
insert into tb_emp_19 VALUES ('E00003', '��ȿ��', 'D00002');
insert into tb_emp_19 VALUES ('E00004', '�ڻ���', 'D00003');
commit;

SELECT * FROM tb_dept_19;
SELECT * FROM tb_emp_19;


-- �Ʒ��� ���� ���̺� �� ������ �������� SQL���� ������� ������ ����
SELECT DISTINCT  a.dept_no
from tb_emp_19 A
where a.dept_no = 'D00002'
UNION ALL
SELECT A.dept_no
from tb_emp_19 A
where a.dept_no = 'D00001'
ORDER BY dept_no
;

-- ���� 21
drop table tb_dept_21;

create table tb_dept_21(
    dept_no char(6)
    , dept_nm varchar(150) not null
    , upper_dept_no char(6) null
    , CONSTRAINT tb_dept_21_pk PRIMARY KEY (dept_no)
);

insert into tb_dept_21 VALUES('D00001', 'ȸ���', null);
insert into tb_dept_21 VALUES('D00002', '��������', 'D00001');
insert into tb_dept_21 VALUES('D00003', '�������', 'D00001');
insert into tb_dept_21 VALUES('D00004', '����������', 'D00002');
insert into tb_dept_21 VALUES('D00005', '�ؿܿ�����', 'D00002');
insert into tb_dept_21 VALUES('D00006', '���߻����', 'D00003');
insert into tb_dept_21 VALUES('D00007', '�����ͻ����', 'D00003');
insert into tb_dept_21 VALUES('D00008', '���������', 'D00004');
insert into tb_dept_21 VALUES('D00009', '����������', 'D00004');
insert into tb_dept_21 VALUES('D00010', '�Ϲ̿�����', 'D00005');
insert into tb_dept_21 VALUES('D00011', '���̿�����', 'D00005');
insert into tb_dept_21 VALUES('D00012', '����������', 'D00006');
insert into tb_dept_21 VALUES('D00013', 'ȭ�鰳����', 'D00006');
insert into tb_dept_21 VALUES('D00014', '����Ŭ�����', 'D00007');
insert into tb_dept_21 VALUES('D00015', '���¼ҽ������', 'D00007');
commit;

SELECT * FROM tb_dept_21;

-- �Ʒ��� ���� ����� ���� �ƿ��� ������ ����?
-- D00001 ȸ���   null   null
-- D00002 �������� D00001 null
-- D00003 ������� D00001 null
SELECT
    b.dept_no "B �μ���ȣ"
    , b.dept_nm "B �μ��̸�"
    , b.upper_dept_no "B ��� �μ���ȣ"
    , a.upper_dept_no "A ��� �μ���ȣ"
FROM tb_dept_21 A
--JOIN tb_dept_21 B
--FULL OUTER JOIN tb_dept_21 B
LEFT OUTER JOIN tb_dept_21 B
--RIGHT OUTER JOIN tb_dept_21 B
ON b.upper_dept_no = a.dept_no
--where b.upper_dept_no is null
ORDER BY b.dept_no
;