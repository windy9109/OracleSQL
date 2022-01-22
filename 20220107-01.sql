2022-0107-01)
3. DELETE문
  - 테이블내의 자료를 삭제할때 사용
  - ROLLBACK 의 대상

(사용형식)
DELETE FROM 테이블명
[WHERE 조건];
. WHERE 절이 생략되면 모든 자료를 삭제

사용예) 테이블 GOODS의 모든 자료를 삭제
DELETE FROM GOODS;

COMMIT;

SELECT * FROM GOODS;

ROLLBACK;
SELECT FROM GOODS;



사용예)테이블 GOODS의 자료중 상품코드가 'P101'보다 큰 자료를 삭제하시오.
DELETE FROM GOODS
    WHERE GOOD_ID>='P102'; -- 조건의 왼쪽부터 비교하여 처리

SELECT * FROM GOODS;



