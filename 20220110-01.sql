2022-0110-01)

(3) BETWEEN ������ --Like�����ڿ��� ��¥������ ��� �Ұ���, ���� BETWEEN������ ���
- ������ �����Ͽ� �����͸� ���Ҷ� ���
- AND �����ڷ� ��ȯ ����

(�������)
�÷�|����   BETWEEN ��1 AND ��2




��뿹) ��ǰ���̺�(PROD)���� �ǸŰ���(PROD_PRICE)�� 10�������� 20���� ���̿� ���� ��ǰ������ ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �ǸŰ����̴�.
        
(AND ������ ���)
        
        SELECT PROD_ID AS ��ǰ�ڵ�,
                PROD_NAME AS ��ǰ��,
                PROD_LGU AS �з��ڵ�,
                PROD_PRICE AS �ǸŰ���
            FROM PROD
         WHERE PROD_PRICE >= 100000 AND PROD_PRICE <= 200000;
         
         
         
(BETWEEN ������ ���)
        SELECT PROD_ID AS ��ǰ�ڵ�,
                PROD_NAME AS ��ǰ��,
                PROD_LGU AS �з��ڵ�,
                PROD_PRICE AS �ǸŰ���
            FROM PROD
         WHERE PROD_PRICE 100000 BETWEEN 200000;
         
         
         
��뿹) ��ٱ��� ���̺�(CART)���� 2005�� 7���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�
        Alias�� ��¥, ��ǰ�ڵ�, �Ǹż����̴�.
        
        SELECT SUBSTR(CART_NO,1,8) AS ��¥,
                CART_PROD AS ��ǰ�ڵ�,
                CART_QTY AS �Ǹż���
            FROM CART
          WHERE SUBSTR(CART_NO,1,6)='200507'; -- ���� ��ȸ �ϹǷ� �� 6���ڸ� �����ص� ����(���ڿ� ����)
          
          
          
         
��뿹) ���� ���̺�(BUYPROD)���� 2005�� 2���� ���Ի�ǰ�� ��ȸ�Ͻÿ�
        Alias�� ��¥, ��ǰ�ڵ�, ���Լ���, ���Աݾ��̴�.
            
        SELECT  BUY_DATE AS ��¥, --��¥�� ��¥�� ���Ѵ�.
                BUY_PROD AS ��ǰ�ڵ�,
                BUY_QTY AS ���Լ���,
                BUY_QTY*BUY_COST AS ���Աݾ�
            FROM BUYPROD
          WHERE BUY_DATE BETWEEN '20050201' AND '20050228';
         --WHERE BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201');
         --�������� ������� �𸦶� ������ ��¥ LAST_DAYD�� ����.
        -- SELECT LAST_DAY('20050201') FROM DUAL;
                
    SELECT * FROM BUYPROD;
            
            
         
         
            
            
** ����̸��� ���� ���ο� �÷��� ����
    �÷��� : EMP_NAME VARCHAR2(50) <= FIRST_NAME,' ',LAST_NAME ����
    
    ALTER TABLE HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(50));
    
    UPDATE HR.EMPLOYEES
       SET EMP_NAME = FIRST_NAME||''||LAST_NAME;
        COMMIT;
        
        
        
��뿹) HR������ ������̺�(EMPLOYEES)���� 2006�� ������ �Ի��� ��������� ��ȸ�Ͻÿ�
        Alias�� �����ȣ, �����, �Ի���, �μ��ڵ�
        ��, ����� �Ի��� ������ ����Ұ�
        

        SELECT EMPLOYEE_ID AS �����ȣ, 
               EMP_NAME AS �����, 
               HIRE_DATE AS �Ի���, 
               JOB_ID AS �μ��ڵ�
            FROM HR.EMPLOYEES
        WHERE HIRE_DATE <= LAST_DAY('20051201') -- ��¥�� ���ڷ� ǥ���Ҷ��� ������� ���缭 ǥ���ϰ� �߰��� ��ȣ�� �����ʴ´�.
        -- WHERE HIRE_DATE <ANY '20060101'
        -- WHERE HIRE_DATE < '20060101'
         ORDER BY 3;
        
        COMMIT;
        
         
��뿹) ȸ�����̺�(MEMBER)���� '��'�� ~ '��'�� ���� ���� ȸ�� �� ���ϸ��� 2000�̻��� ȸ���� ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ, ȸ����, �ּ�, ���ϸ���
       �� ���������� ����Ͻÿ�.
       
       SELECT MEM_ID AS ȸ����ȣ, 
              MEM_NAME AS ȸ����, 
              MEM_ADD1 ||' '|| MEM_ADD2 AS �ּ�, 
              MEM_MILEAGE AS ���ϸ���
            FROM MEMBER
         WHERE SUBSTR(MEM_NAME,1,1) BETWEEN '��' AND '��' AND MEM_MILEAGE >=2000
         -- BETWEEN ����, ����, ��¥�� ��������
            ORDER BY 2;
         
       
(4)LIKE ������ 
--�ǵ��� �Ⱦ��°� ���� WHY? ����� ���� �����͸� �̾Ƴ�. ������ ����
- ���ڿ��� ������ ���Ҷ� ���
- ���Ϲ��ڿ�(���ϵ�ī��): %,_���
- '%':'%'�� ���� ��ġ���� �ڿ� �����ϴ� ��� ���ڿ��� ����
    ex) '��%':'��' ���� �����ϴ� ��� ���ڿ��� ����
        '%��':'��' ���� ������ ��� ���ڿ��� ����
        '%��%': ���ڿ� ���ο� '��' �̶�� ���ڿ��� ������ ����� ��(true)
        
- '_':'_'�� ���� ��ġ���� �ѱ��ڿ� ����
    ex) '��':'��' ���� �����ϰ� 2������ ���ڿ��� ����
        '_��': 2���ڷ� �����ǰ� '��'���� ������ ��� ���ڿ��� ����
        '_��_': 3�����̸鼭 �߰��� ���ڰ� '��'�� ���ڿ��� ����



��뿹) ��ٱ��� ���̺�(CART)���� 2005�� 7���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�. LIKE ������ ���
        Alias�� ��¥, ��ǰ�ڵ�, �Ǹż����̴�.

        SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥, --TO_DATE�� ��¥�������� ��ȯ
               CART_PROD AS ��ǰ�ڵ�, 
               CART_QTY AS �Ǹż���
            FROM CART
          WHERE CART_NO LIKE '200507%';
          
        
��뿹) ȸ�����̺��� �������� '�泲'�� ȸ���� ��ȸ �Ͻÿ�
       Alias�� ȸ����ȣ, ȸ����, �ּ�, ����, ���ϸ���
       
       SELECT MEM_ID AS ȸ����ȣ, 
              MEM_NAME AS ȸ����, 
              MEM_ADD1|| ' ' || MEM_ADD2 AS �ּ�, 
              MEM_JOB AS ����, 
              MEM_MILEAGE AS ���ϸ���
         FROM MEMBER
        WHERE MEM_ADD1 LIKE '�泲%';


��뿹) ȸ�����̺��� �������� '�泲'�̰ų� '����' ȸ���� ��ȸ �Ͻÿ�
       Alias�� ȸ����ȣ, ȸ����, �ּ�, ����, ���ϸ���
       
       SELECT MEM_ID AS ȸ����ȣ, 
              MEM_NAME AS ȸ����, 
              MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
              MEM_JOB AS ����, 
              MEM_MILEAGE AS ���ϸ���
          FROM MEMBER
        WHERE SUBSTR(MEM_ADD1,1,2) IN('�泲','����'); --ȿ������ ����
        --��ȿ���� ����
        --WHERE MEM_ADD1 LIKE '�泲%' AND MEM_ADD1 LIKE '����%'
        
��뿹) 2005�� 4�� ���Ի�ǰ�� �Ǹ������� ��ȸ�Ͻÿ�
       Alias�� ��ǰ�ڵ�, ��ǰ��, �����հ�, �ݾ��հ�

        
       SELECT A.BUY_PROD AS ��ǰ�ڵ�, 
              B.PROD_NAME AS ��ǰ��, 
              SUM(A.BUY_QTY) AS �����հ�, 
              SUM(A.BUY_QTY*B.PROD_COST) AS �ݾ��հ�
            FROM BUYPROD A, PROD B -- ���̺��� ��Ī ��밡��, ���̺� ��Ī�� �����ϰ� �ο�����. A,B,C,�� ����
        WHERE A.BUY_PROD = B.PROD_ID --JOIN ����
          AND A.BUY_DATE BETWEEN '20050401' AND LAST_DAY('20050401') --��¥�����Ϳ� LIKE�� ���� ����ȵ�! BETWEEN
        GROUP BY A.BUY_PROD, B.PROD_NAME
        ORDER BY 1;
        
        

        
        

