-- DDL: 데이터 정의어
    -- CREATE, ALTER, DROP, RENAME, TRUNCATE

-- CREATE TABLE: 테이블을 생성
CREATE TABLE board (
    bno NUMBER(10)  -- 글번호 10자리 숫자
    , title VARCHAR2(200) NOT NULL -- 글제목 : 200byte까지, 필수 작성
    , writer VARCHAR2(40) NOT NULL -- 작성자 : 필수 작성, 중복 허용(허용 안 하면 한 사람이 여러 글 못 씀)
    , content CLOB  -- 글 내용 : VARCHAR2는 최대 4000byte까지, 더 긴 글을 쓰려면 CLOB 타입으로
    , reg_date DATE DEFAULT SYSDATE -- 작성 일자 : 시스템 날짜 자동 기입
    , view_count NUMBER(10) DEFAULT 0 -- 조회수 : 0 자동 기입
);

-- SELECT : 테이블 조회
SELECT * FROM board;


-- ALTER : 데이터베이스의 구조를 변경(통째로 외우기)
    -- PK  설정(PK 자체에 NOT NULL UNIQUE가 자동으로 걸림)
ALTER TABLE board
ADD CONSTRAINT pk_board_bno
PRIMARY KEY (bno);


-- 데이터 추가
INSERT INTO board
    (bno, title, writer, content)
VALUES 
    (1, '안뇽?', '꾸꾸까까', '아하하아하하 ㅋㅋㅋ');
    
INSERT INTO board
    (bno, title, writer)
VALUES 
    (2, '맛있는 점심', '하하호호');

COMMIT;

SELECT * FROM board;


-- 연관관계 설정
    -- 게시물 댓글의 관계 = 1 : M
    -- 게시물 하나당 댓글 여러 개

    -- 댓글 테이블 생성
CREATE TABLE reply (
    rno NUMBER(10)
    , r_content VARCHAR2(400)
    , r_writer VARCHAR2(40) NOT NULL
    , bno NUMBER(10) -- 자식 테이블은 부모 테이블의 pk를 가지고 있어야 한다
    , CONSTRAINT pk_reply_rno PRIMARY KEY (rno) -- PK 설정
);

    -- 외래키(FOREIGN KEY) 설정 : 테이블 간의 관계 제약 설정
ALTER TABLE reply
ADD CONSTRAINT fk_reply_bno
FOREIGN KEY (bno)
REFERENCES board (bno);

SELECT * FROM reply;

-- 컬럼 변경
    -- 컬럼 추가
ALTER TABLE reply
ADD (r_reg_date DATE DEFAULT SYSDATE);

    -- 컬럼 제거
ALTER TABLE board
DROP COLUMN view_count;

    -- 컬럼 수정
ALTER TABLE board
MODIFY (title VARCHAR2(500));

-- 테이블 삭제
DROP TABLE reply;
    -- 테이블 구조 삭제(롤백 불가)
    -- 정보가 있을 경우 모두 날아감, 별도의 조치가 없다면 복구 불가
TRUNCATE TABLE reply;
    -- 테이블 내부 전체 삭제(휴지통 비우기랑 비슷, 롤백 불가)
    -- board를 삭제할 때 연동된 reply를 어떻게 할 건지 설정을 안 하면 충돌남
    

