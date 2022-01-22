2022-0112-02) 날짜함수

1)SYSDATE
- 시스템에서 제공하는 날짜정보(년,월,일,시,분,초) 반환
- 덧셈과 뺄셈 가능
- 덧셈(장래에 도래할 날짜)과 뺄셈(지나간 날짜) 가능
- 나눗셈, 곱셈 불가능
- 시간정보(시,분,초)출력은 TO_CHAR 함수 사용

사용예)
SELECT SYSDATE, SYSDATE-20, 
        --20일 이전의 날짜 
        SYSDATE+20,
        --앞으로 20일 후의 날짜
        FROM DUAL;
    
    SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),
           TO_CHAR(SYSDATE-20,'YYYY-MM-DD HH24:MI:SS'),
           TO_CHAR(SYSDATE+20,'YYYY-MM-DD HH24:MI:SS')
      FROM DUAL;
    
    


2)ADD_MONTHS(d1, n)
- 주어진 날짜 d1에 n개월을 더한 날짜 반환

사용예)
    SELECT ADD_MONTHS(SYSDATE,4) FROM DUAL;
    
    SELECT EMP_NAME,
            HIRE_DATE,
            ADD_MONTHS(HIRE_DATE,3)
        FROM HR.EMPLOYEES;
    
    

3) NEXT_DAY(d1,c) -- 한글로 지칭된 것만 반환
  - d1 일자이후 가장 먼저 만나는 c요일의 날짜 반환 
  - c는 요일을 지칭하며 '일요일','일',,'월요일','월'등으로 기술

사용예)
    SELECT NEXT_DAY(SYSDATE,'월'),
            NEXT_DAY(SYSDATE,'수요일')
        FROM DUAL;
        
        
        
4) LAST_DAY(d1)
- 제시된 날짜 d1에 포함된 월의 마지막 일자를 반환
- 주로 2월의 마지막일을 반환 받을때 사용

사용예) 매입테이블(BUYPROD)에서 2005년 2월 일자별 판매집계를 조회하시오.
        --전체가 아닌 부분조건을 구하는것이므로 WHERE가 필요함
        Alias는 일자, 수량합계, 매입금액합계
        
        SELECT BUY_DATE AS 일자, 
               SUM(BUY_QTY) AS 수량합계, 
               SUM(BUY_QTY*BUY_COST) AS 매입금액합계
            FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
          GROUP BY BUY_DATE -- 일자별로 묶음
          ORDER BY 1;
         
        
5)EXTRACT(fmt FROM d1) 
-- d1으로 부터 fmt에 해당하는 날짜자료를 반환하세요
-- 날짜자료만 반환
- 제시된 날짜자료 d1에서 'fmt'에 해당하는 요소를 추출하여 반환
- 반환되는 타입은 숫자
- 'fmt(Format String: 형식 문자열)'은 YEAR, MONTH, DAY, HOUR, MINUTE, SECOND 중 하나이어야 함

    
사용예) 회원테이블에서 연령을 구하고 연령대별 회원수를 조회하시오
        Alias는 연령대, 회원수
        --TRUNC -> 자리버림
        
        SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE)
                    -EXTRACT(YEAR FROM MEM_BIR)),-1)||'대' AS 연령대, 
                    COUNT(*) AS 회원수 --집계함수는 GROUP BY가 무조건 와야한다.
           FROM MEMBER
         GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)
                        -EXTRACT(YEAR FROM MEM_BIR)),-1)
            ORDER BY 1;
            
사용예) 사원테이블에서 입사월이 이번달인 사원들을 조회하시오.
        Alias는 사원번호, 사원명, 부서코드, 입사일 (입사일 기준 오름차순 정렬)
        
        SELECT EMPLOYEE_ID AS 사원번호, 
               EMP_NAME AS 사원명, 
               DEPARTMENT_ID AS 부서코드, 
               HIRE_DATE AS 입사일
            FROM HR.EMPLOYEES
          WHERE EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM HIRE_DATE)
         ORDER BY 4;
         -- BETWEEN EXTRACT(MONTH FROM SYSDATE) AND EXTRACT(MONTH FROM SYSDATE);
         
         SELECT EMPLOYEE_ID AS 사원번호, 
               EMP_NAME AS 사원명, 
               DEPARTMENT_ID AS 부서코드, 
               HIRE_DATE AS 입사일
            FROM HR.EMPLOYEES
         
         
         
         
6) MONTHS_BETWEEN(d1, d2)
    - 제시된 두 날짜자료 사이의 월수를 반환

사용예) 1998년 3월 10일에 태어난 사람의 정확한 나이는?

    SELECT 
        TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE, TO_DATE('19980310')))/12) ||'년'||
        MOD(ROUND(MONTHS_BETWEEN(SYSDATE, TO_DATE('19980310'))),12) ||'개월'
     FROM DUAL;
         
        
    
    
    
    
    