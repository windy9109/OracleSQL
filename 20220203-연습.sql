2022-02-03) ����


1���� 100������ ¦���� �հ� Ȧ���� ���� ���Ͻÿ�

DECLARE
    V_CNT NUMBER :=1;
    V_ESUM NUMBER :=0;
    V_OSUM NUMBER :=0;
BEGIN
    LOOP 
    IF MOD(V_CNT,2)=0 THEN
        V_ESUM :=V_CNT+V_ESUM;
    ELSE
        V_OSUM :=V_CNT+V_OSUM;
    END IF;
    EXIT WHEN V_CNT>=100;
    V_CNT:=V_CNT+1;
END LOOP;
DBMS_OUTPUT.PUT_LINE('¦���� ��'||V_ESUM);
DBMS_OUTPUT.PUT_LINE('Ȧ���� ��'||V_OSUM);    
END;




DECLARE
    V_CNT NUMBER:=1;
    V_OSUM NUMBER:=0;
    V_ESUM NUMBER:=0;
BEGIN
    LOOP
       IF MOD(V_CNT,2)=0 THEN
       V_ESUM:=V_CNT+V_ESUM;
       ELSE
       V_OSUM:=V_CNT+V_OSUM;
       END IF;
       EXIT WHEN V_CNT >= 100;
       V_CNT:=V_CNT+1;
END LOOP;
DBMS_OUTPUT.PUT_LINE('¦���� �� '||V_ESUM);
DBMS_OUTPUT.PUT_LINE('Ȧ���� ��'||V_OSUM);
END;



��뿹) ������ �μ���ȣ(10-110��)�� �����ϰ� �ش�μ��� ���� �����
        �Ի����� ���� ���� �����ȣ, �����, �Ի���, �μ����� ���
--PL/SQL������ SELECT���� ����� INTO���� ������ ��ġ�ؾ���


DECLARE
    V_DEPTNO HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- �μ��ڵ�
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; -- �����
    V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- �����ȣ
    V_HDATE DATE;  -- �Ի���
    V_DNAME VARCHAR2(100); -- �μ���
BEGIN
    V_DEPTNO:=TRUNC(DBMS_RANDOM.VALUE(10,119),-1); --���� �μ���ȣ ����
    SELECT TBL.AID, TBL.ANAME, TBL.ADATE, TBL.BNAME
      INTO V_EID, V_ENAME, V_HDATE, V_DNAME
      FROM(SELECT A.EMPLOYEE_ID AS AID,
                  A.EMP_NAME AS ANAME,
                  A.HIRE_DATE AS ADATE,
                  B.DEPARTMENT_NAME AS BNAME
             FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
             WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
               AND A.DEPARTMENT_ID=V_DEPTNO
               ORDER BY 3) TBL
         WHERE ROWNUM =1;
    DBMS_OUTPUT.PUT_LINE('�����ȣ'||V_EID);
    DBMS_OUTPUT.PUT_LINE('�����'||V_ENAME);
    DBMS_OUTPUT.PUT_LINE('�Ի���'||V_HDATE);
    DBMS_OUTPUT.PUT_LINE('�μ���'||V_DNAME);
END;




