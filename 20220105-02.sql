2022-0105-02)데이터타입
- 오라클에 사용되는 데이터 타입은 문자열, 숫자, 날짜, 이진자료 등이 제공
※문자열은 반드시 '문자열'과 같이 써준다
※SQL에서 숫자는 NUMBER 데이터 타입만 사용

1. 문자열자료
  .문자자료(''로 묶인 자료)를 저자하기 위한 타입 -> 따옴표 밖에서는 대소문자 구분 안함
  .가변길이(CHAR제외한 모두)와 고정길이(CHAR)로 구분 -> 가변길이 문자열이 남으면 SYSTEM에 반납한다.
  1)CHAE(n[BYTE|CHAR])
    .고정길이 데이터 저장
    .최대 2000BYTE 저장
    .'n[BYTE|CHAR]' : 확보하는 저장공간의 크기 지정
    .'BYTE'가 default이며 'CHAR'은 n이 문자 갯수를 의미
    .한글 한글자는 3byte임 -> 따라서 한글이 저장되는 갯수는 666개임 / 알파벳은 그대로 2000자
    .보통 기본키나 길이가 고정되고 고정된길이가 중요한 경우(주민번호나 우편번호 등)에 사용
  
사용예)
  CREATE TABLE TRMP_01(
    COL1 CHAR(10 BYTE),
    COL2 CHAR(10 CHAR),
    COL3 CHAR(10));
  
오류문구)
   INSERT INTO TRMP_01(COL1,COL2,COL3)
    VALUES('대전시','대전시 중구 오류동','대전시 중구 오류동'); --COL3은 MAX 10byte 인데 26byte초과
  
정상문구)
   INSERT INTO TRMP_01(COL1,COL2,COL3)
    VALUES('대전시','대전시 중구 오류동','중구');


 SELECT * FROM TRMP_01;
 
 SELECT LENGTHB(COL1), -- LENGTHB()괄호안의 컬럼을 바이트로 나타내세요. 바이트 갯수
        LENGTHB(COL2),
        LENGTHB(COL3)
   FROM TRMP_01;
  
  
--행추가)
  INSERT INTO TRMP_01 VALUES('대한','대한민국','민국'); -- 12+6 = 18BYTE
  -- CHAR(10)에서 대한민국(4) 빼고 남은 6BYTE와 대한민국(12)를 합하여 18BYTE됨
  -- CHAR자료형의 셈법은 BYTE와 다르다는 것을 알수있음.
  SELECT * FROM TRMP_01;
  
  
2)VARCHAR2(n[BYTE|CHAR]) --오라클에만 유일함
  .가변길이 문자열 저장
  .VARCHER와 동일기능 제공
  .최대 4000BYTE 저장기능 --한글 1333글자
  .사용자가 정의한 데이터를 저장하고 남는 기억공간은 반환
  .가장널리 사용되는 타입
  --NVARCHAR, NVARCHAR2, NCLOB 는 다국어 제공 자료형
  
사용예)
        CREATE TABLE TEMP_02(
          COL1 VARCHAR2(4000 BYTE),
          COL2 VARCHAR2(4000 CHAR),
          COL3 VARCHAR2(4000));
          
        INSERT INTO TEMP_02 VALUES('IL POSTINO','PERSTMMON','APPLE');
        
        SELECT * FROM TEMP_02;
        
        SELECT LENGTHB(COL1),
                LENGTHB(COL2),
                LENGTHB(COL3)
        FROM TEMP_02;

3)LONG --될수있으면 쓰지 않는편
  .가변길이 자료 저장
  .최대 2GB까지 저장 가능
  .일부 기능은 사용불가
  .한 테이블에 1개의 LONG 타입만 사용가능(기능개선 중단) 
  .CLOB 타입으로 대체
  .SELECT문의 SELECT절, UPDATE문의 SET절, INSERT문의 VALUES절에서만 사용 가능 
  
사용예)

오류)
        CREATE TABLE TEMP_03(
            COL1 LONG,
            COL2 VARCHAR2(200),
            COL3 LONG); --LONG 중복

정상)
        CREATE TABLE TEMP_03(
            COL1 LONG,
            COL2 VARCHAR2(200));
  
  INSERT INTO TEMP_03 VALUES('대전시 중구 계룡로 846 3층','대덕인재개발원');
  
  SELECT * FROM TEMP_03;
  
  검색 오류1)
  SELECT LENGTHB(COL1), --LONG 데이터타입이 너무 커서 못셈
         LENGTHB(COL2) 
  FROM TEMP_03;
  

  검색 오류2)
  SELECT SUBSTR(COL2,2,5) FROM TEMP_03; --SQL은 1번부터 셈하므로 '덕인재개발'이 출력됨
  SELECT SUBSTR(COL1,2,5) FROM TEMP_03; --오류/사용불가능


4)CLOB(Character Large OBjects)
  .가변길이 문자열을 저장
  .최대 4GB 까지 처리가능
  .한 테이블에 복수개의 CLOB 사용가능
  .일부 기능은 DBMS_LOB API의 지원을 받아야함(EX: LENGTHB등은 제한)

사용예)
        CREATE TABLE TRMP_04(
            COL1 CLOB,
            COL2 CLOB,
            COL3 VARCHAR2(4000));
        
        INSERT INTO TRMP_04 VALUES('대전시 중구 계룡로 846 3층','대덕인재개발원','ILPOSTINO');
        
        
        
        SELECT * FROM TRMP_04;
 
 오류예시)
        SELECT LENGTHB(COL1), --오류
                LENGTHB(COL2),
                LENGTHB(COL3)
        FROM TRMP_04;
 
 정상예시)
        SELECT DBMS_LOB.GETLENGTH(COL1),
                LENGTH(COL2), --4000BYTE 이내면 출력
                LENGTHB(COL3)
        FROM TRMP_04;
 

  --JAVA는 문자 최우선
  --ORACLE은 숫자 최우선
    SELECT '76'+1900 FROM DUAL;   
  