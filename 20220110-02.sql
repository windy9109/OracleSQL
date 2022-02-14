2022-0110-02)함수(FUNCTION)
- 자주사용되는 모듈을 미리 컴파일하여 실행 가능한 상태로 저장된 프로그램
- 오라클에서 제공하는 함수와 사용자가 작성하는 함수가 있다.
- 함수는 중첩사용이 가능(예외로 집계함수간의 중첩은 허용되지 않음)
- 문자열함수, 숫자함수, 날짜함수, 형변환함수, NULL처리 함수, 집계함수 등이 제공


1. 문자열 함수
    1) CONCAT(c1,c2) --두개밖에 결함 못시킴 2개 이상은 두번 중첩사용해야함.
      . 주어진 두 문자열 c1과 c2를 결합하여 새로운 문자열 반환
      . 문자열 결합 연산자 '||'와 같은 기능
       
사용예) 사원테이블에서 FIRST_NAME과 LAST_NAME을 결합하여 출력하시오
        
        SELECT EMPLOYEE_ID AS 사원번호, 
               FIRST_NAME AS FIRST_NAME, 
               LAST_NAME AS LAST_NAME, 
               CONCAT(FIRST_NAME,LAST_NAME) AS "결합된 이름" --컬럼 이름에 공백이 포함된 경우 ""로 감싸준다.
          FROM HR.EMPLOYEES;
          
          
          --결합된 이름 데이터 사이에 공백을 넣을 경우(중첩함수 사용)
          --함수 중첩시 안쪽부터 실행되며 바깥쪽으로 나간다.
          
        SELECT EMPLOYEE_ID AS 사원번호, 
               FIRST_NAME AS FIRST_NAME, 
               LAST_NAME AS LAST_NAME, 
               CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS "결합된 이름" --컬럼 이름에 공백이 포함된 경우 ""로 감싸준다.
          FROM HR.EMPLOYEES;
          
          -- SELSCT FIRST_NAME||' '|| LAST_NAME AS "결합된 이름"
          
       2)LOWER(C1), UPPER(C1), INITCAP(C1)
       . LOWER(C1): 주어진 문자열 C1에 포한된 모든 문자를 소문자로 변환
       . UPPER(C1): 주어진 문자열 C1에 폰함된 모든 문자를 대문자로 변환
       . INITCAP(C1):주어진 문자열 C1의 단어 시작글자만 대문자로 변환 -- 낙타식 표기법
       
       
사용예) 상품테이블에서 분류코드가 'P102'에 속한 상품을 조회하시오
       Alias는 상품코드, 상품명, 매입가격, 매출가격
       
       SELECT PROD_ID AS 상품코드, 
              PROD_NAME AS 상품명, 
              PROD_COST AS 매입가격, 
              PROD_PRICE AS 매출가격
           FROM PROD
        -- WHERE PROD_LGU = 'p102'; 
        -- 문자열은 소문자 대문자 구분함
         WHERE LOWER(PROD_LGU)='p102'; --대소문자 구분없이 출력하게 도와줌
       
       
** 사원테이블의 FIRST_NAME과 LAST_NAME를 모두 소문자로 변경하여 저장하시오.

    UPDATE HR.EMPLOYEES
        SET FIRST_NAME=LOWER(FIRST_NAME),
            LAST_NAME=LOWER(LAST_NAME);
            
    COMMIT;
    
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
        FROM HR.EMPLOYEES;
        
사용예) 사원테이블의 FIRST_NAME과 LAST_NAME를 결합하되 중간에 공백을 삽입하고 단어 첫글자를 대문자로 변환하여 출력하시오.
            
            SELECT EMPLOYEE_ID,
                   FIRST_NAME,
                   LAST_NAME,
                   INITCAP(FIRST_NAME||' '||LAST_NAME)   
             FROM HR.EMPLOYEES;
       
       
       
       
       
       
       
       
       
       
          
          
