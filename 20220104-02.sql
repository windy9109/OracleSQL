2022-0104-01)테이블 생성
CREATE TABLE 명령으로 생성
(표현형식)
CREATE TABLE 테이블명(
    컬럼명 데이터타입[(크기)][NOT NULL][DEFAULT 값][,]
                        :
    컬럼명 테이터타입[(크기)][NOT NULL][DEFAULT 값][,]
    [CONSTRAINT 기본키 인덱스 PRIMARY KEY (컬럼명,[, 컬럼명,...])[,]]
    [CONSTRAINT 외래키 인덱스 FOREIGN KEY (컬럼명)
        REFERENCES 테이블명(컬럼명)[,]]
    [CONSTRAINT 외래키 인덱스 FOREIGN KEY (컬럼명)
        REFERENCES 테이블명(컬럼명)];
        
        
사용예)
    CREATE TABLE GOODS(
        GOOD_ID CHAR(4) NOT NULL,
        GOOD_NAME VARCHAR2(30),
        PRICE NUMBER(7),
        CONSTRAINT pk_goods PRIMARY KEY(GOOD_ID));
    

    CREATE TABLE CUSTOMERSP(
        CUST_ID CHAR(3),
        CUST_NAME VARCHAR2(20),
        CUST_ADDR VARCHAR2(100),
        CONSTRAINT pk_customers PRIMARY KEY(CUST_ID));
        
    CREATE TABLE ORDERS(
        ORDER_ID CHAR(12), --기본키
        ORDER_DATE DATE DEFAULT SYSDATE,
        CUST_ID CHAR(3), --외래키
        CONSTRAINT pk_oders PRIMARY KEY(ORDER_ID),
        CONSTRAINT fk_orders_cust FOREIGN KEY(CUST_ID)
            REFERENCES CUSTOMERSP(CUST_ID));
        
        
    CREATE TABLE ORDER_GOODS(
        ORDER_ID CHAR(12),
        GOOD_ID CHAR(4),
        ORDER_QTY NUMBER(4) DEFAULT 0,
        CONSTRAINT pk_ogoods PRIMARY KEY(ORDER_ID,GOOD_ID),
        CONSTRAINT FK_ogoods_order FOREIGN KEY(ORDER_ID)
            REFERENCES ORDERS(ORDER_ID),
        CONSTRAINT FK_ogoods_goods FOREIGN KEY(GOOD_ID)
            REFERENCES GOODS(GOOD_ID));
        