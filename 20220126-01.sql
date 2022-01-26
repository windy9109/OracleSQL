2022-0126-01) SYNONYM(동의어)
- 오라클 객체에 부여하는 별칭
- 긴 이름의 객체나 다른사람 소유의 객체에 접근할때 주로사용
- 테이블 별칭, 컬럼 별칭과의 차이점은 QUERY와 관계 없이 사용가능

(사용형식)
    CREATE [OR REPLACE] SYNONYM 동의어
    FOR 객체명;
    
    
사용예) 
    CREATE OR REPLACE SYNONYM EMP
        FOR HR.EMPLOYEES;
    
    CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;
        
    SELECT * FROM EMP;
    SELECT * FROM DEPT;
    
    
    CREATE OR REPLACE SYNONYM MYDUAL FOR SYS.DUAL;
    
    SELECT SYSDATE FROM MYDUAL;
    
    
    
2. INDEX
    - 데이터 검색효율 증대시키기 위한 도구
    - WHERE 조건절에 사용되는 컬럼, 정렬(ORDER BY), 그룹화(GROUP BY) --가장많이 사용되는곳 WHERE절
      의 기준컬럼에 사용하여 처리 효율을 증대
    - 인덱스를 위한 별도의 기억공간이 소요(필요)되고, 시스템의 자원이 소비됨
    - 데이터의 변동이 심한 경우 인덱스 파일의 갱신에 많은 시간과 자원이 요구됨
    --인덱스를 많이 만들어쓰게 되면 전체적인 효율이 떨어져 악영향을 미친다.
    
    
    - 인덱스의 종류
    . Unique/Non-Uniqe: 인덱스가 중복값을 허용하는지 여부에 따른 분류
    'Unique'인덱스는 unll값도 허용하나 하나의 null만 허용됨
    . Sing.Composite: 인덱스 구성 컬럼이 1개 인경우(Single), 2개 이상의 컬럼으로 구성(Composite)된 경우
    . Normal Index: Default 인덱스로 컬럼값과 rowid(물리적 위치정보)를 기반으로 주소계산되며 트리구조 이용
    . Bitmap Index: 컬럼값과 rowid(물리적 위치정보)를 2진으로 조합하여 주소계산하며, Cardinality가 적은 경우(성별,나이 등) 효율적인 방식
    . Function-Based Normal Index: 인덱스 구성컬럼에 함수가 적용된 경우로 이 인덱스를 이용하여 자료를 검색하는 경우 인덱스 구성에 사용된 함수를 사용하는것이 가장 효율적
    
    
    (사용형식)
    CREATE [UNIQUE|BITMAP] INDEX 인덱스명
      ON 테이블명(컬럼명[,컬럼명,...])[ASC|DESC];
      . 'ASC|DESC': 인덱스 생성시 정렬 방식(기본은 ASC)
    
    (사용예) 상품명으로 인덱스를 구성하시오
    CREATE INDEX idx_prod_name
        ON PROD(PROD_NAME);
    
    
    DROP INDEX idx_prod_name;
    
    -- 속도 비교(INDEX는 대량의 데이터를 처리할때 속도가 상대적으로 매우 빠르다.)
    -- 인덱스를 남발하면 비효율적이므로 적당히 사용해야함.
    SELECT * FROM PROD
     WHERE PROD_NAME ='대우 VTR 6헤드';
     
     
사용예) 사원테이블에서 'TJOlson'사원 정보를 조회하시오
    SELECT *
      FROM EMP
     WHERE EMP_NAME = 'TJOlson';
    
    
    -- TJOlson의 주소로 가서 한번에 출력하는 로직, 비교연산자처럼 처리안함
    CREATE INDEX idx_emp_name
      ON EMP(EMP_NAME);
    
    -- INDEX에 자료가 삽입될경우 실시간으로 재구성되지 않고 일정시간뒤에 재구성되는데, 강제로 재구성을 가능하게 할수있다.
    ** 인덱스의 재구성
    - 자료의 삽입/삭제가 대량 발생된 경우
    - 테이블의 저장 위치(TABLE SPACE)가 변경된경우
    
    (사용형식)
    ALTER INDEX 인덱스명 REBUILD;
    
    사용예)
    ALTER INDEX idx_emp_name REBUILD; --강제 재구성
    
    
    
    
    
    
    
    
    
    
    
    