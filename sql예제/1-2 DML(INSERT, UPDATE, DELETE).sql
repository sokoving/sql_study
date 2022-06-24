-- SELECT, INSERT, UPDATE, DELETE
-- SELECT(Read)
    -- 조회
    -- 요청한 여러 데이터를 보여준다
-- INSERT(Create), UPDATE, DELETE
    -- 갱신
    -- 이상이 생길 가능성이 높음
    -- yes or no


-- INSERT : 삽입
INSERT INTO board  -- 데이터를 삽입할 컬럼 이름 명시
    (bno, title, content, writer, reg_date) -- 이름 순서 상관 없음
VALUES
    (2, '제목이야~', '랄랄라~~~', '둘리', SYSDATE + 1); --위 괄호와 동일한 순서

COMMIT;

SELECT * FROM board;

    -- NOT NULL 제약조건 위반 > 삽입 실패
INSERT INTO board
    (bno, content, writer)
VALUES
    (3, '랄랄라~~~', '둘리');
    
    -- PK의 UNIQUE 제약조건 위반 > 삽입 실패
INSERT INTO board
    (bno, title, content, writer, reg_date)
VALUES
    (1, '제목이야~', '랄랄라~~~', '둘리', SYSDATE + 1);
 
    -- reg_date가 NOT NULL 이어도 자동 기입 > 삽입 성공
INSERT INTO board
    (bno, title, writer)
VALUES
    (3, '하하하호호호~', '둘리');

    -- column 생략 가능
    -- 하지만 모든 데이터를 순서대로 채워야 하며 권장하지 않는 방법이다
INSERT INTO board
VALUES
    (4, '컬럼 생략', '가능', '근데 모든 컬럼을 순서대로 채워야 함, 추천 안 함', SYSDATE+1); 
    
COMMIT;        
    
-- UPDATE : 수정
UPDATE board
 SET title = '수정된 제목이야~'
 WHERE bno = 1;  -- WHERE에는 보통 PK를 쓴다. 여러 값이 나오는 키의 경우 전부 수정됨
 
UPDATE board
 SET writer = '수정맨'         -- set에는 여러 컬럼을 콤마로 구분하여 나열할 수 있다
 , content = '수정수정수정수정'
 WHERE bno = 2;
    
    -- WHERE절 생략하면 전체 행 일괄 수정
UPDATE board
 set writer = '나쁜놈';
 
    -- 커밋 안 하면 롤백할 수 있다(커밋하면 복구 불가)
 ROLLBACK;
 
 -- DELETE : 데이터 삭제
 DELETE FROM board -- SELECT * FROM과 달리 DELETE FROM 사이에 아무것도 안 들어감
  WHERE bno=1;
  
  -- 전체 데이터 삭제
    -- 1. WHERE절을 생략한 DELETE절
    -- 롤백 가능, 수동 커밋 가능, 로그 남기기 가능
DELETE FROM board;

    -- 2. TRUMCATE TABLE
    -- 롤백 불가능, 자동 커밋, 로그를 남길 수 없음, 테이블 생성 초기 상태로 복귀
    -- 위험: 관리자 말고는 하지 못함
TRUNCATE TABLE board;

    -- 3. DROP TABLE
    -- 롤백 불가능, 자동 커밋, 로그를 남길 수 엇ㅂ음, 테이블 생성 초기 상태로 복귀
    -- 거기다 구조(컬럼 포함)가 완전 삭제됨
DROP TABLE board;