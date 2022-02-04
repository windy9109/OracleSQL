2022-0204-01) �������ν���(Stored Procedure : Procedure)
 - ������ ����� ���డ����(������ �Ǿ ����ȴٴ� ��) ���α׷� ���
 - ��� �������α׷����� ����� �� �ֵ��� ����� ĸ��ȭ
 - ���ȼ� Ȯ��
 - ��ȯ���� ����

(�������)
CREATE [OR REPLACE] PROCEDURE ���ν�����
  [(�Ű����� [���] ������Ÿ�� [:=[DEFAULT] ��][,] 
                    :
  [(�Ű����� [���] ������Ÿ�� [:=[DEFAULT] ��])]
  AS|IS --DECLARE ����
    �����;
  BEGIN
    �����; -- ȣ��Ǵ� �κ�
    [EXCEPTION
      ����ó��;
    ]
 END;
 . '���': �Ű������� ��Ȱ=> IN(�Է¿�), OUT(��¿�), INOUT(����¿�:�������) --�ܺο��� ���η�IN, ���ο��� �ܺη� OUT
 . '������Ÿ��': ũ�⸦ �����ϸ� �ȵ� -- EX) VARCHAR2 (O)/ VARCHAR2(50) (X)


(���๮ ����)
EXECUTE|EXEC ���ν�����(�Ű�����list);
-- �ܵ�����
OR

���ν�����(�Ű�����list);
-- �ٸ� ���ν��� �Ǵ� �Լ� �� �͸��� ��� ����
-- ����������
-- ��ȯ���� ��� �ٸ��������� ����Ҽ� ���� SELECT���� ����Ҽ� ����


��뿹) ��ǰ�ڵ带 �Է¹޾� 2005�� ���� ������ ����ݾ� �� ��ǰ���� ����ϴ� ���ν��� �ۼ�
     
     
        CREATE OR REPLACE PROCEDURE PROC_CART01(
          P_PID IN VARCHAR2) --PROD.PROD_ID%TYPE
        IS
            --��ǰ��,
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
             DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ�: '||P_PID);
             DBMS_OUTPUT.PUT_LINE('��ǰ��: '||V_NAME);
             DBMS_OUTPUT.PUT_LINE('�������: '||V_QTY);
             DBMS_OUTPUT.PUT_LINE('�����: '||V_AMT);
             DBMS_OUTPUT.PUT_LINE('------------------------------------------');
        END;


(ȣ�⹮)
EXECUTE PROC_CART01('P202000001');







---------------------------------------------------------------------------------

��뿹) �μ���ȣ�� �Է¹޾� �μ���, �ο���, �ּҸ� ��ȯ�ϴ� ���ν��� �ۼ�
        --OUT�Ű����� ��뿹
        
        CREATE OR REPLACE PROCEDURE PROD_EMP01(
            P_DID IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE,
            P_DNAME OUT VARCHAR2,
            P_CNT OUT NUMBER,
            P_ADDR OUT VARCHAR2)
         IS
           
         BEGIN
            --�ο���,�ּ�,�μ���
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
         
         
         
        (����) --ȣ�⹮(ȣ�⹮�� �͸����� �̿��ؾ���)
        
          ACCEPT P_DID PROMPT('�μ��ڵ� �Է�(10~110):')
          DECLARE
            V_DNAME VARCHAR2(200);
            V_CNT NUMBER:=0;
            V_ADDR VARCHAR2(200);
          
          BEGIN
            PROD_EMP01(TO_NUMBER('&P_ID'), V_DNAME, V_CNT, V_ADDR);
            
            DBMS_OUTPUT.PUT_LINE('�μ��ڵ�: '||'&P_ID');
            DBMS_OUTPUT.PUT_LINE('�μ���: '||V_DNAME);
            DBMS_OUTPUT.PUT_LINE('�ο���: '||V_CNT);
            DBMS_OUTPUT.PUT_LINE('�ּ�: '||V_ADDR);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
          END;
         
 ---------------------------------------------------------------------------------        
         


��뿹) �⵵�� ���� �Է¹޾� �ش� ���� ���� ���� ������ ȸ���� ȸ����ȣ, �̸�, �ּ�, ���ϸ����� ��ȯ�ϴ� ���ν��� �ۼ�
        ���ν��� ���� 'PROC_MEM01'�̴�
        
        
        
        CREATE OR REPLACE PROCEDURE PROC_MEM01(
            --������
            --�Է�
            P_PERIOD IN VARCHAR2; --�⵵,��
            --��ȯ
            P_DID OUT MEMBER.MEM_ID%TYPE; --ȸ����ȣ
            P_ADDR OUT VARCHAR;--�ּ�
            P_NAME OUT MEMBER.MEM_NAME%TYPE;--�̸�
            P_DMILEAGE OUT MEMBER.MEM_ID%TYPE--���ϸ���
            )
            IS
             V_PERIOD VARCHAR2(7):=P_PERIOD||'%';
            BEGIN
             -- ȸ����ȣ, �̸�, �ּ�, ���ϸ���
             SELECT TBL.AID INTO P_MID --������ ���帹�� �߻���Ųȸ��
              FROM( SELECT A.CART_MEMBER AS AID, 
                            SUM(A.CART_QTY*B.PROD_PRICE) --�����Լ��� �����Լ��� �����Ҽ�����
                      FROM CART A, PROD B
                      WHERE A.CART_PROD = B.PROD_ID
                      GROUP BY A.CART_MEMBER
                      ORDER BY 2 DESC) TBL
                    WHERE ROWNUM =1;
                    
                    SELECT MEM_NAME, NEN_ADD1||''||MEM_ADD2, MEM_MILEAGE
                      INTO
                    
                AND SUBSTR(B.CART_NO,1,6) = P_PERIOD;
            
            END;
        
        
      (����) --ȣ�⹮(ȣ�⹮�� �͸����� �̿��ؾ���)
        
        --  ACCEPT P_ID PROMPT('�μ��ڵ� �Է�(10~110):')
          DECLARE
            V_MID MEMBER.MEM_ID%TYPE;
            V_NAME VARCHAR2(50);
            V_ADDR VARCHAR2(100);
            V_MILE NUMBER:=0;
          
          BEGIN
            PROC_MEM01('200505', V_MID, V_NAME, V_ADDR, V_MILE);
            
            DBMS_OUTPUT.PUT_LINE('�μ��ڵ�: '||'&P_ID');
            DBMS_OUTPUT.PUT_LINE('�μ���: '||V_DNAME);
            DBMS_OUTPUT.PUT_LINE('�ο���: '||V_CNT);
            DBMS_OUTPUT.PUT_LINE('�ּ�: '||V_ADDR);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
          END;



------------------------------------------------------------------------------------------






��뿹) �⵵�� ���� �Է¹޾� ��ǰ�� ���Լ����� ��������� ���ѵ� ���������̺��� �����Ͻÿ�
--��ǰ�� ���Լ������踦 ���ѵ� ������Ʈ���� ������ȴ�.

--��ȯ�Ǿ����� �����ʹ� ����.
-- ���ν������ٴ� FUNTION���� ������ 

--������ �����ؼ��� �ذ�Ұ���
--Ŀ���� �ذ�


CREATE OR REPLACE PROCEDURE CUR_BUY01(
            P_PERIOD IN VARCHAR2)
        IS
            V_SDATE DATE:=TO_DATE(P_PETIOD||'01'); --ù��
            V_EDATE DATE:=LAST_DAY(V_SDATE); --���帶������
            V_QTY NUMBER:=0;
            CURSOR CUR_BUY02
            IS
            --Ư���Ⱓ ������ ���Լ�������
                SELECT BUY_PROD AS BID, SUM(BUY_QTY) AS BAMT
                    FROM BUYPROD
                WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATR;
                GROUP BY BUY_PROD;
        BEGIN
            FOR REC IN CUR_BUY02 LOOP
               UPDATE REMAIN
                SET REMAIN_I = REMAIN_I+REC.BAMT, REMAIN_J_99+REC.BAMT,REMAIN_DATE=V_EDATE
                --�����Լ���=�������Լ���+���ο���Լ���
                --����� = �������+���ο� ���
                WHERE REMAIN_TEAR=SUBSTR(P_PERIOD,1,4)
                 AND PROD_ID=REC.BID; --��ǰ�ڵ� ����
                COMMIT; --�´���ǰ�� ���پ� ���ѵ� ������Ʈ�ϰ� Ŀ���Ѵ�.
            END LOOP;
        END;
        

    (����)
    EXECUTE PROC_REMAIN01('200503');
    
    SELECT * FROM REMAIN; --3�� 31�� �԰� �ڷᰡ ������ ����

    SELECT DISTINCT BUY_PROD
        FROM BUYPROD
    WHERE BUY_DATE BETWEEN '20050301' AND '20050331';

