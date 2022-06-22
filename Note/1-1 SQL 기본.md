# SQL 기본 문법
- 대소문자 구분하지 않으나 명령어는 대문자를 권고한다
- '문자열' 내에서는 대소문자 구분(아스키 코드가 다름)
- 데이터 유형은 반드시 지정해야 한다
- 주석 :  --
- 코드를 줄 단위로 삭제하기 위해서 세미콜론을 엔터치고 넣기

- ctrl + enter
+ 커서가 위치한 명령어 단위로 실행됨
+ 명령어는 세미콜론으로 닫는다
+ 전체 실행은 없음
+ 이미 실행된 명령어는 내용을 수정해도 되돌릴 수 없고 수정 명령어를 써야 한다

## 1. 작명 관례
- 단수형 권고(예시: 사원들의 데이터를 저장하는 테이블이라도 이름은 사원으로 한다)
- 테이블 이름은 중복을 허용하지 않는다
- 한 테이블 내에서 컬럼 이름은 중복을 허용하지 않는다
- 테이블 명과 칼럼 명은 반드시 문자로 시작(숫자로 시작 X)
- A-Z, a-z, 0-9, _, $, #

## 2. SQL문의 종류(종류별 명령어 외우기)
1. [DML](Data Manipulation Language, 데이터 조작어)
- [SELECT], [INSERT], [UPDATE], [DELETE]
- CRUD : 데이터를 생성(CREATE - INSERT), 조회(READ - SELECT), 수정(UPDATE), 삭제(DELETE)하는 명령어
2. [DDL](Data Definition Language, 데이터 정의어)
- [CREATE], [ALTER], [DROP], [RENAME], [TRUNCATE]
- 데이터 구조를 정의하는 명령어
- 데이터 구조를 생성(CREATE), 변경(ALTER), 삭제(DROP, TRUNCATE), 이름을 변경(RENAME)하는 명령어
3. [DCL](Data Control Language, 데이터 제어어)
- [GRANT], [REVOKE]
- 데이터 베이스에 접근하고 객체를 사용하도록 권한을 부여(GRANT), 회수(REVOKE)하는 명령어들
4. [TCL](Transaction Control Language, 트랜젝션 제어어)
- [COMMIT], [ROLLBACK]
- DML에 의해 조작된 결과를 트랜젝션 단위로 적용(COMMIT), 취소(ROLLBACK)하는 명령어

## 3. 주요 데이터 타입(유형)
- 선언 유형이 아닌 다른 종류의 데이터가 들어오면 에러 발생한다
- CHAR(L) : 고정 길이 문자열 / L보다 적게 입력하면 공백을 입력하여 길이를 강제로 맞춘다
- VARCHAR2(L) : 가변 길이 문자열 / 값이 L보다 작을 경우 해당 값만큼만 공간 차지 (L의 범위 : 1~4000byte)
- CLOB : 대용량의 텍스트 데이터를 저장하기 위한 데이터 타입 (최대 4GB)
- NUMBER(L, D): 정수와 실수를 저장하는 데이터 타입 / L은 D(소숫점 자리)를 포함한 전체 길이
- DATE: 날짜와 시각 정보 / 년월일시분초를 표현한다
### SQL 데이터 타입 > java 데이터 타입
- CHAR(L), VARCHAR2(L) > String
- NUMBER(L) > Int
- NUMBER(L, D) > Double
- DATE > LocalDate / LocalTime / LocalDateTime

## 5. 제약조건(CONSTRAINT)
- 데이터의 무결성을 유지하기 위한 방법으로
+ 특정 칼럼에 제약조건을 설정혀여
+ 사용자가 원하는 조건의 데이터만 생성할 수 있게 한다
### 제약조건의 종류
- [기본 키(Primary Key, P.K)]
+ 테이블에 저장된 행을 식별하기 위한 키
+ 하나의 테이블에 하나의 PK
+ 자동으로 UNIQUE, NOT NULL 제약이 걸린다
+ 테이블 생성할 때 필수 요소는 아님, 후에 조건에 맞는 칼럼을 PK로 수정 가능
- [외래 키(Foreign Key, F.K)]
+ 참조무결성 제약조건
+ 다른 테이블의 기본 키가 해당 테이블의 외래 키가 된다
- [고유 키(UNIQUE)]
+ 행 데이터의 중복을 허용하지 않는다
+ NULL 가능
+ UNIQUE 제약조건을 걸지 않으면 중복 허용
- [NOT NULL(N.N)]
+ 값이 필수적으로 들어가야 칼럼
+ 공백이나 0, 공집합은 NULL이 아니다.
+ NOT NULL 제약조건을 걸지 않으면 NULL값 가능
- [CHECK]
+ 입력할 수 있는 값의 종류, 범위를 제한한다
- [DEFAULT]
+ 칼럼의 값을 입력하지 않을 경우 NULL값 대신 자동으로 입력되는 값을 설정한다
