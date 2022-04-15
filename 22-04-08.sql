select count(*) from board1;


select A.* from (
    select rownum as rnum, B.*  from (
         select * from board1 
         order by num desc) B
     where rownum <= 6) A 
 where A.rnum >=4;