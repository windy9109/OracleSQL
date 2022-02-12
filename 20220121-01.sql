2022-0121-01)

사용예) 모든 부서별 인원수를 조회하시오 --외부조인 그룹
        Alias는 부서코드, 부서명, 인원수
         
   (일반조인) --문법오류
  SELECT B.DEPARTMENT_ID AS 부서코드, 
       B.DEPARTMENT_NAME AS 부서명, 
       COUNT(*) AS 인원수
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B 
  WHERE A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID(+)
    GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY 1;
    
    
    (ANSI조인) --FULL OUTER JOIN 사용시
    SELECT NVL(TO_CHAR(B.DEPARTMENT_ID),'미배정') AS 부서코드, 
            --NVL(B.DEPARTMENT_ID,0) 사용시 같은 타입의 값을 반환해서 맞춰줘야함
       NVL(B.DEPARTMENT_NAME,'프리랜서') AS 부서명, 
       COUNT(A.EMPLOYEE_ID) AS 인원수 
       --COUNT(*)는 NULL행까지 포함해 1을 카운트시키므로 COUNT안에 컬럼명을 기술한다.
    FROM HR.EMPLOYEES A
    FULL OUTER JOIN HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
    GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY B.DEPARTMENT_ID; 
    --1로 설정하면 문자열로 정렬시키게 되므로 본래 컬럼인 B.DEPARTMENT_ID를 기술해준다.
    
    
    
사용예) 2005년 모든 상품별 매입/매출수량을 집계하시오
        Alias는 상품코드, 상품명, 매입수량, 매출수량
        --서브쿼리로만 해결가능
        
(2005년 모든 상품별 매입수량 집계)
SELECT B.PROD_ID AS 상품코드, 
       B.PROD_NAME AS 상품명, 
       SUM(A.BUY_QTY)AS 매입수량
  FROM BUYPROD A
RIGHT OUTER JOIN PROD B ON(A.BUY_PROD =B.PROD_ID AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231'))
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;



(2005년 모든 상품별 매출수량 집계)
SELECT B.PROD_ID AS 상품코드, 
       B.PROD_NAME AS 상품명, 
       SUM(A.CART_QTY)AS 매출수량
  FROM CART A
RIGHT OUTER JOIN PROD B ON(A.CART_PROD =B.PROD_ID AND A.CART_NO LIKE '2005%') --결과적으로 FULL OUTER
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
 
 --매입/매출 모두 충족하는것은 모순



(한문장으로 합쳤을때) --논리오류
SELECT B.PROD_ID AS 상품코드, 
       B.PROD_NAME AS 상품명, 
       SUM(A.BUY_QTY)AS 매입수량,
       SUM(C.CART_QTY)AS 매출수량
  FROM BUYPROD A
RIGHT OUTER JOIN PROD B ON(A.BUY_PROD =B.PROD_ID AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231'))
LEFT OUTER JOIN CART C ON(C.CART_PROD =B.PROD_ID AND C.CART_NO LIKE '2005%')
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;



(서브쿼리 사용)
SELECT A.PROD_ID AS 상품코드, 
       A.PROD_NAME AS 상품명, 
        AS 매입수량,
        AS 매출수량
  FROM PROD A, 
       (2005년 상품별 매입수량 집계)B, 
       (2005년 상품별 매출수량 집계)C  --A테이블을 기준으로 B,C가 확장되는것은 가능하다.
WHERE A.PROD_ID = B.상품코드(+)
  AND A.PROD_ID = C.상품코드(+)
ORDER BY 1;




(서브쿼리 사용2)
SELECT A.PROD_ID AS 상품코드, 
       A.PROD_NAME AS 상품명, 
       NVL(B.BSUM,0) AS 매입수량,
       NVL(C.CSUM,0) AS 매출수량
  FROM PROD A, 
       ( SELECT BUY_PROD AS BID,
                SUM(BUY_QTY) AS BSUM 
            FROM BUYPROD
          WHERE BUY_DATE BETWEEN TO_DATE('20050101')AND TO_DATE('20051231')
          GROUP BY BUY_PROD )B, 
          
       ( SELECT CART_PROD AS CID,
                SUM(CART_QTY) AS CSUM
            FROM CART
          WHERE CART_NO LIKE '2005%'
          GROUP BY CART_PROD )C  --A테이블을 기준으로 B,C가 확장되는것은 가능하다.
WHERE A.PROD_ID = B.BID(+)
  AND A.PROD_ID = C.CID(+)
ORDER BY 1;






