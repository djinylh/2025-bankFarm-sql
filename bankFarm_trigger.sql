-- 이것만 예시로 적어두겠음!

DROP TRIGGER IF EXISTS trg_insert_transaction

DELIMITER $$

CREATE TRIGGER trg_insert_transaction
BEFORE INSERT ON `transaction`
FOR EACH ROW
BEGIN

DECLARE amount INT; -- 계좌 잔액 변수 설정

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
SET NEW.trns_bal = amount + NEW.trns_amt; -- 출금 반영

/* 출금이 아니라면 .... */
ELSE -- 여기에서 위의 큰 IF문을 끝내는 END IF; 와 같은 효력을 가짐
SET NEW.trns_bal = amount + NEW.trns_amt; -- 입금 반영
END IF;

UPDATE `account` -- 원래 계좌의 보유 잔액으로 업데이트하기
SET acct_bal = NEW.trns_bal
WHERE acct_id = NEW.acct_id;

END $$
DELIMITER ;