2022-0110-02)�Լ�(FUNCTION)
- ���ֻ��Ǵ� ����� �̸� �������Ͽ� ���� ������ ���·� ����� ���α׷�
- ����Ŭ���� �����ϴ� �Լ��� ����ڰ� �ۼ��ϴ� �Լ��� �ִ�.
- �Լ��� ��ø����� ����(���ܷ� �����Լ����� ��ø�� ������ ����)
- ���ڿ��Լ�, �����Լ�, ��¥�Լ�, ����ȯ�Լ�, NULLó�� �Լ�, �����Լ� ���� ����


1. ���ڿ� �Լ�
    1) CONCAT(c1,c2) --�ΰ��ۿ� ���� ����Ŵ 2�� �̻��� �ι� ��ø����ؾ���.
      . �־��� �� ���ڿ� c1�� c2�� �����Ͽ� ���ο� ���ڿ� ��ȯ
      . ���ڿ� ���� ������ '||'�� ���� ���
      
��뿹) ������̺��� FIRST_NAME�� LAST_NAME�� �����Ͽ� ����Ͻÿ�
        
        SELECT EMPLOYEE_ID AS �����ȣ, 
               FIRST_NAME AS FIRST_NAME, 
               LAST_NAME AS LAST_NAME, 
               CONCAT(FIRST_NAME,LAST_NAME) AS "���յ� �̸�" --�÷� �̸��� ������ ���Ե� ��� ""�� �����ش�.
          FROM HR.EMPLOYEES;
          
          
          --���յ� �̸� ������ ���̿� ������ ���� ���(��ø�Լ� ���)
          --�Լ� ��ø�� ���ʺ��� ����Ǹ� �ٱ������� ������.
          
        SELECT EMPLOYEE_ID AS �����ȣ, 
               FIRST_NAME AS FIRST_NAME, 
               LAST_NAME AS LAST_NAME, 
               CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS "���յ� �̸�" --�÷� �̸��� ������ ���Ե� ��� ""�� �����ش�.
          FROM HR.EMPLOYEES;
          
          -- SELSCT FIRST_NAME||' '|| LAST_NAME AS "���յ� �̸�"
          
       2)LOWER(C1), UPPER(C1), INITCAP(C1)
       . LOWER(C1): �־��� ���ڿ� C1�� ���ѵ� ��� ���ڸ� �ҹ��ڷ� ��ȯ
       . UPPER(C1): �־��� ���ڿ� C1�� ���Ե� ��� ���ڸ� �빮�ڷ� ��ȯ
       . INITCAP(C1):�־��� ���ڿ� C1�� �ܾ� ���۱��ڸ� �빮�ڷ� ��ȯ -- ��Ÿ�� ǥ���
       
       
��뿹) ��ǰ���̺��� �з��ڵ尡 'P102'�� ���� ��ǰ�� ��ȸ�Ͻÿ�
       Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰���, ���Ⱑ��
       
       SELECT PROD_ID AS ��ǰ�ڵ�, 
              PROD_NAME AS ��ǰ��, 
              PROD_COST AS ���԰���, 
              PROD_PRICE AS ���Ⱑ��
           FROM PROD
        -- WHERE PROD_LGU = 'p102'; 
        -- ���ڿ��� �ҹ��� �빮�� ������
         WHERE LOWER(PROD_LGU)='p102'; --��ҹ��� ���о��� ����ϰ� ������
       
       
** ������̺��� FIRST_NAME�� LAST_NAME�� ��� �ҹ��ڷ� �����Ͽ� �����Ͻÿ�.

    UPDATE HR.EMPLOYEES
        SET FIRST_NAME=LOWER(FIRST_NAME),
            LAST_NAME=LOWER(LAST_NAME);
            
    COMMIT;
    
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
        FROM HR.EMPLOYEES;
        
��뿹) ������̺��� FIRST_NAME�� LAST_NAME�� �����ϵ� �߰��� ������ �����ϰ� �ܾ� ù���ڸ� �빮�ڷ� ��ȯ�Ͽ� ����Ͻÿ�.
            
            SELECT EMPLOYEE_ID,
                   FIRST_NAME,
                   LAST_NAME,
                   INITCAP(FIRST_NAME||' '||LAST_NAME)   
             FROM HR.EMPLOYEES;
       
       
       
       
       
       
       
       
       
       
          
          