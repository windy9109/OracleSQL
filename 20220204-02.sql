2022-0204-02)�Լ�(User Defined Function : Function)
 - Ư¡�� procedure�� �����ϳ� ��ȯ���� ������(��ȯ���� �� �Ѱ���)
 - ��ȯ�� ������ �������� �Լ��� ������ �����
 - select ���� select��, where��, update���� � ���
 
 (�������)
 CREATE [OR REPLACE] FUNCTION �Լ���[(
   ������ [���] Ÿ�Ը� [:=[DEFAULT] ��][,]
                  :
   ������ [���] Ÿ�Ը� [:=[DEFAULT] ��])
   RETURN Ÿ�Ը�
 AS|IS
   �����; --����,���,Ŀ�� ����
 BEGIN
   �����;
   RETURN expr;
   [EXCEPTION 
     ����ó����;
   ]
 END;  
 
��뿹)�ŷ�ó�ڵ带 �Է¹޾� �ش� �ŷ�ó���� ��ǰ�ϴ� ��ǰ
      ������ ��ȸ�Ͻÿ�(�Լ����)
      Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,��ǰ�ڵ�,��ǰ��,���Դܰ�
      
  CREATE OR REPLACE FUNCTION FN_PROD_INFO(
    P_BID IN BUYER.BUYER_ID%TYPE)
    RETURN VARCHAR2
  IS
    V_RES VARCHAR2(1000);
  BEGIN
    SELECT PROD_ID||' '||RPAD(PROD_NAME,20,' ')||
           LPAD(PROD_COST,8,' ')
      INTO V_RES
      FROM PROD
     WHERE PROD_BUYER=P_BID
       AND ROWNUM=1;
    RETURN V_RES;
    
    EXCEPTION 
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('�����߻�'||SQLERRM);
        RETURN NULL;
  END;
 
(����)
  SELECT BUYER_ID,BUYER_NAME,FN_PROD_INFO(BUYER_ID)
    FROM BUYER;
    
    
    
(��뿹)ȸ����ȣ�� �Է¹޾� ȸ������ ����ϴ� �Լ� �ۼ�
  SELECT MEM_ID,MEM_NAME
    FROM MEMBER;
    
  CREATE OR REPLACE FUNCTION FN_MEM_NAME(
    P_MID IN MEMBER.MEM_ID%TYPE)
    RETURN MEMBER.MEM_NAME%TYPE
  IS
    V_NAME MEMBER.MEM_NAME%TYPE;
  BEGIN
    SELECT MEM_NAME INTO V_NAME
      FROM MEMBER
     WHERE MEM_ID=P_MID;
    RETURN V_NAME; 
  END;
  
(����)
  SELECT MEM_ID AS ȸ����ȣ,
         FN_MEM_NAME(MEM_ID) AS ȸ����
    FROM MEMBER;     
    
    
    
2022-0207)
��뿹) �Ⱓ(��,��)�� �Է¹޾� ��ǰ�� ����ݾ����踦 ��ȸ�Ͻÿ�

    CREATE OR REPLACE FUNCTION FN_SUM_CART(
        --�ΰ��� �ϳ��� ���� �Է¹޴´�(��Ȳ�� ���� �ٸ�)
        P_PERIOD IN VARCHAR2,
        P_PID PROD.PROD_ID%TYPE)
        RETURN NUMBER --6�ڸ� �Է¹���
    AS
        V_PERIOD CHAR(7):=P_PERIOD||'%';
        V_SUM NUMBER:=0;  --��ǰ�� ����ݾ��հ�
    BEGIN
        SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM
          FROM CART A, PROD B
        WHERE A.CART_PROD =P_PID
          AND A.CART_PROD=B.PROD_ID
          AND A.CART_NO LIKE V_PERIOD;
        RETURN V_SUM;
        
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('���ܹ߻�: '||SQLERRM);
          RETURN NULL;
    END;
        
        
        
        
����)
SELECT PROD_ID AS ��ǰ�ڵ�, 
        NVL(FN_SUM_CART('200506', PROD_ID),0) AS ��������
    FROM PROD
  ORDER BY 1; --�ܺ�����


����2)
ACCEPT P_PERIOD PROMPT '�Ⱓ�Է�(��/��)' 
DECLARE
    V_AMT NUMBER:=0;
    V_RES VARCHAR2(100);
    CURSOR CUR_PROD01 
    --SELECT PROD_ID AS ��ǰ�ڵ�, NVL(FN_SUM_CART('200506', PROD_ID),0) AS ��������
    --�̰��� �ϳ��� ������(74��)
    IS
        SELECT PROD_ID, PROD_NAME FROM PROD;
BEGIN
    FOR REC IN CUR_PROD01 LOOP
       V_AMT:=NVL(FN_SUM_CART('&P_PERIOD', REC.PROD_ID),0); --��������� �Ҵ�
       V_RES:=REC.PROD_ID||' '
         ||RPAD(REC.PROD_NAME,30,' ')
         ||LPAD(V_AMT,9,' ');
  DBMS_OUTPUT.PUT_LINE(V_RES);
  END LOOP;
  
  END;
        
        










��뿹) �����ȣ�� �Է¹޾� �ش� ����� ���� �μ���� �ּҸ� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
        CREATE OR REPLACE FUNCTION FN_EMP_ADDR(
            P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
            RETURN VARCHAR2
        IS
            V_RES VARCHAR2(200); --�Է¹��� �μ���� �ּ� �����ϴ� ����
            V_ADDR VARCHAR2(100);
        BEGIN
            SELECT A.DEPARTMENT_NAME,
                   ' ZIP CODE: '||B.POSTAL_CODE||
                   ' '||STREET_ADDRESS||', '||CITY||
                   ' '||STATE_PROVINCE
              INTO V_RES, V_ADDR
              FROM HR.DEPARTMENTS A, HR.LOCATIONS B, HR.EMPLOYEES C
            WHERE C.EMPLOYEE_ID=P_EID
              AND C.DEPARTMENT_ID = A.DEPARTMENT_ID
              AND A.LOCATION_ID=B.LOCATION_ID;
            V_RES:=V_RES||'  '||V_ADDR; -- V_RES ���� �μ�����, V_ADDR���� �ּҰ� �������
            RETURN V_RES;
            
            EXCEPTION WHEN OTHERS THEN --���ܹ�
                DBMS_OUTPUT.PUT_LINE('���ܹ߻�: '||SQLERRM);
                RETURN NULL; --���Ϲ� ������ ����
        END;



����)
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       FN_EMP_ADDR(EMPLOYEE_ID) AS "�μ��� �� �ּ�"
  FROM HR.EMPLOYEES;





-----------------------------------------------------------------------------------------------

��뿹) �⵵�� �Է¹޾� �ش�⵵�� ��ǰ�� ���Լ����հ�� ���Աݾ��հ踦 ���ϴ� �Լ����� ����� ���Աݾױ���
        ����5���� ��ǰ�� ���� �������踦 ����Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ�
        
--��������հ�     
        CREATE OR REPLACE FUNCTION FN_AMT_BUYQYT(
            P_YEAR CHAR, P_PID PROD.PROD_ID%TYPE) --�Է¹޴°��� �⵵�� ��ǰ�ڵ���, ���� �Լ��� 2����
            RETURN NUMBER
        IS
            V_SQTY NUMBER:=0;
        
        BEGIN
            SELECT SUM(BUY_QTY) 
              INTO V_SQTY
              FROM BUYPROD
            WHERE EXTRACT(YEAR FROM BUY_DATE) = P_YEAR
               AND BUY_PROD = P_PID;
              RETURN V_SQTY;
        END; 
        
        
  


--����ݾ��հ�

        CREATE OR REPLACE FUNCTION FN_SUM_BUYAMT(
            P_YEAR CHAR, P_PID PROD.PROD_ID%TYPE) --�Է¹޴°��� �⵵�� ��ǰ�ڵ���, ���� �Լ��� 2����
            RETURN NUMBER
        IS
            V_SAMT NUMBER:=0;
        BEGIN
            SELECT SUM(BUY_QTY*BUY_COST)
              INTO V_SAMT
              FROM BUYPROD
            WHERE EXTRACT(YEAR FROM BUY_DATE) = P_YEAR
                AND BUY_PROD = P_PID;
            RETURN V_SAMT;
        END;


����) --���Աݾױ������� ����5�� ��ǰ ����� ���࿡�� �Ѵ�.
     --�ش�⵵�� ����5���̹Ƿ� ���������� �����

    SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��,
            A.FAB AS ���Լ���,
            TO_CHAR(A.FSB,'99,999,999') AS ���Աݾ�
      FROM ( SELECT PROD_ID, PROD_NAME,
                FN_AMT_BUYQYT('2005', PROD_ID) AS FAB,
                FN_SUM_BUYAMT('2005', PROD_ID) AS FSB
               FROM PROD
              ORDER BY 3 DESC) A
    WHERE ROWNUM <= 5;

 









   