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
2. PROJECT 연산 (SELECT 칼럼)
3. JOIN 연산 (JOIN)
- WHERE - INNER JOIN
- FROM - NATURAL JOIN, INNER JOIN, OUTER JOIN, USING 조건절, ON 조건절
4. DIVIDE 연산 (사용 X)
- 왼쪽 집합을 'XZ'로 나누었을 때 XZ를 모두 가지고 있는 'A'가 답이 되는 기능

## 조인의 형태
1. INNER JOIN
- 컬럼 간 동일한 컬럼을 매칭하여 동일한 값이 있는 행만 리턴한다
2. EQUI JOIN
- 둘 이상의 테이블에 존재하는 공통 속성을 동등 연산자(=)를 사용해 매칭하는 조인 방법
3. NATURAL JOIN
- 두 테이블 간 동일한 이름을 갖는 모든 컬럼들에 대해 EQUI JOIN 수행
- 조건 선택 불가
4. USING 조건절
- FROM 절에서 USING 조건절을 이욯하여 (NATURAL JOIN과 다르게)
- 동명의 컬럼 중 선택적으로 EQUI JOIN 할 수 있다
5. ON 조건절
- JOIN 서술부와(ON 조건절) 비 JOIN 서술부(WHERE 조건절)을 분리하여
- 가독성을 높이고 이름이 다른 컬럼들도 JOIN 조건을 사용할 수 있게 한다
6. CROSS JOIN
- 테이블 간 JOIN 조건이 없는 경우 생길 수 있는 모든 데이터의 조합
- 일반집합 연산자의 PRODUCT 개념
7. OUTER JOIN

8. EQUI JOIN