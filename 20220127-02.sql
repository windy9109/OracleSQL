2022-0127-02)�ݺ���
 - ����Ŭ���� �����ϴ� �ݺ����� LOOP, WHILE, FOR���� ����
 -- Ŀ���� �������� �ݺ����� ���°�찡 ����.
 
 1. LOOP
 - �ݺ����� �⺻ ���� ����
 - ���ѷ���
 - JAVA�� DO���� ���� 
 
 (�������)
 LOOP
  �ݺ�ó�� ��ɹ�(��);
  [EXIT WHEN ����;]
        :
    END LOOP;
. EXIT WHEN ����: '����'�� ���ΰ�� �ݺ����� ���
--WHILE�� ������ ������ �ݺ��ϰ� LOOP�� ������ ������ �ݺ��� ���



��뿹) �������� 6���� LOOP���� �̿��Ͽ� �ۼ�
    DECLARE
        V_CNT NUMBER:=1;
        
    BEGIN
        LOOP
            EXIT WHEN V_CNT>9;
            DBMS_OUTPUT.PUT_LINE('6*'||V_CNT||'='||V_CNT*6);
            V_CNT:=V_CNT+1;
            END LOOP;
    END;


��뿹) ��ǰ���̺��� �з��ڵ� 'P102'�� ���� ��ǰ������ ��� �����Ͻÿ�

       'P102'�� ���� ��ǰ�ڵ�� 'P102000001'����
       'P102000007'�̴�.
       
       DECLARE 
        V_START NUMBER:=0; --���۰�(6�ڸ���)
        V_END NUMBER:=0; --����(6�ڸ���)
        V_CNT NUMBER:=0; --��ǰ�ڵ带 1�� ������ų ��
        V_PID GOODS.PROD_ID%TYPE;--(��ǰ�ڵ�)
       BEGIN
       SELECT MIN(TO_NUMBER(SUBSTR(PROD_ID,5))) INTO V_START
            FROM GOODS
            WHERE PROD_LGU='P102';
            V_CNT:=V_START;
       SELECT MAX(TO_NUMBER(SUBSTR(PROD_ID,5))) INTO V_END
            FROM GOODS
            WHERE PROD_LGU='P102';
        
        LOOP
        EXIT WHEN V_CNT>V_END;
        V_PID:='P102'||TRIM(TO_CHAR(V_CNT,'000000'));
        DELETE FROM GOODS
         WHERE PROD_ID=V_PID;
         V_CNT:=V_CNT+1;
         END LOOP;
        END;
       
       
       



