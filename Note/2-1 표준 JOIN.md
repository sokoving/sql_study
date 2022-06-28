# 표준 조인
## 일반집합 연산자 (SQL 문)
1. UNION 연산 (UNION)
 - 교집합 중복을 제거한 합집합이며 자동 정렬 > 시스템 부하 ↑
 - UNION ALL : 중복 허용, 정렬 x > 시스템 부하 ↓
 - UNION과 UNION ALL의 출력 결과가 같다면 UNION ALL 권고
2. INTERSECTION 연산 (INTERSECT)
 - 교집합, 두 집합의 공통 집합만 추출
3. DIFFERENCE 연산 (Oracle - MINUS / MS - EXCEPT)
 - 차집합, 합집합에서 교집합을 제외한다
4. PRODUCT 연산 (CROSS JOIN)
 - 곱집합, JOIN 조건이 없을 경우 생길 수 있는 모든 데이터의 조합
 - 양쪽 집합의 개수를 곱한 만큼의 데이터 조합 발생(M*N건)
 - CROSS PRODUCT(ANIS/ISO 표준), CARTESIAN PRODUCT(카테시안 곱)

## 순수관계연산자 (SQL 문)
1. SELECT 연산 (WHERE)
2. PROJECT 연산 (SELECT절 칼럼 선택)
3. JOIN 연산 (JOIN)
- WHERE - INNER JOIN
- FROM - NATURAL JOIN, INNER JOIN, OUTER JOIN, USING 조건절, ON 조건절
4. DIVIDE 연산 (사용 X)
- 왼쪽 집합을 'XZ'로 나누었을 때 XZ를 모두 가지고 있는 'A'가 답이 되는 기능

## 조인의 종류
1. 오라클 조인
   + FROM 테이블명 A, 테이블명 B, 테이블명 C
   + WHERE A.컬럼 = B.컬럼 AND B.컬럼 = C.컬럼
   + AND 조건문
> WHERE에 조인 서술부와 조건절과 비조인 서술부룰 병기
> 조인하는 테이블 N개면 조인 조건 N-1개
2. ANSI 조인(표준 조인법)
   + FROM 데이블명 a JOIN 테이블명 b
   + ON (A.컬럼 = B.컬럼) JOIN 테이블명 c
   + ON (B.컬럼 = C.컬럼)
> 조인 서술부 ON 조건절과 비조인 서술부 WHERE 조건절을 분리
> INNER JOIN은 INNER 생략

3. EQUI JOIN
- 둘 이상의 테이블에 존재하는 공통 속성을 동등 연산자(=)를 사용해 매칭하는 조인 방법
4. INNER JOIN
- 테이블 간 동일한 컬럼을 매칭하여 동일한 값이 있는 행만 리턴한다
5. OUTER JOIN
- JOIN 조건에서 동일한 값이 없는 행도 리턴한다
 + EQUI 조인에 실패한 행도 출력됨
6. NATURAL JOIN
- 두 테이블 간 동일한 이름, 타입을 갖는 공통 컬럼들에 대해 EQUI JOIN 수행
- 조건 선택 불가
- 조인 컬럼은 별칭(alias) 사용 안 됨
7. CROSS JOIN
- 테이블 간 JOIN 조건이 없는 경우 생길 수 있는 모든 데이터의 조합
- 일반집합 연산자의 PRODUCT 개념

## OUTER JOIN의 종류
1. LEFT OUTER JOIN
- ORACLE 방법
    + FROM 테이블명 A, 테이블명 B
    + WHERE A.컬럼 = B.컬럼(+)
- ANSI 방법
  + FROM 테이블명 A LEFT OUTER JOIN 테이블명 B
  + ON (A.컬럼 = B.컬럼)
  + WHERE 조건문
> A테이블(LEFT)는 다 나오고 B테이블은 매칭되는 것만 나옴
> 매칭되지 않은 행의 B 컬럽은 NULL
2. RIGHT OUTER JOIN
- ORACLE 방법
    + FROM 테이블명 A, 테이블명 B
    + WHERE A.컬럼(+) = B.컬럼
- ANSI 방법
  + FROM 테이블명 A RIGHT OUTER JOIN 테이블명 B
  + ON (A.컬럼 = B.컬럼)
  + WHERE 조건문
> B 테이블은 모두 나오고 A 테이블은 조건이 매칭되는 행만 출력됨
> 매칭되지 않은 B의 컬럼은 NULL
3. FULL OUTER JOIN
 + FROM 테이블 A FULL OUTER JOIN 테이블 B ON (A.컬럼 = B.컬럼)
 + WHERE 조건문
> 매칭되는 행, 양쪽 행 중 매칭되지 않는 행도 다 출력
> 매칭되지 않는 행의 컬럼은 NULL


## JOIN의 조건절
1. USING 조건절
   + FROM 테이블명 JOIN 테이블명 USIG (공통컬럼명)
- 조인 조건을 설정할 수 없는 NATURAL JOIN과 달리
- 조건으로 쓸 공통 컬럼을 열거하는 방법으로 EQUI JOIN 할 수 있다
- USING으로 조인한 컬럼은 별칭 사용 안 됨
2. ON 조건절
   + FROM 테이블명 JOIN 테이블명 ON (조건문)
- JOIN 서술부와(ON 조건절) 비 JOIN 서술부(WHERE 조건절)을 분리하여
- 가독성을 높이고 이름이 다른 컬럼들도 JOIN 조건을 사용할 수 있게 한다
3. WHERE 조건졀
- 오라클 조인의 경우 조인 조건을 ON으로 빼지 않고 WHERE에 같이 쓴다

## JOIN의 결과 행수
- INNER JOIN : 두 테이블의 교집합만큼
- CROSS JOIN : 투 테이블의 행을 서로 곱한 만큼
- LEFT OUTER JOIN : 왼쪽 테이블의 행 수 만큼
- RIGHT OUTER JOIN : 오른쪽 테이블의 행 수 만큼
- FULL OUTER JOIN : 왼쪽 테이블 + 오른쪽 테이블 - 교집합
- 