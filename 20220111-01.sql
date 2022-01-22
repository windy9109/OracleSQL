2022-0111-01)

  3) LPAD(c1,n[,c2]), RPAD(c1,n[,c2])
  - 정의된 기억공간의 크기(n)에서 c1문자열을 채우고 남는 공간 왼쪽(LPAD) 꼬는 오른쪽(PRAD)에 c2를 채움
  - c2가 생략되면 공백을 채움
  - 수표보호문자 등에 주로 사용되었음
  
  사용예)상품테이블에서 상품명을 출력하되 왼쪽 남는 공간에 '*'를 채워 출력하시오
        
        --한글은 정렬이 일정하지않음
        SELECT LPAD(PROD_NAME,40,'*'),
               RPAD(PROD_NAME,40,'*')
            FROM PROD;
            
        --영문은 정렬이 일정함    
        SELECT LPAD(EMP_NAME,50), SALARY
            FROM HR.EMPLOYEES;
            
            
        --숫자는 정렬이 일정함  
        SELECT LPAD(SALARY,8,'*')
            FROM HR.EMPLOYEES;
            
            
            
        5)LTRIM(C1[,C2]),RTRIM(C1[,C2])
        - 주어진 문자열 맨오른쪽(RTRIM) 또는 왼쪽(LTRIM)의 문자열이 C2와 일치하면 삭제
        - C2가 생략되면 공백을 삭제
        -- 현재는 공백 삭제용으로 많이 쓰임
        
**회원테이블(MEMBER)의 구조와 데이터를 복사하여 CUSTOMER테이블을 
  생성하고 이름컬럼(MEM_NAME)의 데이터 타입을 CHAR(20)으로 변경하시오.

--만들어진 테이블을 테스트용으로 쓰고 버릴때 'CREATE 테이블명 AS 서브쿼리'로 생성함
CREATE TABLE CUSTOMER AS
    SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
        FROM MEMBER;
        
ALTER TABLE CUSTOMER
    MODIFY(MEM_NAME CHAR(20));
        
SELECT * FROM CUSTOMER
    --WHERE MEM_NAME='오철희'; --9바이트
       WHERE RTRIM(MEM_NAME)='오철희';
       
       
       
    SELECT MEM_ID,
            MEM_NAME, --공간남음
            RTRIM(MEM_NAME) AS 이름, --공간삭제
            MEM_MILEAGE
        FROM CUSTOMER;
        

SELECT LTRIM('PERSIMMON','PER')
       RTRIM('PERSIMMON','ON')
    FROM DUAL;
    
-- SELECT LTRIM('PERSIMMON','ER')과 같이 부분문자열부터 적게되면 제거 되지않는다.
-- 무조건 진행방향의 첫글자부터
    
        
        6)TRIM(C1)
        - 주어진 문자열 C1의 앞과 뒤에 존재하는 모든 무효의 공백을 제거
        - 문자열 내부에 공백 제거는 불가능

사용예) CUSTOMER테이블의 이름컬럼의 자료타입을 VARCHAR2(20)
       형식으로 변환하시오.
       
       ALTER TABLE CUSTOMER
            MODIFY(MEM_NAME VARCHAR(20));
            
            COMMIT;
            
      SELECT * FROM CUSTOMER;
      

      --고정길이 자료형을 가변길이로 사용하려면 UPDATE문이 필수임
      UPDATE CUSTOMER
        SET MEM_NAME = TRIM(MEM_NAME);
        
        COMMIT;
        
     SELECT * FROM CUSTOMER;
      
      
7)SUBSTR(c1,n1[,n2])
- 주어진 문자열 c1에서 n1번째에서 n2 갯수 만큼의 문자를 추출 
--자바는 n2가 끝나는 위치(오라클에서는 추출될 문자갯수)
- n1, n2는 1부터 시작하는 index
- n2가 생략되면 n1 부터 그 이후의 모든 문자열이 추출
- 추출된 결과도 문자열임
- n1이 음수이면 오른쪽 문자열부터 처리        

사용예) 
    SELECT SUBSTR('APPLEBANNER','2','5'), --출력결과 PPLEB
            SUBSTR('APPLEBANNER','2'), -- 출력결과 PPLEBANNER 
            SUBSTR('APPLEBANNER','-6','5') --출력결과 (음수이므로 오른쪽 끝에서 카운팅) BANNE
        FROM DUAL;
        
        
** 회원테이블에서 MEM_REGNO1
   j001 김윤희    751019	   2448920    1975/11/21 자료를
   j001 김윤희    001019    4448920    2000/11/21 자료로
   
   UPDATE MEMBER
    SET MEM_REGNO1='001019',
        MEM_REGNO2='4448920',
        MEM_BIR='2000/11/21'
    WHERE MEM_ID='j001';
    
    COMMIT;
   
   t001 성원태   760506     1454731	1976/05/06 자료를
   t001 성원태   010506	   3454731  2001/05/06 자료로
   
   
      UPDATE MEMBER
    SET MEM_REGNO1='010506',
        MEM_REGNO2='3454731',
        MEM_BIR='2001/05/06'
    WHERE MEM_ID='t001';
    
    COMMIT;
    
   
   b001	이쁜이	741004	4900000	1974/01/07 자료를
   b001	이쁜이	031004	4900000	2003/01/07 로 변경
   
   
      UPDATE MEMBER
    SET MEM_REGNO1='031004',
        MEM_REGNO2='4900000',
        MEM_BIR='2003/01/07'
    WHERE MEM_ID='b001';
    
    COMMIT;
   
   
   
** 표현식 
    - SELECT 문에서 사용되는 비교기능을 가진 수식
    - CASE WHEN THEN과 DECODE가 제공
    (사용형식1)
    CASE WHEN 조건식 THEN 결과1
         WHEN 조건식 THEN 결과2
                 :
             [ELSE 결과n]
        END
        
        
    (사용형식2) --조건식 한개를 CASE뒤에 놓고 비교한다.
    CASE 조건식 WHEN 값1 THEN 결과1
               WHEN 값2 THEN 결과2
                 :
                [ELSE 결과n]      
    END
    

    (사용형식3)
    DECODE(컬럼명, 조건1, 결과, 조건2, 결과2,...)
    END
        
        
   
   
사용예) 회원테이블에서 20대 이하의 회원정보를 조회하시오.
        Alias는 회원번호, 회원명, 성별, 나이, 마일리지
        성별에는 '여성회원', '남성회원', 중 하나 출력
        나이는 주민번호를 이용하여 구하시오.
        
 
   SELECT MEM_ID AS 회원번호, 
          MEM_NAME AS 회원명, 
          CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR SUBSTR(MEM_REGNO2,1,1)='3' THEN '남성회원' ELSE '여성회원' END AS 성별, 
          MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
          CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR 
                    SUBSTR(MEM_REGNO2,1,1)='2' THEN 
                    EXTRACT(YEAR FROM SYSDATE)- 
                        (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900) 
          ELSE      
                    EXTRACT(YEAR FROM SYSDATE)- 
                        (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000) END AS 나이,
          MEM_MILEAGE AS 마일리지
     FROM MEMBER
   WHERE EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM MEM_BIR)<=29;
   
   
   
   
   --자료추가
 q001	육평회	721020	1402722	1972/10/20 자료를
 q001	육평회	951020	1402722	1995/10/20 로 변경
   
   
      UPDATE MEMBER
    SET MEM_REGNO1='951020',
        MEM_REGNO2='1402722',
        MEM_BIR='1995/10/20'
    WHERE MEM_ID='q001';
    
    COMMIT;
   
   
   
8) REPLACE(c1, c2,[,c3])
- 주어진 문자열 c1에 포함된 c2문자열을 찾아 c3문자열로 치환
- c3가 생략되면 c2문자열을 제거함
- 반복된 c3를 모두 제거
- 문자열 내부 공백제거에 주로 사용

사용예) 
    SELECT REPLACE('APPLEPERSIMMON','P','K') --반복된 전부를 바꾼다. P > K
        FROM DUAL;
    
    SELECT REPLACE('APPLEPERSIMMON','PL','KL') --반복된 전부를 바꾼다. PL > KL
        FROM DUAL;
        
        
사용예) 
    SELECT PROD_ID AS 상품코드,
        PROD_NAME AS 상품명1,
        REPLACE(PROD_NAME,' ') AS 상품명2, --문자열 내부에 있는 공백을 찾아서 제거하세요 라는 뜻.
        PROD_PRICE AS 판매가격
      FROM PROD
    WHERE PROD_COST>=300000;
            
            

9) ASCII(C1), CHR(n1) 
- ASCII(C1) : C1문자열의 ASCII 코드값 --C1 문자열의 맨첫글자만 아스키 코드값으로 변환
- CHR(n1): n1 코드에 대응하는 문자열 반환

SELECT ASCII('ABC'), ASCII('대'), 
        CHR(65)
    FROM DUAL;
    
    
10)LENGTH(C1), LENGTHB(c1)
- LENGTH(C1): 주어진 문자열 C1 내의 글자수를 반환
- LENGTHB(C1): 주어진 문자열 C1내의 기억공간의 크기(BYTE) 반환






    
            
            
            