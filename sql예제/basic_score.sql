
-- Repository layer : 실제 데이터가 저장되는 공간
--  모델 객체, 도메인 객체, 엔터티 객체
CREATE TABLE score (
    stu_num NUMBER(10), --학생 일련번호
    stu_name VARCHAR2(20) NOT NULL, -- 학생 이름
    kor NUMBER(3) NOT NULL, -- 국어 점수
    eng NUMBER(3) NOT NULL, -- 영어 점수
    math NUMBER(3) NOT NULL, -- 수학 점수
    total NUMBER(3), -- 시험 점수 총합
    average NUMBER(5,2), -- 시험 점수 평균
    CONSTRAINT pk_score PRIMARY KEY (stu_num)
);

-- 연속된 숫자 생성
CREATE SEQUENCE seq_score;
  -- 중복 없는 일련번호 만들기
  -- sequence 테이블이 만들어지고 seq_score.nextval을 하면 순서대로 꺼내줌
  -- 게시글 번호 같은 거 만들 때 씀

SELECT * FROM score;

commit;




INSERT INTO score VALUES (seq_score.nextval,  '홍길동', 90, 90, 90, 270, 90);
INSERT INTO score VALUES (seq_score.nextval,  '김철수', 80, 80, 80, 240, 80);
INSERT INTO score VALUES (seq_score.nextval,  '박영희', 100, 100, 100, 300, 100);
COMMIT;


SELECT AVG(AVERAGE) AS avg_class
from score;



----trainee record table
CREATE TABLE trainee (
    tr_num NUMBER(10), --학생 아이디
    tr_name VARCHAR2(20) NOT NULL, -- 학생 이름
    tr_sex char(1) NOT NULL, -- 학생 성별
    run100 NUMBER(3, 1) NOT NULL, -- 100m 달리기 기록
    run1000 NUMBER(3) NOT NULL, -- 1000m 달리기 기록
    situp NUMBER(2) NOT NULL, -- 윗몸일으키기 기록
    pushUp NUMBER(2) NOT NULL, -- 팔굽혀펴기 기록
    rightGrip NUMBER(2) NOT NULL, -- 오른손 악력 기록
    leftGrip NUMBER(2) NOT NULL, -- 왼손 악력 기록

    CONSTRAINT pk_trainee PRIMARY KEY (tr_num)
);

CREATE SEQUENCE seq_trainee;

INSERT INTO trainee VALUES (seq_trainee.nextval, '최승철', 'M', 15, 250, 50, 50, 50, 50);
INSERT INTO trainee VALUES (seq_trainee.nextval, '이우지', 'M', 13.5, 235, 45, 44, 56, 55);
INSERT INTO trainee VALUES (seq_trainee.nextval, '김태연', 'F', 16, 260, 40, 39, 44, 50);
INSERT INTO trainee (tr_num, tr_name, tr_sex, run100, run1000, situp, pushup, rightgrip, leftgrip) VALUES (seq_trainee.nextval, '전소연', 'F', 15.5, 255, 48, 49, 56, 57);
commit;

SELECT
    * FROM trainee;
    
UPDATE trainee SET run100 = 16.5, run1000 = 287, situp = 61, pushup = 61, rightgrip = 59, leftgrip = 55 WHERE tr_num = 5
;
commit;

DELETE FROM trainee WHERE tr_num=7;