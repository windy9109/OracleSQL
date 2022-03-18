SELECT 
    M.BOARD_ID AS 순번,
    M.BOARD_TITTLE AS 제목,
        M.UPDATE_DATE AS 날짜, 
        M.STATUS AS 판매상태
    FROM PRODBOARD M,(SELECT UPDATE_DATE AS DAT
                         FROM PRODBOARD
                      ORDER BY UPDATE_DATE DESC)C
        WHERE M.UPDATE_DATE=C.DAT
    AND MEM_ID = 'red0101' AND ROWNUM <=3 
    ORDER BY BOARD_ID ASC;
    
    
    
    commit;
    
::최신 상위 3개::
SELECT BOARD_ID,
       BOARD_TITTLE,
       STATUS,
       UPDATE_DATE
  FROM PRODBOARD
 WHERE MEM_ID = 'test99'
   AND ROWNUM <=3  
ORDER BY BOARD_ID;
                
                
                