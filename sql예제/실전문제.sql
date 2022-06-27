-- 74번
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



-- 86번
drop table 회원기본정보_86;

CREATE TABLE 회원기본정보_86 (
    user_id VARCHAR2(200) PRIMARY KEY
);

CREATE TABLE 회원상세정보_86 (
    user_id VARCHAR2(200)
    
);

ALTER TABLE 회원상세정보_86
ADD CONSTRAINT fk_user_id 
FOREIGN KEY (user_id)
references 회원기본정보_86 (user_id);

INSERT INTO 회원기본정보_86 VALUES ('abc01');
INSERT INTO 회원기본정보_86 VALUES ('abc02');
INSERT INTO 회원기본정보_86 VALUES ('abc03');
COMMIT;


INSERT INTO 회원상세정보_86 VALUES ('abc01');
INSERT INTO 회원상세정보_86 VALUES ('abc02');
INSERT INTO 회원상세정보_86 VALUES ('abc03');
commit;

-- 보기 1
SELECT user_id FROM "회원기본정보_86"
EXCEPT
SELECT user_id FROM "회원상세정보_86"
;

-- 93번
DROP TABLE 일자별매출_93;

CREATE TABLE 일자별매출_93 (
    일자 DATE,
    매출액 NUMBER(5)
);

INSERT INTO 일자별매출_93 VALUES ('2015-11-01', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-02', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-03', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-04', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-05', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-06', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-07', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-08', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-09', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-10', 1000);
COMMIT;

SELECT * FROM 일자별매출_93;


--  1
SELECT A.일자, SUM(A.매출액) AS 누적매출액
FROM 일자별매출_93 A
GROUP BY A.일자
ORDER BY A.일자
;

-- 2
SELECT
    B.일자, SUM(B.매출액) AS 누적매출액
FROM 일자별매출_93 A
JOIN 일자별매출_93 B
ON (A.일자 >= B.일자)
GROUP BY B.일자
ORDER BY B.일자
;

-----------------------------------------------
-- 추가 문제

-- 문제 19
drop table tb_emp_19;
drop table tb_dept_19;

create table tb_dept_19(
   dept_no char(6)
   , deop_nm VARCHAR2(156) not null
   , CONSTRAINT tb_dept_19_pk PRIMARY KEY (dept_no)
);

INSERT into tb_dept_19 VALUES('D00001', 'Data시각화팀');
INSERT into tb_dept_19 VALUES('D00002', 'Data플랫폼팀');
INSERT into tb_dept_19 VALUES('D00003', 'Data분석팀');

commit;

CREATE table tb_emp_19(
    emp_no char(6)
    , emp_nm varchar2(50) not null
    , dept_no char(6)
    , CONSTRAINT tb_emp_19_pk PRIMARY key (dept_no)
);

insert into tb_emp_19 VALUES ('E00001', '이경오', 'D00001');
insert into tb_emp_19 VALUES ('E00002', '이수지', 'D00001');
insert into tb_emp_19 VALUES ('E00003', '김효선', 'D00002');
insert into tb_emp_19 VALUES ('E00004', '박상진', 'D00003');
commit;

SELECT * FROM tb_dept_19;
SELECT * FROM tb_emp_19;


-- 아래와 같은 테이블 및 데이터 구성에서 SQL문의 결과집합 예상해 보기
SELECT DISTINCT  a.dept_no
from tb_emp_19 A
where a.dept_no = 'D00002'
UNION ALL
SELECT A.dept_no
from tb_emp_19 A
where a.dept_no = 'D00001'
ORDER BY dept_no
;

-- 문제 21
drop table tb_dept_21;

create table tb_dept_21(
    dept_no char(6)
    , dept_nm varchar(150) not null
    , upper_dept_no char(6) null
    , CONSTRAINT tb_dept_21_pk PRIMARY KEY (dept_no)
);

insert into tb_dept_21 VALUES('D00001', '회장실', null);
insert into tb_dept_21 VALUES('D00002', '영업본부', 'D00001');
insert into tb_dept_21 VALUES('D00003', '기술본부', 'D00001');
insert into tb_dept_21 VALUES('D00004', '국내영업부', 'D00002');
insert into tb_dept_21 VALUES('D00005', '해외영업부', 'D00002');
insert into tb_dept_21 VALUES('D00006', '개발사업부', 'D00003');
insert into tb_dept_21 VALUES('D00007', '데이터사업부', 'D00003');
insert into tb_dept_21 VALUES('D00008', '기업영업팀', 'D00004');
insert into tb_dept_21 VALUES('D00009', '공공영업팀', 'D00004');
insert into tb_dept_21 VALUES('D00010', '북미영업팀', 'D00005');
insert into tb_dept_21 VALUES('D00011', '남미영업팀', 'D00005');
insert into tb_dept_21 VALUES('D00012', '서버개발팀', 'D00006');
insert into tb_dept_21 VALUES('D00013', '화면개발팀', 'D00006');
insert into tb_dept_21 VALUES('D00014', '오라클기술팀', 'D00007');
insert into tb_dept_21 VALUES('D00015', '오픈소스기술팀', 'D00007');
commit;

SELECT * FROM tb_dept_21;

-- 아래와 같은 결과를 내는 아우터 조인은 뭘까?
-- D00001 회장실   null   null
-- D00002 영업본부 D00001 null
-- D00003 기술본부 D00001 null
SELECT
    b.dept_no "B 부서번호"
    , b.dept_nm "B 부서이름"
    , b.upper_dept_no "B 상급 부서번호"
    , a.upper_dept_no "A 상급 부서번호"
FROM tb_dept_21 A
--JOIN tb_dept_21 B
--FULL OUTER JOIN tb_dept_21 B
LEFT OUTER JOIN tb_dept_21 B
--RIGHT OUTER JOIN tb_dept_21 B
ON b.upper_dept_no = a.dept_no
--where b.upper_dept_no is null
ORDER BY b.dept_no
;