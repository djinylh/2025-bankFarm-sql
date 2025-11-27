-- FK 제약 무시
SET FOREIGN_KEY_CHECKS = 0;
-- FK 체크 다시 활성화
SET FOREIGN_KEY_CHECKS = 1;

-- 테이블 데이터 삭제
TRUNCATE TABLE account;
TRUNCATE TABLE depo_contract;
TRUNCATE TABLE prod_document;
TRUNCATE TABLE transaction;
TRUNCATE TABLE check_card;
TRUNCATE TABLE loan_product;
TRUNCATE TABLE loan_overdue;

-- PK 1부터 초기화
ALTER TABLE account AUTO_INCREMENT = 1;
ALTER TABLE depo_contract AUTO_INCREMENT = 1;
ALTER TABLE transaction AUTO_INCREMENT = 1;
ALTER TABLE transaction AUTO_INCREMENT =1;


