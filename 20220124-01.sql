2022-0124-01)
사용예) 2005년 모든 거래처별 매입금액합계를 조회하시오 --모든이므로 OUTER JOIN
       Alias는 거래처코드, 거래처명, 매입금액합계
        
       (일반적인 외부조인)  --모든행이 충족되지 않음 NULL제외(현주컴퓨터 조회않됨)
       SELECT A.BUYER_ID AS 거래처코드, 
              A.BUYER_NAME AS 거래처명, 
              SUM(C.PROD_COST*B.BUY_QTY) AS 매입금액합계
         FROM BUYER A, BUYPROD B, PROD C
        WHERE A.BUYER_ID = C.PROD_BUYER(+)
          AND B.BUY_PROD(+) = C.PROD_ID
          AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231')
        GROUP BY A.BUYER_ID,A.BUYER_NAME
        ORDER BY 1;
        
        
        
        (ANSI조인) --정답
       SELECT A.BUYER_ID AS 거래처코드, 
              A.BUYER_NAME AS 거래처명, 
              SUM(C.PROD_COST*B.BUY_QTY) AS 매입금액합계
         FROM BUYER A
         LEFT OUTER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER)
         LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD = C.PROD_ID AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231')) 
        GROUP BY A.BUYER_ID,A.BUYER_NAME
        ORDER BY 1;
       
       
       
       (ANSI 오답)
        SELECT A.BUYER_ID AS 거래처코드, 
              A.BUYER_NAME AS 거래처명, 
              SUM(C.PROD_COST*B.BUY_QTY) AS 매입금액합계
         FROM BUYER A
         LEFT OUTER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER)
         LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD = C.PROD_ID)
        WHERE B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231') --내부조인되서 NULL값 제외됨
        GROUP BY A.BUYER_ID,A.BUYER_NAME
        ORDER BY 1;



        (서브쿼리)  --정답
        SELECT A.BUYER_ID AS 거래처코드, 
              A.BUYER_NAME AS 거래처명, 
              SUM(C.PROD_COST*B.BUY_QTY) AS 매입금액합계
         FROM BUYER A,(2005년도 거래처별 매입금액계산) B
        ORDER BY 1;
        
        (SUBQUERY:2005년도 거래처별 매입금액계산)
        SELECT BUYER_ID AS BID
                SUM(C.PROD_COST*B.BUY_QTY) AS BSUM
           FROM BUYER A, PROD C, BUYPROD B
         WHERE C.PROD_ID = B.BUY_PROD
           AND A.BUYER_ID = C.PROD_BUYER
           AND EXTRACT(YEAR FROM B.BUY_DATE) = 2005
           GROUP BY BUYER_ID;
         
         
         
        (결합) --서브쿼리가 가장 정확함 
         SELECT D.BUYER_ID AS 거래처코드, 
              D.BUYER_NAME AS 거래처명, 
               NVL(E.BSUM,0) AS 매입금액합계
         FROM BUYER D,(SELECT A.BUYER_ID AS BID,
                             SUM(C.PROD_COST*B.BUY_QTY) AS BSUM
                           FROM BUYER A, PROD C, BUYPROD B
                         WHERE C.PROD_ID = B.BUY_PROD
                           AND A.BUYER_ID = C.PROD_BUYER
                           AND EXTRACT(YEAR FROM B.BUY_DATE) = 2005
                           GROUP BY BUYER_ID) E
        WHERE D.BUYER_ID = E.BID(+)
        ORDER BY 1;    
        
        
        
        
        

사용예)회원테이블에서 직업이 자영업인 회원들의 마일리지보다 더 많은 마일리지를 보유하고있는 회원정보를 조회하시오
      Alias는 회원번호, 회원명, 직업, 마일리지
      
      (메인쿼리: 회원번호, 회원명, 직업, 마일리지)
      SELECT MEM_ID AS 회원번호, 
             MEM_NAME AS 회원명, 
             MEM_JOB AS 직업, 
             MEM_MILEAGE AS 마일리지
       FROM MEMBER
      WHERE MEM_MILEAGE > (직업이 자영업인 회원들의 마일리지)
      ORDER BY 1;
      
      
      (서브쿼리: 직업이 주부인 회원들의 마일리지)
      SELECT MEM_MILEAGE
        FROM MEMBER
      WHERE MEM_JOB ='자영업'
      
      
      (결합) --오류
      SELECT MEM_ID AS 회원번호, 
             MEM_NAME AS 회원명, 
             MEM_JOB AS 직업, 
             MEM_MILEAGE AS 마일리지
       FROM MEMBER
      WHERE MEM_MILEAGE > (SELECT MEM_MILEAGE --1:4비교 오류
                                    FROM MEMBER
                                  WHERE MEM_JOB ='자영업')
      ORDER BY 1;
      
     
     
      (결합) --정답
      SELECT MEM_ID AS 회원번호, 
             MEM_NAME AS 회원명, 
             MEM_JOB AS 직업, 
             MEM_MILEAGE AS 마일리지
       FROM MEMBER
      WHERE MEM_MILEAGE > ALL (SELECT MEM_MILEAGE  --ANY나 SOME을 쓰면안됨. 
                                    FROM MEMBER
                                  WHERE MEM_JOB ='자영업')
      ORDER BY 1;
     
     
     
     
      