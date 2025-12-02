/* 																											입출금 트리거 																					*/
DROP TRIGGER IF EXISTS trg_insert_transaction
DELIMITER $$

CREATE TRIGGER trg_insert_transaction
BEFORE INSERT ON `transaction`
FOR EACH ROW
BEGIN

DECLARE amount INT; -- 계좌 잔액 변수 설정
DECLARE fee INT; -- 수수료

SELECT trns_fee INTO fee
FROM trns_fee
WHERE trns_fee_id = NEW.trns_fee_id;

SELECT acct_bal INTO amount -- acct_bal 의 보유 잔액을 amount에 넣겠다
FROM `account`
WHERE acct_id = NEW.acct_id; -- NEW.acct_id는 인서트 됐을 때 넘어오는 acct_id 이거랑 원래 acct_id랑 연결하는 것

IF NEW.trns_amt < 0 THEN -- trns_amt가 출금인지 ( - 10000 ) 입금인지 ( 10000 ) 확인하는 IF문

/* 여기서 다른 IF문 시작 */
IF ABS(NEW.trns_amt) > amount THEN
SIGNAL SQLSTATE '45000' -- 보통 강제 오류발생은 45000을 날린다고 함. 
SET MESSAGE_TEXT = '잔액이 부족합니다';
END IF;
/*	다른 IF문 끝 */
SET NEW.trns_bal = amount + NEW.trns_amt - fee; -- 출금 반영

/* 출금이 아니라면 .... */
ELSE -- 여기에서 위의 큰 IF문을 끝내는 END IF; 와 같은 효력을 가짐
SET NEW.trns_bal = amount + NEW.trns_amt - fee; -- 입금 반영
END IF;

UPDATE `account` -- 원래 계좌의 보유 잔액으로 업데이트하기
SET acct_bal = NEW.trns_bal
WHERE acct_id = NEW.acct_id;

END $$
DELIMITER ;


/*																													대출 가입 트리거 																	*/

DROP TRIGGER IF EXISTS trg_insert_loan

DELIMITER $$

CREATE TRIGGER trg_insert_loan
AFTER INSERT ON loan
FOR EACH ROW
BEGIN

DECLARE i INT DEFAULT 1; -- 반복문용
DECLARE totalMonth INT; -- 대출 기간
DECLARE firstMonth DATE; -- 대출 시작일
DECLARE totalAmt BIGINT; -- 대출 총 금액
DECLARE oneMonthAmt BIGINT; -- 상환 원 금액
DECLARE rate DECIMAL(6,4); -- 실제 이자
DECLARE totalMonthAmt BIGINT; -- 한달 실제 금액
DECLARE app_id BIGINT;
DECLARE bran_id BIGINT;

SELECT 
	la.loan_req_trm
	, la.loan_dcsn_dt 
	, la.loan_req_amt 
	, l.loan_fn_intrst
	, la.loan_app_id
	, b.bran_id
INTO totalMonth, firstMonth, totalAmt, rate, app_id, bran_id
FROM loan l
LEFT JOIN loan_application la
ON l.loan_app_id = la.loan_app_id
LEFT JOIN employees e
ON la.emp_id = e.emp_id
LEFT JOIN branch b
ON b.bran_id = e.bran_id
WHERE la.loan_app_id = NEW.loan_app_id;

SET oneMonthAmt = ROUND(totalAmt / totalMonth,0); -- 상환 원 금액
SET totalMonthAmt = ROUND(oneMonthAmt*rate,0); -- 한달 실제 금액

-- 반복문 시작 [ 대출 기간만큼 row 만들어줄 것 ]
-- repayment 필요 데이터
-- 대출 ID, 매달 상환금, 전체 이자, 이자가 곱해진 금액, 한달씩 늘어나기, 기본 스테이터스값
WHILE i <= totalMonth DO
INSERT INTO loan_repayment (loan_id, loan_rpmt_prncp, loan_rpmt_intrst, loan_rpmt_due, loan_due_dt, loan_due_sts)
VALUE (NEW.loan_id, oneMonthAmt, rate, totalMonthAmt, DATE_ADD(firstMonth, INTERVAL i MONTH) ,'TX003');

SET i = i + 1;

END WHILE;


INSERT INTO prod_document (
	bran_id
	, doc_prod_tp
	, doc_prod_id
	, doc_nm
)
VALUE (
	bran_id
	, 'PD007'
	, app_id
	, '대출 계약 문서 이름'
);

END $$

DELIMITER ;

/*																									계좌 트리거													*/



