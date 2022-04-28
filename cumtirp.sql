select A.* from (
    select rownum as rnum, B.*  from (
         select * from Q_ADMIN
         order by QA_NO desc) B
     where rownum <= 5) A 
 where A.rnum >=1;
 
 
 create sequence Q_ADMIN_num_seq nocache;
 
 
 
 
		select b.mre_no, c.mem_email, c.mre_title, to_char(c.mre_date, 'yyyy-mm-dd') as mre_date, c.mid_no, d.mid_name as mid_name
		from member a, mr_likes b, m_review c, middle d
		where a.mem_email = b.mem_email and b.mre_no = c.mre_no and c.mid_no = d.mid_no
		and a.mem_email = 'windy9109@naver.com'
		union
		select d.STAY_NO as mre_no, c.mem_email as mem_email, c.sre_title as sre_title, to_char(c.sre_date, 'yyyy-mm-dd') as sre_date, c.stay_no as mid_no, d.stay_name as mid_name
		from member a, sr_likes b, s_review c, stay d
		where a.mem_email = b.mem_email and b.sre_no = c.sre_no and d.stay_no = c.stay_no
		and a.mem_email = 'windy9109@naver.com';
        
        
        
        
        
        select a.mre_no as sre_no, a.mre_title as sre_title, to_char(a.mre_date, 'yyyy-mm-dd') as sre_date, a.mre_point as sre_point, a.MID_NO as MID_NO, b.MID_NAME as STAY_NAME
		    from m_review a, MIDDLE b
		  where a.MID_NO=b.MID_NO and mem_email='windy9109@naver.com'        
		union
		select c.sre_no as sre_no, c.sre_title as sre_title, to_char(c.sre_date, 'yyyy-mm-dd') as sre_date, c.sre_point as sre_point, c.STAY_NO as MID_NO, d.STAY_NAME
		    from s_review c, STAY d
		  where c.STAY_NO = d.STAY_NO and mem_email='windy9109@naver.com';
          
          
          
       select mre_no as sre_no, mre_title as sre_title, to_char(mre_date, 'yyyy-mm-dd') as sre_date, mre_point as sre_point, mid_no as mid_no
		    from m_review
		  where mem_email=#id1#     
		union
		select sre_no as sre_no, sre_title as sre_title, to_char(sre_date, 'yyyy-mm-dd') as sre_date, sre_point as sre_point, stay_no as mid_no
		    from s_review
		  where mem_email=#id2#
          
          select * from a_admin where ad_number = 3;
          
          
          
          
select A.* from (
    select rownum as rnum, B.*  from (
         select * from Q_ADMIN
         order by QA_NO desc) B
     where rownum <= 5) A 
 where A.rnum >=1;
 
 
 
 
 select A.* from (
    select rownum as rnum, B.*  from (
         select * from Q_ADMIN x LEFT OUTER JOIN A_ADMIN v on x.QA_NO = v.QA_NO
         order by x.QA_NO desc) B
     where rownum <= 5) A 
 where A.rnum >=1;
 
 
 
 SELECT QA_NO, COUNT(AD_NO) AS cnt FROM A_ADMIN GROUP BY QA_NO HAVING cnt >= 1;


 SELECT QA_NO, COUNT(AD_NO) FROM A_ADMIN GROUP BY QA_NO;
 
 SELECT QA_NO from (select * from Q_ADMIN x LEFT OUTER JOIN A_ADMIN v on x.QA_NO = v.QA_NO) GROUP BY QA_NO;
 
 
select QA_TITLE, QA_CONTENT, QA_DATE, QA_NO, MEM_EMAIL, Q_NUMBER, AD_NO
from (




select distinct x.QA_TITLE, x.QA_CONTENT, x.QA_DATE, x.QA_NO, x.MEM_EMAIL, x.Q_NUMBER, v.QA_NO as AD_QA_NO
        from Q_ADMIN x LEFT OUTER JOIN A_ADMIN v 
        on x.QA_NO = v.QA_NO order by QA_NO desc


QA_TITLE, QA_CONTENT, QA_DATE, QA_NO, MEM_EMAIL, Q_NUMBER, AD_QA_NO


select * from a_admin where ad_number = 4
        
        
        
        
        )



select *
        from Q_ADMIN x LEFT OUTER JOIN A_ADMIN v 
        on x.QA_NO = v.QA_NO




    
    
    
    select *
      from (select x.QA_TITLE, x.QA_CONTENT, x.QA_DATE, x.QA_NO, x.MEM_EMAIL, x.Q_NUMBER, ROW_NUMBER() OVER( PARTITION BY x.QA_NO ORDER BY v.AD_NO ) AS ROW_NUM 
                from Q_ADMIN x LEFT OUTER JOIN A_ADMIN v 
                  on x.QA_NO = v.QA_NO)
        where ROW_NUM  = 1;
         
         
         
         
         
         ) B
     where rownum <= 5) A 
 where A.rnum >=1;
 
 
 
 select x.QA_TITLE, x.QA_CONTENT, x.QA_DATE, x.QA_NO, x.MEM_EMAIL, x.Q_NUMBER, ROW_NUMBER() OVER( PARTITION BY x.QA_NO ORDER BY v.AD_NO ) AS ROW_NUM 
                from Q_ADMIN x LEFT OUTER JOIN A_ADMIN v 
                  on x.QA_NO = v.QA_NO
 
 
 
 
 
 
 delete from Q_ADMIN where Q_NUMBER =5 and MEM_EMAIL='windy9109@naver.com';
 
 
  select A.* from (
    select rownum as rnum, B.*  from (
             select *
                from (select x.QA_TITLE, x.QA_CONTENT, x.QA_DATE, x.QA_NO, x.MEM_EMAIL, x.Q_NUMBER, ROW_NUMBER() OVER( PARTITION BY x.QA_NO ORDER BY v.AD_NO ) AS ROW_NUM 
                from Q_ADMIN x LEFT OUTER JOIN A_ADMIN v 
                  on x.QA_NO = v.QA_NO)
        where ROW_NUM  = 1) B
     where rownum <= 5) A 
 where A.rnum >=1
        




         select A.* from (
	      select rownum as rnum, B.*  from (
	                select distinct x.qa_title, x.qa_content, to_char(x.qa_date, 'yyyy-mm-dd') as qa_date, x.qa_no, x.mem_email, x.q_number, v.qa_no as ad_qa_no
				        from q_admin x left outer join a_admin v 
				        on x.qa_no = v.qa_no where x.mem_email = 'er' order by x.qa_no desc 
	          ) b

		      where rownum <= 8) A 
		   where A.rnum >=1
           
           
           