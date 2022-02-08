2002-0208-01) Ʈ���� ����
    ** HR������ ������̺� �������� �÷��� �߰��Ͻÿ�
        ALTER TABLE HR.EMPLOYEES ADD(RETIRE_DATE DATE);
        --Table HR.EMPLOYEES��(��) ����Ǿ����ϴ�.
    
    ** HR������ ������ ���̺��� �����Ͻÿ�
        ���̺��: RETIRES
        �÷���           ������Ÿ��      NULLABLE    PK/FK
        --------------------------------------------------
        EMPLOYEE_ID     NUMBER(6)       N.N       PK&FK
        RETIRE_DATE     DATE
        JOB_ID          VARCHAR2(10)              FK
        DEPARTMENT_ID   NUMBER(4)                 FK
        -------------------------------------------------- 
        CREATE TABLE RETIRES(
        EMPLOYEE_ID     NUMBER(6),
        RETIRE_DATE     DATE,
        JOB_ID          VARCHAR2(10),    
        DEPARTMENT_ID   NUMBER(4),
        CONSTRAINT pk_retires PRIMARY KEY(EMPLOYEE_ID),
        CONSTRAINT fk_ret_emp FOREIGN KEY(EMPLOYEE_ID)
            REFERENCES EMPLOYEES(EMPLOYEE_ID),
        CONSTRAINT fk_ret_jobs FOREIGN KEY(JOB_ID)
            REFERENCES JOBS(JOB_ID),
        CONSTRAINT fk_ret_dept FOREIGN KEY(DEPARTMENT_ID)
            REFERENCES DEPARTMENTS(DEPARTMENT_ID));
        --Table RETIRES��(��) �����Ǿ����ϴ�.
            
            

        ��뿹) ������̺��� �Ի����� 2003�� ������ �Ի��� ������� ���� ó���Ϸ��Ѵ�.
               �����ڴ� ������̺� �������ڿ� ���ó�¥�� �����ϱ��� ���������̺� ������ �Է��ؾ��Ѵ�.
        --�̰� �۾�����
        
        CREATE TRIGGER tg_retire
          BEFORE UPDATE ON EMPLOYEES
          FOR EACH ROW  --���ึ�ٽ���
          BEGIN
            INSERT INTO RETIRES
                VALUES(:OLD.EMPLOYEE_ID,SYSDATE,:OLD.JOB_ID, :OLD.DEPARTMENT_ID);
                --���ึ���� 
          END;
        --Trigger TG_RETIRE��(��) �����ϵǾ����ϴ�.
        
        
        (����)
        UPDATE EMPLOYEES
            SET RETIRE_DATE = SYSDATE
         WHERE HIRE_DATE <= TO_DATE('20021231');
        --8�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            
            
 