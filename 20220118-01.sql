2022-0118-01) TABLE JOIN
- �����ͺ��̽� ���迡 ����ȭ ������ �����ϸ� ���̺��� ��Ȱ�ǰ� �ʿ��� �ڷḦ 
  ��ȸ�ϱ� ���� �������� ���̺��� ������ �÷��� �������� ���꿡 �����ؾ��� => ���ο���
- ������ ������ ���̽��� �⺻����
- ����
  . ��������(INNER JOIN)�� �ܺ�����(OUTER JOIN)
  . �Ϲ����ΰ� ANSI JOIN
  . ��������(EQUI JOIN)�� �񵿵�����(NON EQUI JOIN)
  
-- ��������: ��������(ǥ���ϴ� �������� ����)�� �������� ��. 
       -- �����ڷ�� ��� ������/ 80~90%�� ��κ� ����������
-- �ܺ�����: �������� �������� ��(NULL���� ä���� ä��)
-- �Ϲ�����: Ư�� DBMS�� ���� Ưȭ�� ����
-- ANSI JOIN: �̱�ǥ������ȸ���� ������ ������ ����/���DBMS���� ���밡��
-- ��������: (=) ���Ǿ����� �����ڿ� ���� ������(95% ��κ��� ����������)
-- �񵿵�����(<,>,<=,>=)



1. cartesian Prodrct
  - ���������� �����Ǿ��ų� �߸������ ���
  - ANSI JOIN ������ cross join�̶����
  - ������ ����� �־��� ��� ���Ǽ��� ���� ����� ���� ���� ���Ѱ�� ��ȯ
  - �Ұ����ϰ� �ʿ��� ��찡 �ƴϸ� ������� ���ƾ� ��
  
(�������)
SELECT �÷� list
   FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2][,���̺��3 [��Ī3],...]
  WHERE ��������1
   [AND ��������2,...]
   [AND �Ϲ�����]
   
   
(CROSS JOIN�� ����)  
SELECT �÷� list
   FROM ���̺��1 [��Ī1]
 CROSS JOIN ���̺��2[��Ī2]
 CROSS JOIN ���̺��3[��Ī3]
                :
 [WHERE �Ϲ�����]; 
 
 
 (��뿹)
 SELECT COUNT(*) FROM CART;
 SELECT COUNT(*) FROM PROD;
 SELECT 207*74 FROM DUAL;
 
 
 --īŸ�þ� ����, �����־��� ���
 SELECT *
    FROM CART, PROD; 
    

SELECT *
    FROM CART, PROD
  WHERE CART_QTY != PROD_QTYSALE;    
 
 

 SELECT COUNT(*)
    FROM CART
  CROSS JOIN PROD;
  
  
 SELECT COUNT(*)
    FROM CART, PROD, BUYPROD;

 SELECT COUNT(*)
    FROM CART
  CROSS JOIN PROD
  CROSS JOIN BUYPROD; 

-- N���� ���̺��� ���Ǿ����� �ּ� N-1���� ���� ������ ���������
-- �Ϲ�����, �������� ���� ��� ����



2. Equi Join
 - �������ǹ��� �������('=')�� ���
 - ���� ���̺��� ���� N���϶� ���������� ��� N-1�� �̻� �̾�� ��
 - ANSI������ INNER JOIN����� �ǰ���
 
 (�������-�Ϲ� ���ι�)
 SELECT [���̺��.|���̺�Ī.]�÷��� [AS �÷���Ī][,]
                        :
        [���̺��.|���̺�Ī.]�÷��� [AS �÷���Ī]
    FROM ���̺��[��Ī], ���̺��[��Ī[,���̺��[��Ī],...]
  WHERE ��������
   [AND ��������]
        : 
   [AND �Ϲ�����];
   
   
   
   
(�������-ANSI ���ι�)
 SELECT [���̺��.|���̺�Ī.]�÷��� [AS �÷���Ī][,]
                        :
        [���̺��.|���̺�Ī.]�÷��� [AS �÷���Ī]
    FROM ���̺��1[��Ī]
    INNER JOIN ���̺��2[��Ī] ON (��������[AND �Ϲ�����]) --INNER JOIN�� ������ �Ϲ������� AND�ڿ� ������ ���
    [INNER JOIN ���̺��3[��Ī] ON (��������[AND �Ϲ�����])]
  [WHERE �Ϲ�����];
  - ���̺�� 1�� ���̺��2�� �ݵ�� ���� �����ؾ���
  
  
��뿹) ��ǰ���̺�� �з����̺��� �̿��Ͽ� �ǸŰ��� 10���� �̻��� ��ǰ�� ��ȸ�Ͻÿ�. 
        -- �ǸŰ��� 10���� �̻��� => �Ϲ�����
        Alias�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �з���, �ǸŰ�
        
        (�Ϲ� JOIN)
        SELECT A.PROD_ID AS ��ǰ�ڵ�, 
                A.PROD_NAME AS ��ǰ��, 
                A.PROD_LGU AS �з��ڵ�, 
                B.LPROD_NM AS �з���, 
                A.PROD_PRICE AS �ǸŰ�
            FROM PROD A, LPROD B
          WHERE A.PROD_PRICE>=100000 --�Ϲ�����
            AND A.PROD_LGU = B.LPROD_GU --��������( EQUI���� )
         ORDER BY 5 DESC;
         
         
         (ANSI JOIN)
          SELECT A.PROD_ID AS ��ǰ�ڵ�, 
                A.PROD_NAME AS ��ǰ��, 
                A.PROD_LGU AS �з��ڵ�, 
                B.LPROD_NM AS �з���, 
                A.PROD_PRICE AS �ǸŰ�
            FROM PROD A
          INNER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU AND
                        A.PROD_PRICE>=100000)
                ORDER BY 5 DESC;
         
         
         
         
         
��뿹) 2005�� 6�� ȸ���� ������Ȳ�� ��ȸ�Ͻÿ�
        Alias�� ȸ����ȣ, ȸ����, ���űݾ��հ��հ�
        
        (�Ϲ� ����)
        SELECT A.CART_MEMBER AS ȸ����ȣ, 
               B.MEM_NAME AS ȸ����, 
               SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ��հ�
            FROM CART A, MEMBER B, PROD C
        WHERE A.CART_PROD = C.PROD_ID AND  --��������: �ǸŴܰ� ����
              A.CART_MEMBER = B.MEM_ID AND --��������: ȸ���� ����
              A.CART_NO LIKE'200506%'
          GROUP BY A.CART_MEMBER, B.MEM_NAME;
          
          
          
        (ANSI����)
        SELECT A.CART_MEMBER AS ȸ����ȣ, 
               B.MEM_NAME AS ȸ����, 
               SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ��հ�
            FROM CART A
            INNER JOIN MEMBER B ON(MEM_ID=CART_MEMBER)
            INNER JOIN PROD C ON(CART_PROD=PROD_ID)
            WHERE CART_NO LIKE '200506%'
            GROUP BY A.CART_MEMBER, B.MEM_NAME;
            
            
            
            
            
��뿹) �μ��� �ο����� ����ӱ��� ��ȸ�Ͻÿ�.
       Alias �μ��ڵ�, �μ���, �ο���, ����ӱ�
       
       
       
       (�Ϲ�����)
       SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
              B.DEPARTMENT_NAME AS �μ���, 
              COUNT(*) AS �ο���, 
              ROUND(AVG(A.SALARY)) AS ����ӱ�
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
            ORDER BY 1;
      

       (ANSI����)
      SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
              B.DEPARTMENT_NAME AS �μ���, 
              COUNT(*) AS �ο���, 
              ROUND(AVG(A.SALARY)) AS ����ӱ�
            FROM HR.EMPLOYEES A
            INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
            GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
            ORDER BY 1;
            
            
            
       
            
����) 2005�� 1�� ~ 6�� �� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�.
     Alias�� �ŷ�ó �ڵ�, �ŷ�ó��, ���Աݾ��հ�
        
        (�Ϲ�����)
        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
               A.BUYER_NAME AS �ŷ�ó��,
               SUM(B.BUY_COST) AS �ŷ��ݾ��հ�
          FROM BUYER A, BUYPROD B, PROD C
          WHERE A.BUYER_ID = C.PROD_BUYER
                AND B.BUY_PROD=C.PROD_ID
                AND B.BUY_DATE BETWEEN TO_DATE(20050101) AND LAST_DAY(TO_DATE(20050601))
            GROUP BY A.BUYER_ID, A.BUYER_NAME
            ORDER BY 1;
          
   
        (ANSI����)
          SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
               A.BUYER_NAME AS �ŷ�ó��,
               SUM(B.BUY_COST) AS �ŷ��ݾ��հ�
          FROM BUYER A
            INNER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER)
            INNER JOIN BUYPROD B ON(B.BUY_PROD=C.PROD_ID)
            WHERE B.BUY_DATE BETWEEN TO_DATE(20050101) AND LAST_DAY(TO_DATE(20050601))
            GROUP BY A.BUYER_ID, A.BUYER_NAME
            ORDER BY 1;


����) 2005�� 4�� ~ 6�� �� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
     Alias ��ǰ�ڵ�, ��ǰ��, ��������հ�, ����ݾ��հ��̴�.
     
     SELECT A.PROD_ID AS ��ǰ�ڵ�, 
            A.PROD_NAME AS ��ǰ��, 
            COUNT(*) AS ��������հ�, 
            SUM(A.PROD_PRICE*B.CART_QTY) AS ����ݾ��հ�
        FROM PROD A, CART B
      WHERE A.PROD_ID = B.CART_PROD AND
       TO_DATE(SUBSTR(B.CART_NO,1,8)) BETWEEN TO_DATE(20050401) AND LAST_DAY(TO_DATE(20050601)) 
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
     


����) 2005�� 4�� ~ 6�� �� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
     Alias ��ǰ�ڵ�, ��ǰ��, ���Լ����հ�, ���Աݾ��հ��̴�.
     
        SELECT A.PROD_ID AS ��ǰ�ڵ�, 
            A.PROD_NAME AS ��ǰ��, 
            SUM(BUY_QTY) AS ���Լ����հ�, 
            SUM(B.BUY_QTY*A.PROD_COST) AS ���Աݾ��հ�
        FROM PROD A, BUYPROD B
      WHERE A.PROD_ID = B.BUY_PROD AND
       B.BUY_DATE BETWEEN TO_DATE(20050401) AND LAST_DAY(TO_DATE(20050601)) 
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
     
     
����) 2005�� 4�� ~ 6�� �� ��ǰ�� ����/������Ȳ�� ��ȸ�Ͻÿ�.
     Alias ��ǰ�ڵ�, ��ǰ��, ���Աݾ��հ�, ����ݾ��հ��̴�.

    (�Ϲ�����)
      SELECT A.PROD_ID AS ��ǰ�ڵ�, 
            A.PROD_NAME AS ��ǰ��, 
            SUM(B.BUY_QTY*A.PROD_COST) AS ���Աݾ��հ�, 
            SUM(A.PROD_PRICE*C.CART_QTY) AS ����ݾ��հ�
        FROM PROD A, BUYPROD B, CART C
      WHERE A.PROD_ID = B.BUY_PROD AND
            A.PROD_ID = C.CART_PROD AND
       B.BUY_DATE BETWEEN TO_DATE(20050401) AND LAST_DAY(TO_DATE(20050601)) AND 
       TO_DATE(SUBSTR(C.CART_NO,1,8)) BETWEEN TO_DATE(20050401) AND LAST_DAY(TO_DATE(20050601)) 
       --����� ��¥�� �ι� ��ø��
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
      
      
      
      (ANSI ����)
      SELECT A.PROD_ID AS ��ǰ�ڵ�, 
            A.PROD_NAME AS ��ǰ��, 
            SUM(B.BUY_QTY*A.PROD_COST) AS ���Աݾ��հ�, 
            SUM(A.PROD_PRICE*C.CART_QTY) AS ����ݾ��հ�
        FROM PROD A
        INNER JOIN BUYPROD B ON(A.PROD_ID = B.BUY_PROD AND 
                    B.BUY_DATE BETWEEN TO_DATE(20050401) AND LAST_DAY(TO_DATE(20050601)))
        INNER JOIN CART C ON(A.PROD_ID = C.CART_PROD AND 
                    TO_DATE(SUBSTR(C.CART_NO,1,8)) BETWEEN TO_DATE(20050401) AND LAST_DAY(TO_DATE(20050601)) )   
                     --����� ��¥�� �ι� ��ø��
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;


          -- ��������-----------------------------------------------------
  
  SELECT A.PROD_ID AS ��ǰ�ڵ�,
           A.PROD_NAME AS ��ǰ��,
           BSUM AS ���Աݾ��հ�,
           CSUM AS ����ݾ��հ�
      FROM PROD A,
           (SELECT CC. BUY_PROD AS BID,
                   SUM(CC.BUY_QTY * CC.BUY_COST) AS BSUM
              FROM PROD BB, BUYPROD CC
             WHERE BB.PROD_ID = CC.BUY_PROD
               AND CC.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
             GROUP BY CC.BUY_PROD) B,
           (SELECT CC.CART_PROD AS CID,
                   SUM(CC.CART_QTY * BB.PROD_PRICE) AS CSUM
              FROM CART CC, PROD BB
             WHERE CC.CART_PROD = BB.PROD_ID
               AND TO_DATE(SUBSTR(CC.CART_NO,1,8)) BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
             GROUP BY CC.CART_PROD) C          
     WHERE A.PROD_ID = B.BID
       AND A.PROD_ID = C.CID    
    ORDER BY 1;
    
    ----------------------------------------------------------   
