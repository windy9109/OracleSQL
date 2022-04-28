		select *
		from
		(select mem_email, mid_name, mid_location, mid_no, photo_path, ROW_NUMBER() OVER( PARTITION BY mid_no ORDER BY photo_path ) AS ROW_NUM
		from  
		(select distinct a.mem_email, b.mid_name, b.mid_location, c.mid_no, c.photo_path
		from mylist a, middle b, photo c
		where a.mid_no = b.mid_no and b.mid_no = c.mid_no and a.mem_email = #data#))
		where ROW_NUM = 1
        
        
        
        
        select *
		from
		(select mem_email, mid_name, mid_location, mid_no, photo_path, ROW_NUMBER() OVER( PARTITION BY mid_no ORDER BY photo_path ) AS ROW_NUM
		from  
		(
        select distinct a.mem_email, b.mid_name, b.mid_location, c.mid_no, c.photo_path
		from mylist a, middle b, photo c
		where a.mid_no = b.mid_no and b.mid_no = c.mid_no and a.mem_email = 'windy9109@naver.com'
        union
        select distinct a.mem_email, b.STAY_NAME, b.STAY_LOCATION, c.STAY_NO, c.SPHO_PATH
		from STAYMYLIST a, STAY b, S_PHOTO c
		where a.STAY_NO = b.STAY_NO and b.STAY_NO = c.STAY_NO and a.mem_email = 'windy9109@naver.com'))
		where ROW_NUM = 1 order by mid_no;
        
        
   mem_email, mid_name, mid_location, mid_no, photo_path
   
   
   
   		update q_admin set qa_title='수정15', qa_content='내용수정15' where q_number=5 and mem_email='windy9109@naver.com';
   
           select a.mre_no as sre_no, a.mre_title as sre_title, to_char(a.mre_date, 'yyyy-mm-dd') as sre_date, a.mre_point as sre_point, a.mid_no as mid_no, b.mid_name as stay_name
		    from m_review a, middle b
		  where a.mid_no=b.mid_no and mem_email='windy9109@naver.com'    
		union
		select c.sre_no as sre_no, c.sre_title as sre_title, to_char(c.sre_date, 'yyyy-mm-dd') as sre_date, c.sre_point as sre_point, c.stay_no as mid_no, d.stay_name
		    from s_review c, stay d
		  where c.stay_no = d.stay_no and mem_email='windy9109@naver.com';
        