create table bankinfo(
    bank_no VARCHAR2(40) not null, --계좌번호
    bank_name varchar2(40) not null, -- 은행명
    bank_user_name varchar2(30) not null, --예금주명
    bank_date date not null, --개설 날짜
    Constraint pk_bankinfo primary key (bank_no) -- 키본키명 및 기본키 지정
);

-- insert into bankinfo (bank_no, bank_name, bank_user, bank_user_name, bank_date)
-- value('111-111-111','농협','홍길동','sysdate')

/*
  회원ID :ss' or '1' ='1
  String memId = a001;
  select * from member where mem_id = '" + memId + "'";
  
*/

select * from member where mem_id = 'a001';
-- 해킹위험
select * from member where mem_id = 'ss' or '1' ='1';


-- prepareStatement 사용시 '' 안의 객체를 데이터로 간주해서 작은따옴표를 한번더 넣어준다.
-- 구동 예시는 아래와 같음
select * from member where mem_id = 'ss'' or ''1'' =''1';


--setString 사용할 경우 문장그대로 읽게 함. 
select 'ss'' or ''1'' =''1' from dual;


select max(LPROD_ID) maxnum  FROM LPROD;
select count(*) from LPROD where LPROD_GU ='P109';



create table mymember(
    mem_id varchar2(15) not null, --회원 id
    mem_name varchar2(30) not null,  --회원 이름
    mem_pass varchar2(70) not null,  -- password
    mem_tel varchar2(14) not null,  -- 전화번호
    mem_addr varchar2(70) not null,  -- 주소
    constraint pk_mymember primary key (mem_id) 
);


drop table mymember;
