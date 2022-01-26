2022-0125-03) SEQUENCE
 - ���ʴ�� �����Ǵ� �������� �� ��ȯ
 - ���̺�� �������̸� ���� ���̺��� ���ÿ� ��밡��
 - �⺻Ű�� ���ų� PK�� �ǹ��ְ� ������ �ʾƵ� �Ǵ� ���
 - �ڵ������� �ο��Ǵ� ��ȣ�� �ʿ��Ѱ��
 
 (�������� Ư¡)
 - ������ ���� ������ �� ����.
 - �����ϰ� ����ؾ���
 
 (�������)
 CREATE SEQUENCE ��������
    [START WITH n] --���۰�(n)���� �����ϸ� MINVALUE�� �Ҵ�
    [INCREMENT BY n] --����[����]��, �����̸� ���Ұ�, N�� �����Ǿ����� 1�� ����
    [MAXVALUE n|NOMAXVALUE] --�ִ밪 ����, �⺻�� NOMAXVALUE�̸�(10^27)
    [MINVALUE n|NOMINVALUE] --�ּҰ� ����, �⺻�� NOMINVALUE(1)
    [CYCLE|NOCYCLE] --�ִ�(�ּ�)�� ���� �� �ٽ� ������ ��������, �⺻�� NOCYCLE 
    [CACHE n|NOCACHE] -- �޸𸮿� �̸� ��������, �⺻�� CACHE 20
    [ORDER|NOORDER] --���� ���û��״�� ������ ������ ��������, 
    --NOORDER�� �⺻ (ORDER: ���� | NOORDER: ����X])
    

- SEQUENCE���� ���Ǵ� �ǻ��÷�
-------------------------------------------------------------
    �ǻ� �÷�                �ǹ�
-------------------------------------------------------------
��������.CURRVAL    �������� ���� �ִ� ���簪
��������.NEXTVAL    �������� ���� �� ��ȯ
-------------------------------------------------------------
**�������� ������ �� ó�� ����Ǿ���ϴ� ����� NEXTVAL�̾�� ��

(��뿹)
    CREATE SEQUENCE SEQ_SAMPLE
        START WITH 10;

--����
SELECT SEQ_SAMPLE.CURRVAL FROM DUAL;

--ORA-08002: sequence SEQ_SAMPLE.CURRVAL is not yet defined in this session
--08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
--*Cause:    sequence CURRVAL has been selected before sequence NEXTVAL
--*Action:   select NEXTVAL from the sequence before selecting CURRVAL

--CURRVAL�� ���ǵ��� ����



--����
SELECT SEQ_SAMPLE.NEXTVAL FROM DUAL; --NEXT�� �����;���
SELECT SEQ_SAMPLE.CURRVAL FROM DUAL; --���� ����
-- ������ ������ ���� �ǵ��ư��� ����. SEQUENCE�� �ٽ� ��������


��뿹) �з����̺� ���� �ڷḦ �߰� �Ͻÿ�
        ��, LPROD_ID�� �������� �����Ͽ� ����Ұ�
        
        [�ڷ�]
        �з��ڵ�        �з���
        ------------------------------
        P501        ��깰
        P502        ���깰
        P503        �ӻ깰
        ------------------------------
        
(������ ����)
    CREATE SEQUENCE SEQ_LPROD_ID -- ���������� ���� �տ� ���ξ� SEQ_�� �ٴ´�
        START WITH 10;

    INSERT INTO LPROD(LPROD_ID,LPROD_GU, LPROD_NM)
        VALUES(SEQ_LPROD_ID.NEXTVAL,'P501','��깰');

    INSERT INTO LPROD(LPROD_ID,LPROD_GU, LPROD_NM)
        VALUES(SEQ_LPROD_ID.NEXTVAL,'P502','���깰');
        
     INSERT INTO LPROD(LPROD_ID,LPROD_GU, LPROD_NM)
        VALUES(SEQ_LPROD_ID.NEXTVAL,'P503','�ӻ깰');

    SELECT * FROM LPROD;
    
    
��뿹) ������ 2005�� 7�� 8���̶� �ϰ� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�(������ ���)

    CREATE OR REPLACE PROCEDURE PROC_CARTNO_CREATE(
        P_DATE IN DATE,
        P_CNUM OUT NUMBER)
    IS
        V_NUM NUMBER:=0;
        V_CNO CHAR(9):=TO_CHAR(P_DATE,'YYYYMMDD')||'%';
    BEGIN
        SELECT MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1
            INTO V_NUM
            FROM CART
         WHERE CART_NO LIKE V_CNO;
      P_CNUM:=V_NUM;
    END;
        

(����)
    DECLARE
     V_CNO CHAR(13);
     V_CNUM NUMBER:=0;
    BEGIN
     PROC_CARTNO_CREATE('20050708',V_CNUM); -- P_CNUM���� �Ѱܹ���
     V_CNO:='20050708'||TRIM(TO_CHAR(V_CNUM,'00000')); -- 5�ڸ��� ����
     DBMS_OUTPUT.PUT_LINE('��ٱ��Ϲ�ȣ:'||V_CNO);
    END;

    
    ** �������� ����� �� ���� ���
    . SELECT, UPDATE, DELETE ���� ���Ǵ� SUBQUERY
    . VIEW�� QUERY
    . DISTINCT�� ���� SELECT��
    . GROUP BY, ORDER BY���� �ִ� SELECT��
    . SELECT ���� WHERE��
    
    
    
    
    
    
    






    