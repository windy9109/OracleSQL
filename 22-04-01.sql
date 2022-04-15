--지역
select distinct sido from ziptb;

--구
select distinct gugun from ziptb where sido ='대전';

--동
select distinct dong from ziptb where sido ='대전' and gugun='서구';


--상세주소
select * from ziptb where sido ='대전' and gugun='대덕구' and dong like '법%';






create table board1 (
num			number			not null	primary key,
subject			varchar2(100)	not null,
writer			varchar2(15)	not null,
mail			varchar2(30),
password		varchar2(10)	not null,
content			varchar2(2000),
hit				number			not null,
wip				char(15)		not null,
wdate			date			not null
);

create table reply(
renum  number              not null primary key,
bonum  number              not null,
name   varchar2(15)        not null,
cont   varchar2(1000)      not null,
redate   date			  not null,
CONSTRAINT RE_BONUM FOREIGN KEY(BONUM)
REFERENCES BOARD1(NUM)
ON DELETE CASCADE 
);


create sequence board1_num_seq nocache;
create sequence reply_renum_seq nocache;



insert into board1 values (board1_num_seq.nextval, '제목1', '이름1', 'test1@test.com', '1234', '내용1', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목2', '이름2', 'test2@test.com', '1234', '내용2', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목3', '이름3', 'test3@test.com', '1234', '내용3', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목4', '이름4', 'test4@test.com', '1234', '내용4', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목5', '이름5', 'test5@test.com', '1234', '내용5', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목6', '이름6', 'test6@test.com', '1234', '내용6', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목7', '이름7', 'test7@test.com', '1234', '내용7', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목8', '이름8', 'test8@test.com', '1234', '내용8', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목9', '이름9', 'test9@test.com', '1234', '내용9', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목10', '이름10', 'test10@test.com', '1234', '내용10', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목11', '이름11', 'test11@test.com', '1234', '내용11', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목12', '이름12', 'test12@test.com', '1234', '내용12', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목13', '이름13', 'test13@test.com', '1234', '내용13', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목14', '이름14', 'test14@test.com', '1234', '내용14', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목15', '이름15', 'test15@test.com', '1234', '내용15', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목16', '이름16', 'test16@test.com', '1234', '내용16', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목17', '이름17', 'test17@test.com', '1234', '내용17', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목18', '이름18', 'test18@test.com', '1234', '내용18', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목19', '이름19', 'test19@test.com', '1234', '내용19', 0, '000.000.000.000', sysdate);
insert into board1 values (board1_num_seq.nextval, '제목20', '이름20', 'test20@test.com', '1234', '내용20', 0, '000.000.000.000', sysdate);



commit;



select * from board1;



