# DDL (Data Definition Language, 데이터 정의어)
- [CREATE], [ALTER], [DROP], [RENAME], [TRUNCATE]
- 데이터 구조를 정의하는 명령어
- 데이터 구조를 생성(CREATE), 변경(ALTER), 삭제(DROP, TRUNCATE), 이름을 변경(RENAME)한다
------------------------------------------------------------------
## 1. CREATE TABLE: 테이블을 생성
``` CREATE TABLE 테이블명 (컬럼명 제약조건 나열);
CREATE TABLE board (                          -- board 테이블 생성
    bno NUMBER(10)                            -- 글번호 : 10btye 고정
    , title VARCHAR2(200) NOT NULL            -- 글제목 : 200byte까지, 필수 작성
    , writer VARCHAR2(40) NOT NULL            -- 작성자 : 필수 작성, 중복 허용(허용 안 하면 한 사람이 여러 글 못 씀)
    , content CLOB                            -- 글 내용 : VARCHAR2는 최대 4000byte까지, 더 긴 글을 쓰려면 CLOB 타입으로
    , reg_date DATE DEFAULT SYSDATE           -- 작성 일자 : 시스템 날짜 자동 기입
    , view_count NUMBER(10) DEFAULT 0         -- 조회수 : 0 자동 기입
);
```
### 연관관계 설정
- 게시물 댓글의 관계 = 1 : M
- 게시물 하나당 댓글 여러 개
```
CREATE TABLE reply (                           -- reply 테이블 생성
rno NUMBER(10)
, r_content VARCHAR2(400)
, r_writer VARCHAR2(40) NOT NULL
, bno NUMBER(10)                               -- 자식 테이블은 부모 테이블의 pk를 가지고 있어야 한다
, CONSTRAINT pk_reply_rno PRIMARY KEY (rno)    -- PK 설정
);
```

### 인덱스 생성 문법
CREATE INDEX 인덱스명 ON 테이블명  (지정할 칼럼명)

### 테이블 생성 시 DELETE 옵션
1. CASCADE : 부모 삭제 시 자식 행 같이 삭제
2. SET NULL : 부모 삭제시 자식의 값 null로 변경
3. SET DEFAULT : 부모 삭제시 자식의 값 default값으로 변경
4. RESTRICT : 자식의 PK가 없을 때만 부모 삭제를 허용
5. NO ACTION: 참조 무결성을 위반하는 삭제/수정 허용 X

### 테이블 생성 시 INSERT 옵션
1. SET NULL : 부모 삽입시 자식의 값 null로 삽입
2. SET DEFAULT : 부모 삽입시 자식의 값 default값으로 삽입
3. AUTOMATIC : 부모의 PK가 없을 시 부모의 PK를 생성한 후 자식 삽입
4. DEPENDENT : 부모의 PK가 없는 경우 자식의 삽입을 허용하지 않음

------------------------------------------------------------------

## 2. ALTER TABLE : 데이터베이스의 구조를 변경
### PK 설정
- PK 자체에 NOT NULL UNIQUE가 자동으로 걸림
``` ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명(임의) PRIMARY KEY (컬럼명);
ALTER TABLE board
ADD CONSTRAINT pk_board_bno
PRIMARY KEY (bno);
```
### FK 설정
- 테이블 간의 관계 제약 설정
``` ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명(임의) FOREIGN KEY (컬럼명) REFERENCES 테이블명 (컬럼명);
ALTER TABLE reply
ADD CONSTRAINT fk_reply_bno
FOREIGN KEY (bno)
REFERENCES board (bno);
```
### 컬럼 변경 - 추가
``` ALTER TABLE 테이블명 ADD (컬럼명 타입 제약조건);
ALTER TABLE reply
ADD (r_reg_date DATE DEFAULT SYSDATE);
```
### 컬럼 변경 - 제거
```ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE board
DROP COLUMN view_count;
```
### 컬럼 변경 - 수정
```ALTER TABLE 테이블명 MODIFY (컬럼명 타입);
ALTER TABLE board
MODIFY (title VARCHAR2(500));
```
### ALTER 명령어 주의: DROP만 COLUMN을 붙인다
- ALTER TABLE reply  ADD (r_reg_date DATE DEFAULT SYSDATE);
- ALTER TABLE board DROP COLUMN view_count;
- ALTER TABLE board MODIFY (title VARCHAR2(500));

------------------------------------------------------------------

## 3. DROP TABLE: 테이블 구조 삭제
- 정보가 있을 경우 모두 날아감, 별도의 조치가 없다면 롤백 불가
- board를 삭제할 때 연동된 reply를 어떻게 할 건지 설정을 안 하면 충돌남
```
DROP TABLE reply;
```

------------------------------------------------------------------
## 4. TRUNCATE TABLE: 테이블 내부 전체 삭제
- 휴지통 비우기랑 비슷, 롤백 불가
```
TRUNCATE TABLE reply;
```
-----------------------------------------------------------------
## PK, FK 설정
```
CREATE TABLE pkBoard(
     pkCol1 CHAR(8) PRIMARY KEY ①
    , pkCol2 CHAR(8)
    , pkCol3 number CONSTRAINT pk_pk3 PRIMARY KEY ②
    , pkCol4 char(8)
    , fkCol5 char(8)
    , CONSTRAINT pk_pk2 PRIMARY KEY(pkCol2) ③
);

ALTER TABLE pkBoard
ADD CONSTRINT pk_pk4 PRIMARY KEY (pkCol4); ④

ALTER TABLE fkTest 
ADD CONSTRAINT fk_test
FOREIGN KEY (fk_Col)
REFERENCES pkBoard (fkCol5)
```
1. 컬럼명 타입 PRIMARY KEY
2. 컬럼명 타입 CONSTRAINT 제약조건명 PRIMARY KEY
3. *CONSTRAINT 제약조건명 PRIMARY KEY(컬럼1, 컬럼2...)*
4. ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 PRIMARY KEY (컬럼명);

