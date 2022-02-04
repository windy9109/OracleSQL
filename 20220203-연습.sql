2022-02-03) 연습


1부터 100사이의 짝수의 합과 홀수의 합을 구하시오

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
DBMS_OUTPUT.PUT_LINE('짝수의 합'||V_ESUM);
DBMS_OUTPUT.PUT_LINE('홀수의 합'||V_OSUM);    
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
DBMS_OUTPUT.PUT_LINE('짝수의 합 '||V_ESUM);
DBMS_OUTPUT.PUT_LINE('홀수의 합'||V_OSUM);
END;



사용예) 임의의 부서번호(10-110번)을 생성하고 해당부서에 속한 사원중
        입사일이 가장 빠른 사원번호, 사원명, 입사일, 부서명을 출력
--PL/SQL에서는 SELECT절의 내용과 INTO절의 내용이 일치해야함


DECLARE
    V_DEPTNO HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- 부서코드
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; -- 사원명
    V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- 사원번호
    V_HDATE DATE;  -- 입사일
    V_DNAME VARCHAR2(100); -- 부서명
BEGIN
    V_DEPTNO:=TRUNC(DBMS_RANDOM.VALUE(10,119),-1); --임의 부서번호 생성
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
    DBMS_OUTPUT.PUT_LINE('사원번호'||V_EID);
    DBMS_OUTPUT.PUT_LINE('사원명'||V_ENAME);
    DBMS_OUTPUT.PUT_LINE('입사일'||V_HDATE);
    DBMS_OUTPUT.PUT_LINE('부서명'||V_DNAME);
END;




