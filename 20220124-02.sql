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
        
        
        
        
        
