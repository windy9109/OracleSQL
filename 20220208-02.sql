2022-0208-02)
  ** CART?��?��블에 ?��?��?��료�?? ???��?��?��?��
        구매?��?��: ?��?��(20050728)
        구매?��?��: d001
        구매?��?��
        -----------------------------
        ?��?��번호         ?��?��
        -----------------------------
        P201000003      3
        P201000015      2
 
        
    
        
        

--?��?��?���? 증�??��?���??�� 번호 ?��?��
--?��?���? ?��짜에 ?��?��?�� CART번호�? 만들?��보자

    CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
        P_DATE DATE)
        RETURN VARCHAR2 --반환???��
    IS
        V_CNO VARCHAR2(20):=TO_CHAR(P_DATE,'YYYYMMDD'); 
        V_FLAG NUMBER:=0;
    BEGIN
        SELECT COUNT(*) INTO V_FLAG -- SUBSTR(CART_NO,1,8)=V_CNO;만족?��?�� 값만?�� V_FLAG?�� 값을 ?��?��?��
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
    
    
    
    
(?��?��)
    SELECT FN_CREATE_CARTNO(SYSDATE)
        FROM DUAL;
        
    SELECT FN_CREATE_CARTNO(TO_DATE('20050505')),
            FN_CREATE_CARTNO(TO_DATE('20050513'))
        FROM DUAL;




    --구매?�� ?��반되?�� 마일리�? 증�??�� ?��리거�? 처리?��
    --?��리거?��?�� 처리?��?��?�� ?��?��: ?���? UPDATE, 마일리�? UPDATE
    
    CREATE OR REPLACE TRIGGER TG_CART_CHANGE
      AFTER INSERT OR UPDATE OR DELETE ON CART
      FOR EACH ROW
    DECLARE
      V_QTY NUMBER:=0; --번호
      V_PID PROD.PROD_ID%TYPE; --?��?��ID
      V_MILE NUMBER:=0; --마일리�?
      V_DATE DATE; --?���?
      V_MID MEMBER.MEM_ID%TYPE; --?��?��번호
    BEGIN
      IF INSERTING THEN 
        V_QTY:=:NEW.CART_QTY; --?��로운 ?��?��추�?
        V_PID:=:NEW.CART_PROD; --?��로운 ?��?��ID추�? 
        V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8)); --?��?��?��짜추�?
        V_MID:=:NEW.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
            FROM PROD
          WHERE PROD_ID=V_PID;
      ELSIF UPDATING THEN
        V_QTY:=:NEW.CART_QTY - :OLD.CART_QTY; -- ?��???��?�� = ?��?��?��체수?�� - 기존?��?��
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


(?��고조?��)

          
          
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

    --반품?��경우
    DELETE FROM CART
     WHERE CART_NO='2005072800005'
       AND CART_PROD='P201000003';
    
    
    
    
    
    
    
    

