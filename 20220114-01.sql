2022-0114-01) 집계함수(그룹함수)
- 주어진 자료를 특정 컬럼(들)을 기준으로 그룹화하고 각 그룹에서 합계(SUM), 평균(AVG), 빈돗수(COUNT), 최대값(MAX), 최소값(MIN)을 반환 하는 함수
     
    - SELECT절에 집계함수를 제외한 일반컬럼과 같이 사용되면 반드시 GROUT BY 절이 사용되어야함
    - 집계함수가 사용된 컬럼(수식)에 조건이 부여된 경우
      HAVING절로 처리
    - 집계함수들은 다른 집계함수를 포함 할수 없다.
    
    
    (사용형식)
    SELECT [컬럼 list,]
            그룹함수
        FROM 테이블명
     [WHERE 조건]
     [GROUP BY 컬럼명1][,컬럼명2,...]
    [HAVING 조건]
     [ORDER BY 컬럼명|컬럼인덱스[ASC|DESC][,...]];
     . GROUP BY 컬럼명1[,컬럼명2,...]:컬럼명1을 기준으로 그룹화 하고 각 그룹에서 다시 '컬럼명2'로 그룹화
     . SELECT절에 사용된 일반컬럼은 반드시 GROUP BY절에 기술해야하며, SELECT절에 사용되지 않은 컬럼도 GROUP BY 절에 기술가능
     . SELECT절에 그룹함수만 사용된 경우 GROUP BY절 생략(테이블 전체를 하나의 그룹으로 간주)
     . SUM(expr), AVG(expr), COUNT(*|expr), MIN(expr), MAX(expr)
     
     
     사용예) 사원테이블에서 각 부서별 급여합계를 구하시오
            Alias는 부서코드, 급여합계
            --부서별 GROUP BY, 별이 두개나온다면 컬럼명1을 GROUP BY화 후에 컬럼명2를 추가 GROUP BY한다.
            
            SELECT DEPARTMENT_ID AS 부서코드,
                    SUM(SALARY) AS 급여합계
                FROM HR.EMPLOYEES
             GROUP BY DEPARTMENT_ID
                ORDER BY 1;
        
           
     사용예) 사원테이블에서 각 부서별 급여합계를 구하되
     급여합계가 100000이상인 부서만 조회하시오.
            Alias는 부서코드, 급여합계
            
            SELECT DEPARTMENT_ID AS 부서코드,
                    SUM(SALARY) AS 급여합계
                 FROM HR.EMPLOYEES
              -- WHERE SUM(SALARY)>=100000  =>불가능 HAVING절에 들어가야함
              GROUP BY DEPARTMENT_ID
             HAVING SUM(SALARY)>=100000
                ORDER BY 1;
                
                
                
     사용예) 사원테이블에서 각 부서별 평균급여를 구하시오
            Alias는 부서코드, 부서명, 평균급여 --DEPARTMENTS와 EMPLOYEES는 DEPARTMENT_ID
             -- GROUP BY에는 별칭을 쓸수 없다.
             
            SELECT A.DEPARTMENT_ID AS 부서코드, 
                   B.DEPARTMENT_NAME AS 부서명, 
                   ROUND(AVG(A.SALARY),1)평균급여
               FROM HR.EMPLOYEES A, HR.DEPARTMENTS B  --테이블이 두개나오면 JOIN해줘야하므로 WHERE가 반드시 나옴
              WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
              --GROUP BY DEPARTMENT_ID, DEPARTMENT_NAME -- DEPARTMENT_ID, DEPARTMENT_NAME는 동등한 의미 
               GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
              ORDER BY 1;
        
    
    사용예) 상품테이블에서 각 분류별 평균매입가를 조회하시오
            --Alias는 부서코드, 부서명, 사원수 
            SELECT PROD_LGU AS 분류코드,
                    ROUND(AVG(PROD_COST),-2) AS 평균매입가
              FROM PROD
            GROUP BY PROD_LGU;
            
            
    사용예)장바구니테이블에서 2005년 4월 제품별 판매수량집계를 구하시오.
    
    
    SELECT CART_PROD AS 제품명, 
         SUM(CART_QTY) AS 판매수량집계
        FROM CART
        WHERE SUBSTR(CART_NO,1,6) = '200504'
      GROUP BY CART_PROD
        ORDER BY 1;
    
    
    사용예)장바구니테이블에서 2005년 4월 제품별 판매수량 합계가 10개이상인 매입집계를 구하시오.
    
       SELECT CART_PROD AS 제품명, 
         SUM(CART_QTY) AS 판매수량합계
        FROM CART
        WHERE SUBSTR(CART_NO,1,6) = '200504'
      GROUP BY CART_PROD
        HAVING SUM(CART_QTY)>=10
      ORDER BY 1;
    
    
    사용예)매입테이블에서 2005년 1월~6월 월별매입집계를 구하시오.
        SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월, --아래에서 이미 2005년도로 걸렀음
               SUM(BUY_QTY) AS 매입수량합계,
               SUM(BUY_QTY*BUY_COST) AS 매입금액합계
            FROM BUYPROD
          WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
        GROUP BY EXTRACT(MONTH FROM BUY_DATE)
            ORDER BY 1;
            
         
         
    (문제풀기)   
            
    사용예)장바구니테이블에서 2005년 1월~6월 월별, 제품별 매입금액 합계가 1000만원 이상인 정보만 조회하시오.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월,

  
  --정답  
--        SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS 매입월,
--           B.PROD_NAME AS 제품명,
--           SUM(A.BUY_COST*A.BUY_QTY) AS 매입금액합계
--    FROM BUYPROD A, PROD B
--    WHERE A.BUY_PROD = B.PROD_ID AND
--          EXTRACT(MONTH  FROM BUY_DATE) BETWEEN 1 AND 6
--    GROUP BY EXTRACT(MONTH FROM BUY_DATE), B.PROD_NAME
--   HAVING SUM(A.BUY_COST)>=1000000
--   ORDER BY 1;
    
    
    
    사용예)장바구니테이블에서 2005년 4월 제품별 제품별 판매수량 합계가 50개 이상인 제품을 조회하시오.
   
   
        
        
    사용예) 사원테이블에서 각 부서별 사원수를 구하시오
            Alias는 부서코드, 부서명, 사원수 
            

  
            
    사용예) 사원테이블에서 각 부서별 최대급여와 최소급여를 구하시오
            Alias는 부서코드, 부서명, 최대급여, 최소급여
          
            
            
            
    사용예) 사원테이블에서 각 부서별 평균급여를 구하시오
            Alias는 부서코드, 부서명, 평균급여
    
        -- 정답
--    SELECT A.DEPARTMENT_ID AS 부서코드, 
--              B.DEPARTMENT_NAME AS 부서명,
--              ROUND(AVG(A.SALARY),1) AS 평균급여
--        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
--       WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
--    GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
--    ORDER BY 1; 

            
   ----------------------------------------------------------------------         
            
            
            
            
            
            
            
    문제) 회원테이블에서 성별 마일리지 합계를 수하시오
         Alise는 구분, 마일리지합계 이며 구분에는 '여성회원'과 '남성회원'을 출력
         
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                     SUBSTR(MEM_REGNO2,1,1)='3' THEN '남성회원'
           ELSE '여성회원' 
           END AS 구분, 
          SUM(MEM_MILEAGE) AS 마일리지합계
        FROM MEMBER
      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                     SUBSTR(MEM_REGNO2,1,1)='3' THEN '남성회원'
           ELSE '여성회원' 
           END;

         
            
    문제) 회원테이블에서 연령대별 마일리지 합계를 조회하시오
        Alise는 구분, 마일리지합계이며 구분란에는 '10대',..'70대'등으로 연령대를 출력
        
    
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                  SUBSTR(MEM_REGNO2,1,1)='2' THEN
                  ROUND((EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900))/10)*10
             ELSE ROUND((EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000))/10)*10 
             END || '대' AS 구분, 
          SUM(MEM_MILEAGE) AS 마일리지합계
        FROM MEMBER
      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                  SUBSTR(MEM_REGNO2,1,1)='2' THEN
                  ROUND((EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900))/10)*10
             ELSE ROUND((EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000))/10)*10
             END
        ORDER BY 1;
    
    
    --다른답
   SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)||'대' AS 구분, 
            SUM(MEM_MILEAGE) AS 마일리지합계
       FROM MEMBER
   GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)
     ORDER BY 1;
     
    
    
         
    
    
사용예) 전체사원의 평균급여를 출력
    
    SELECT ROUND(AVG(SALARY)) AS 평균급여,
            SUM(SALARY) AS 급여합계,
            COUNT(*) AS 사원수
      FROM HR.EMPLOYEES;
    
    
    
    사용예)사원들의 급여가 평균급여보다 적은사원정보를 조회
          Alias는 사원번호, 사원명, 부서코드, 직무코드, 급여, 평균급여 
          --여러컬럼조회할때는 GROUP BY를 쓰지않고 서브쿼리를 쓴다.
          
    SELECT A.EMPLOYEE_ID AS 사원번호, 
           A.EMP_NAME AS 사원명, 
           A.DEPARTMENT_ID AS 부서코드, 
           A.JOB_ID AS 직무코드, 
           A.SALARY AS 급여,
           B.ASAL AS 평균급여
      FROM HR.EMPLOYEES A,
            (SELECT ROUND(AVG(SALARY)) AS ASAL FROM HR.EMPLOYEES)B 
            --서브쿼리가 1번만 실행하고 계속참조하는 형태
        WHERE A.SALARY < B.ASAL
      ORDER BY 1;
    

    
      
            
    
    
    
    
    
    
    
    
    
