# DML (Data Manipulation Language, 데이터 조작어)
- [SELECT], [INSERT], [UPDATE], [DELETE]
- CRUD : 데이터를 생성(CREATE - INSERT), 조회(READ - SELECT), 수정(UPDATE), 삭제(DELETE)한다

- SELECT
 + 데이터에 변동이 없다
 + 명령의 결과가 다양하게 출력된다
- INSERT, UPDATE, DELETE
 + 데이터를 갱신하는 명령어 > 이상(ANOMALY)이 생길 가능성이 높음
 + 명령의 결과는 yes or no
------------------------------------------------------------------
## 1. INSERT : 삽입
``` 
INSERT INTO board                          ┌ 데이터를 삽입할 컬럼 이름
   (bno, title, content, writer, reg_date) └ 순서 상관 없음
VALUES
(2, '제목', '내용쓰', '작성쓰', SYSDATE);  --위 괄호와 동일한 순서
```
### NOT NULL 제약조건 위반 
``` 
INSERT INTO board
(bno, content, writer)
VALUES
(3, '랄랄라~~~', '둘리');
```
### PK의 UNIQUE 제약조건 위반 > 삽입 실패
```
INSERT INTO board
(bno, title, content, writer, reg_date)
VALUES
(1, '제목이야~', '랄랄라~~~', '둘리', SYSDATE + 1);
```
### reg_date의 DEFAULT 옵션 > 안 써도 이어도 자동 기입 > 삽입 성공
```
INSERT INTO board
(bno, title, writer)
VALUES
(3, '하하하호호호~', '둘리');
```
###  INSERT 시 컬럼명 생략 가능
하지만 모든 데이터를 순서대로 채워야 하며 권장하지 않는다
```
INSERT INTO board
VALUES
(4, '컬럼 생략', '가능', '근데 모든 컬럼을 순서대로 채워야 함, 추천 안 함', SYSDATE+1);
```

------------------------------------------------------------------

## 2. UPDATE : 수정
- 커밋 안 하면 롤백할 수 있다(커밋하면 복구 불가)

### WHERE
- 보통 PK를 쓴다.
  + 여러 값이 나오는 키의 경우 해당 키를 가진 모든 행이 수정됨
- WHERE절 생략하면 전체 행 일괄 수정
```
UPDATE board
SET title = '수정된 제목이야~'
WHERE bno = 1;

UPDATE board
set writer = '나쁜놈';      
```
### SET
- 여러 컬럼을 콤마로 구분하여 나열할 수 있다
```
UPDATE board
SET writer = '수정맨'         
, content = '수정수정수정수정'
WHERE bno = 2;
```

------------------------------------------------------------------

## 3. DELETE : 데이터 삭제
- SELECT * FROM과 달리 DELETE FROM 사이에 아무것도 안 들어감
 ```
DELETE FROM board 
WHERE bno=1;
```

### 전체 데이터 삭제
1. WHERE절을 생략한 DELETE절
- 롤백 가능, 수동 커밋 가능, 로그 남기기 가능
```
DELETE FROM board;
```

2. TRUNCATE TABLE
- 롤백 불가능, 자동 커밋, 로그를 남길 수 없음
- 테이블 생성 초기 상태로 복귀
> 주의: 데이터가 있다면 모두 없어지고 롤백할 수 없다
```
TRUNCATE TABLE board;
```

3. DROP TABLE
- 롤백 불가능, 자동 커밋, 로그를 남길 수 없음
- 테이블 생성 초기 상태로 복귀, 구조(컬럼 포함)까지 완전 삭제
```
DROP TABLE board;
```
------------------------------------------------------------------

## 4. SELECT : 조회
### 기본
```
SELECT
emp_no, emp_nm     -- 컬럼 이름
FROM tb_emp;       -- 테이블 이름

SELECT
certi_nm, certi_cd -- 테이블 컬럼 순서와 상관없다
FROM tb_certi;

SELECT
*                  -- 테이블의 모든 컬럼 조회
FROM tb_dept;
```
### SELECT DISTINCT
- SELECT ALL : 기본값 > 중복 포함 20행 출력
- SELECT DISTINCT : 중복값을 제외하고 조회 > 6행 출력
```
- SELECT DISTINCT
issue_insti_nm  
FROM tb_certi;

SELECT DISTINCT
certi_cd, issue_insti_nm   -- 주의사항: 컬럼이 복수 이상이면 열 단위로 중복 체크
FROM tb_certi;
```

### 열 별칭(column alias) 지정
```
SELECT
certi_cd AS "자격증 코드"  -- "띄어쓰기가 있을 경우 쌍따옴표"
, certi_nm AS 자격증명      -- 띄어쓰기 없을 경우 쌍따옴표 생략 가능
, issue_insti_nm 발급기관명 -- AS 항상 생략 가능
FROM tb_certi;
```

### 문자열 결합 연산자 ||
- ex) SQLD(100001) - 한국데이터베이스진흥원
```
- SELECT
certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm AS "자격증 정보"
FROM tb_certi;
```

### dual
- 오라클에서 제공하는 더미 테이블 
- 단순 연산 결과를 조회할 때 사용한다
```
SELECT
3 * 6 AS "연산 결과"
FROM dual;

SELECT
SYSDATE AS "현재 날짜"
FROM dual;
    
```
