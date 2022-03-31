select buyer_name, buyer_id from buyer;

select * from buyer where buyer_id='P10101';


select prod_id, prod_name from prod where prod_lgu = 'P102';

select * from prod where prod_id='P102000001';



create table ziptb (
 zipcode varchar2(7) not null,     --우편번호  7  
 sido  varchar2(6) not null,  --  특별시,광역시,도  4
 gugun  varchar2(30),           -- 시,군,구  17  
 dong   varchar2(40),            --읍,면,동  26  
 ri     varchar2(30),       --  리명  18
 bldg  varchar2(60),        -- 건물명  40 
 bunji varchar2(30),        -- 번지,아파트동,호수  17 
 seq  number(5) not null,        -- 데이터 순서  5
constraint pk_ziptb primary key (seq) 
);

-- list
select mem_id from member where mem_id='korea1234';

-- object
select * from ziptb where dong like '오류%';

insert into member(mem_id, mem_pass, mem_name, mem_bir, mem_zip, mem_add1, mem_add2, mem_hp, mem_mail) 
values(

)







