2022-0207-01)트리거(TRIGGER)
- 특정 테이블에 발생된 이벤트 (INSERT, UPDATE, DELETE)에 의하여 별도의 동작이 필요한 일종의 프로시져
 
(사용형식) 
CREATE TRIGGER 트리거명
  BEFORE|AFTER INSERT|UPDATE|DELETE 
  -- BEFORE: 이벤트(INSERT|UPDATE|DELETE) 발생전에 트리거(본문이)가 수행
  -- AFTER: 이벤트(INSERT|UPDATE|DELETE) 발생후에 트리거(본문이)가 수행
  -- INSERT|UPDATE|DELETE : 이벤트
  ON 테이블명 
  -- ON 뒤의 테이블명과 BEGIN 뒤의 테이블명을 반드시 같으면 안됨(무한루프될수 있음)
   [FOR EACH ROW] --행단위 트리거(FOR EACH ROW), 문장단위 트리거: 영향받은 행들이 다수여도 딱한번만 수행됨
   [WHEN 조건]
  [DECLARE]
   선언부;
  BEGIN; 
   트리거본문;
  END;
  --트리거는 트랜젝션이 마무리 되어야 다음 트리거를 쓸수있음
  
  . 'BEFORE|AFTER': timing으로 트리거 본문이 실행되는 시점
  . 'INSERT|UPDATE|DELETE': event로 트리거본문을 실행시키는 원인이 되는 dml명령. 조합사용가능(insert or update 등)
  . 'ON 테이블명': 트리거 원인이되는 이벤트가 발생된 테이블명 
  . 'FOR EACH ROW': 행단위의 트리거(이벤트결과 각 행 마다 트리거 수행). 생략하면 문장단위 트리거
  . 'WHEN 조건': 행단위의 트리거에서만 사용할수 있으며 트리거를 발생 시키는 
                이벤트가 발생되는 테이블에서 이벤트가 발생할 때 좀더 구체적인 검색조건 제시에 사용
                
                
                
                 
  * 트리거 유형 
  - 행단위 트리거와 문장단위 트리거로 구분 
  1)문장단위 트리거: 이벤트 수행결과에 관계없이 1번만 수행 --EX)장바구니테이블에 여러 주문이 들어와도 한번만 수행
                    'FOR EACH ROW'생략
  2)행단위 트리거: 이벤트명령 실행결과가 복수개의 행이 반환되는 경우 각 행마다 트리거 본문 실행 'FOR EACH ROW'기술
  --대부분이 행단위 트리거임
  
  *의사레코드
  - 행단위 트리거에서만 사용가능(※많이 사용되어짐)
---------------------------------------------------------------------------  
    의사레코드           의미
---------------------------------------------------------------------------
    :NEW            이벤트가 INSERT, UPDATE 일때만 사용
                    데이터가 삽입(갱신)될때 새롭게 입력 되는 자료(행)을 지칭
                    DELETE시 사용되면 모든 컬럼값이 NULL
---------------------------------------------------------------------------                   
    :OLD            이벤트가 DELETE, UPDATE 일때만 사용
                    데이터가 삭제(갱신)될때 해당 연산의 대상이 되는 자료(행)을 지칭
                    INSERT시 사용되면 모든 컬럼값이 NULL
---------------------------------------------------------------------------  
 
 
 
 *트리거 함수 
 - 이벤트로 정의된 명령을 구분하기위해 사용
---------------------------------------------------------------------------  
    함수           의미
---------------------------------------------------------------------------
  INSERTING     이벤트가 INSERT이면 참(ture)반환
  UPDATING      이벤트가 UPDATE이면 참(ture)반환
  DELETING      이벤트가 DELETE이면 참(ture)반환
  
  
  
  
사용예) 분류테이블(LPROD)에서 순번 10부터 모두 삭제하시오
        삭제후 '분류코드가 삭제되었습니다'라는 메시지를 출력하시오.

  
    CREATE TRIGGER TG_DEL_LPROD
        AFTER DELETE ON LPROD
    BEGIN
        DBMS_OUTPUT.PUT_LINE('분류코드가 삭제됐습니다.');
    END;
    
    --트리거지우기
    DROP TG_DEL_LPROD;
  
--결과가 즉시반영되지 않으므로 SELECT문이나 COMMIT을 통하여 해준다.

    DELETE FROM LPROD
        WHERE LPROD_ID=12;  
    COMMIT;
    
    SELECT * FROM LPROD;
  
    ROLLBACK;
    
    
    --트리거삭제
    DROP TRIGGER TG_DELUPDATE_CUST;
    
    
    사용예) CUSTOMER 테이블에 자료를 변경하면 '자료가 수정瑛'을 
            자료가 삭제되면 '자료가삭제되었음'을 출력하는 트리거 작성
    --트리거에서는 SAVEPOINT, COMMIT, ROLLBACK 등을 쓸수없음
    CREATE TRIGGER TG_DELUPDATE_CUST2
      AFTER UPDATE OR DELETE ON CUSTOMER
    BEGIN
      IF UPDATING THEN 
            DBMS_OUTPUT.PUT_LINE('자료가 수정되었음');
      ELSIF DELETING THEN
            DBMS_OUTPUT.PUT_LINE('자료가 삭제되었음');
      END IF;
    END;
                        

    
    예) CUSTOMER의 마일리지를 모두 500씩증가
    
    UPDATE CUSTOMER
        SET MEM_MILEAGE = MEM_MILEAGE+500;
    COMMIT;
    
    
  
  
    예2) CUSTOMER의 자료중 마일리지가 3000미만 자료삭제 
    DELETE FROM CUSTOMER
      WHERE MEM_MILEAGE < 3000;
    SELECT * FROM CUSTOMER;
  
  
  
  
