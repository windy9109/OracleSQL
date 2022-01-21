2022-0106-03)��Ÿ �ڷ���
- 2���ڷḦ ����
- RAW, BLOB, BFILE Ÿ�� ���� --BLOB(������ ���ο� �� ��ü�� ����), BFILE(���� ��θ� ����)
- ����Ŭ���� �ؼ��̳� ��ȯ�� �������� ����

1) RAW(ũ��) --������� ��ĵ���� ������ ũ�� / �߾Ⱦ�
  . �����Ը��� 2���ڷ� ����
  . �ִ� 2000BYTE ���� ���� ����
  . �ε��� ó�� ����
  
��뿹)
    CREATE TABLE TEMP_07(
        COL1 RAW(2000),
        COL2 RAW(500));
    INSERT INTO TEMP_07 VALUES(HEXTORAW('A5C7FF25')),'10100101110001111111111100100101'); 
    -- A5C7FF25(16����)�� 10100101110001111111111100100101�� ���� 2������ �����
    
    SELECT * FROM TEMP_07;
    
2)BFILE
 . �����ڷ� ����
 . ����ڷ�� �����ͺ��̽� �ۿ� ����ǰ� �����ͺ��̽����� ������� ����
 . �ִ� 4GB ���尡��
 
�������)
  �÷��� BFILE
    . ���� ���丮��ü�� �����Ͽ� ���

��뿹)
1. ���̺� ����
    CREATE TABLE TEMP_08(
        COL1 BFILE);
        
2. �׸����� �غ�
    
3. ���丮��ü ����
    -- CREATE DIRECTORY ��Ī AS '�����θ�'
    
    CREATE DIRECTORY TEST_DIR
    AS 'D:\A_TeachingMaterial\02_Oracle\workspace';
    
4. ������ ����
    INSERT INTO TEMP_08
        VALUES(BFILENAME('TEST_DIR','SAMPLE.jpg'));
    
    SELECT * FROM TEMP_08;
    
    
3)BLOB(Binary Large OBjects)
  . �����ڷḦ ���̺� ���ο� ����
  . 2���ڷ� ��������
  . �ִ� 4GB���� ���� ����

�������)
  �÷��� BLOB

��뿹)
  1. ���̺� ����
    CREATE TABLE TEMP_09(
        COL1 BLOB);
  
  2. �͸��� �ۼ�-�ڷ����
    DECLARE
      L_DIR VARCHAR(20) := 'TEST_DIR';
      L_FILE VARCHAR(30) := 'SAMPLE.jpg';
      L_BFILE BFILE;
      L_BLOB BLOB;
    BEGIN
      INSERT INTO TEMP_09(COL1) VALUES(EMPTY_BLOB())
        RETURN COL1 INTO L_BLOB;
        
      L_BFILE := BFILENAME(L_DIR, L_FILE);
      DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
      DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
      DBMS_LOB.FILECLOSE(L_BFILE);
    
      COMMIT;
    END;
    
    SELECT * FROM TEMP_09;
    
    
    BEGIN
    
    END;
    
    



    