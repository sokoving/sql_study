# oracle sql
## 1. sql 실행 명령어 sqlplus
```
C:\Users\slinfo>sqlplus
SQL*PLUS: Release 11.2.0.2.0 Production on 월 6월 20일
```

## 2. 관리자 로그인 (아이디: sys /as sysdba  비번: 설치할 때 입력했던 비번(oracle))
```
Enter user-name: sys /as sysdba
Enter password: oracle

Connected to: 
Oracle Database 11g Express Edition Release 11.2.0.2.0 -64bit Production
```

## 3. 설치 확인
```
SQL> SELECT SYSDATE FROM dual;

SYSDATE
---------
22/06/20
```

## 4. 학습용 계정 언락 (아이디: hr  비번: hr)
```
SQL> ALTER USER hr ACCOUNT UNLOCK IDENTIFIED BY hr;
```

## 5. 직원 수 조회하기
```
SQL> SELECT COUNT(*) FROM employees;

     COUNT(*)
--------------
	107
```

## 6. 관리자 계정 로그인 후 내 계정 만들기(아이디: sqld, 비번: 1234)
```
SQL> conn sys /as sysdba;
Enter password:
Connected.
SQL> CREATE USER sqld IDENTIFIED BY 1234;

User created.
```

## 7. 만든 계정에 권한 주고 커밋
```
SQL> GRANT CONNECT, RESOURCE, DBA TO sqld;
Grant succeeded.
SQL> COMMIT;
Commit complete.
```
## 8. sql 종료
``` 
exit;
```

## 9. 학습용 데이터 입력
### 9-1 데이터 파일 저장한 위치로 이동한 후 sql 시작
```
C:'\Users\slinfo>E:
E:\>cd sl_dev\sql_study
E:\sl_dev\sql_study>sqlplus
```
### 9-2 sqld로 로그인
```
Enter user-name: sqld
Enter password: 1234

Connected to:
Oracle Database 11g Express Edition 
```
### 9-3 데이터 불러오기(@ + 파일 이름)
```
SQL> @sqld_datas.sql
```
### 9-4 데이터 조회하기
```
SQL> SELECT emp_nm, addr FROM tb_emp;
```

----------------------------------------------------------
# oracle sql developer
## 계정 추가
```
왼쪽 탭 접속 > 녹색 +
Name : [알아보기 편한 것]
사용자 이름 : cmd에서 만든 계정(sys as sysdba, hr, sqld)
비밀번호 : cmd에서 설정한 비번(oracle, hr, 1234)
```
## 환경설정
```
도구 > 환경설정 > 코드 편집기
글꼴 > 글꼴 크기
행 여백 > 행 번호 표시 체크
```