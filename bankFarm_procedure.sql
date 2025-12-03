
/*																															대출 연체 프로시저 																	*/
DROP PROCEDURE IF EXISTS proc_loan_overdue;
DELIMITER $$

CREATE PROCEDURE proc_loan_overdue()
BEGIN
-- 공통 조인
	CREATE TEMPORARY TABLE temp_rs AS 
	    SELECT pr.prod_id, SUM(rr.rt_pct) AS total_rt_pct
	    FROM prod_rate pr
	    JOIN rate_rule rr ON rr.rt_id = pr.prod_rt_id AND rr.rt_tp = 'RT002'
	    WHERE pr.prod_tp = 'RT007'
	      AND pr.prod_id IN (
	          SELECT loan_id 
	          FROM loan_repayment 
	          WHERE loan_due_sts = 'TX007'
	      )
	    GROUP BY pr.prod_id;

--									대출상환 아이디, 대출 아이디, 대출 스테이터스, 대출 상환금, 연체 시작일, 연체 이자, 연체 총 금액
		INSERT INTO loan_overdue(loan_rpmt_id, loan_id, loan_od_due_sts, loan_od_amt, loan_od_st_dt, loan_od_intrst, loan_od_fn_amt)
		SELECT
		  lr.loan_rpmt_id, -- 대출 상환 아이디
		  lr.loan_id, -- 대출 아이디
		  'TX007',
		    lr.loan_rpmt_due, -- 대출 금액
		  lr.loan_due_dt, -- 대출 일시
		  lr.loan_rpmt_intrst + COALESCE(rs.total_rt_pct, 0), -- 대출 총 이자 ( 원래 이자 + 가산 금리 )
		  ROUND(lr.loan_rpmt_due * (lr.loan_rpmt_intrst + COALESCE(rs.total_rt_pct,0)),0)
		FROM loan_repayment lr
		LEFT JOIN temp_rs
		    ON temp_rs.prod_id = lr.loan_id
		WHERE lr.loan_due_sts = 'TX007'
		AND lr.loan_due_dt = CURDATE() - INTERVAL 1 DAY;

-- 공통 연체에도 이동
		INSERT INTO overdue_history(od_id, cust_id, od_source_id, od_tp, od_st_dt, od_amt)
		SELECT UUID(), la.cust_id, lr.loan_rpmt_id, 'PD007', lr.loan_due_dt, ROUND(lr.loan_rpmt_due * (lr.loan_rpmt_intrst + COALESCE(rs.total_rt_pct,0)),0)
		FROM loan_repayment lr
		LEFT JOIN temp_rs
		    ON temp_rs.prod_id = lr.loan_id
		    LEFT JOIN loan_application la
		    ON lr.loan_id = la.loan_id
		WHERE lr.loan_due_sts = 'TX007'
		AND lr.loan_due_dt = CURDATE() - INTERVAL 1 DAY;


END $$
DELIMITER ;

/* 																															고객 가입 프로시저 																*/

DROP PROCEDURE IF EXISTS proc_customer_join;
DELIMITER $$

CREATE PROCEDURE proc_customer_join(
	IN p_cust_nm VARCHAR(11)
	,IN p_cust_phone VARCHAR(13)
	,IN p_cust_email VARCHAR(30)
	,IN p_cust_birth VARCHAR(10)
	,IN p_cust_crd_point INT
	,IN p_cust_ssn VARCHAR(20)
	,IN p_cust_cd VARCHAR(5)
	,IN p_cust_tp VARCHAR(5)
	,IN p_cust_marketing_yn CHAR(1)
	,IN p_cust_business_number VARCHAR(14)
	,IN p_cust_company_name VARCHAR(20)
	,IN p_cust_fax VARCHAR(30)
)
BEGIN

	DECLARE new_cust_id BIGINT; -- 변수 저장
	
	INSERT INTO customer
	(cust_nm, cust_phone, cust_email ,  cust_birth, cust_crd_point, cust_ssn, cust_cd, cust_tp, cust_marketing_yn)
	VALUES
	(p_cust_nm, p_cust_phone, p_cust_email, p_cust_birth, p_cust_crd_point, p_cust_ssn, p_cust_cd, p_cust_tp, p_cust_marketing_yn);
	
	 SET new_cust_id = LAST_INSERT_ID(); -- 위의 customer의 PK 생성시 여기에 담아줌
	 
	 IF new_cust_id IS NULL THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '고객 생성 실패: cust_id를 가져올 수 없습니다.';
	 END IF;
	 
	 IF p_cust_tp <> 'CU011' -- 일반 고객이 아니라면
	 THEN
	 	IF  	p_cust_business_number IS NULL
	 		OR p_cust_company_name IS NULL
	 		OR p_cust_fax IS NULL
		THEN
	 		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = '사업자번호, 회사이름, 팩스번호는 필수로 입력해야 합니다.';
	 		
	 	ELSE
	 		INSERT INTO cust_business_corporation
	 		(cust_business_number, cust_id, cust_company_name, cust_fax)
	 		VALUE
	 		(p_cust_business_number,new_cust_id, p_cust_company_name, p_cust_fax);
	 	END IF;
	 		
	 END IF;		
	 
END $$
DELIMITER ;