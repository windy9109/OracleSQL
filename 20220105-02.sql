2022-0105-02)������Ÿ��
- ����Ŭ�� ���Ǵ� ������ Ÿ���� ���ڿ�, ����, ��¥, �����ڷ� ���� ����
�ع��ڿ��� �ݵ�� '���ڿ�'�� ���� ���ش�
��SQL���� ���ڴ� NUMBER ������ Ÿ�Ը� ���

1. ���ڿ��ڷ�
  .�����ڷ�(''�� ���� �ڷ�)�� �����ϱ� ���� Ÿ�� -> ����ǥ �ۿ����� ��ҹ��� ���� ����
  .��������(CHAR������ ���)�� ��������(CHAR)�� ���� -> �������� ���ڿ��� ������ SYSTEM�� �ݳ��Ѵ�.
  1)CHAE(n[BYTE|CHAR])
    .�������� ������ ����
    .�ִ� 2000BYTE ����
    .'n[BYTE|CHAR]' : Ȯ���ϴ� ��������� ũ�� ����
    .'BYTE'�� default�̸� 'CHAR'�� n�� ���� ������ �ǹ�
    .�ѱ� �ѱ��ڴ� 3byte�� -> ���� �ѱ��� ����Ǵ� ������ 666���� / ���ĺ��� �״�� 2000��
    .���� �⺻Ű�� ���̰� �����ǰ� �����ȱ��̰� �߿��� ���(�ֹι�ȣ�� �����ȣ ��)�� ���
  
��뿹)
  CREATE TABLE TRMP_01(
    COL1 CHAR(10 BYTE),
    COL2 CHAR(10 CHAR),
    COL3 CHAR(10));
  
��������)
   INSERT INTO TRMP_01(COL1,COL2,COL3)
    VALUES('������','������ �߱� ������','������ �߱� ������'); --COL3�� MAX 10byte �ε� 26byte�ʰ�
  
���󹮱�)
   INSERT INTO TRMP_01(COL1,COL2,COL3)
    VALUES('������','������ �߱� ������','�߱�');


 SELECT * FROM TRMP_01;
 
 SELECT LENGTHB(COL1), -- LENGTHB()��ȣ���� �÷��� ����Ʈ�� ��Ÿ������. ����Ʈ ����
        LENGTHB(COL2),
        LENGTHB(COL3)
   FROM TRMP_01;
  
  
--���߰�)
  INSERT INTO TRMP_01 VALUES('����','���ѹα�','�α�'); -- 12+6 = 18BYTE
  -- CHAR(10)���� ���ѹα�(4) ���� ���� 6BYTE�� ���ѹα�(12)�� ���Ͽ� 18BYTE��
  -- CHAR�ڷ����� ������ BYTE�� �ٸ��ٴ� ���� �˼�����.
  SELECT * FROM TRMP_01;
  
  
2)VARCHAR2(n[BYTE|CHAR]) --����Ŭ���� ������
  .�������� ���ڿ� ����
  .VARCHER�� ���ϱ�� ����
  .�ִ� 4000BYTE ������ --�ѱ� 1333����
  .����ڰ� ������ �����͸� �����ϰ� ���� �������� ��ȯ
  .����θ� ���Ǵ� Ÿ��
  --NVARCHAR, NVARCHAR2, NCLOB �� �ٱ��� ���� �ڷ���
  
��뿹)
        CREATE TABLE TEMP_02(
          COL1 VARCHAR2(4000 BYTE),
          COL2 VARCHAR2(4000 CHAR),
          COL3 VARCHAR2(4000));
          
        INSERT INTO TEMP_02 VALUES('IL POSTINO','PERSTMMON','APPLE');
        
        SELECT * FROM TEMP_02;
        
        SELECT LENGTHB(COL1),
                LENGTHB(COL2),
                LENGTHB(COL3)
        FROM TEMP_02;

3)LONG --�ɼ������� ���� �ʴ���
  .�������� �ڷ� ����
  .�ִ� 2GB���� ���� ����
  .�Ϻ� ����� ���Ұ�
  .�� ���̺� 1���� LONG Ÿ�Ը� ��밡��(��ɰ��� �ߴ�) 
  .CLOB Ÿ������ ��ü
  .SELECT���� SELECT��, UPDATE���� SET��, INSERT���� VALUES�������� ��� ���� 
  
��뿹)

����)
        CREATE TABLE TEMP_03(
            COL1 LONG,
            COL2 VARCHAR2(200),
            COL3 LONG); --LONG �ߺ�

����)
        CREATE TABLE TEMP_03(
            COL1 LONG,
            COL2 VARCHAR2(200));
  
  INSERT INTO TEMP_03 VALUES('������ �߱� ���� 846 3��','������簳�߿�');
  
  SELECT * FROM TEMP_03;
  
  �˻� ����1)
  SELECT LENGTHB(COL1), --LONG ������Ÿ���� �ʹ� Ŀ�� ����
         LENGTHB(COL2) 
  FROM TEMP_03;
  

  �˻� ����2)
  SELECT SUBSTR(COL2,2,5) FROM TEMP_03; --SQL�� 1������ ���ϹǷ� '�����簳��'�� ��µ�
  SELECT SUBSTR(COL1,2,5) FROM TEMP_03; --����/���Ұ���


4)CLOB(Character Large OBjects)
  .�������� ���ڿ��� ����
  .�ִ� 4GB ���� ó������
  .�� ���̺� �������� CLOB ��밡��
  .�Ϻ� ����� DBMS_LOB API�� ������ �޾ƾ���(EX: LENGTHB���� ����)

��뿹)
        CREATE TABLE TRMP_04(
            COL1 CLOB,
            COL2 CLOB,
            COL3 VARCHAR2(4000));
        
        INSERT INTO TRMP_04 VALUES('������ �߱� ���� 846 3��','������簳�߿�','ILPOSTINO');
        
        
        
        SELECT * FROM TRMP_04;
 
 ��������)
        SELECT LENGTHB(COL1), --����
                LENGTHB(COL2),
                LENGTHB(COL3)
        FROM TRMP_04;
 
 ���󿹽�)
        SELECT DBMS_LOB.GETLENGTH(COL1),
                LENGTH(COL2), --4000BYTE �̳��� ���
                LENGTHB(COL3)
        FROM TRMP_04;
 

  --JAVA�� ���� �ֿ켱
  --ORACLE�� ���� �ֿ켱
    SELECT '76'+1900 FROM DUAL;   
  