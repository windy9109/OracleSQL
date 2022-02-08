2022-0208-02)
  ** CART테이블에 다음자료를 저장하시오
        구매일자: 오늘(20050728)
        구매회원: d001
        구매상품
        -----------------------------
        상품번호         수량
        -----------------------------
        P201000003      3
        P201000015      2
 
        

        
        

--자동으로 증가되어지는 번호 예제
--함수로 날짜에 해당된 CART번호를 만들어보자

    CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
        P_DATE DATE)
        RETURN VARCHAR2 --반환타입
    IS
        V_CNO VARCHAR2(20):=TO_CHAR(P_DATE,'YYYYMMDD'); 
        V_FLAG NUMBER:=0;
    BEGIN
        SELECT COUNT(*) INTO V_FLAG -- SUBSTR(CART_NO,1,8)=V_CNO;만족하는 값만큼 V_FLAG에 값을 넣는다
            FROM CART
          WHERE SUBSTR(CART_NO,1,8)=V_CNO;
          
        IF V_FLAG=0 THEN
           V_CNO:=V_CNO||TRIM('00001');
        ELSE
            SELECT MAX(CART_NO)+1 INTO V_CNO
              FROM CART
             WHERE SUBSTR(CART_NO,1,8)=V_CNO;
        END IF;
        RETURN V_CNO;
    END;
    
    
    
    
(실행)
    SELECT FN_CREATE_CARTNO(SYSDATE)
        FROM DUAL;
        
    SELECT FN_CREATE_CARTNO(TO_DATE('20050505')),
            FN_CREATE_CARTNO(TO_DATE('20050513'))
        FROM DUAL;




    --구매시 동반되는 마일리지 증가는 트리거로 처리함
    --트리거에서 처리해야할 내용: 재고 UPDATE, 마일리지 UPDATE
    
    CREATE OR REPLACE TRIGGER TG_CART_CHANGE
      AFTER INSERT OR UPDATE OR DELETE ON CART
      FOR EACH ROW
    DECLARE
      V_QTY NUMBER:=0; --번호
      V_PID PROD.PROD_ID%TYPE; --상품ID
      V_MILE NUMBER:=0; --마일리지
      V_DATE DATE; --날짜
      V_MID MEMBER.MEM_ID%TYPE; --회원번호
    BEGIN
      IF INSERTING THEN 
        V_QTY:=:NEW.CART_QTY; --새로운 수량추가
        V_PID:=:NEW.CART_PROD; --새로운 상품ID추가 
        V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8)); --현재날짜추가
        V_MID:=:NEW.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
            FROM PROD
          WHERE PROD_ID=V_PID;
      ELSIF UPDATING THEN
        V_QTY:=:NEW.CART_QTY - :OLD.CART_QTY; -- 남은수량 = 현재전체수량 - 기존수량
        V_PID:=:NEW.CART_PROD;
        V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
        V_MID:=:NEW.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
            FROM PROD
          WHERE PROD_ID=V_PID;
      ELSIF DELETING THEN
         V_QTY:=-(:OLD.CART_QTY);
         V_PID:=:OLD.CART_PROD;
         V_DATE:=TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
         V_MID:=:OLD.CART_MEMBER;
          SELECT V_QTY*PROD_MILEAGE INTO V_MILE
            FROM PROD
          WHERE PROD_ID=V_PID;
    END IF;
        
        UPDATE REMAIN
            SET REMAIN_O=REMAIN_O+V_QTY,
                REMAIN_J_99=REMAIN_J_99-V_QTY,
                REMAIN_DATE=V_DATE
        WHERE PROD_ID=V_PID
          AND REMAIN_YEAR=EXTRACT(YEAR FROM V_DATE);
        
        UPDATE MEMBER
            SET MEM_MILEAGE=MEM_MILEAGE+V_MILE
        WHERE MEM_ID=V_MID;
                
        
    END;


(재고조회)

          
          
    SELECT * FROM REMAIN
        WHERE PROD_ID='P201000003';

    SELECT MEM_MILEAGE FROM MEMBER
        WHERE MEM_ID='d001';
        
    INSERT INTO CART
          VALUES('d001', FN_CREATE_CARTNO(TO_DATE('20050728')), 'P201000003', 3);
           
    ROLLBACK;
       
    COMMIT;
        
    UPDATE CART
      SET CART_QTY=30;
    WHERE CART_NO='2005072800005'
     AND CART_PROD='P201000003';

    --반품할경우
    DELETE FROM CART
     WHERE CART_NO='2005072800005'
       AND CART_PROD='P201000003';
    
    
    
    
    
    
    
    

