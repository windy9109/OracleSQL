2022-0107-02)데이터 검색명령(SELECT)
 
**객체삭제 (DROP)
. 테이블 삭제
  DROP TABLE 테이블명; 
  
  사용예)쇼핑몰 테이블(BUYER, BUYPROD, CART, LPROD, MEMBER)을 제외하고 모든 테이블을 삭제
        DROP TABLE ORDER_GOODS;
        DROP TABLE ORDERS;
        DROP TABLE CUSTOMERS;
        DROP TABLE GOODS;
        
        DROP TABLE TEMP_01;
        DROP TABLE TEMP_02;
        DROP TABLE TEMP_03;
        DROP TABLE TEMP_04;
        DROP TABLE TEMP_05;
        DROP TABLE TEMP_06;
        DROP TABLE TEMP_07;
        DROP TABLE TEMP_08;
        DROP TABLE TEMP_09;
    


**HR계정 활성화
1. HR계정의 잠금해제
   ALTER USER HR ACCOUNT UNLOCK;
   
2. HR계정 암호설정
   ALTER USER HR IDENTIFIED BY java;
   
        
**데이터 검색 명령
  -SELECT문 제공
  -SQL명령 중 가장 많이 사용되는 명령
  
(사용형식)
SELECT * |[DISTINCT]컬럼명 [AS 컬럼별칭][,] --마지막 실행(AS사용시 주의) / DISTINCT 중복배제
        컬럼명[AS 컬럼별칭][,]
                :
        컬럼명 [AS 컬럼별칭]
    FROM 테이블명 --1
    [WHERE 조건  --2
        [AND 조건,...]]
    [GROUP BY 컬럼명[,컬럼명,...]] -- 특정컬럼명 안에서 그룹별로 묶은것(EX. 학급별, 부서별)
        [HAVING 조건] -- SUM, COUNT, AVG, MIN, MAX 다섯개의 집계함수 사용
        [ORDER BY 컬럼명|컬럼index [ASC|DESC][, -- 정렬(컬럼 중심)
                    컬럼명|컬럼index [ASC|DESC],...]];
                

. 'DISTINCT': 중복배제
. 'AS 컬럼별칭': 컬럼에 부여한 또 다른 이름. 컬럼의 제목 출력할 목적
. '컬럼별칭'에 특수문자(공백등)나 예약어가 포함된 경우 반드시 ""로 묶어 주어야함!!!
. 특정 테이블이 없거나 불필요한 경우 시스템이 제공하는 더미(DUMMY)테이블인 DUAL을 사용


사용예) 회원테이블(MEMBER)에서 여성회원들의 정보를 조회하시오
        Alias는 회원정보, 회원명, 주소, 나이, 마일리지이다.
        
        SELECT MEM_ID AS 회원정보, 
               MEM_NAME AS 회원명, 
               MEM_ADD1 ||' '||MEM_ADD2 AS 주소, 
               EXTRACT(YEAR FROM SYSDATE)- --추출
                EXTRACT(YEAR FROM MEM_BIR) AS 나이, 
               MEM_MILEAGE AS 마일리지
          FROM MEMBER
            WHERE SUBSTR(MEM_REGNO2,1,1)='2'; --여성회원만인 조건, 주민등록에서 뒷자리 첫번째 글자만 추출한다.
            --SUBSTR 문자 추출
            
            
사용예) DUAL로 2636363*24242 값을 출력
       SELECT 2636363*24242 FROM DUAL; --연산(중복배제)
       
       SELECT SYSDATE FROM DUAL; --오늘 날짜 출력
       
1)연산자
- 산술연산자(+,-,/,*)
- 비교(관계)연산자(>,<,=,>=,<=,!=(<>))
- 논리연산자(NOT, AND, OR)
-- NOT>AND>OR순으로 실행
-- 단항 우선 출력, 산술 > 비교연산자

사용예) HR계정의 사원테이블(EMPLOYEES)에서 보너스를 구하고 각 사원의 급여 지급액을 구하시오.
        보너스 = 기본급(SALARY)*영업실적(COMMISSIN_PCT)
        지급액 = 기본급+보너스
        Alias는 사원번호, 사원명, 기본급, 보너스, 지급액이다.
        
        SELECT EMPLOYEE_ID AS 사원번호, 
               FIRST_NAME||''||LAST_NAME AS 사원명, 
               SALARY AS 기본급, 
               COMMISSION_PCT AS 영업실적,
               NVL(SALARY * COMMISSION_PCT,0) AS 보너스, 
               SALARY + NVL(SALARY*COMMISSION_PCT,0) AS 지급액 --NULL값을 0으로 바꿈
        FROM HR.EMPLOYEES;  --다른 사람의 자료를 쓰려면 유저명을 반드시 기입 .(dot)는 소속나타냄
        
        
사용예) 회원테이블에서 마일리지가 3000 이상인 회원을 조회하시오
       Alias는 회원번호, 회원명, 마일리지, 직업
       
       SELECT MEM_ID AS 회원번호, 
              MEM_NAME AS 회원명, 
              MEM_MILEAGE AS 마일리지, 
              MEM_JOB AS 직업
         FROM MEMBER --내계정은 유저명. 생략가능
            WHERE MEM_MILEAGE >= 3000
            ORDER BY 3 DESC; --SELECT의 위에서 3번째인 MEM_MILEAGE AS 마일리지가 내림차순으로 정렬된다.(컬럼이 기술되어진 순번)
        --ORDER BY MEM_MILEAGE DESC; 도 똑같은 뜻
        
        
        
        
  사용예) 회원테이블에서 마일리지가 3000 이상이면서 거주지가 '대전'인 회원을 조회하시오
         Alias는 회원번호, 회원명, 마일리지, 직업, 성별
         성별란에는 '여성회원','남성회원' 중 하나를 출력
         
         SELECT MEM_ID AS 회원번호, 
                MEM_NAME AS 회원명, 
                MEM_MILEAGE AS 마일리지, 
                MEM_JOB AS 직업, 
                --MEM_JOB AS 직 업
                --공백이 들어가게 되면 SELECT절이 끝난것으로 간주. 오류메세지 "FROM keyword not found where expected"
                --오라클은 공백이 끝을 뜻함.
                CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' THEN 
                          '남성회원' 
                          ELSE 
                          '여성회원' 
                          END  AS 성별 
            FROM MEMBER
           WHERE MEM_MILEAGE >= 3000
             AND MEM_ADD1 LIKE '대전%'; -- % 와일드카드
             
             
사용예) 년도를 입력받아 윤년과 평년을 구별하시오
        ACCEPT P_YEAR PROMPT '년도입력:'
        DECLARE
         V_YEAR NUMBER := TO_NUMBER('&P_YEAR');
         V_RES VARCHAR2(100);
        BEGIN
         IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0)OR
            (MOD(V_YEAR,400)=0) THEN
            V_RES:=V_YEAR||'년도는 윤년입니다.';
            ELSE
            V_RES:=V_YEAR||'년도는 평년입니다.';
            END IF;
            DBMS_OUTPUT.PUT_LINE(V_RES);
        END;
        
2)기타연산자
- 범위지정이나 복수개의 표현식을 지정할때 등을 표현
- IN, ANY, SOME, ALL, BETWEEN, LIKE, EXISTS 등이 제공
(1) IN 연사자 --(OR와 비슷함)
. 질의 탐색을 위해 사용될 둘 이상의 표현식을 지정
. 제시된 복수개의 자료 중 어느하나와 일치하면 전체 결과가 참을 반환
  전체 결과가 참을 반환
(사용형식)
  컬럼명 IN (값1[, 값2,...]) -- IN 안에 =(관계연산자)가 포함되어 있기 때문에 비교연산자 사용불가
  - '컬럼명'에 저장된 값이 '값1[, 값2,...]'중 어느하나와 일치하면 결과가 참(true)을 반환
  - =ANY, =SOME 으로 바꾸어 사용 가능함
  - 연속된 값은 BETWEEN으로, 불연속적인 값의 비교는 IN으로 수행
  - OR연산자로 치환 가능
  
  
  사용예) 사원테이블에서 부서번호 20, 50, 90, 110에 속하는 사원정보를 조회하시오.
        Alias는 사원번호, 사원명, 부서번호, 급여
        
        --OR연산의 경우
        SELECT EMPLOYEE_ID AS 사원번호, 
               FIRST_NAME||''||LAST_NAME AS 사원명, 
               DEPARTMENT_ID AS 부서번호, 
               SALARY AS 급여
        FROM HR.EMPLOYEES
        WHERE DEPARTMENT_ID=20
           OR DEPARTMENT_ID=50
           OR DEPARTMENT_ID=90
           OR DEPARTMENT_ID=110;
           
           
        --IN연산의 경우
        SELECT EMPLOYEE_ID AS 사원번호, 
               FIRST_NAME||''||LAST_NAME AS 사원명, 
               DEPARTMENT_ID AS 부서번호, 
               SALARY AS 급여
        FROM HR.EMPLOYEES
        WHERE DEPARTMENT_ID IN(20,50,90,110)
        ORDER BY 3;
            

(2)ANY(SOME)연산자
. IN연산자와 유사한 기능제공
. 주어진데이터 중 어느 하나의 값과 ANY(SOME)앞에
  기술된 관계연산자를 만족하면 참(TRUE)인 결과를 반환

(사용형식)
    컬럼명 관계연산자ANY|SOME(값1[,값2,...]) -- 관계연산자ANY 사이에 공백이 오면 안됨. = ANY ->X 


사용예) 사원테이블에서 부서번호 20, 50, 90, 110에 속하는 사원정보를 조회하시오.
        Alias는 사원번호, 사원명, 부서번호, 급여 
        
        --ANY연산의 경우(IN과 유사한 결과 출력)
        SELECT EMPLOYEE_ID AS 사원번호, 
               FIRST_NAME||''||LAST_NAME AS 사원명, 
               DEPARTMENT_ID AS 부서번호, 
               SALARY AS 급여
        FROM HR.EMPLOYEES
        WHERE DEPARTMENT_ID =ANY(20,50,90,110)
        ORDER BY 3;
         


사용예)회원테이블에서 직업이 공무원인 회원들이 보유한 마일리지보다 많은 마일리지를 보유한 회원들을 조회하시오
    Alias는 회원번호, 회원명, 직업, 마일리지
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_JOB AS 직업,
           MEM_MILEAGE AS 마일리지
        FROM MEMBER
      WHERE MEM_MILEAGE >ANY(SELECT MEM_MILEAGE
                                FROM MEMBER
                                WHERE MEM_JOB='공무원');
                                -- >=는 데이터값 1:4 로 비교불가
                                -- 그래서 이때쓰는것이 ANY와 SOME임
                                -- 서브쿼리부터 먼저 실행됨
         
            
        
        
