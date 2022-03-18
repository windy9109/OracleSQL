commit;



DELETE FROM CATTING WHERE MASSAGE_ID = 12;

DELETE FROM MASSAGE WHERE MASSAGE_ROOM_ID > 7;

ROLLBACK;

//생성규칙
//만약 판매자 아이디와 로그인 아이디가 같다면 채팅방생성 안함(ok)

//대화목록에 대화상대 출력하는법
//MEM_ID(구매자)아이디와 로그인 아이디가 같다면 판매자 아이디를 출력한다.
MEM_ID(구매자)아이디와 로그인 아이디가 다르다면 MEM_ID(구매자)아이디를 출력한다.


SELECT A.MASSAGE_ROOM_ID AS AMAS, 
        A.BOARD_ID AS ABOA, 
        A.MEM_ID AS MID, 
        B.MEM_ID AS BID
  FROM MASSAGE A, PRODBOARD B
 WHERE A.BOARD_ID = B.BOARD_ID
   AND A.MEM_ID = 'test99'
   UNION
   SELECT A.MASSAGE_ROOM_ID AS AMAS, 
        A.BOARD_ID AS ABOA, 
        A.MEM_ID AS MID, 
        B.MEM_ID AS BID
  FROM MASSAGE A, PRODBOARD B
 WHERE A.BOARD_ID = B.BOARD_ID
   AND B.MEM_ID = 'test99';
   
   
   --------------------
   SELECT A.MASSAGE_ROOM_ID AS AMAS,"
				+ "               A.BOARD_ID AS ABOD,"
				+ "               A.MEM_ID AS AMID"
				+ "          FROM MASSAGE A"
				+ "        WHERE EXISTS (SELECT 1"
				+ "                        FROM (SELECT BOARD_ID,"
				+ "                                     MEM_ID"
				+ "                                FROM MASSAGE"
				+ "                                WHERE BOARD_ID = ? AND MEM_ID = ?)B"
				+ "        WHERE A.BOARD_ID = B.BOARD_ID"
				+ "          AND A.MEM_ID = B.MEM_ID)";
                

   

                

            
            
                
         
 내거래출력   
    SELECT A.MASSAGE_ROOM_ID AS AMAS, 
            A.BOARD_ID AS ABOA, 
            A.MEM_ID AS MID, 
            B.MEM_ID AS BID,
            RANK() OVER( PARTITION BY C.MASSAGE_ROOM_ID ORDER BY C.MASSAGE_ID DESC) AS RANKONE,
            C.CONTENT AS CCON,
            C.READ_DATE AS CDATA
     FROM MASSAGE A, PRODBOARD B, CATTING C
    WHERE A.BOARD_ID = B.BOARD_ID
      AND A.MASSAGE_ROOM_ID = C.MASSAGE_ROOM_ID
      AND A.MEM_ID = 'test99'
    UNION ALL
    SELECT A.MASSAGE_ROOM_ID AS AMAS, 
            A.BOARD_ID AS ABOA, 
            A.MEM_ID AS MID, 
            B.MEM_ID AS BID,
            RANK() OVER( PARTITION BY C.MASSAGE_ROOM_ID ORDER BY C.MASSAGE_ID DESC) AS RANKONE,
            C.CONTENT AS CCON,
            C.READ_DATE AS CDATA
     FROM MASSAGE A, PRODBOARD B, CATTING C
    WHERE A.BOARD_ID = B.BOARD_ID
      AND A.MASSAGE_ROOM_ID = C.MASSAGE_ROOM_ID
      AND B.MEM_ID = 'test99';
                
           

           
           
 //최신순으로 메세지 순위매기기         
      SELECT MASSAGE_ID, 
          MASSAGE_ROOM_ID,
          RANK() OVER( PARTITION BY MASSAGE_ROOM_ID ORDER BY MASSAGE_ID DESC) AS RANKONE, 
                CONTENT
           FROM CATTING
        ORDER BY MASSAGE_ID DESC
           
            



 SELECT A.MASSAGE_ROOM_ID AS AMAS,
				            A.BOARD_ID AS ABOA,
				            A.MEM_ID AS MID,
				            B.MEM_ID AS BID,
				            C.CONTENT AS CCON,
				            C.READ_DATE AS CDATA
				     FROM MASSAGE A, PRODBOARD B, CATTING C
				     WHERE A.BOARD_ID = B.BOARD_ID AND C.CONTENT IS NOT NULL
				      AND A.MASSAGE_ROOM_ID = C.MASSAGE_ROOM_ID
				      AND A.MEM_ID = 'test99'
				    UNION
				    SELECT A.MASSAGE_ROOM_ID AS AMAS,
				            A.BOARD_ID AS ABOA,
				            A.MEM_ID AS MID,
				            B.MEM_ID AS BID,
				            C.CONTENT AS CCON,
				            C.READ_DATE AS CDATA
				     FROM MASSAGE A, PRODBOARD B, CATTING C
				     WHERE A.BOARD_ID = B.BOARD_ID AND C.CONTENT IS NOT NULL
				      AND A.MASSAGE_ROOM_ID = C.MASSAGE_ROOM_ID
				      AND B.MEM_ID = 'test99'
                      ORDER BY C.READ_DATE;


1.선택한 채팅창 내용 모두보기
--닉네임: 내용 (날짜)
SELECT MEM_ID, CONTENT, READ_DATE
  FROM CATTING
  WHERE MASSAGE_ROOM_ID = 5
  ORDER BY READ_DATE;
  
2.채팅보내기
INSERT INTO CATTING VALUES((SELECT NVL(MAX(MASSAGE_ID),0)+1 FROM CATTING), ?, ?, SYSDATE, ?)
------------------------------------------------------
UPDATE CATTING
  SET MASSAGE_ROOM_ID = 5
WHERE MASSAGE_ID = 9;

DELETE FROM CATTING WHERE MASSAGE_ID = 9;
COMMIT;

3.선택한 채팅창에 연결되어있는 상품게시글 가져오기

