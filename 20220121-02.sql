2022-0121-02) SUBQUERY
- SQL�����ȿ� �� �ٸ� SELECT���� �����ϴ� ���
- JOIN�̳� ���⵵�� �����ϱ� ���� ���
- ��� SUBQUERY ���� ()�ȿ� ����ؾ���. ��, INSRT���� ���Ǵ� SUBQUERY�� ����
- �������� WHERE�� ��� �����ڿ� ���� ���ɶ� �ݵ�� ������ �����ʿ� ��ġ                   
--���������� ������ ������ �����ʿ� �´�.
- ���������� �з�
  . ��� ��ġ�� ����: �Ϲݼ�������(SELECT ��), ��ø��������(WHERE ��), In-line��������(FROM ��) 
                    --WHERE�� FROM�� ���Ǵ� ���������� ��뼺�� ����.
  . ������������ ���迡 ����: ���ü� ���� ��������(���������� ���� ���̺�� JOIN ���� ������ ��������), 
                          ���ü� �ִ� ��������(���������� ���� ���̺�� JOIN ���� ����� ��������)
  . ��ȯ�Ǵ� ��/���� ����: ���Ͽ�|���߿�/������|������
                        �������� => ���Ǵ� �����ڿ� ���� ����
- �˷����� ���� ���ǿ� �ٰ��� ������ �˻��ϴ� SELECT�� � Ȱ��
- ���������� ����Ǳ� ���� �ѹ� ����ȴ�.



��뿹) ������̺��� ������� ����ӱݺ��� ���� �޿��� 
        �޴� ������� �����ȣ, �����, �μ��ڵ� ,�޿��� ��ȸ�Ͻÿ� 
        
        (FROM���� ����ϴ� In-line VIEW ��������)
        
        (��������: -- ������� �����ȣ, �����, �μ��ڵ� ,�޿��� ��ȸ )
        SELECT A.EMPLOYEE_ID AS �����ȣ, 
               A.EMP_NAME AS �����, 
               A.DEPARTMENT_ID AS �μ��ڵ�, 
               A.SALARY AS �޿�
          FROM HR.EMPLOYEES A,(����ӱ�) B
        WHERE A.SALARY > B.����ӱ�
        ORDER BY 3;
          
        (��������: -- ����ӱ��� ���ϴ°� )
        SELECT AVG(SALARY) AS ASAL 
          FROM HR.EMPLOYEES



        (���μ��� ����) - In-line VIEW
        SELECT A.EMPLOYEE_ID AS �����ȣ, 
               A.EMP_NAME AS �����, 
               A.DEPARTMENT_ID AS �μ��ڵ�, 
               A.SALARY AS �޿�
          FROM HR.EMPLOYEES A,(SELECT AVG(SALARY) AS ASAL --������ ��������
                                 FROM HR.EMPLOYEES) B
        WHERE A.SALARY > B.ASAL
        ORDER BY 3;



        (��ø��������)
        SELECT EMPLOYEE_ID AS �����ȣ, 
               EMP_NAME AS �����, 
               DEPARTMENT_ID AS �μ��ڵ�, 
               SALARY AS �޿�
          FROM HR.EMPLOYEES
        WHERE SALARY > (SELECT AVG(SALARY) --������ ��������
                          FROM HR.EMPLOYEES)
        ORDER BY 3;

-- �ζ��� ���������� 1���� ����, ��ø���������� �ݺ��ؼ� ����
-- JAVA�� ����ȭ �ڵ���


��뿹) ȸ�����̺��� ȸ���� ������ �ִ븶�ϸ����� �����ִ� ȸ�������� ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���
        
        (��������: ȸ����ȣ, ȸ����, ����, ���ϸ��� ��ȸ)
        SELECT MEM_ID AS ȸ����ȣ, 
                MEM_NAME AS ȸ����, 
                MEM_JOB AS ����, 
                MEM_MILEAGE AS ���ϸ���
          FROM MEMBER
        WHERE (MEM_JOB,MEM_MILEAGE) = (��������) --������ ���ϱ�
        
        (��������: ȸ���� ������ �ִ� ���ϸ���)
        SELECT MEM_JOB,
            MAX(MEM_MILEAGE)
          FROM MEMBER
        GROUP BY MEM_JOB
        
        
        (����)
        SELECT MEM_ID AS ȸ����ȣ, 
                MEM_NAME AS ȸ����, 
                MEM_JOB AS ����, 
                MEM_MILEAGE AS ���ϸ���
          FROM MEMBER
        WHERE (MEM_JOB,MEM_MILEAGE) IN (SELECT MEM_JOB, --��ø��������
                                             MAX(MEM_MILEAGE)
                                         FROM MEMBER
                                        GROUP BY MEM_JOB); --1:N���� ���ϰ� �����Ƿ� �񱳿�����(=)�� �񱳺Ұ�
        -- ������ ��������
        -- ������ �߻����� �ʾ����Ƿ� ������ ����.
        
        
        
        
        
        (EXISTS ������ ����� ���� ������ ���)
        SELECT A.MEM_ID AS ȸ����ȣ, 
               A.MEM_NAME AS ȸ����, 
               A.MEM_JOB AS ����, 
               A.MEM_MILEAGE AS ���ϸ���
          FROM MEMBER A
        WHERE EXISTS (SELECT B.BMILE --SELECT���� ����� �͵� ��������� ���� 1�� ����.
                        FROM (SELECT MEM_JOB,
                                     MAX(MEM_MILEAGE) AS BMILE
                                FROM MEMBER
                           GROUP BY MEM_JOB)B
        WHERE A.MEM_JOB = B.MEM_JOB
          AND A.MEM_MILEAGE = B.BMILE); 
        --���������� ����� �� �ϳ��� ������ ����� ���̴�(IN�� �Ȱ���) 






��뿹) ��ǰ���̺��� ��ǰ�� �ǸŰ��� ����ǸŰ����� ū ��ǰ�� ��ȸ�Ͻÿ�
       Alias�� ��ǰ��ȣ, ��ǰ��, �ǸŰ�, ����ǸŰ�
      
      SELECT A.PROD_ID AS ��ǰ��ȣ, 
             A.PROD_NAME AS ��ǰ��, 
             A.PROD_PRICE AS �ǸŰ�, 
             ROUND(B.PRICE) AS ����ǸŰ�
        FROM PROD A, (SELECT AVG(PROD_PRICE) AS PRICE
                        FROM PROD) B
        WHERE A.PROD_PRICE > B.PRICE
        ORDER BY 1;
      
      
      
��뿹) ��ٱ������̺��� ȸ���� �ִ� ���ż����� ����� ��ǰ�� ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ, ȸ����, ��ǰ��, ���ż���

        (EXISTS��� �̿ϼ�)
        SELECT A.CART_MEMBER AS ȸ����ȣ, 
               C.MEM_NAME AS ȸ����, 
               D.PROD_NAME AS ��ǰ��, 
               A.CART_QTY AS ���ż���
          FROM CART A, MEMBER C, PROD D
        WHERE EXISTS (SELECT 1
                        FROM (SELECT CART_MEMBER,
                                     MAX(CART_QTY) AS CARQT
                                FROM CART
                               GROUP BY CART_MEMBER) B
                       WHERE A.CART_QTY = B.CARQT)
              AND A.CART_MEMBER = C.MEM_ID 
              AND A.CART_PROD = D.PROD_ID
        ORDER BY 1;

           
            
            
��뿹) ��ٱ������̺��� ȸ���� �ִ� ���ż����� ����� ��ǰ�� ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ, ȸ����, ��ǰ��, ���ż���         
            
      (��ø�������� ���)      
      SELECT A.CART_MEMBER AS ȸ����ȣ, 
               C.MEM_NAME AS ȸ����, 
               D.PROD_NAME AS ��ǰ��, 
               A.CART_QTY AS ���ż���
          FROM CART A, MEMBER C, PROD D
         WHERE (A.CART_MEMBER, A.CART_QTY) IN ( SELECT CART_MEMBER,
                                                MAX(CART_QTY) AS CAQTY
                                            FROM CART
                                            GROUP BY CART_MEMBER ) AND
                A.CART_MEMBER = C.MEM_ID 
                AND A.CART_PROD = D.PROD_ID
        ORDER BY 1;
            
            
            
            
         (�ٸ����)   
        SELECT A.CART_MEMBER AS ȸ����ȣ, 
               C.MEM_NAME AS ȸ����, 
               D.PROD_NAME AS ��ǰ��, 
               A.CART_QTY AS ���ż���
          FROM CART A, MEMBER C, PROD D
         WHERE  A.CART_MEMBER = C.MEM_ID 
            AND A.CART_PROD = D.PROD_ID
            AND A.CART_QTY = ( SELECT MAX(D.CART_QTY) AS CAQTY
                                FROM CART D
                               WHERE D.CART_MEMBER = A.CART_MEMBER )
        ORDER BY 1;
        
        
            
              






                        