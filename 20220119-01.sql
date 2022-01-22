2022-01190-01)

����) ������̺� ���� �̿��Ͽ� �̱����� ��ġ�� �μ��� ������� ����ӱ��� ��ȸ�Ͻÿ�.
    Alias�� �μ���ȣ, �μ���, �����, ����ӱ��̴�.
    
    SELECT A.DEPARTMENT_ID AS �μ���ȣ, 
           B.DEPARTMENT_NAME AS �μ���, 
           COUNT(*) AS �����, 
           ROUND(AVG(A.SALARY)) AS ����ӱ�
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.COUNTRIES D
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID 
       AND B.LOCATION_ID = C.LOCATION_ID
       AND C.COUNTRY_ID = D.COUNTRY_ID AND LOWER(D.COUNTRY_NAME) LIKE '%america%'
       GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
       ORDER BY 1;
       
       
       
       ����) ��ٱ��� ���̺�(CART)���� 2005�� �����ڷḦ �м��Ͽ� �ŷ�ó��, ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
            Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ��, �������, ����ݾ�
            
            
            (�Ϲ�����)
            SELECT C.BUYER_ID AS �ŷ�ó�ڵ�, 
                   C.BUYER_NAME AS �ŷ�ó��, 
                   B.PROD_NAME AS ��ǰ��, 
                   SUM(A.CART_QTY) AS �������, 
                   SUM(A.CART_QTY*B.PROD_PRICE) AS ����ݾ�
              FROM CART A, PROD B, BUYER C
             WHERE A.CART_PROD = B.PROD_ID
                AND C.BUYER_ID = B.PROD_BUYER AND SUBSTR(CART_NO,1,4) = '2005'
            GROUP BY C.BUYER_ID, B.PROD_NAME, C.BUYER_NAME
             ORDER BY 1;
       
       
       
          (ANSI����)
           SELECT C.BUYER_ID AS �ŷ�ó�ڵ�, 
                   C.BUYER_NAME AS �ŷ�ó��, 
                   B.PROD_NAME AS ��ǰ��, 
                   SUM(A.CART_QTY) AS �������, 
                   SUM(A.CART_QTY*B.PROD_PRICE) AS ����ݾ�
              FROM CART A
              INNER JOIN PROD B ON(A.CART_PROD = B.PROD_ID)
              INNER JOIN BUYER C ON(C.BUYER_ID = B.PROD_BUYER AND SUBSTR(CART_NO,1,4) = '2005')
            GROUP BY C.BUYER_ID, B.PROD_NAME, C.BUYER_NAME
             ORDER BY 1;
             
            
         
         
             
             
             
       