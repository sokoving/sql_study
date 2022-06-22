# TCL (Transaction Control Language, 트랜젝션 제어어)
- ACID : [원자성 Atomicity], [일관성 Consistency], [고립성 Isolation], [지속성 Durability]
- [COMMIT], [ROLLBACK]
- DML에 의해 조작된 결과를 트랜젝션 단위로 적용(COMMIT), 취소(ROLLBACK)하는 명령어

------------------------------------------------------------------

## 1. 트랜젝션의 특성
- 데이터베이스의 논리적 연산단위
- 하나의 트랜잭션에는 하나 이상의 SQL 문장이 포함된다

### ACID
- *원자성 Atomicity*
 + 트랜잭션은 분할할 수 없는 최소단위이기 때문에
 + 전부 적용할 수 없다면 전부 취소한다 (All or Nothing)
- *일관성 Consistency*
 + 트랜잭션 실행되기 전에 데이터베이스의 내용에 오류가 없다면
 + 실행된 이후의 데이터베이스의 내용에도 오류가 없어야 한다
- *고립성 Isolation*
 + 트랜잭션이 실행되는 중에 다른 트랜잭션의 영향을 받아
 + 잘못된 결과가 도출되서는 안 된다
- *지속성 Durability*
 + 트랜잭션이 성공적으로 수행되면
 + 그 트랜잭션이 갱신한 데이터베이스의 내용은 영구적으로 저장된다

------------------------------------------------------------------

## 2. COMMIT : 트랜잭션 완료
- 입력, 수정, 삭제한 자료에 대해서 문제가 없다고 판단할 경우
- COMMIT 명령어를 통해 트랜잭션을 완료한다
```
COMMIT;
```

### COMMIT 이전
- 데이터 변경 이전 상태
- 복구(ROLLBACK)가 가능하다
- 현재 사용자는 SELECT문으로 결과 확인 가능
 + 다른 사용자는 확인 못 함
- 변경된 행은 잠금(LOKING)이 설정되면서
 + 다른 사용자가 데이터를 변경할 수 없다

### COMMIT 이후
- 데이터 변경 사항이 데이터베이스에 반영
- 이전 데이터는 영원히 잃어버리게 된다
- 모든 사용자가 결과 확인 가능
- 관련 행에 대한 잠금(LOKING)이 풀리고
 + 다른 사용자가 데이터를 변경할 수 있게 된다

------------------------------------------------------------------

## 3. ROLLBACK : 변경 사항 취소
- 입력, 삭제, 수정 등 변경한 데이터를 최신 커밋 상태로 되돌려놓는 것
- 커밋한 데이터는 롤백할 수 없다
 ```
ROLLBACK;
```

## 롤백 이후
- 데이터의 변경 사항이 취소
- 데이터가 이전 상태로 복구
- 관련ㄷ 행에 대한 잠금이 풀리고
 + 다른 사용자가 데이터를 변경할 수 있게 된다

------------------------------------------------------------------

## SAVE POINT : 저장점 정의
- 롤백할 때 원

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

2. TRUMCATE TABLE
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
