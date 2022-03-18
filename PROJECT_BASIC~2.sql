INSERT INTO LIKEITEM VALUES ('testing',2);
INSERT INTO LIKEITEM VALUES ('testing',3);
INSERT INTO LIKEITEM VALUES ('testing',4);
INSERT INTO LIKEITEM VALUES ('testing',5);
INSERT INTO LIKEITEM VALUES ('testing',6);



INSERT INTO LIKEITEM VALUES ('test99',3);
INSERT INTO LIKEITEM VALUES ('test99',4);
INSERT INTO LIKEITEM VALUES ('test99',5);
INSERT INTO LIKEITEM VALUES ('test99',6);


INSERT INTO LIKEITEM VALUES ('red0101',3);

COMMIT;

:: 관심상품 조회 ::
SELECT A.BOARD_ID, A.BOARD_TITTLE, A.MEM_ID, A.BOARD_PRICE, A.STATUS, A.UPDATE_DATE
 FROM PRODBOARD A, MEMBER B, LIKEITEM C
 WHERE A.BOARD_ID = C.BOARD_ID 
    AND C.MEM_ID = B.MEM_ID
    AND C.MEM_ID = 'red0101';
 

:: 리뷰조회 ::
SELECT MEM_ID2, REVIEW_CONTENT, GRADE, REVIEW_DATE
  FROM RATING
WHERE MEM_ID = 'testing';



:: 리뷰 총 평점 ::
SELECT AVG(GRADE)
       FROM RATING
      WHERE MEM_ID='red0101';
     
     commit;
     
     
:: 총판매액 ::
SELECT NVL(SUM(BOARD_PRICE),0) AS SUMCION
  FROM PRODBOARD
  WHERE STATUS = 'T' AND MEM_ID = 'testing';

:: 등급 ::
SELECT MEM_GRADE
  FROM MEMBER
 WHERE MEM_ID = 'testing';
 
 
:: 갯수 ::
SELECT COUNT(MEM_ID) AS RCOUNT
    FROM RATING
 WHERE MEM_ID='testing';




  FROM PRODBOARD A, MEMBER B
 WHERE A.MEM_ID = B.MEM_ID
   AND A.STATUS = 'T' AND A.MEM_ID = 'testing'
 GROUP BY B.MEM_GRADE;
 


구매자 아이디 && 글번호로 대화방 번호를 생성한다.
만약 대화방번호가 있다면 INSERT를 수행하지 않는다.


1. LOOP
 - 반복문의 기본 구조 제공
 - 무한루프
 - JAVA의 DO문과 유사 
 
 (사용형식)
 LOOP
  반복처리 명령문(들);
  [EXIT WHEN 조건;]
        :
    END LOOP;
. EXIT WHEN 조건: '조건'이 참인경우 반복문을 벗어남
--WHILE는 조건이 맞으면 반복하고 LOOP는 조건이 맞으면 반복을 벗어남



사용예) 구구단의 6단을 LOOP문을 이용하여 작성
    DECLARE
        V_CNT NUMBER:=1;
        
    BEGIN
        LOOP
            EXIT WHEN V_CNT>9;
            DBMS_OUTPUT.PUT_LINE('6*'||V_CNT||'='||V_CNT*6);
            V_CNT:=V_CNT+1;
            END LOOP;
    END;
    

