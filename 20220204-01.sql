2022-0204-01) 저장프로시져(Stored Procedure : Procedure)
 - 서버에 저장된 실행가능한(컴파일 되어서 저장된다는 뜻) 프로그램 모듈
 - 모든 응용프로그램에서 사용할 수 있도록 기능을 캡슐화
 - 보안성 확보
 - 반환값이 없음
 
(사용형식)
CREATE [OR REPLACE] PROCEDURE 프로시저명
  [(매개변수 [모드] 데이터타입 [:=[DEFAULT] 값][,] 
                    :
  [(매개변수 [모드] 데이터타입 [:=[DEFAULT] 값])]
  AS|IS --DECLARE 역할
    선언부;
  BEGIN
    실행부; -- 호출되는 부분
    [EXCEPTION
      예외처리;
    ]
 END;
 . '모드': 매개변수의 역활=> IN(입력용), OUT(출력용), INOUT(입출력용:사용자제) --외부에서 내부로IN, 내부에서 외부로 OUT
 . '데이터타입': 크기를 지정하면 안됨 -- EX) VARCHAR2 (O)/ VARCHAR2(50) (X)


(실행문 형식)
EXECUTE|EXEC 프로시저명(매개변수list);
-- 단독실행
OR

프로시저명(매개변수list);
-- 다른 프로시저 또는 함수 및 익명블록 등에서 실행
-- 독립적실행
-- 반환값이 없어서 다른쿼리에서 사용할수 없고 SELECT문을 사용할수 없음


사용예) 상품코드를 입력받아 2005년 매출 수량과 매출금액 및 상품명을 출력하는 프로시져 작성
     
     
        CREATE OR REPLACE PROCEDURE PROC_CART01(
          P_PID IN VARCHAR2) --PROD.PROD_ID%TYPE
        IS
            --상품명,
            V_NAME PROD.PROD_NAME%TYPE;
            V_QTY NUMBER:=0;
            V_AMT NUMBER:=0;
            
        BEGIN
            SELECT A.PROD_NAME, SUM(B.CART_QTY), SUM(B.CART_QTY*A.PROD_PRICE)
              INTO V_NAME, V_QTY, V_AMT
              FROM PROD A, CART B
             WHERE B.CART_PROD=P_PID
             AND A.PROD_ID=B.CART_PROD
             AND B.CART_NO LIKE '2005%'
             GROUP BY A.PROD_NAME;
             DBMS_OUTPUT.PUT_LINE('상품코드: '||P_PID);
             DBMS_OUTPUT.PUT_LINE('상품명: '||V_NAME);
             DBMS_OUTPUT.PUT_LINE('매출수량: '||V_QTY);
             DBMS_OUTPUT.PUT_LINE('매출액: '||V_AMT);
             DBMS_OUTPUT.PUT_LINE('------------------------------------------');
        END;


(호출문)
EXECUTE PROC_CART01('P202000001');







---------------------------------------------------------------------------------

사용예) 부서번호를 입력받아 부서명, 인원수, 주소를 반환하는 프로시저 작성
        --OUT매개변수 사용예
        
        CREATE OR REPLACE PROCEDURE PROD_EMP01(
            P_DID IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE,
            P_DNAME OUT VARCHAR2,
            P_CNT OUT NUMBER,
            P_ADDR OUT VARCHAR2)
         IS
           
         BEGIN
            --인원수,주소,부서명
            SELECT A.DEPARTMENT_NAME,
                   B.POSTAL_CODE||' '||B.STREET_ADDRESS||' '
                   ||B.CITY||' '||B.STATE_PROVINCE
                INTO P_DNAME, P_ADDR
                FROM HR.DEPARTMENTS A, HR.LOCATIONS B
            WHERE A.LOCATION_ID = B.LOCATION_ID
              AND A.DEPARTRNT_ID=P_DID;
            SELECT COUNT(*) INTO P_CNT
              FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID =P_DID;
         
         END;
         
         
         
        (실행) --호출문(호출문도 익명블록을 이용해야함)
        
          ACCEPT P_DID PROMPT('부서코드 입력(10~110):')
          DECLARE
            V_DNAME VARCHAR2(200);
            V_CNT NUMBER:=0;
            V_ADDR VARCHAR2(200);
          
          BEGIN
            PROD_EMP01(TO_NUMBER('&P_ID'), V_DNAME, V_CNT, V_ADDR);
            
            DBMS_OUTPUT.PUT_LINE('부서코드: '||'&P_ID');
            DBMS_OUTPUT.PUT_LINE('부서명: '||V_DNAME);
            DBMS_OUTPUT.PUT_LINE('인원수: '||V_CNT);
            DBMS_OUTPUT.PUT_LINE('주소: '||V_ADDR);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
          END;
         
 ---------------------------------------------------------------------------------        
         


사용예) 년도와 월을 입력받아 해당 월에 가장 많이 구매한 회원의 회원번호, 이름, 주소, 마일리지를 반환하는 프로시저 작성
        프로시저 명은 'PROC_MEM01'이다
        
        
        
        CREATE OR REPLACE PROCEDURE PROC_MEM01(
            --변수명
            --입력
            P_PERIOD IN VARCHAR2; --년도,월
            --반환
            P_DID OUT MEMBER.MEM_ID%TYPE; --회원번호
            P_ADDR OUT VARCHAR;--주소
            P_NAME OUT MEMBER.MEM_NAME%TYPE;--이름
            P_DMILEAGE OUT MEMBER.MEM_ID%TYPE--마일리지
            )
            IS
             V_PERIOD VARCHAR2(7):=P_PERIOD||'%';
            BEGIN
             -- 회원번호, 이름, 주소, 마일리지
             SELECT TBL.AID INTO P_MID --매출을 가장많이 발생시킨회원
              FROM( SELECT A.CART_MEMBER AS AID, 
                            SUM(A.CART_QTY*B.PROD_PRICE) --집계함수는 집계함수를 포함할수없다
                      FROM CART A, PROD B
                      WHERE A.CART_PROD = B.PROD_ID
                      GROUP BY A.CART_MEMBER
                      ORDER BY 2 DESC) TBL
                    WHERE ROWNUM =1;
                    
                    SELECT MEM_NAME, NEN_ADD1||''||MEM_ADD2, MEM_MILEAGE
                      INTO
                    
                AND SUBSTR(B.CART_NO,1,6) = P_PERIOD;
            
            END;
        
        
      (실행) --호출문(호출문도 익명블록을 이용해야함)
        
        --  ACCEPT P_ID PROMPT('부서코드 입력(10~110):')
          DECLARE
            V_MID MEMBER.MEM_ID%TYPE;
            V_NAME VARCHAR2(50);
            V_ADDR VARCHAR2(100);
            V_MILE NUMBER:=0;
          
          BEGIN
            PROC_MEM01('200505', V_MID, V_NAME, V_ADDR, V_MILE);
            
            DBMS_OUTPUT.PUT_LINE('부서코드: '||'&P_ID');
            DBMS_OUTPUT.PUT_LINE('부서명: '||V_DNAME);
            DBMS_OUTPUT.PUT_LINE('인원수: '||V_CNT);
            DBMS_OUTPUT.PUT_LINE('주소: '||V_ADDR);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
          END;



------------------------------------------------------------------------------------------






사용예) 년도와 월을 입력받아 제품별 매입수량과 매출수량을 구한뒤 재고수불테이블을 갱신하시오
--제품별 매입수량집계를 구한뒤 업데이트문이 나오면된다.

--반환되어지는 데이터는 없다.
-- 프로시저보다는 FUNTION문이 적합함 

--변수에 저장해서는 해결불가능
--커서로 해결


CREATE OR REPLACE PROCEDURE CUR_BUY01(
            P_PERIOD IN VARCHAR2)
        IS
            V_SDATE DATE:=TO_DATE(P_PETIOD||'01'); --첫날
            V_EDATE DATE:=LAST_DAY(V_SDATE); --가장마지막날
            V_QTY NUMBER:=0;
            CURSOR CUR_BUY02
            IS
            --특정기간 동안의 매입수량집계
                SELECT BUY_PROD AS BID, SUM(BUY_QTY) AS BAMT
                    FROM BUYPROD
                WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATR;
                GROUP BY BUY_PROD;
        BEGIN
            FOR REC IN CUR_BUY02 LOOP
               UPDATE REMAIN
                SET REMAIN_I = REMAIN_I+REC.BAMT, REMAIN_J_99+REC.BAMT,REMAIN_DATE=V_EDATE
                --현매입수량=기존매입수량+새로운매입수량
                --현재고 = 기존재고+새로운 재고
                WHERE REMAIN_TEAR=SUBSTR(P_PERIOD,1,4)
                 AND PROD_ID=REC.BID; --제품코드 선택
                COMMIT; --맞는제품을 한줄씩 비교한뒤 업데이트하고 커밋한다.
            END LOOP;
        END;
        

    (실행)
    EXECUTE PROC_REMAIN01('200503');
    
    SELECT * FROM REMAIN; --3월 31일 입고 자료가 있으면 성공

    SELECT DISTINCT BUY_PROD
        FROM BUYPROD
    WHERE BUY_DATE BETWEEN '20050301' AND '20050331';

