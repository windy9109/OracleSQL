2022-0113-01) 형변환함수
  1)CAST(expr AS 타입명)
-- TO_CHAR, TO_NUMBER, TO_DATE
    - 'expr'로 정의된 컬럼 또는 수식의 데이터 타입이 '타입명' 형식으로 변환

사용예) 장바구니 테이블에서 2005년 5월 판매정보를 조회하시오
        Alias는 일자,상품명,수량,금액이며 일자순으로 출력하시오
 
    
SELECT CAST(SUBSTR(CART.CART_NO,1,8)AS DATE) AS 일자,
       PROD.PROD_NAME AS 상품명,
       CART.CART_QTY AS 수량,
       CART.CART_QTY*PROD_PRICE AS 금액
    FROM CART, PROD
  WHERE CART.CART_PROD = PROD.PROD_ID --조인조건
    AND CART.CART_NO LIKE '200505%'
  ORDER BY 1;
  
  
  2) TO_CHAR(expr[,fmt])
  - 문자열(CHAR, CLOB=>VARCHAR2로), 숫자, 날짜 자료를 문자열 자료로 형변환
  - 숫자,날짜->문자(O) / 문자->문자(X)
  - 변환형식을 지정할때에는 'fmt'(형식지정문자열)을 기술
  - 날짜관련 형식문자열
----------------------------------------------------------------------
    FORMAT              의미                    사용예
----------------------------------------------------------------------
    BC,AD            서기,기원전        SELECT TO_CHAR(SYSDATE,'BC') FROM DUAL; --양수이기때문에 서기로 출력됨
    CC               세기              SELECT TO_CHAR(SYSDATE,'CC') FROM DUAL;
    YYYY,YYY,YY,Y    년도             SELECT TO_CHAR(SYSDATE,'YYYY'),
                                            TO_CHAR(SYSDATE,'YYY'), 
                                            TO_CHAR(SYSDATE,'YY'), 
                                            TO_CHAR(SYSDATE,'Y') --왼쪽부터 하나씩 제거
                                        FROM DUAL; 
    MM              (01~12월)
    MON, MONTH      월                SELECT TO_CHAR(SYSDATE,'MM'),
                                             TO_CHAR(SYSDATE,'MONTH'), --(글자까지 포함되어출력)
                                             TO_CHAR(SYSDATE,'MON') --(글자까지 포함되어출력)
                                        FROM DUAL;  
    DD              (01~31)일표시
    DDD             (01~365)일표시
    D               한 주의 순번 값(일요일부터 1)
    DY              '월'~'일'
    DAY             '월요일'~'일요일'     SELECT TO_CHAR(SYSDATE,'DD'), --한달(31)중 일을 출력
                                               TO_CHAR(SYSDATE,'DDD'), -- 365일표시
                                               TO_CHAR(SYSDATE,'D'), --요일순번값
                                               TO_CHAR(SYSDATE,'DY'),--요일출력(축약)
                                               TO_CHAR(SYSDATE,'DAY') --요일출력
                                            FROM DUAL;
    WW              연중 주(01~53)       SELECT TO_CHAR(SYSDATE, 'WW')
                                          FROM DUAL;
    AM, PM                              SELECT TO_CHAR(SYSDATE, 'PM') --SYSDATE를 쓰면 현재시간에 맞추어 무조건 출력된다.
                                          FROM DUAL;
    A.M., P.M.      오전,오후
    HH, HH12, HH24  시간                 SELECT TO_CHAR(SYSDATE, 'HH')
                                          FROM DUAL;
    MI              분
    SS              초(01~60)
    SSSSS           초(01~86000)         SELECT TO_CHAR(SYSDATE, 'HH:MI:SS'),
                                                TO_CHAR(SYSDATE, 'HH:MI:SSSSS')
                                          FROM DUAL;
                    --하루는 86000초
  
  ----------------------------------------------------------------------
  
    SELECT TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8)))
      FROM CART
     WHERE CART_NO LIKE '200504%';
  
  --업데이트됨
  SELECT TO_CHAR(CART_NO) 
    FROM CART;
  

  - 숫자관련 형식문자열
----------------------------------------------------------------------
    FORMAT              의미                    사용예
----------------------------------------------------------------------
      9         대응되는 무효의 0을 공백처리        99999 --유효숫자를 만나면 유효숫자 출력
                                               01234
                                            ----------- 9(5)라면
                                                1234
                                               
                                         SELECT TO_CHAR(12345,'9999999') AS AL
                                            FROM DUAL;
                                         
 
     0         대응되는 무효의 0을 '0'으로 출력     99999 --유효숫자를 만나면 유효숫자 출력
                                               01234
                                            ----------- 9(5)라면
                                               01234
                                               
                                        SELECT TO_CHAR(12345,'0000000') AS AL
                                            FROM DUAL;


    PR      자료가 음수이면 <> 안에 출력       SELECT TO_CHAR(124,'99999PR'), --양수는 반응 없음
                                                 TO_CHAR(-124,'99999PR') --<124>
                                              FROM DUAL;

    ,(COMMA)        자리점
    .(DOT)          소숫점                 SELECT TO_CHAR(1234,'99,999.9PR'), --자리맞춰줌
                                                 TO_CHAR(-1234,'99,999.0PR')
                                              FROM DUAL;

    $,L            화폐기호                 SELECT TO_CHAR(1234,'$99,999.9PR'),
                                                 TO_CHAR(-1234,'L99,999.0PR') --L은 원화 기호 출력
                                              FROM DUAL;
  ----------------------------------------------------------------------
  
    SELECT TO_NUMBER(TO_CHAR(1234,'99,9999.9'),'999999.9')+20
      FROM DUAL;



사용예) 오늘이 2005년 7월 31일이고 쇼핑몰 페이지에 처음 로그인 한 경우 장바구니번호를 생성하시오.
    
    SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||TRIM(TO_CHAR(1,'00000'))
        FROM DUAL;
   --TO_CHAR(1,'00000') 변환오류 공백
   
   
사용예) 오늘이 2005년 7월 28일이고 쇼핑몰에 새롭게 로그인 한 경우 장바구니번호를 생성하시오.

    SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
           TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000'))
       FROM CART
     WHERE SUBSTR(CART_NO,1,8) = TO_CHAR(SYSDATE,'YYYYMMDD');
    

3) TO_NUMBER(expr[,fmt])
    -문자열을 숫자자료로 반환
    -변환시킬 문자자료는 숫자로 변환가능한 자료이어야 함
    -'fmt'는 TO_CHAR에서 사용된것과 동일
    
    
        CREATE TABLE GOODS AS
        SELECT PROD_ID, PROD_NAME, PROD_LGU, PROD_PRICE
            FROM PROD;
        
    SELECT * FROM GOODS; 
    
사용예) 상품테이블(GOODS)에 다음 자료를 추가로 등록하시오
    상품명: 삼성 노트북 15인치
    거래처코드: P101000001
    판매가격: 1200000원
    
    ***(상품코드생성)***
    
    INSERT INTO GOODS
    SELECT A.P_CODE, '삼성노트북 15인치', 'P101', 1200000
        FROM 
            (SELECT 'P101'
                ||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(PROD_ID),5))+1,'000000')) AS P_CODE
            --SELECT TO_CHAR(TO_NUMBER(SUBSTR(PROD_ID,4)),'0000')||TRIM(TO_CHAR(1,'000000')) 
                FROM GOODS
                WHERE PROD_LGU='P101') A;
                
    
    SELECT *FROM GOODS
        WHERE PROD_LGU ='P101';
    
    
    
    
    SELECT TO_NUMBER('￦1,234','L99,999'),
            TO_NUMBER('<1,234>','99,999PR')+10
        FROM DUAL;
  
  
        
4)TO_DATE(expr[,fmt])
- 날짜형식의 문자열 자료를 날짜형식으로 변환하여 반환
- 'fmt'는 TO_CHAR에서 사용된 날짜형 형식 문자열과 동일


사용예)
    SELECT TO_DATE('20060708'),
           TO_CHAR(TO_DATE('20220113092035', 'YYYYMMDDHHMISS'),
                    'YYYY/MM/DD HH:MI:SS')
        FROM DUAL;
        
        
사용예) 회원테이블에서 주민등록번호를 이용하여 다음과
       같은 형식으로 자료를 출력하시오
       (출력)
       회원번호     회원명          생년월일           직업              마일리지
        XXXX       XXX       1997년 00월 00일      자영업              9999
    
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1'OR 
                SUBSTR(MEM_REGNO2,1,1)='2' THEN
                TO_CHAR(TO_DATE('19'||MEM_REGNO1),'YYYY"년" MM"월" DD"일"')
           ELSE
                TO_CHAR(TO_DATE('20'||MEM_REGNO1),'YYYY"년" MM"월" DD"일"') -- ""는 사용자 정의형식 문자열
            END  AS 생년월일,
           MEM_JOB AS 직업,
           MEM_MILEAGE AS 마일리지
        FROM MEMBER;
    
    
    
    
    
    
    
    
    
    사용예) 상품테이블(PROD)에 다음 자료를 추가로 등록하시오
---------------------------------------------------------------
상품코드       상품명      분류코드    거래처     매입      판매      할인      설명      이미지     전체재고      적정재고

