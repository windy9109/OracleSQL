2022-0113-01) ����ȯ�Լ�
  1)CAST(expr AS Ÿ�Ը�)
-- TO_CHAR, TO_NUMBER, TO_DATE
    - 'expr'�� ���ǵ� �÷� �Ǵ� ������ ������ Ÿ���� 'Ÿ�Ը�' �������� ��ȯ

��뿹) ��ٱ��� ���̺��� 2005�� 5�� �Ǹ������� ��ȸ�Ͻÿ�
        Alias�� ����,��ǰ��,����,�ݾ��̸� ���ڼ����� ����Ͻÿ�

    
SELECT CAST(SUBSTR(CART.CART_NO,1,8)AS DATE) AS ����,
       PROD.PROD_NAME AS ��ǰ��,
       CART.CART_QTY AS ����,
       CART.CART_QTY*PROD_PRICE AS �ݾ�
    FROM CART, PROD
  WHERE CART.CART_PROD = PROD.PROD_ID --��������
    AND CART.CART_NO LIKE '200505%'
  ORDER BY 1;
  
  
  2) TO_CHAR(expr[,fmt])
  - ���ڿ�(CHAR, CLOB=>VARCHAR2��), ����, ��¥ �ڷḦ ���ڿ� �ڷ�� ����ȯ
  - ����,��¥->����(O) / ����->����(X)
  - ��ȯ������ �����Ҷ����� 'fmt'(�����������ڿ�)�� ���
  - ��¥���� ���Ĺ��ڿ�
----------------------------------------------------------------------
    FORMAT              �ǹ�                    ��뿹
----------------------------------------------------------------------
    BC,AD            ����,�����        SELECT TO_CHAR(SYSDATE,'BC') FROM DUAL; --����̱⶧���� ����� ��µ�
    CC               ����              SELECT TO_CHAR(SYSDATE,'CC') FROM DUAL;
    YYYY,YYY,YY,Y    �⵵             SELECT TO_CHAR(SYSDATE,'YYYY'),
                                            TO_CHAR(SYSDATE,'YYY'), 
                                            TO_CHAR(SYSDATE,'YY'), 
                                            TO_CHAR(SYSDATE,'Y') --���ʺ��� �ϳ��� ����
                                        FROM DUAL; 
    MM              (01~12��)
    MON, MONTH      ��                SELECT TO_CHAR(SYSDATE,'MM'),
                                             TO_CHAR(SYSDATE,'MONTH'), --(���ڱ��� ���ԵǾ����)
                                             TO_CHAR(SYSDATE,'MON') --(���ڱ��� ���ԵǾ����)
                                        FROM DUAL;  
    DD              (01~31)��ǥ��
    DDD             (01~365)��ǥ��
    D               �� ���� ���� ��(�Ͽ��Ϻ��� 1)
    DY              '��'~'��'
    DAY             '������'~'�Ͽ���'     SELECT TO_CHAR(SYSDATE,'DD'), --�Ѵ�(31)�� ���� ���
                                               TO_CHAR(SYSDATE,'DDD'), -- 365��ǥ��
                                               TO_CHAR(SYSDATE,'D'), --���ϼ�����
                                               TO_CHAR(SYSDATE,'DY'),--�������(���)
                                               TO_CHAR(SYSDATE,'DAY') --�������
                                            FROM DUAL;
    WW              ���� ��(01~53)       SELECT TO_CHAR(SYSDATE, 'WW')
                                          FROM DUAL;
    AM, PM                              SELECT TO_CHAR(SYSDATE, 'PM') --SYSDATE�� ���� ����ð��� ���߾� ������ ��µȴ�.
                                          FROM DUAL;
    A.M., P.M.      ����,����
    HH, HH12, HH24  �ð�                 SELECT TO_CHAR(SYSDATE, 'HH')
                                          FROM DUAL;
    MI              ��
    SS              ��(01~60)
    SSSSS           ��(01~86000)         SELECT TO_CHAR(SYSDATE, 'HH:MI:SS'),
                                                TO_CHAR(SYSDATE, 'HH:MI:SSSSS')
                                          FROM DUAL;
                    --�Ϸ�� 86000��
  
  ----------------------------------------------------------------------
  
    SELECT TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8)))
      FROM CART
     WHERE CART_NO LIKE '200504%';
  
  --������Ʈ��
  SELECT TO_CHAR(CART_NO) 
    FROM CART;
  

  - ���ڰ��� ���Ĺ��ڿ�
----------------------------------------------------------------------
    FORMAT              �ǹ�                    ��뿹
----------------------------------------------------------------------
      9         �����Ǵ� ��ȿ�� 0�� ����ó��        99999 --��ȿ���ڸ� ������ ��ȿ���� ���
                                               01234
                                            ----------- 9(5)���
                                                1234
                                               
                                         SELECT TO_CHAR(12345,'9999999') AS AL
                                            FROM DUAL;
                                         
 
     0         �����Ǵ� ��ȿ�� 0�� '0'���� ���     99999 --��ȿ���ڸ� ������ ��ȿ���� ���
                                               01234
                                            ----------- 9(5)���
                                               01234
                                               
                                        SELECT TO_CHAR(12345,'0000000') AS AL
                                            FROM DUAL;


    PR      �ڷᰡ �����̸� <> �ȿ� ���       SELECT TO_CHAR(124,'99999PR'), --����� ���� ����
                                                 TO_CHAR(-124,'99999PR') --<124>
                                              FROM DUAL;

    ,(COMMA)        �ڸ���
    .(DOT)          �Ҽ���                 SELECT TO_CHAR(1234,'99,999.9PR'), --�ڸ�������
                                                 TO_CHAR(-1234,'99,999.0PR')
                                              FROM DUAL;

    $,L            ȭ���ȣ                 SELECT TO_CHAR(1234,'$99,999.9PR'),
                                                 TO_CHAR(-1234,'L99,999.0PR') --L�� ��ȭ ��ȣ ���
                                              FROM DUAL;
  ----------------------------------------------------------------------
  
    SELECT TO_NUMBER(TO_CHAR(1234,'99,9999.9'),'999999.9')+20
      FROM DUAL;



��뿹) ������ 2005�� 7�� 31���̰� ���θ� �������� ó�� �α��� �� ��� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�.
    
    SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||TRIM(TO_CHAR(1,'00000'))
        FROM DUAL;
   --TO_CHAR(1,'00000') ��ȯ���� ����
   
   
��뿹) ������ 2005�� 7�� 28���̰� ���θ��� ���Ӱ� �α��� �� ��� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�.

    SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
           TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000'))
       FROM CART
     WHERE SUBSTR(CART_NO,1,8) = TO_CHAR(SYSDATE,'YYYYMMDD');
    

3) TO_NUMBER(expr[,fmt])
    -���ڿ��� �����ڷ�� ��ȯ
    -��ȯ��ų �����ڷ�� ���ڷ� ��ȯ������ �ڷ��̾�� ��
    -'fmt'�� TO_CHAR���� ���ȰͰ� ����
    
    
        CREATE TABLE GOODS AS
        SELECT PROD_ID, PROD_NAME, PROD_LGU, PROD_PRICE
            FROM PROD;
        
    SELECT * FROM GOODS; 
    
��뿹) ��ǰ���̺�(GOODS)�� ���� �ڷḦ �߰��� ����Ͻÿ�
    ��ǰ��: �Ｚ ��Ʈ�� 15��ġ
    �ŷ�ó�ڵ�: P101000001
    �ǸŰ���: 1200000��
    
    ***(��ǰ�ڵ����)***
    
    INSERT INTO GOODS
    SELECT A.P_CODE, '�Ｚ��Ʈ�� 15��ġ', 'P101', 1200000
        FROM 
            (SELECT 'P101'
                ||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(PROD_ID),5))+1,'000000')) AS P_CODE
            --SELECT TO_CHAR(TO_NUMBER(SUBSTR(PROD_ID,4)),'0000')||TRIM(TO_CHAR(1,'000000')) 
                FROM GOODS
                WHERE PROD_LGU='P101') A;
                
    
    SELECT *FROM GOODS
        WHERE PROD_LGU ='P101';
    
    
    
    
    SELECT TO_NUMBER('��1,234','L99,999'),
            TO_NUMBER('<1,234>','99,999PR')+10
        FROM DUAL;
  
  
        
4)TO_DATE(expr[,fmt])
- ��¥������ ���ڿ� �ڷḦ ��¥�������� ��ȯ�Ͽ� ��ȯ
- 'fmt'�� TO_CHAR���� ���� ��¥�� ���� ���ڿ��� ����


��뿹)
    SELECT TO_DATE('20060708'),
           TO_CHAR(TO_DATE('20220113092035', 'YYYYMMDDHHMISS'),
                    'YYYY/MM/DD HH:MI:SS')
        FROM DUAL;
        
        
��뿹) ȸ�����̺��� �ֹε�Ϲ�ȣ�� �̿��Ͽ� ������
       ���� �������� �ڷḦ ����Ͻÿ�
       (���)
       ȸ����ȣ     ȸ����          �������           ����              ���ϸ���
        XXXX       XXX       1997�� 00�� 00��      �ڿ���              9999
    
    
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1'OR 
                SUBSTR(MEM_REGNO2,1,1)='2' THEN
                TO_CHAR(TO_DATE('19'||MEM_REGNO1),'YYYY"��" MM"��" DD"��"')
           ELSE
                TO_CHAR(TO_DATE('20'||MEM_REGNO1),'YYYY"��" MM"��" DD"��"') -- ""�� ����� �������� ���ڿ�
            END  AS �������,
           MEM_JOB AS ����,
           MEM_MILEAGE AS ���ϸ���
        FROM MEMBER;
    
    
    
    
    
    
    
    
    
    ��뿹) ��ǰ���̺�(PROD)�� ���� �ڷḦ �߰��� ����Ͻÿ�
---------------------------------------------------------------
��ǰ�ڵ�       ��ǰ��      �з��ڵ�    �ŷ�ó     ����      �Ǹ�      ����      ����      �̹���     ��ü���      �������

