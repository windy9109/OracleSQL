select b.cart_no as cart_no, c.stay_name as stay_name, e.room_grade as room_grade, a.pay_date as pay_date, 
b.cart_in as cart_in, g.pway_name as pway_name, f.refund_date as refund_date, b.CART_CHECK as CART_CHECK, a.PAY_STATUS as PAY_STATUS
from pay a, cart b, stay c, member d, room e, refund f, pay_way g
where a.cart_no = b.cart_no and c.stay_no = e.stay_no
and e.room_no = b.room_no and a.pay_no = f.refund_no 
and a.pway_code = g.pway_code and b.mem_email = d.mem_email
and d.mem_email = 'windy9109@naver.com';


------------------------------완성----------------------------------------------

select *
 from (select *
     from (select d.cart_no, d.CART_CHECK, d.stay_name, d.cart_in, d.cart_out, d.room_grade, d.mem_email, e.pay_no, e.pay_date, e.pay_price, e.pway_code, e.pay_status
             from (select c.cart_no, a.stay_name, b.room_grade, c.mem_email, c.cart_in, c.cart_out, c.CART_CHECK
                from stay a, room b, cart c
                where a.stay_no = b.stay_no and c.room_no = b.room_no and c.stay_no = b.stay_no
                and c.mem_email ='windy9109@naver.com')d left outer join pay e on d.cart_no = e.cart_no)f 
                left outer join refund g on f.pay_no = g.refund_no)h left outer join pay_way i on h.pway_code = i.pway_code;
                
                
select *
 from (select *
     from (select d.cart_no, d.CART_CHECK, d.stay_name, to_char(d.cart_in, 'yyyy-mm-dd') as cart_in, to_char(d.cart_out, 'yyyy-mm-dd') as cart_out, d.room_grade, d.mem_email, e.pay_no, e.pay_date, e.pay_price, e.pway_code, e.pay_status
             from (select c.cart_no, a.stay_name, b.room_grade, c.mem_email, c.cart_in,  c.cart_out, c.CART_CHECK
                from stay a, room b, cart c
                where a.stay_no = b.stay_no and c.room_no = b.room_no and c.stay_no = b.stay_no
                and c.mem_email ='windy9109@naver.com' ) d left outer join pay e on d.cart_no = e.cart_no)f 
                left outer join refund g on f.pay_no = g.refund_no)h left outer join pay_way i on h.pway_code = i.pway_code;
                
----------------------------------------------------------------------------

select *
from (select a.stay_name, b.room_grade, b.room_no
from stay a, room b
where a.stay_no = b.stay_no)c right outer join cart d on c.room_no = d.room_no;


-------------------------------------------------------------------------------------------------


select distinct a.mem_email, b.mid_name, b.mid_location, c.mid_no, c.photo_path
from mylist a, middle b, photo c
where a.mid_no = b.mid_no and b.mid_no = c.mid_no and a.mem_email = 'windy9109@naver.com';



----------------------------------------------------------------------------------------------------


select *
from
(select mem_email, mid_name, mid_location, mid_no, photo_path, ROW_NUMBER() OVER( PARTITION BY mid_no ORDER BY photo_path ) AS ROW_NUM
from  
(select distinct a.mem_email, b.mid_name, b.mid_location, c.mid_no, c.photo_path
from mylist a, middle b, photo c
where a.mid_no = b.mid_no and b.mid_no = c.mid_no and a.mem_email = 'windy9109@naver.com'))
where ROW_NUM = 1;




		select b.mre_no, c.mem_email, c.mre_title, to_char(c.mre_date, 'yyyy-mm-dd') as mre_date, b.mr_like, c.MID_NO
		from member a, mr_likes b, m_review c, middle d
		where a.mem_email = b.mem_email and b.mre_no = c.mre_no and c.mid_no = d.mid_no
		and a.mem_email = 'windy9109@naver.com'
		union
		select b.sre_no as mre_no, c.mem_email as mem_email, c.sre_title as sre_title, to_char(c.sre_date, 'yyyy-mm-dd') as sre_date, b.sr_like as sr_like, c.STAY_NO as MID_NO, d.stay_name
		from member a, sr_likes b, s_review c, stay d
		where a.mem_email = b.mem_email and b.sre_no = c.sre_no and d.stay_no = c.stay_no
		and a.mem_email = 'windy9109@naver.com';

