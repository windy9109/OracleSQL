2022-0110-01)

(3) BETWEEN 연산자 --Like연산자에는 날짜데이터 사용 불가능, 따라서 BETWEEN연산자 사용
- 범위를 지정하여 데이터를 비교할때 사용
- AND 연산자로 변환 가능

(사용형식)
컬럼|수식   BETWEEN 값1 AND 값2




사용예) 상품테이블(PROD)에서 판매가격(PROD_PRICE)이 10만원에서 20만원 사이에 속한 상품정보를 조회하시오.
        Alias는 상품코드, 상품명, 분류코드, 판매가격이다.
        
(AND 연산자 사용)
        
        SELECT PROD_ID AS 상품코드,
                PROD_NAME AS 상품명,
                PROD_LGU AS 분류코드,
                PROD_PRICE AS 판매가격
            FROM PROD
         WHERE PROD_PRICE >= 100000 AND PROD_PRICE <= 200000;
         
         
         
(BETWEEN 연산자 사용)
        SELECT PROD_ID AS 상품코드,
                PROD_NAME AS 상품명,
                PROD_LGU AS 분류코드,
                PROD_PRICE AS 판매가격
            FROM PROD
         WHERE PROD_PRICE 100000 BETWEEN 200000;
         
         
         
사용예) 장바구니 테이블(CART)에서 2005년 7월에 판매된 제품을 조회하시오
        Alias는 날짜, 상품코드, 판매수량이다.
        
        SELECT SUBSTR(CART_NO,1,8) AS 날짜,
                CART_PROD AS 상품코드,
                CART_QTY AS 판매수량
            FROM CART
          WHERE SUBSTR(CART_NO,1,6)='200507'; -- 월만 조회 하므로 앞 6글자만 추출해도 가능(문자열 비교임)
          
          
          
         
사용예) 매입 테이블(BUYPROD)에서 2005년 2월에 매입상품을 조회하시오
        Alias는 날짜, 상품코드, 매입수량, 매입금액이다.
            
        SELECT  BUY_DATE AS 날짜, --날짜는 날짜로 비교한다.
                BUY_PROD AS 상품코드,
                BUY_QTY AS 매입수량,
                BUY_QTY*BUY_COST AS 매입금액
            FROM BUYPROD
          WHERE BUY_DATE BETWEEN '20050201' AND '20050228';
         --WHERE BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201');
         --윤년인지 평년인지 모를때 마지막 날짜 LAST_DAYD를 쓰자.
        -- SELECT LAST_DAY('20050201') FROM DUAL;
                
    SELECT * FROM BUYPROD;
            
            
         
         
            
            
** 사원이름을 합쳐 새로운 컬럼에 저장
    컬럼명 : EMP_NAME VARCHAR2(50) <= FIRST_NAME,' ',LAST_NAME 저장
    
    ALTER TABLE HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(50));
    
    UPDATE HR.EMPLOYEES
       SET EMP_NAME = FIRST_NAME||''||LAST_NAME;
        COMMIT;
        
        
        
사용예) HR계정의 사원테이블(EMPLOYEES)에서 2006년 이전에 입사한 사원정보를 조회하시오
        Alias는 사원번호, 사원명, 입사일, 부서코드
        단, 출력은 입사일 순으로 출력할것
        

        SELECT EMPLOYEE_ID AS 사원번호, 
               EMP_NAME AS 사원명, 
               HIRE_DATE AS 입사일, 
               JOB_ID AS 부서코드
            FROM HR.EMPLOYEES
        WHERE HIRE_DATE <= LAST_DAY('20051201') -- 날짜를 문자로 표기할때는 년월일을 맞춰서 표기하고 중간에 기호를 넣지않는다.
        -- WHERE HIRE_DATE <ANY '20060101'
        -- WHERE HIRE_DATE < '20060101'
         ORDER BY 3;
        
        COMMIT;
        
         
사용예) 회원테이블(MEMBER)에서 '김'씨 ~ '박'씨 성을 가진 회원 중 마일리지 2000이상인 회원을 조회하시오.
       Alias는 회원번호, 회원명, 주소, 마일리지
       단 성씨순으로 출력하시오.
       
       SELECT MEM_ID AS 회원번호, 
              MEM_NAME AS 회원명, 
              MEM_ADD1 ||' '|| MEM_ADD2 AS 주소, 
              MEM_MILEAGE AS 마일리지
            FROM MEMBER
         WHERE SUBSTR(MEM_NAME,1,1) BETWEEN '김' AND '박' AND MEM_MILEAGE >=2000
         -- BETWEEN 숫자, 문자, 날짜에 쓸수있음
            ORDER BY 2;
         
       
(4)LIKE 연산자 
--되도록 안쓰는게 좋음 WHY? 상당히 많은 데이터를 뽑아냄. 과부하 위험
- 문자열의 패턴을 비교할때 사용
- 패턴문자열(와일드카드): %,_사용
- '%':'%'이 사용된 위치에서 뒤에 존재하는 모든 문자열과 대응
    ex) '김%':'김' 으로 시작하는 모든 문자열과 대응
        '%김':'김' 으로 끝나는 모든 문자열과 대응
        '%김%': 문자열 내부에 '김' 이라는 문자열이 있으면 결과가 참(true)
        
- '_':'_'가 사용된 위치에서 한글자와 대응
    ex) '김':'김' 으로 시작하고 2글자인 문자열과 대응
        '_김': 2글자로 구성되고 '김'으로 끝나는 모든 문자열과 대응
        '_김_': 3글자이면서 중간의 글자가 '김'인 문자열과 대응



사용예) 장바구니 테이블(CART)에서 2005년 7월에 판매된 제품을 조회하시오. LIKE 연산자 사용
        Alias는 날짜, 상품코드, 판매수량이다.

        SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS 날짜, --TO_DATE로 날짜형식으로 변환
               CART_PROD AS 상품코드, 
               CART_QTY AS 판매수량
            FROM CART
          WHERE CART_NO LIKE '200507%';
          
        
사용예) 회원테이블에서 거주지가 '충남'인 회원을 조회 하시오
       Alias는 회원번호, 회원명, 주소, 직업, 마일리지
       
       SELECT MEM_ID AS 회원번호, 
              MEM_NAME AS 회원명, 
              MEM_ADD1|| ' ' || MEM_ADD2 AS 주소, 
              MEM_JOB AS 직업, 
              MEM_MILEAGE AS 마일리지
         FROM MEMBER
        WHERE MEM_ADD1 LIKE '충남%';


사용예) 회원테이블에서 거주지가 '충남'이거나 '서울' 회원을 조회 하시오
       Alias는 회원번호, 회원명, 주소, 직업, 마일리지
       
       SELECT MEM_ID AS 회원번호, 
              MEM_NAME AS 회원명, 
              MEM_ADD1||' '||MEM_ADD2 AS 주소,
              MEM_JOB AS 직업, 
              MEM_MILEAGE AS 마일리지
          FROM MEMBER
        WHERE SUBSTR(MEM_ADD1,1,2) IN('충남','서울'); --효율적인 연산
        --비효율적 연산
        --WHERE MEM_ADD1 LIKE '충남%' AND MEM_ADD1 LIKE '서울%'
        
사용예) 2005년 4월 매입상품별 판매정보를 조회하시오
       Alias는 상품코드, 상품명, 수량합계, 금액합계

        
       SELECT A.BUY_PROD AS 상품코드, 
              B.PROD_NAME AS 상품명, 
              SUM(A.BUY_QTY) AS 수량합계, 
              SUM(A.BUY_QTY*B.PROD_COST) AS 금액합계
            FROM BUYPROD A, PROD B -- 테이블에도 별칭 사용가능, 테이블 별칭은 복잡하게 부여안함. A,B,C,와 같은
        WHERE A.BUY_PROD = B.PROD_ID --JOIN 조건
          AND A.BUY_DATE BETWEEN '20050401' AND LAST_DAY('20050401') --날짜데이터에 LIKE를 절대 쓰면안됨! BETWEEN
        GROUP BY A.BUY_PROD, B.PROD_NAME
        ORDER BY 1;
        
        

        
        

