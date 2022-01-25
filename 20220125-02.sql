2022-0125-01) ����Ŭ ��ü 
- ����Ŭ���� �����ϴ� OBJECT�� VIEW, INDEX, PROCEDURE, FUNCTION, PACKAGE, TRIGGER, SYNONYM, SEQUENCE, DIRECTORY ���� ����
- ������ CREATE, ���Ž� DROP ��ɻ��
 
1. VIEW
- ������ ���̺�
- ������ ���̺��̳� �並 ���Ͽ� ���ο� SELECT���� ����� ���̺�ó�� ���
- ���̺�� ������
- �ʿ��� ������ ���� ���̺� �л�� ���
- ���̺��� ��� �ڷῡ ���� ������ �����ϰ� �ʿ��� �ڷḸ�� �����ϴ� ���

(�������)
    CREATE [OR REPLACE] VIEW ���̸� [(�÷� list)]
    -- [OR REPLACE] ������� �ǹ�
    -- VIEW �̸� ���� �켱����: 1.(�÷� list)  2.SELECT���� AS��  3.SELECT���� �÷���
    AS
      SELECT ��
      [WITH CHECK OPTION] -- VIEW���� �ش������� INSERT, UPDATE, DELECT �Ҽ� ����.
      [WITH READ ONLY]; -- �б�����(������ �����Ǵ°��� �����ϱ� ����)
      
      -- [WITH CHECK OPTION]�� [WITH READ ONLY]�� ���ÿ� ��� �� �� ����.


��뿹) ȸ�����̺��� ���ϸ����� 2000�̻��� ȸ���� ȸ����ȣ, �̸�, ����, ���ϸ����� ������ �並 �����Ͻÿ�

        -- VIEW�� �̸� �����Ͽ� �����
        CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
        AS
            SELECT MEM_ID AS ȸ����ȣ, 
                    MEM_NAME AS �̸�, 
                    MEM_JOB AS ����, 
                    MEM_MILEAGE AS ���ϸ���
            FROM MEMBER
            WHERE MEM_MILEAGE >=2000;
            
            
        SELECT * FROM V_MEM;
            
            
            
        -- ��Ī���� VIEW����(�����)
        CREATE OR REPLACE VIEW V_MEM
        AS
            SELECT MEM_ID AS ȸ����ȣ, 
                    MEM_NAME AS �̸�, 
                    MEM_JOB AS ����, 
                    MEM_MILEAGE AS ���ϸ���
            FROM MEMBER
            WHERE MEM_MILEAGE >=2000;
            
            
        SELECT * FROM V_MEM;
        
        
        --���̺������ VIEW����(�����)
        CREATE OR REPLACE VIEW V_MEM
        AS
            SELECT MEM_ID, 
                    MEM_NAME, 
                    MEM_JOB, 
                    MEM_MILEAGE
            FROM MEMBER
            WHERE MEM_MILEAGE >=2000;
            
            
        SELECT * FROM V_MEM;
        
        
        
        
��뿹) ������ �� V_MEM���� 'r001'ȸ���� ���ϸ����� 500���� �����Ͻÿ�

--�������̺� ����Ǵ� ���
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
            SELECT MEM_ID AS ȸ����ȣ, 
                    MEM_NAME AS �̸�, 
                    MEM_JOB AS ����, 
                    MEM_MILEAGE AS ���ϸ���
              FROM MEMBER
             WHERE MEM_MILEAGE >=2000
            WITH CHECK OPTION;
            
            
     
-- �������� �����ϴ� ���·� �����Ұ���
��뿹) �� V_MEM�� 'r001'ȸ���� ���ϸ����� 1500���� �����Ͻÿ�.       
            
        SELECT * FROM V_MEM;
        
        --SQL ����: ORA-00904: "ȸ����ȣ": invalid identifier ( WITH CHECK OPTION ���� )
         UPDATE V_MEM
            SET ���ϸ��� = 1500
         WHERE ȸ����ȣ = 'r001';
         
         

 --�������̺��� �����ϸ� view�� �ڵ����� �ݿ��ȴ�.
** 'n001'ȸ���� ���ϸ����� 2500���� �����Ͻÿ�
         UPDATE MEMBER
            SET MEM_MILEAGE = 2500
         WHERE MEM_ID = 'n001';

        
 ** ȸ�����̺��� 'f001'ȸ���� ���ϸ����� 1500���� �����Ͻÿ�       
        UPDATE MEMBER
            SET MEM_MILEAGE = 1500
         WHERE MEM_ID = 'f001';
         

ROLLBACK;





    CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
        AS
        SELECT MEM_ID AS ȸ����ȣ, 
                MEM_NAME AS �̸�, 
                MEM_JOB AS ����, 
                MEM_MILEAGE AS ���ϸ���
          FROM MEMBER
         WHERE MEM_MILEAGE >=2000
        WITH READ ONLY; --�б�����
            
            
    SELECT * FROM V_MEM;
    
    
 ** ������ �� V_MEM�� ��� �ڷḦ �����Ͻÿ�.
 DELETE FROM V_MEM;
 
 
** VIEW���� ������ ��
  (1) VIEW ������ WITH���� ����� ���������� �ο��� ��� ORDER BY�� ���Ұ�.
  (2) VIEW ������ �����Լ��� ���� ��� �信 INSERT, UPDATE, DELETE�� ����� �� ����
  (3) VIEW�� �÷��� ǥ���� (CASE~WHEN)�̳� �Լ��� ���� ��� �÷��߰� �Ǵ� ������ �Ұ�
  (4) Pseudo Column(CURVAL, NEXTVAL ��) ���Ұ�
  
��뿹)
    CREATE OR REPLACE VIEW V_CART
    AS
        SELECT CART_PROD AS CID,
                COUNT(*) AS CNT
          FROM CART
         WHERE CART_NO LIKE '200505%'
         GROUP BY CART_PROD
         ORDER BY 1;
         
         
        SELECT * FROM V_CART;
        
        --SQL ����: ORA-01732: data manipulation operation not legal on this view
        --���������� ������ ����Ǿ����� ���ٴ� ��
        UPDATE V_CART
            SET CNT = 10
         WHERE CID='P101000001';
        
 
 
 ��뿹) 
    CREATE OR REPLACE VIEW V_MEM02
    AS
    SELECT MEM_ID AS MID,
           MEM_NAME AS NMAME,
           CASE WHEN SUBSTR(MEM_REGNO2,1,1) ='1' OR
                     SUBSTR(MEM_REGNO2,1,1)= '3' THEN
                     '����'
            ELSE
                '����'
            END AS GUBUN
    FROM MEMBER;
 
 
 SELECT * FROM V_MEM02;
 
 
 --�����÷��� ���Ұ���(����)
 UPDATE V_MEM02
    SET GUBUN = '����ȸ��'
  WHERE GUBUN = '����';
 
 
    
