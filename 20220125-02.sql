2022-0125-01) 오라클 객체 
- 오라클에서 제공하는 OBJECT로 VIEW, INDEX, PROCEDURE, FUNCTION, PACKAGE, TRIGGER, SYNONYM, SEQUENCE, DIRECTORY 등이 있음
- 생성시 CREATE, 제거시 DROP 명령사용
 
1. VIEW
- 가상의 테이블
- 기존의 테이블이나 뷰를 통하여 새로운 SELECT문의 결과를 테이블처럼 사용
- 테이블과 독립적
- 필요한 정보가 여러 테이블에 분산된 경우
- 테이블의 모든 자료에 대한 접근을 제한하고 필요한 자료만을 제공하는 경우

(사용형식)
    CREATE [OR REPLACE] VIEW 뷰이름 [(컬럼 list)]
    -- [OR REPLACE] 덮어씌우라는 의미
    -- VIEW 이름 적용 우선순위: 1.(컬럼 list)  2.SELECT문의 AS명  3.SELECT문의 컬럼명
    AS
      SELECT 문
      [WITH CHECK OPTION] -- VIEW에서 해당조건을 INSERT, UPDATE, DELECT 할수 없다.
      [WITH READ ONLY]; -- 읽기전용(원본이 수정되는것을 방지하기 위함)
      
      -- [WITH CHECK OPTION]과 [WITH READ ONLY]은 동시에 사용 할 수 없다.


사용예) 회원테이블에서 마일리지가 2000이상인 회원의 회원번호, 이름, 직업, 마일리지로 구성된 뷰를 생성하시오

        -- VIEW에 이름 지정하여 만들기
        CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
        AS
            SELECT MEM_ID AS 회원번호, 
                    MEM_NAME AS 이름, 
                    MEM_JOB AS 직업, 
                    MEM_MILEAGE AS 마일리지
            FROM MEMBER
            WHERE MEM_MILEAGE >=2000;
            
            
        SELECT * FROM V_MEM;
            
            
            
        -- 별칭으로 VIEW변경(덮어쓰기)
        CREATE OR REPLACE VIEW V_MEM
        AS
            SELECT MEM_ID AS 회원번호, 
                    MEM_NAME AS 이름, 
                    MEM_JOB AS 직업, 
                    MEM_MILEAGE AS 마일리지
            FROM MEMBER
            WHERE MEM_MILEAGE >=2000;
            
            
        SELECT * FROM V_MEM;
        
        
        --테이블명으로 VIEW생성(덮어쓰기)
        CREATE OR REPLACE VIEW V_MEM
        AS
            SELECT MEM_ID, 
                    MEM_NAME, 
                    MEM_JOB, 
                    MEM_MILEAGE
            FROM MEMBER
            WHERE MEM_MILEAGE >=2000;
            
            
        SELECT * FROM V_MEM;
        
        
        
        
사용예) 생성된 뷰 V_MEM에서 'r001'회원의 마일리지를 500으로 변경하시오

--원본테이블도 변경되는 경우
    UPDATE V_MEM
        SET MEM_MILEAGE = 500
     WHERE MEM_ID = 'r001';
     
    SELECT * FROM V_MEM;    
    
    SELECT MEM_ID, MEM_MILEAGE
     FROM MEMBER
     WHERE MEM_ID ='r001';
        
    ROLLBACK;
        
        
    
   
     CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
        AS
            SELECT MEM_ID AS 회원번호, 
                    MEM_NAME AS 이름, 
                    MEM_JOB AS 직업, 
                    MEM_MILEAGE AS 마일리지
              FROM MEMBER
             WHERE MEM_MILEAGE >=2000
            WITH CHECK OPTION;
            
            
     
-- 조건절을 위배하는 형태로 수정불가능
사용예) 뷰 V_MEM의 'r001'회원의 마일리지를 1500으로 변경하시오.       
            
        SELECT * FROM V_MEM;
        
        --SQL 오류: ORA-00904: "회원번호": invalid identifier ( WITH CHECK OPTION 위배 )
         UPDATE V_MEM
            SET 마일리지 = 1500
         WHERE 회원번호 = 'r001';
         
         

 --원본테이블을 변경하면 view도 자동으로 반영된다.
** 'n001'회원의 마일리지를 2500으로 변경하시오
         UPDATE MEMBER
            SET MEM_MILEAGE = 2500
         WHERE MEM_ID = 'n001';

        
 ** 회원테이블에서 'f001'회원의 마일리지를 1500으로 변경하시오       
        UPDATE MEMBER
            SET MEM_MILEAGE = 1500
         WHERE MEM_ID = 'f001';
         

ROLLBACK;





    CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
        AS
        SELECT MEM_ID AS 회원번호, 
                MEM_NAME AS 이름, 
                MEM_JOB AS 직업, 
                MEM_MILEAGE AS 마일리지
          FROM MEMBER
         WHERE MEM_MILEAGE >=2000
        WITH READ ONLY; --읽기전용
            
            
    SELECT * FROM V_MEM;
    
    
 ** 생성된 뷰 V_MEM의 모든 자료를 삭제하시오.
 DELETE FROM V_MEM;
 
 
** VIEW사용시 주의할 점
  (1) VIEW 생성시 WITH절을 사용한 제약조건이 부여된 경우 ORDER BY절 사용불가.
  (2) VIEW 생성에 집계함수가 사용된 경우 뷰에 INSERT, UPDATE, DELETE를 사용할 수 없음
  (3) VIEW의 컬럼이 표현식 (CASE~WHEN)이나 함수가 사용된 경우 컬럼추가 또는 수정이 불가
  (4) Pseudo Column(CURVAL, NEXTVAL 등) 사용불가
  
사용예)
    CREATE OR REPLACE VIEW V_CART
    AS
        SELECT CART_PROD AS CID,
                COUNT(*) AS CNT
          FROM CART
         WHERE CART_NO LIKE '200505%'
         GROUP BY CART_PROD
         ORDER BY 1;
         
         
        SELECT * FROM V_CART;
        
        --SQL 오류: ORA-01732: data manipulation operation not legal on this view
        --데이터조작 연산이 수행되어질수 없다는 뜻
        UPDATE V_CART
            SET CNT = 10
         WHERE CID='P101000001';
        
 
 
 사용예) 
    CREATE OR REPLACE VIEW V_MEM02
    AS
    SELECT MEM_ID AS MID,
           MEM_NAME AS NMAME,
           CASE WHEN SUBSTR(MEM_REGNO2,1,1) ='1' OR
                     SUBSTR(MEM_REGNO2,1,1)= '3' THEN
                     '남성'
            ELSE
                '여성'
            END AS GUBUN
    FROM MEMBER;
 
 
 SELECT * FROM V_MEM02;
 
 
 --가상컬럼은 사용불가능(오류)
 UPDATE V_MEM02
    SET GUBUN = '여성회원'
  WHERE GUBUN = '여성';
 
 
    
