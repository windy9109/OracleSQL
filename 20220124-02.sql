2022-0124-02) 집합연산자
- 복수개의 QUERY결과를 연산하여 새로운 결과를 반환
- JOIN 연산을 줄일 수 있음
- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS) 제공
  . UNION: 두 집합의 모든 원소를 중복하지 않게 반환(정렬)
  . UNION ALL: 중복을 허용한 두 집합의 모든 원소를 반환(정렬하지 않음)
  . INTERSECT: 두집합의 공통된 원소 반환(정렬)
  . MINUS: 피감수(빼짐을 당한)집합에서 감수(뺀)집합결과를 차감한 결과 반환
  
  (사용형식)
  QUERY1
  UNION|UNION ALL|INTERSECT|MINUS
  QUERY_2
  [UNION|UNION ALL|INTERSECT|MINUS
  QUERY_3]
     :
  [UNION|UNION ALL|INTERSECT|MINUS
  QUERY_n]
  
  - 모든쿼리의 SELECT 절 컬럼의 '수'와 '타입', '순서'가 동일해야함(중요)
  - 출력의 기본은 첫번째 SELECT 문임
  - ORDER BY절은 맨 마지막 QUERY만 사용 가능
  
  
1. UION
- 합집합의 결과 출력
- 중복을 배제

사용예) 사원테이블에서 2005년도에 입사한 사원과 부서가 시에틀인 사원을 조회하시오
        Alias는 사원번호, 사원명, 입사일, 근무지
        
        SELECT A.EMPLOYEE_ID AS 사원번호,
               A.EMP_NAME AS 사원명, 
               A.HIRE_DATE AS 입사일, 
               B.DEPARTMENT_NAME AS 부서명
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
       WHERE A.DEPARTMENT_ID =B.DEPARTMENT_ID
       AND EXTRACT(YEAR FROM HIRE_DATE) = 2005;
       
       
       (부서가 시에틀인 사원)
        SELECT A.EMPLOYEE_ID AS 사원번호,
               A.EMP_NAME AS 사원명, 
               A.HIRE_DATE AS 입사일, 
               B.DEPARTMENT_NAME AS 부서명
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C
       WHERE A.DEPARTMENT_ID =B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND C.CITY='Seattle';
        
        
    
       SELECT A.EMPLOYEE_ID AS 사원번호,
               A.EMP_NAME AS 사원명, 
               A.HIRE_DATE AS 입사일, 
               B.DEPARTMENT_NAME AS 부서명
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
       WHERE A.DEPARTMENT_ID =B.DEPARTMENT_ID
       AND EXTRACT(YEAR FROM HIRE_DATE) = 2005
       UNION
      SELECT A.EMPLOYEE_ID AS 사원번호,
               A.EMP_NAME AS 사원명, 
               A.HIRE_DATE AS 입사일, 
               B.DEPARTMENT_NAME AS 부서명
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C
       WHERE A.DEPARTMENT_ID =B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND C.CITY='Seattle';
        
        
        
        
사용예) 2005년 4월에 매입된 상품과 매출된상품을 중복되지않게 모두 조회 하시오 --중복제외이므로 UNION
       Alias는 상품코드, 상품명, 거래처명

    --(매입테이블)
     SELECT DISTINCT A.BUY_PROD AS 상품코드, 
            B.PROD_NAME AS 상품명, 
            C.BUYER_NAME AS 거래처명
        FROM BUYPROD A, PROD B, BUYER C
      WHERE B.PROD_ID = A.BUY_PROD
        AND B.PROD_BUYER = C.BUYER_ID
        AND A.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050401'))
     UNION
     --(매출테이블)
     SELECT DISTINCT A.CART_PROD AS 상품코드, 
            B.PROD_NAME AS 상품명, 
            C.BUYER_NAME AS 거래처명
        FROM CART A, PROD B, BUYER C
      WHERE B.PROD_ID = A.CART_PROD
        AND B.PROD_BUYER = C.BUYER_ID
        AND SUBSTR(A.CART_NO,1,6) = '200504'
        ORDER BY 1;
        
        
        
        
사용예) 2005년 6월과 7월에 상품을 구입한 회원을 조회하시오
       Alias는 회원번호, 회원명, 주소, 마일리지
       
       SELECT DISTINCT A.MEM_ID AS 회원번호, 
              A.MEM_NAME AS 회원명, 
              A.MEM_ADD1 || A.MEM_ADD2 AS 주소, 
              A.MEM_MILEAGE AS 마일리지
        FROM MEMBER A, CART B
       WHERE A.MEM_ID = B.CART_MEMBER AND 
       SUBSTR(B.CART_NO,1,6) BETWEEN '200506' AND '200507';
       
       
       
       
       SELECT DISTINCT A.MEM_ID AS 회원번호, 
              A.MEM_NAME AS 회원명, 
              A.MEM_ADD1 || A.MEM_ADD2 AS 주소, 
              A.MEM_MILEAGE AS 마일리지
        FROM MEMBER A, CART B
       WHERE A.MEM_ID = B.CART_MEMBER AND 
       SUBSTR(B.CART_NO,1,6) = '200506'
       UNION
       SELECT DISTINCT A.MEM_ID AS 회원번호, 
              A.MEM_NAME AS 회원명, 
              A.MEM_ADD1 || A.MEM_ADD2 AS 주소, 
              A.MEM_MILEAGE AS 마일리지
        FROM MEMBER A, CART B
       WHERE A.MEM_ID = B.CART_MEMBER AND 
       SUBSTR(B.CART_NO,1,6) = '200507';
       
       
       
2. INTERSECT
 - 두 결과의 교집합(공통된 영역)을 반환
 
사용예)  2005년도 금액기준 매입순위 상위 5개 품목과 매출순위 상위 5개를 조회하여 양쪽모두를 만족하는 상품정보를 출력하시오.
        Alias는 상품코드, 상품명, 매입금액, 순위
        (2005년도 금액기준 매입순위 상위 5개 품목)
        --분류이름도 알기 위해서는 LPROD도 필요하다
        
        
        
        SELECT A.BUY_PROD AS BID, 
               B.PROD_NAME AS BNAME, 
               SUM(A.BUY_QTY*B.PROD_COST) AS BSUM,
               RANK() OVER(ORDER BY SUM(A.BUY_QTY*B.PROD_COST) DESC) AS RANK
          FROM BUYPROD A, PROD B
         WHERE A.BUY_PROD = B.PROD_ID
           AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
        GROUP BY A.BUY_PROD, B.PROD_NAME;
        
        
        
        (2005년도 금액기준 매입순위 상위 5개 품목)
        SELECT C.BID AS 금액,
               C.BNAME AS 상품명,
               C.BSUM AS 합계,
               C.BRANK AS 순위
          FROM(SELECT A.BUY_PROD AS BID, 
                       B.PROD_NAME AS BNAME, 
                       SUM(A.BUY_QTY*B.PROD_COST) AS BSUM,
                       RANK() OVER(ORDER BY SUM(A.BUY_QTY*B.PROD_COST) DESC) AS BRANK
                  FROM BUYPROD A, PROD B
                 WHERE A.BUY_PROD = B.PROD_ID
                   AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
                GROUP BY A.BUY_PROD, B.PROD_NAME)C
        WHERE C.BRANK <= 5;
        
        
        
         (2005년도 금액기준 매출순위 상위 5개 품목)
          SELECT D.CID AS 상품코드,
                   D.CNAME AS 상품명,
                   D.CSUM AS 합계,
                   D.CRANK AS 순위
              FROM(SELECT A.CART_PROD AS CID, 
                           B.PROD_NAME AS CNAME, 
                           SUM(A.CART_QTY*B.PROD_COST) AS CSUM,
                           RANK() OVER(ORDER BY SUM(A.CART_QTY*B.PROD_COST) DESC) AS CRANK
                      FROM CART A, PROD B
                     WHERE A.CART_PROD = B.PROD_ID
                       AND SUBSTR(A.CART_NO,1,4) = '2005'
                    GROUP BY A.CART_PROD, B.PROD_NAME)D
                    WHERE D.CRANK<=5;
    
        
      
        
  
  사용예) 2005년 1월과 5월에 매입된 상품정보를 조회하시오.
        Alias는 상품코드, 상품명, 분류명
        (2005년 1월에 매입된 상품)
        
        SELECT DISTINCT A.BUY_PROD AS 상품코드, 
               B.PROD_NAME AS 상품명, 
               C.LPROD_NM AS 분류명
          FROM BUYPROD A, PROD B, LPROD C
        WHERE A.BUY_PROD =B.PROD_ID
         AND B.PROD_LGU = C.LPROD_GU
         AND A.BUY_DATE BETWEEN TO_DATE('20050101')AND LAST_DAY(TO_DATE('20050101'))
         INTERSECT 
        SELECT DISTINCT A.BUY_PROD AS 상품코드, 
               B.PROD_NAME AS 상품명, 
               C.LPROD_NM AS 분류명
          FROM BUYPROD A, PROD B, LPROD C
        WHERE A.BUY_PROD =B.PROD_ID
         AND B.PROD_LGU = C.LPROD_GU
         AND A.BUY_DATE BETWEEN TO_DATE('20050501')AND LAST_DAY(TO_DATE('20050501'))
         ORDER BY 1;

        
        
3. MINUS
- 두 집합의 차집합결과를 반환
- 기술 순서가 중요

사용예) 2005년 6,7월중 6월달에만 판매된 상품정보를 조회하시오
       Alias는 상품코드, 상품명, 판매가, 매입가
       
    --교집합빼고 나머지 출력
(2005년 6월에 판매된 상품)
    SELECT DISTINCT A.CART_PROD AS 상품코드, 
           B.PROD_NAME AS 상품명, 
           B.PROD_PRICE AS 판매가, 
           B.PROD_COST AS 매입가
      FROM CART A, PROD B
     WHERE A.CART_PROD = B.PROD_ID
      AND A.CART_NO LIKE '200506%'
      MINUS
      --(2005년 7월에 판매된 상품)
     SELECT DISTINCT A.CART_PROD AS 상품코드, 
           B.PROD_NAME AS 상품명, 
           B.PROD_PRICE AS 판매가, 
           B.PROD_COST AS 매입가
      FROM CART A, PROD B
     WHERE A.CART_PROD = B.PROD_ID
      AND A.CART_NO LIKE '200507%'
      ORDER BY 1;

  
  
  
    --교집합만 출력
      SELECT DISTINCT A.CART_PROD AS 상품코드, 
           B.PROD_NAME AS 상품명, 
           B.PROD_PRICE AS 판매가, 
           B.PROD_COST AS 매입가
      FROM CART A, PROD B
     WHERE A.CART_PROD = B.PROD_ID
      AND A.CART_NO LIKE '200506%'
      INTERSECT
      --(2005년 7월에 판매된 상품)
     SELECT DISTINCT A.CART_PROD AS 상품코드, 
           B.PROD_NAME AS 상품명, 
           B.PROD_PRICE AS 판매가, 
           B.PROD_COST AS 매입가
      FROM CART A, PROD B
     WHERE A.CART_PROD = B.PROD_ID
      AND A.CART_NO LIKE '200507%'
      ORDER BY 1;
        
     
     
 (EXISTS 연산자 사용가능)
      SELECT DISTINCT A.CART_PROD AS 상품코드, 
               B.PROD_NAME AS 상품명, 
               B.PROD_PRICE AS 판매가, 
               B.PROD_COST AS 매입가
          FROM CART A, PROD B
         WHERE A.CART_PROD = B.PROD_ID
          AND A.CART_NO LIKE '200506%'
          AND NOT EXISTS( SELECT 1  
          -- C와 A가 가지고 있는 상품코드가 같으면 참이다를 NOT로 받으므로 거짓이 된다. 
          --따라서 비교해서 같은 값들을 제외하게 됨
          --만약 NOT을 빼면 교집합(INTERSECT)이 된다.
                  FROM CART C
                 WHERE A.CART_PROD = C.CART_PROD
                  AND C.CART_NO LIKE '200507%')
        ORDER BY 1;
        
        
        
        
        
** 순위함수(RANK OVER)
 - 특정컬럼을 기준으로 순서화 시키고 등수부여
 - 그룹안에서도 순위부여
 - RANK OVER, DENSE_RANK 등이 있다.
 

 
 1) RANK
 . 순위를 부여
 . 같은 값은 같은 순위를 부여하고 차 순위는 중복된 개수만큼 순위를 증분하여 부여(ex 1,2,2,2,5,6....)
 . SELECT 절에 사용
 (사용형식)
 RANK() OVER(ORDER BY 컬럼명 [ASC|DESC]) [AS 별칭]
 - '컬럼명'을 기준으로 등수부여
 
 
 
 
 
 
 
 사용예)2005년 5월 매입금액이 많은 5명의 회원을 조회하시오.
      Alias는 회원번호,회원명,구매금액
 
 
(오류) --부정확
    SELECT A.CART_MEMBER AS 회원번호, 
           B.MEM_NAME AS 회원명, 
           SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액
      FROM CART A, MEMBER B, PROD C
    WHERE A.CART_MEMBER = B.MEM_ID
      AND A.CART_PROD = C.PROD_ID
      AND ROWNUM <=5
    GROUP BY A.CART_MEMBER,B.MEM_NAME
    ORDER BY 3 DESC;
    
    
    
       
(서브쿼리 사용) --정답
    
    (서브쿼리: 2005년 회원별 구매금액 계산, 구매금액 순으로 내림차순 정렬)
    SELECT A.CART_MEMBER AS CID, 
           SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
      FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
      AND A.CART_NO LIKE '2005%'
    GROUP BY A.CART_MEMBER
    ORDER BY 2 DESC;
    
    
    (메인쿼리: 구매금액이 많은 5명 조회)
    SELECT M.MEM_ID AS 회원번호, 
           M.MEM_NAME AS 회원명, 
           C.CSUM 구매금액
      FROM MEMBER M, (SELECT A.CART_MEMBER AS CID, 
                               SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                        FROM CART A, PROD B
                       WHERE A.CART_PROD = B.PROD_ID
                         AND A.CART_NO LIKE '2005%'
                    GROUP BY A.CART_MEMBER
                    ORDER BY 2 DESC)C
    WHERE M.MEM_ID = C.CID
      AND ROWNUM <= 5;
      
      
      
      
 사용예)2005년 구매금액이 많은 회원부터 등수를 부여하여 조회하시오.
      Alias는 회원번호,회원명,구매금액, 등수 
      
      SELECT A.CART_MEMBER AS 회원번호, 
             B.MEM_NAME AS 회원명, 
             SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액, 
             RANK() OVER(ORDER BY  SUM(A.CART_QTY*C.PROD_PRICE) DESC ) AS 등수 
        FROM CART A, MEMBER B, PROD C 
      WHERE A.CART_MEMBER = B.MEM_ID
        AND A.CART_PROD = C.PROD_ID
      GROUP BY A.CART_MEMBER,B.MEM_NAME;
  
  
  2) 그룹내에서 순위
  (사용형식)
  RANK()OVER(PARTITION BY 컬럼명[,컬럼명,....]   
              ORDER BY 컬럼명[,컬럼명,...][ASC|DESC]
  . PARTITION BY 컬럼명: 그룹으로 묶을 컬럼명 기술
  --GROUP BY를 쓰지 않기 위해 PARTITION BY를 쓴다. 순위를 정하기 위한 그룹화임
  
  사용예) 사원테이블에서 각 부서별 사원들의 급여를 기준으로 순위를 부여하여 출력하시오. 
         순위는 급여가 많은 사람 순으로 부여하고 같은 급여이면 입사일이 빠른순으로 부여하시오.
         Alias는 사원번호, 사원명, 부서명, 급여, 순위
         
         SELECT A.EMPLOYEE_ID AS 사원번호, 
                A.EMP_NAME AS 사원명, 
                B.DEPARTMENT_NAME AS 부서명, 
                A.SALARY AS 급여, 
                A.HIRE_DATE AS 입사일,
                RANK() OVER(PARTITION BY A.DEPARTMENT_ID
                            ORDER BY A.SALARY DESC, HIRE_DATE ASC)순위
           FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
         
         
3) DENSE_RANK()
- 순위부여
- 같은 값이면 같은 순위를 부여하며, 차순위는 같은순위 갯수와 관계없이 다음 순위 부여(EX. 1,1,1,1,2,3,4,...)
- 나머지 특징은 RANK()와 동일


4) ROW_NUMBER()
- 순위부여                      값 9 9 9 8 7 6...
- 같은 값이라도 순차적인 순위 부여(EX. 1,2,3,4,5,6,...)
- 나머지 특징은 RANK()와 동일

사용예)회원테이블에서 거주지가 '대전'인 회원들의 마일리지를 조회하고 값에 따라 순위를 부여하시오


사용예) 사원테이블에서 급여가 5000이하인 사원들을 조회하고 급여에 따른 순위를 부여하시오
(RANK() 함수사용)
  SELECT EMPLOYEE_ID AS 사원번호, 
         EMP_NAME AS 사원명, 
         DEPARTMENT_ID AS 부서코드, 
         SALARY AS 급여, 
         RANK() OVER(ORDER BY SALARY DESC) AS 순위
    FROM HR.EMPLOYEES
    WHERE SALARY<= 5000;
  
  
(DENSE_RANK() 함수사용)
  SELECT EMPLOYEE_ID AS 사원번호, 
         EMP_NAME AS 사원명, 
         DEPARTMENT_ID AS 부서코드, 
         SALARY AS 급여, 
         DENSE_RANK() OVER(ORDER BY SALARY DESC) AS 순위
    FROM HR.EMPLOYEES
    WHERE SALARY<= 5000;
    
    
    
(ROW_NUMBER() 함수사용)
  SELECT EMPLOYEE_ID AS 사원번호, 
         EMP_NAME AS 사원명, 
         DEPARTMENT_ID AS 부서코드, 
         SALARY AS 급여, 
         ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 순위
    FROM HR.EMPLOYEES
    WHERE SALARY<= 5000;    










           
           
           
  
  
  
  