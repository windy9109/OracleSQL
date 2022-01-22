2022-0114-01) �����Լ�(�׷��Լ�)
- �־��� �ڷḦ Ư�� �÷�(��)�� �������� �׷�ȭ�ϰ� �� �׷쿡�� �հ�(SUM), ���(AVG), �󵾼�(COUNT), �ִ밪(MAX), �ּҰ�(MIN)�� ��ȯ �ϴ� �Լ�
    
    - SELECT���� �����Լ��� ������ �Ϲ��÷��� ���� ���Ǹ� �ݵ�� GROUT BY ���� ���Ǿ����
    - �����Լ��� ���� �÷�(����)�� ������ �ο��� ���
      HAVING���� ó��
    - �����Լ����� �ٸ� �����Լ��� ���� �Ҽ� ����.
    
    
    (�������)
    SELECT [�÷� list,]
            �׷��Լ�
        FROM ���̺��
     [WHERE ����]
     [GROUP BY �÷���1][,�÷���2,...]
    [HAVING ����]
     [ORDER BY �÷���|�÷��ε���[ASC|DESC][,...]];
     . GROUP BY �÷���1[,�÷���2,...]:�÷���1�� �������� �׷�ȭ �ϰ� �� �׷쿡�� �ٽ� '�÷���2'�� �׷�ȭ
     . SELECT���� ���� �Ϲ��÷��� �ݵ�� GROUP BY���� ����ؾ��ϸ�, SELECT���� ������ ���� �÷��� GROUP BY ���� �������
     . SELECT���� �׷��Լ��� ���� ��� GROUP BY�� ����(���̺� ��ü�� �ϳ��� �׷����� ����)
     . SUM(expr), AVG(expr), COUNT(*|expr), MIN(expr), MAX(expr)
     
     
     ��뿹) ������̺��� �� �μ��� �޿��հ踦 ���Ͻÿ�
            Alias�� �μ��ڵ�, �޿��հ�
            --�μ��� GROUP BY, ���� �ΰ����´ٸ� �÷���1�� GROUP BYȭ �Ŀ� �÷���2�� �߰� GROUP BY�Ѵ�.
            
            SELECT DEPARTMENT_ID AS �μ��ڵ�,
                    SUM(SALARY) AS �޿��հ�
                FROM HR.EMPLOYEES
             GROUP BY DEPARTMENT_ID
                ORDER BY 1;
        
           
     ��뿹) ������̺��� �� �μ��� �޿��հ踦 ���ϵ�
     �޿��հ谡 100000�̻��� �μ��� ��ȸ�Ͻÿ�.
            Alias�� �μ��ڵ�, �޿��հ�
            
            SELECT DEPARTMENT_ID AS �μ��ڵ�,
                    SUM(SALARY) AS �޿��հ�
                 FROM HR.EMPLOYEES
              -- WHERE SUM(SALARY)>=100000  =>�Ұ��� HAVING���� ������
              GROUP BY DEPARTMENT_ID
             HAVING SUM(SALARY)>=100000
                ORDER BY 1;
                
                
                
     ��뿹) ������̺��� �� �μ��� ��ձ޿��� ���Ͻÿ�
            Alias�� �μ��ڵ�, �μ���, ��ձ޿� --DEPARTMENTS�� EMPLOYEES�� DEPARTMENT_ID
             -- GROUP BY���� ��Ī�� ���� ����.
             
            SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
                   B.DEPARTMENT_NAME AS �μ���, 
                   ROUND(AVG(A.SALARY),1)��ձ޿�
               FROM HR.EMPLOYEES A, HR.DEPARTMENTS B  --���̺��� �ΰ������� JOIN������ϹǷ� WHERE�� �ݵ�� ����
              WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
              --GROUP BY DEPARTMENT_ID, DEPARTMENT_NAME -- DEPARTMENT_ID, DEPARTMENT_NAME�� ������ �ǹ� 
               GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
              ORDER BY 1;
        
    
    ��뿹) ��ǰ���̺��� �� �з��� ��ո��԰��� ��ȸ�Ͻÿ�
            --Alias�� �μ��ڵ�, �μ���, ����� 
            SELECT PROD_LGU AS �з��ڵ�,
                    ROUND(AVG(PROD_COST),-2) AS ��ո��԰�
              FROM PROD
            GROUP BY PROD_LGU;
            
            
    ��뿹)��ٱ������̺��� 2005�� 4�� ��ǰ�� �Ǹż������踦 ���Ͻÿ�.
    
    
    SELECT CART_PROD AS ��ǰ��, 
         SUM(CART_QTY) AS �Ǹż�������
        FROM CART
        WHERE SUBSTR(CART_NO,1,6) = '200504'
      GROUP BY CART_PROD
        ORDER BY 1;
    
    
    ��뿹)��ٱ������̺��� 2005�� 4�� ��ǰ�� �Ǹż��� �հ谡 10���̻��� �������踦 ���Ͻÿ�.
    
       SELECT CART_PROD AS ��ǰ��, 
         SUM(CART_QTY) AS �Ǹż����հ�
        FROM CART
        WHERE SUBSTR(CART_NO,1,6) = '200504'
      GROUP BY CART_PROD
        HAVING SUM(CART_QTY)>=10
      ORDER BY 1;
    
    
    ��뿹)�������̺��� 2005�� 1��~6�� �����������踦 ���Ͻÿ�.
        SELECT EXTRACT(MONTH FROM BUY_DATE) AS ��, --�Ʒ����� �̹� 2005�⵵�� �ɷ���
               SUM(BUY_QTY) AS ���Լ����հ�,
               SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�
            FROM BUYPROD
          WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
        GROUP BY EXTRACT(MONTH FROM BUY_DATE)
            ORDER BY 1;
            
         
         
    (����Ǯ��)   
            
    ��뿹)��ٱ������̺��� 2005�� 1��~6�� ����, ��ǰ�� ���Աݾ� �հ谡 1000���� �̻��� ������ ��ȸ�Ͻÿ�.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS ��,

  
  --����  
--        SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS ���Կ�,
--           B.PROD_NAME AS ��ǰ��,
--           SUM(A.BUY_COST*A.BUY_QTY) AS ���Աݾ��հ�
--    FROM BUYPROD A, PROD B
--    WHERE A.BUY_PROD = B.PROD_ID AND
--          EXTRACT(MONTH  FROM BUY_DATE) BETWEEN 1 AND 6
--    GROUP BY EXTRACT(MONTH FROM BUY_DATE), B.PROD_NAME
--   HAVING SUM(A.BUY_COST)>=1000000
--   ORDER BY 1;
    
    
    
    ��뿹)��ٱ������̺��� 2005�� 4�� ��ǰ�� ��ǰ�� �Ǹż��� �հ谡 50�� �̻��� ��ǰ�� ��ȸ�Ͻÿ�.
   
   
        
        
    ��뿹) ������̺��� �� �μ��� ������� ���Ͻÿ�
            Alias�� �μ��ڵ�, �μ���, ����� 
            

  
            
    ��뿹) ������̺��� �� �μ��� �ִ�޿��� �ּұ޿��� ���Ͻÿ�
            Alias�� �μ��ڵ�, �μ���, �ִ�޿�, �ּұ޿�
          
            
            
            
    ��뿹) ������̺��� �� �μ��� ��ձ޿��� ���Ͻÿ�
            Alias�� �μ��ڵ�, �μ���, ��ձ޿�
    
        -- ����
--    SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
--              B.DEPARTMENT_NAME AS �μ���,
--              ROUND(AVG(A.SALARY),1) AS ��ձ޿�
--        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
--       WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
--    GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
--    ORDER BY 1; 

            
   ----------------------------------------------------------------------         
            
            
            
            
            
            
            
    ����) ȸ�����̺��� ���� ���ϸ��� �հ踦 ���Ͻÿ�
         Alise�� ����, ���ϸ����հ� �̸� ���п��� '����ȸ��'�� '����ȸ��'�� ���
         
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                     SUBSTR(MEM_REGNO2,1,1)='3' THEN '����ȸ��'
           ELSE '����ȸ��' 
           END AS ����, 
          SUM(MEM_MILEAGE) AS ���ϸ����հ�
        FROM MEMBER
      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                     SUBSTR(MEM_REGNO2,1,1)='3' THEN '����ȸ��'
           ELSE '����ȸ��' 
           END;

         
            
    ����) ȸ�����̺��� ���ɴ뺰 ���ϸ��� �հ踦 ��ȸ�Ͻÿ�
        Alise�� ����, ���ϸ����հ��̸� ���ж����� '10��',..'70��'������ ���ɴ븦 ���
        
    
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                  SUBSTR(MEM_REGNO2,1,1)='2' THEN
                  ROUND((EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900))/10)*10
             ELSE ROUND((EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000))/10)*10 
             END || '��' AS ����, 
          SUM(MEM_MILEAGE) AS ���ϸ����հ�
        FROM MEMBER
      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                  SUBSTR(MEM_REGNO2,1,1)='2' THEN
                  ROUND((EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900))/10)*10
             ELSE ROUND((EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000))/10)*10
             END
        ORDER BY 1;
    
    
    --�ٸ���
   SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)||'��' AS ����, 
            SUM(MEM_MILEAGE) AS ���ϸ����հ�
       FROM MEMBER
   GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)
     ORDER BY 1;
     
    
    
         
    
    
��뿹) ��ü����� ��ձ޿��� ���
    
    SELECT ROUND(AVG(SALARY)) AS ��ձ޿�,
            SUM(SALARY) AS �޿��հ�,
            COUNT(*) AS �����
      FROM HR.EMPLOYEES;
    
    
    
    ��뿹)������� �޿��� ��ձ޿����� ������������� ��ȸ
          Alias�� �����ȣ, �����, �μ��ڵ�, �����ڵ�, �޿�, ��ձ޿� 
          --�����÷���ȸ�Ҷ��� GROUP BY�� �����ʰ� ���������� ����.
          
    SELECT A.EMPLOYEE_ID AS �����ȣ, 
           A.EMP_NAME AS �����, 
           A.DEPARTMENT_ID AS �μ��ڵ�, 
           A.JOB_ID AS �����ڵ�, 
           A.SALARY AS �޿�,
           B.ASAL AS ��ձ޿�
      FROM HR.EMPLOYEES A,
            (SELECT ROUND(AVG(SALARY)) AS ASAL FROM HR.EMPLOYEES)B 
            --���������� 1���� �����ϰ� ��������ϴ� ����
        WHERE A.SALARY < B.ASAL
      ORDER BY 1;
    

    
      
            
    
    
    
    
    
    
    
    
    