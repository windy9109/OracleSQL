2022-0126-01) SYNONYM(���Ǿ�)
- ����Ŭ ��ü�� �ο��ϴ� ��Ī
- �� �̸��� ��ü�� �ٸ���� ������ ��ü�� �����Ҷ� �ַλ��
- ���̺� ��Ī, �÷� ��Ī���� �������� QUERY�� ���� ���� ��밡��

(�������)
    CREATE [OR REPLACE] SYNONYM ���Ǿ�
    FOR ��ü��;
    
    
��뿹) 
    CREATE OR REPLACE SYNONYM EMP
        FOR HR.EMPLOYEES;
    
    CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;
        
    SELECT * FROM EMP;
    SELECT * FROM DEPT;
    
    
    CREATE OR REPLACE SYNONYM MYDUAL FOR SYS.DUAL;
    
    SELECT SYSDATE FROM MYDUAL;
    
    
    
2. INDEX
    - ������ �˻�ȿ�� �����Ű�� ���� ����
    - WHERE �������� ���Ǵ� �÷�, ����(ORDER BY), �׷�ȭ(GROUP BY) --���帹�� ���Ǵ°� WHERE��
      �� �����÷��� ����Ͽ� ó�� ȿ���� ����
    - �ε����� ���� ������ �������� �ҿ�(�ʿ�)�ǰ�, �ý����� �ڿ��� �Һ��
    - �������� ������ ���� ��� �ε��� ������ ���ſ� ���� �ð��� �ڿ��� �䱸��
    --�ε����� ���� ������ �Ǹ� ��ü���� ȿ���� ������ �ǿ����� ��ģ��.
    
    
    - �ε����� ����
    . Unique/Non-Uniqe: �ε����� �ߺ����� ����ϴ��� ���ο� ���� �з�
    'Unique'�ε����� unll���� ����ϳ� �ϳ��� null�� ����
    . Sing.Composite: �ε��� ���� �÷��� 1�� �ΰ��(Single), 2�� �̻��� �÷����� ����(Composite)�� ���
    . Normal Index: Default �ε����� �÷����� rowid(������ ��ġ����)�� ������� �ּҰ��Ǹ� Ʈ������ �̿�
    . Bitmap Index: �÷����� rowid(������ ��ġ����)�� 2������ �����Ͽ� �ּҰ���ϸ�, Cardinality�� ���� ���(����,���� ��) ȿ������ ���
    . Function-Based Normal Index: �ε��� �����÷��� �Լ��� ����� ���� �� �ε����� �̿��Ͽ� �ڷḦ �˻��ϴ� ��� �ε��� ������ ���� �Լ��� ����ϴ°��� ���� ȿ����
    
    
    (�������)
    CREATE [UNIQUE|BITMAP] INDEX �ε�����
      ON ���̺��(�÷���[,�÷���,...])[ASC|DESC];
      . 'ASC|DESC': �ε��� ������ ���� ���(�⺻�� ASC)
    
    (��뿹) ��ǰ������ �ε����� �����Ͻÿ�
    CREATE INDEX idx_prod_name
        ON PROD(PROD_NAME);
    
    
    DROP INDEX idx_prod_name;
    
    -- �ӵ� ��(INDEX�� �뷮�� �����͸� ó���Ҷ� �ӵ��� ��������� �ſ� ������.)
    -- �ε����� �����ϸ� ��ȿ�����̹Ƿ� ������ ����ؾ���.
    SELECT * FROM PROD
     WHERE PROD_NAME ='��� VTR 6���';
     
     
��뿹) ������̺��� 'TJOlson'��� ������ ��ȸ�Ͻÿ�
    SELECT *
      FROM EMP
     WHERE EMP_NAME = 'TJOlson';
    
    
    -- TJOlson�� �ּҷ� ���� �ѹ��� ����ϴ� ����, �񱳿�����ó�� ó������
    CREATE INDEX idx_emp_name
      ON EMP(EMP_NAME);
    
    -- INDEX�� �ڷᰡ ���Եɰ�� �ǽð����� �籸������ �ʰ� �����ð��ڿ� �籸���Ǵµ�, ������ �籸���� �����ϰ� �Ҽ��ִ�.
    ** �ε����� �籸��
    - �ڷ��� ����/������ �뷮 �߻��� ���
    - ���̺��� ���� ��ġ(TABLE SPACE)�� ����Ȱ��
    
    (�������)
    ALTER INDEX �ε����� REBUILD;
    
    ��뿹)
    ALTER INDEX idx_emp_name REBUILD; --���� �籸��
    
    
    
    
    
    
    
    
    
    
    
    