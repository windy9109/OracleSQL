** �����Լ�(RANK OVER)
 - Ư���÷��� �������� ����ȭ ��Ű�� ����ο�
 - �׷�ȿ����� �����ο�
 - RANK OVER, DENSE_RANK ���� �ִ�.
 

 
 1) RANK
 . ������ �ο�
 . ���� ���� ���� ������ �ο��ϰ� �� ������ �ߺ��� ������ŭ ������ �����Ͽ� �ο�(ex 1,2,2,2,5,6....)
 . SELECT ���� ���
 (�������)
 RANK() OVER(ORDER BY �÷��� [ASC|DESC]) [AS ��Ī]
 - '�÷���'�� �������� ����ο�
 
 
 
 
 
 
 
 ��뿹)2005�� 5�� ���Աݾ��� ���� 5���� ȸ���� ��ȸ�Ͻÿ�.
      Alias�� ȸ����ȣ,ȸ����,���űݾ�
 
 
(����) --����Ȯ
    SELECT A.CART_MEMBER AS ȸ����ȣ, 
           B.MEM_NAME AS ȸ����, 
           SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ�
      FROM CART A, MEMBER B, PROD C
    WHERE A.CART_MEMBER = B.MEM_ID
      AND A.CART_PROD = C.PROD_ID
      AND ROWNUM <=5
    GROUP BY A.CART_MEMBER,B.MEM_NAME
    ORDER BY 3 DESC;
    
    
    
       
(�������� ���) --����
    
    (��������: 2005�� ȸ���� ���űݾ� ���, ���űݾ� ������ �������� ����)
    SELECT A.CART_MEMBER AS CID, 
           SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
      FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
      AND A.CART_NO LIKE '2005%'
    GROUP BY A.CART_MEMBER
    ORDER BY 2 DESC;
    
    
    (��������: ���űݾ��� ���� 5�� ��ȸ)
    SELECT M.MEM_ID AS ȸ����ȣ, 
           M.MEM_NAME AS ȸ����, 
           C.CSUM ���űݾ�
      FROM MEMBER M, (SELECT A.CART_MEMBER AS CID, 
                               SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                        FROM CART A, PROD B
                       WHERE A.CART_PROD = B.PROD_ID
                         AND A.CART_NO LIKE '2005%'
                    GROUP BY A.CART_MEMBER
                    ORDER BY 2 DESC)C
    WHERE M.MEM_ID = C.CID
      AND ROWNUM <= 5;
      
      
      
      
 ��뿹)2005�� ���űݾ��� ���� ȸ������ ����� �ο��Ͽ� ��ȸ�Ͻÿ�.
      Alias�� ȸ����ȣ,ȸ����,���űݾ�, ��� 
      
      SELECT A.CART_MEMBER AS ȸ����ȣ, 
             B.MEM_NAME AS ȸ����, 
             SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ�, 
             RANK() OVER(ORDER BY  SUM(A.CART_QTY*C.PROD_PRICE) DESC ) AS ��� 
        FROM CART A, MEMBER B, PROD C 
      WHERE A.CART_MEMBER = B.MEM_ID
        AND A.CART_PROD = C.PROD_ID
      GROUP BY A.CART_MEMBER,B.MEM_NAME;
  
  
  2) �׷쳻���� ����
  (�������)
  RANK()OVER(PARTITION BY �÷���[,�÷���,....]   
              ORDER BY �÷���[,�÷���,...][ASC|DESC]
  . PARTITION BY �÷���: �׷����� ���� �÷��� ���
  --GROUP BY�� ���� �ʱ� ���� PARTITION BY�� ����. ������ ���ϱ� ���� �׷�ȭ��
  
  ��뿹) ������̺��� �� �μ��� ������� �޿��� �������� ������ �ο��Ͽ� ����Ͻÿ�. 
         ������ �޿��� ���� ��� ������ �ο��ϰ� ���� �޿��̸� �Ի����� ���������� �ο��Ͻÿ�.
         Alias�� �����ȣ, �����, �μ���, �޿�, ����
         
         SELECT A.EMPLOYEE_ID AS �����ȣ, 
                A.EMP_NAME AS �����, 
                B.DEPARTMENT_NAME AS �μ���, 
                A.SALARY AS �޿�, 
                A.HIRE_DATE AS �Ի���,
                RANK() OVER(PARTITION BY A.DEPARTMENT_ID
                            ORDER BY A.SALARY DESC, HIRE_DATE ASC)����
           FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
         
         
3) DENSE_RANK()
- �����ο�
- ���� ���̸� ���� ������ �ο��ϸ�, �������� �������� ������ ������� ���� ���� �ο�(EX. 1,1,1,1,2,3,4,...)
- ������ Ư¡�� RANK()�� ����


4) ROW_NUMBER()
- �����ο�                      �� 9 9 9 8 7 6...
- ���� ���̶� �������� ���� �ο�(EX. 1,2,3,4,5,6,...)
- ������ Ư¡�� RANK()�� ����

��뿹)ȸ�����̺��� �������� '����'�� ȸ������ ���ϸ����� ��ȸ�ϰ� ���� ���� ������ �ο��Ͻÿ�


��뿹) ������̺��� �޿��� 5000������ ������� ��ȸ�ϰ� �޿��� ���� ������ �ο��Ͻÿ�
(RANK() �Լ����)
  SELECT EMPLOYEE_ID AS �����ȣ, 
         EMP_NAME AS �����, 
         DEPARTMENT_ID AS �μ��ڵ�, 
         SALARY AS �޿�, 
         RANK() OVER(ORDER BY SALARY DESC) AS ����
    FROM HR.EMPLOYEES
    WHERE SALARY<= 5000;
  
  
(DENSE_RANK() �Լ����)
  SELECT EMPLOYEE_ID AS �����ȣ, 
         EMP_NAME AS �����, 
         DEPARTMENT_ID AS �μ��ڵ�, 
         SALARY AS �޿�, 
         DENSE_RANK() OVER(ORDER BY SALARY DESC) AS ����
    FROM HR.EMPLOYEES
    WHERE SALARY<= 5000;
    
    
    
(ROW_NUMBER() �Լ����)
  SELECT EMPLOYEE_ID AS �����ȣ, 
         EMP_NAME AS �����, 
         DEPARTMENT_ID AS �μ��ڵ�, 
         SALARY AS �޿�, 
         ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ����
    FROM HR.EMPLOYEES
    WHERE SALARY<= 5000;    










           
           
           
  
  
  
  