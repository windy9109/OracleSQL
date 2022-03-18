SELECT MASSAGE_ROOM_ID, BOARD_ID, MEM_ID
				FROM MASSAGE
                
                
INSERT INTO MASSAGE VALUES((SELECT NVL(MAX(MASSAGE_ROOM_ID),0)+1 FROM MASSAGE), 7, 'red0101');
INSERT INTO MASSAGE VALUES((SELECT NVL(MAX(MASSAGE_ROOM_ID),0)+1 FROM MASSAGE), 6, '샘플아이디2');

DELETE FROM MASSAGE
WHERE MASSAGE_ROOM_ID = 2;

COMMIT;





대화방이있는지 확인함        
        SELECT A.MASSAGE_ROOM_ID AS AMAS, 
               A.BOARD_ID AS ABOD, 
               A.MEM_ID AS AMID
          FROM MASSAGE A
        WHERE EXISTS (SELECT 1 
                        FROM (SELECT BOARD_ID,
                                     MEM_ID
                                FROM MASSAGE
                                WHERE BOARD_ID = 3 AND MEM_ID = 'red0101')B
        WHERE A.BOARD_ID = B.BOARD_ID
          AND A.MEM_ID = B.MEM_ID); 
          
          --SELECT에는 어떤것이 와도 상관없지만 보통 1을 쓴다.
        --서브쿼리의 결과가 단 하나라도 있으면 결과는 참이다(IN과 똑같음) 

