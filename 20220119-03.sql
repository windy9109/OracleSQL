2022-0119-03)
2. SELF JOIN
    -하나의 테이블에 여러개의 별칭을 부여하여 수행하는 조인
     
사용예) 회원테이블에서 '라준호'회원의 마일리지보다 많은 마일리지를 보유한 회원의
       회원번호, 회원명, 직업, 마일리지를 조회하시오.
        
        SELECT B.MEM_ID AS 회원번호, 
               B.MEM_NAME AS 회원명, 
               B.MEM_JOB AS 직업, 
               B.MEM_MILEAGE AS 마일리지
         FROM MEMBER A, MEMBER B
         WHERE A.MEM_NAME ='라준호'
            AND B.MEM_MILEAGE> A.MEM_MILEAGE;
            
            
            

사용예) 사원테이블에서 각 사원의 관리자 사원이름을 조회하시오
        관리자가 없으면 'CEO'를 출력하시오
        Alias는 사원번호, 사원명, 부서명, 관리자이름 
    
    SELECT C.EMPLOYEE_ID AS 사원번호, 
           C.EMP_NAME AS 사원명, 
           B.DEPARTMENT_NAME AS 부서명, 
           NVL((SELECT D.EMP_NAME
                  FROM HR.EMPLOYEES D
                WHERE D.EMPLOYEE_ID = C.MANAGER_ID),'CEO')  AS 관리자이름
        FROM HR.DEPARTMENTS B, HR.EMPLOYEES C 
        WHERE  C.DEPARTMENT_ID = B.DEPARTMENT_ID
        ORDER BY 1;
                
                
                
                
                
        --관리자가 NULL인 사원 OUTER 조인
        SELECT C.EMPLOYEE_ID AS 사원번호, 
           C.EMP_NAME AS 사원명, 
           B.DEPARTMENT_NAME AS 부서명, 
           NVL(D.EMP_NAME,'CEO') AS 관리자이름
--           NVL((SELECT D.EMP_NAME
--                  FROM HR.EMPLOYEES D
--                WHERE D.EMPLOYEE_ID = C.MANAGER_ID),'CEO') 
        FROM HR.DEPARTMENTS B, HR.EMPLOYEES C, HR.EMPLOYEES D
        WHERE  C.DEPARTMENT_ID = B.DEPARTMENT_ID
          AND D.DEPARTMENT_ID(+) = C.MANAGER_ID
        ORDER BY 1;
            
         
