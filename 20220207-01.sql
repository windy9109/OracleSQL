2022-0207-01)트리거(TRIGGER)
- 특정 테이블에 발생된 이벤트 (INSERT, UPDATE, DELETE)에 의하여 별도의 동작이 필요한 일종의 프로시져

(사용형식) 
CREATE TRIGGER 트리거명
  BEFORE|AFTER INSERT|UPDATE|DELETE
  ON 테이블명
   [FOR EACH ROW]
   [WHEN 조건]
  [DECLARE]
   선언부;
  BEGIN;
   트리거본문;
  END;
  
  . 'BEFORE|AFTER': timing으로 트리거 본문이 실행되는 시점
  . 'INSERT|UPDATE|DELETE': event로 트리거본문을 실행시키는 원인이 되는 dml명령. 조합사용가능(insert or update 등)
  . 'ON 테이블명': 트리거 원인이되는 이벤트가 발생된 테이블명 
  . 'FOR EACH ROW': 행단위의 트리거(이벤트결과 각 행 마다 트리거 수행). 생략하면 문장단위 트리거
  . 'WHEN 조건': 행단위의 트리거에서만 사용할수 있으며 트리거를 발생 시키는 
                이벤트가 발생되는 테이블에서 이벤트가 발생할 때 좀더 구체적인 검색조건 제시에 사용