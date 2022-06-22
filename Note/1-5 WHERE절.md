# WHERE 조건문
- 행을 대상으로 조회 결과를 제한하는 조건절
- FROM 다음에 위치
``` SELECT 조회할 칼럼들 FROM 조회할 테이블명 WHERE 조건식
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp          -- 여기까지만 쓰면 해당하는 모든 행 출력
WHERE sex_cd = 2;    -- 성별코드 2인 행만 출력
```
## 연산자의 종류
1. 비교 연산자 : =, >, >=, <, <=
2. 부정 비교 연산자(NOT EQUAL)
  - !=, <>, ^= : 같지 않다 (<> 많이 씀)
  - NOT 칼럼명= : ~와 같지 않다
  - NOT 칼럼명> : ~보다 크지 않다
3. SQL 연산자
 - BETWEEN a AND b : a와 b 사이에 있는 값이면 된다 (AND와 비슷)
 - IN(list) : 리스트에 있는 값 중 하나라도 있으면 된다 (OR와 비슷)
 - LIKE '와일드 카드를 사용한 비교문자열' : 비교문자열 형태와 일치하면 된다
   + 와일드 카드 : %(0개 이상의 불특정 문자를 의미), _(불특정 단일문자 1개를 의미)
 - IS NULL / IN NOT NULL : 값이 null이면 된다 / 값이 null이 아니면 된다
  + null값은 =로 비교할 수 없음
3. 논리 연산자
 - a AND b : a, b 모두 참이어야 한다
 - a OR b : a, b 중 하나라도 참이면 된다
 - NOT a : a(조건)가 거짓이면 된다 

## 연산자의 우선순위
() 괄호  > NOT 연산자 > 비교연산자, SQL 비교 연산자 > AND > OR

## 1. 비교연산자
### 동등 조건 : = 
PK로 WHERE절 동등조건을 만들면 반드시 단일행이 조회된다
```
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE emp_no = 1000000001
    AND emp_no > '00001';    --VARCHAR2가 NUMBER로 자동 형변환;
```

## 2. SQL 연산자
### BETWEEN, LIKE, IN, NOT IN
```
SELECT
    emp_no, emp_nm, birth_de, dept_cd, addr
FROM tb_emp
WHERE 1=1   -- WHERE 바로 뒤에 무조건 참인 식 1=1을 쓰고 
    AND birth_de BETWEEN '19900101' AND '19991231' -- 연산자와 세미콜론을 개행해서 쓰면 편집이 편하다
    AND dept_cd IN ('100004', '100006')
    AND addr LIKE '%수원시%;
    AND emp_nm LIKE '김__'
    AND manager_emp_no IS NULL
;
```

### 부정 비교 연산자(NOT EQUAL)
```
SELECT
   emp_no, emp_nm, pay_amp, sex_cd
FROM tb_emp         
WHERE sex_cd <> 2    
    AND emp_no ^= 100000001
    AND emp_nm NOT LIKE '김%'
    AND NOT pay_amp >= 5500000   -- 급여가 5500000보다 크거나 같지 ㅇ낳다
;
```

### null값 조회(시험 별표)
- null은 비교연산자 =가 아닌 IS NULL, IS NOT NULL로 확인한다
```
SELECT
emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp         
WHERE direct_manager_emp_no IS NULL
WHERE direct_manager_emp_no IS NOT NULL
;
```

### 연산자 우선순위 : NOT > AND > OR
```
-- 사원정보 중에 김씨면서 수원 또는 일산에 사는 사원들의 정보 조회
SELECT
emp_no, emp_nm, addr
FROM tb_emp         
WHERE 1=1                       -- 괄호로 묶지 않으면 AND 연산을 먼저 하기 때문에
AND emp_nm LIKE '김%'            -- (김씨 AND %수원%) OR (%일산%) 이렇게 됨
AND (addr LIKE '%수원%' OR addr LIKE '%일산%')
;
```