2022-0208-02)
  ** CART?Öå?ù¥Î∏îÏóê ?ã§?ùå?ûêÎ£åÎ?? ???û•?ïò?ãú?ò§
        Íµ¨Îß§?ùº?ûê: ?ò§?äò(20050728)
        Íµ¨Îß§?öå?õê: d001
        Íµ¨Îß§?ÉÅ?íà
        -----------------------------
        ?ÉÅ?íàÎ≤àÌò∏         ?àò?üâ
        -----------------------------
        P201000003      3
        P201000015      2
 
        
    
        
        

--?ûê?èô?úºÎ°? Ï¶ùÍ??êò?ñ¥Ïß??äî Î≤àÌò∏ ?òà?†ú
--?ï®?àòÎ°? ?Ç†ÏßúÏóê ?ï¥?ãπ?êú CARTÎ≤àÌò∏Î•? ÎßåÎì§?ñ¥Î≥¥Ïûê

    CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
        P_DATE DATE)
        RETURN VARCHAR2 --Î∞òÌôò???ûÖ
    IS
        V_CNO VARCHAR2(20):=TO_CHAR(P_DATE,'YYYYMMDD'); 
        V_FLAG NUMBER:=0;
    BEGIN
        SELECT COUNT(*) INTO V_FLAG -- SUBSTR(CART_NO,1,8)=V_CNO;ÎßåÏ°±?ïò?äî Í∞íÎßå?Åº V_FLAG?óê Í∞íÏùÑ ?Ñ£?äî?ã§
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
    
    
    
    
(?ã§?ñâ)
    SELECT FN_CREATE_CARTNO(SYSDATE)
        FROM DUAL;
        
    SELECT FN_CREATE_CARTNO(TO_DATE('20050505')),
            FN_CREATE_CARTNO(TO_DATE('20050513'))
        FROM DUAL;




    --Íµ¨Îß§?ãú ?èôÎ∞òÎêò?äî ÎßàÏùºÎ¶¨Ï? Ï¶ùÍ??äî ?ä∏Î¶¨Í±∞Î°? Ï≤òÎ¶¨?ï®
    --?ä∏Î¶¨Í±∞?óê?Ñú Ï≤òÎ¶¨?ï¥?ïº?ï† ?Ç¥?ö©: ?û¨Í≥? UPDATE, ÎßàÏùºÎ¶¨Ï? UPDATE
    
    CREATE OR REPLACE TRIGGER TG_CART_CHANGE
      AFTER INSERT OR UPDATE OR DELETE ON CART
      FOR EACH ROW
    DECLARE
      V_QTY NUMBER:=0; --Î≤àÌò∏
      V_PID PROD.PROD_ID%TYPE; --?ÉÅ?íàID
      V_MILE NUMBER:=0; --ÎßàÏùºÎ¶¨Ï?
      V_DATE DATE; --?Ç†Ïß?
      V_MID MEMBER.MEM_ID%TYPE; --?öå?õêÎ≤àÌò∏
    BEGIN
      IF INSERTING THEN 
        V_QTY:=:NEW.CART_QTY; --?ÉàÎ°úÏö¥ ?àò?üâÏ∂îÍ?
        V_PID:=:NEW.CART_PROD; --?ÉàÎ°úÏö¥ ?ÉÅ?íàIDÏ∂îÍ? 
        V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8)); --?òÑ?û¨?Ç†ÏßúÏ∂îÍ∞?
        V_MID:=:NEW.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
            FROM PROD
          WHERE PROD_ID=V_PID;
      ELSIF UPDATING THEN
        V_QTY:=:NEW.CART_QTY - :OLD.CART_QTY; -- ?Ç®???àò?üâ = ?òÑ?û¨?†ÑÏ≤¥Ïàò?üâ - Í∏∞Ï°¥?àò?üâ
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


(?û¨Í≥†Ï°∞?öå)

          
          
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

    --Î∞òÌíà?ï†Í≤ΩÏö∞
    DELETE FROM CART
     WHERE CART_NO='2005072800005'
       AND CART_PROD='P201000003';
    
    
    
    
    
    
    
    

