2022-0203-02) Ŀ��(CURSOR)
 - Ŀ���� SQL������� ������� ����� ����
 - SELECT���� Ŀ���� ��� ����
 - Ŀ���� ������Ŀ��(IMPLICITE CURSOR)�� �����Ŀ��(EXPLICITE CURSOR)�� ����
       
     
 1. ������ Ŀ��
  . �̸��� ���� Ŀ��
  . SELECT���� ��� ����
  . ������Ŀ���� �׻� CLOSE�Ǿ� �־� Ŀ�� ������ �ڷ� ������ �Ұ���
  . ������ Ŀ�� �Ӽ�
    
---------------------------------------------------------------------------
    Ŀ��              �ǹ� 
---------------------------------------------------------------------------
SQL%ISIPEN          Ŀ���� ���ٰ����� ����(OPEN)�ΰ��� �Ǵ� �Ͽ� OPEN�����̸� ��, 
                    �ƴϸ� ������ ��ȯ.  ������ Ŀ���� �׻� false��.
SQL%FOUND           Ŀ������ ��(ROW)�� �����ϸ� ��, ������ ���� ��ȯ
SQL%NOTFOUND        Ŀ������ ��(ROW)�� �����ϸ� ����, ������ �� ��ȯ
SQL%ROWCOUNT        Ŀ������ ���� �� ��ȯ
---------------------------------------------------------------------------



2. ����� Ŀ��
 . �̸��� �ο��� Ŀ��
 . ���� ����ο��� ����
 . �����Ŀ���� '����' -> 'OPEN' -> 'FETCH' -> 'CLOSE' �ܰ� ������ ó��
   (��, FOR���� ����)
 
 1) ����
 - ����ο� ���
 (��������)
  CURSOR Ŀ����[(������ Ÿ��[,...])] --���� ũ������ ����, Ÿ�Ը�
  IS 
    SELECT ��;
    . '������'�� ���� �Ҵ��ϴ� ���� OPEN������ ����
   
   
2) OPEN ��
    - Ŀ���� ����ϱ� ���� ������� ����� Ŀ���� ���ٰ����� ���·� ����
    - Ŀ���� �Ű������� ����� ��� OPEN������ ���� ����
    - BEGIN ��Ͽ� ���
(�������)
OPEN Ŀ����[(��,...)];


3) FETCH ��
    - Ŀ�����ο� �� ������� �ڷḦ �о� ������ �Ҵ�
    - BEGIN ��Ͽ� ����Ǹ� ���� �ݺ��� ���ο� ���
(�������)
    FETCH Ŀ���� INTO ������[,������,...]
    . Ŀ�������� �÷��� ������ ���� �� �ڷ�Ÿ�԰� INTO���� ���� ����, ����, �ڷ�Ÿ���� ��ġ�ؾ���
    . Ŀ���÷� ���� ������ ���ʴ�� �Ҵ�

4) CLOSE ��
- ����� ����� Ŀ���� �ݵ�� CLOSE �Ǿ����
- Ŀ���� �ٽ� OPEN �����ϳ� �����͸� FETCH, ����, ������ �� ����





   
    
��뿹) �μ���ȣ 100�� �μ��� ���� ��������� Ŀ���� �̿��Ͽ� ����Ͻÿ�
        
        DECLARE
        CURSOR CUR_EMP01(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
        IS
            SELECT EMPLOYEE_ID, EMP_NAME, JOB_TITLE, HIRE_DATE --Ŀ���ȿ� �÷��� 4���� �ִ�. ������ �Ҵ�޾ƾ���
              FROM HR.EMPLOYEES A, HR.JOBS B
            WHERE A.JOB_ID=B.JOB_ID
            AND A.DEPARTMENT_ID=P_DID;
            V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
            V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
            V_JTITLE HR.JOBS.JOB_TITLE%TYPE;
            V_HDATE HR.EMPLOYEES.HIRE_DATE%TYPE;
            BEGIN
                OPEN CUR_EMP01(100);
                --LOOP ���� ���
                LOOP
                FETCH CUR_EMP01 INTO V_EID, V_ENAME, V_JTITLE, V_HDATE;
                EXIT WHEN CUR_EMP01%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('�����ȣ: '||V_EID);
                DBMS_OUTPUT.PUT_LINE('�����: '||V_ENAME);
                DBMS_OUTPUT.PUT_LINE('������: '||V_JTITLE);
                DBMS_OUTPUT.PUT_LINE('�Ի���: '||V_HDATE);
                DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
            END LOOP;
            CLOSE CUR_EMP01;
        END;
                
-------------------------------------------------------------------------------------------

/* WHILE��� */
        DECLARE
        CURSOR CUR_EMP01(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
        IS
            SELECT EMPLOYEE_ID, EMP_NAME, JOB_TITLE, HIRE_DATE --Ŀ���ȿ� �÷��� 4���� �ִ�. ������ �Ҵ�޾ƾ���
              FROM HR.EMPLOYEES A, HR.JOBS B
            WHERE A.JOB_ID=B.JOB_ID
            AND A.DEPARTMENT_ID=P_DID;
            V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
            V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
            V_JTITLE HR.JOBS.JOB_TITLE%TYPE;
            V_HDATE HR.EMPLOYEES.HIRE_DATE%TYPE;
            BEGIN
                OPEN CUR_EMP01(100);

                FETCH CUR_EMP01 INTO V_EID, V_ENAME, V_JTITLE, V_HDATE;
                WHILE CUR_EMP01%FOUND  LOOP
                EXIT WHEN CUR_EMP01%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('�����ȣ: '||V_EID);
                DBMS_OUTPUT.PUT_LINE('�����: '||V_ENAME);
                DBMS_OUTPUT.PUT_LINE('������: '||V_JTITLE);
                DBMS_OUTPUT.PUT_LINE('�Ի���: '||V_HDATE);
                DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
                FETCH CUR_EMP01 INTO V_EID, V_ENAME, V_JTITLE, V_HDATE;
            END LOOP;
            CLOSE CUR_EMP01;
        END;
        
  -------------------------------------------------------------------------------------------

/* FOR�� ��� */



        DECLARE
        CURSOR CUR_EMP01 --(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
        IS
            SELECT EMPLOYEE_ID AS AEID, 
                    EMP_NAME AS ANAME, 
                    JOB_TITLE AS BTITLE, 
                    HIRE_DATE AS AHDATE --Ŀ���ȿ� �÷��� 4���� �ִ�. ������ �Ҵ�޾ƾ���
              FROM HR.EMPLOYEES A, HR.JOBS B
            WHERE A.JOB_ID=B.JOB_ID
            AND A.DEPARTMENT_ID = 100;
            
            BEGIN
                FOR REC IN CUR_EMP01 LOOP
                DBMS_OUTPUT.PUT_LINE('�����ȣ: '||REC.AEID);
                    DBMS_OUTPUT.PUT_LINE('�����: '||REC.ANAME);
                    DBMS_OUTPUT.PUT_LINE('������: '||REC.BTITLE);
                    DBMS_OUTPUT.PUT_LINE('�Ի���: '||REC.AHDATE);
                    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
            END LOOP;
        END;      
        
 
 
 ------------------------------------------------------------------------------------------       
    
 /* FOR�� ��� (�������ϰ�)*/
 /*FOR�� (IN-LINE SUBQUERY�� ���)*/



        DECLARE
            
            BEGIN
                FOR REC IN (SELECT EMPLOYEE_ID AS AEID, 
                    EMP_NAME AS ANAME, 
                    JOB_TITLE AS BTITLE, 
                    HIRE_DATE AS AHDATE --Ŀ���ȿ� �÷��� 4���� �ִ�. ������ �Ҵ�޾ƾ���
              FROM HR.EMPLOYEES A, HR.JOBS B
            WHERE A.JOB_ID=B.JOB_ID
            AND A.DEPARTMENT_ID = 100)
            LOOP
                DBMS_OUTPUT.PUT_LINE('�����ȣ: '||REC.AEID);
                    DBMS_OUTPUT.PUT_LINE('�����: '||REC.ANAME);
                    DBMS_OUTPUT.PUT_LINE('������: '||REC.BTITLE);
                    DBMS_OUTPUT.PUT_LINE('�Ի���: '||REC.AHDATE);
                    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
            END LOOP;
        END;    
                
                
                
                
                
 
FETCH ��뿹) ��������'�泲'�� ȸ������ 2005�� ���������� ��ȸ�Ͻÿ�
            Alias ȸ������, ȸ����, �ּ�, ���űݾ�, ���ϸ���
            -- Ŀ���� ������� �κ��� �����������
            
            (Ŀ�� : �������� �泲�� ȸ������ ȸ����ȣ)
            DECLARE
                V_AMT NUMBER:=0; --���űݾ��հ�
                v_RES VARCHAR2(500);
                CURSOR CUR_CART02 IS
                    SELECT MEM_ID, MEM_NAME, MEM_ADD1||' '||MEM_ADD2 AS ADDR,
                            MEM_MILEAGE
                      FROM MEMBER
                    WHERE MEM_ADD1 LIKE '�泲%';
            BEGIN
             FOR REC IN CUR_CART02 LOOP --CURSOR�� ������ REC���� 4�� �÷��� ������ �������� �о��.
                SELECT SUM(CART_QTY*PROD_PRICE) INTO V_AMT
                    FROM CART, PROD
                  WHERE CART_MEMBER = REC.MEM_ID
                    AND CART_PROD = PROD_ID
                    AND CART_NO LIKE '2005%';
                    V_RES:=REC.MEM_ID||' '||REC.MEM_NAME||' '
                    ||RPAD(REC.ADDR, 30,' ')||LPAD(V_AMT,9,' ')||
                    LPAD(REC.MEM_MILEAGE,6,' ');
            DBMS_OUTPUT.PUT_LINE(V_RES);
            END LOOP; 
            END;
            
            
            
            
            
��뿹) ����� ���� 5���� ��ǰ�� ���� 2005�� ���������� ��ȸ�Ͻÿ�
        Alias�� ��ǰ�ڵ�, ��ǰ��, ��������, ���Լ���
        
        (CURSOR�� MAX 5�� ��ǰ�ڵ�)
        
        SELECT SUM(BUY_QTY) AS ����
                BUY_COST AS ��ǰ�ڵ�
          FROM BUYPROD
         WHERE BUY_PROD
           AND SUBSTR(TO_NUMBER(BUY_DATE),1,4) = '2005' 
           GROUP BY BUY_COST;
            
            
-----------------------------------------------------------
      DECLARE
      CURSOR CUR_BUY01 IS
      SELECT A.PROD_ID AS APID
        FROM (SELECT PROD_ID, RNAME_J_99
                FROM REMAIN
                ORDER BY 2 DESC ) A
            WHERE ROWNUM <= 5;
        V_PNAME PROD.PROD_NAME%TYPE;
        V_QTY NUMBER:=0;
      BEGIN
        FOR REC IN CUR_BUY01 LOOP
        SELECT PROD_NAME INTO V_PNAME
          FROM PROD
          WHERE PROD_ID =REC.APID
                 AND EXTRACT(YEAR FROM BUY_DATE)=2005;
      DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ�: '||REC.APID);      
      DBMS_OUTPUT.PUT_LINE('��ǰ��: '||V_PNAME); 
      DBMS_OUTPUT.PUT_LINE('��������: '||V_DATE); 
      DBMS_OUTPUT.PUT_LINE('���Լ���: '||V_QTY); 
      DBMS_OUTPUT.PUT_LINE('----------------------------------'); 
    END LOOP;
    END;
        
        
            
            
            
            
            
            
            







