--                                                           생성 테이블
CREATE TABLE cust_customer (
	cust_id	BIGINT	PRIMARY KEY	 AUTO_INCREMENT 	COMMENT '고객 ID'
	,cust_nm	VARCHAR(11)	NOT NULL 	COMMENT '고객 이름'
	,cust_phone	VARCHAR(20)	NOT NULL 	COMMENT '고객 연락처'
	,cust_email	VARCHAR(30)	NOT NULL 	COMMENT '고객 이메일'
	,cust_birth	VARCHAR(11)	NOT NULL 	COMMENT '고객 생년월일'
	,cust_crd_point	INT	NOT NULL 	COMMENT '고객 신용점수'
	,cust_ssn	VARCHAR(20)	NOT NULL 	COMMENT '고객 주민번호'
	,cust_cd	VARCHAR(5)	NOT NULL	COMMENT '고객 등급'
	,cust_tp	VARCHAR(5)	NOT NULL	COMMENT '고객 유형'
	,cust_marketing_yn	CHAR(1)	NOT NULL 	COMMENT '마케팅 동의 여부'
	,cust_crt_at	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP 	COMMENT '고객 가입일'
);

CREATE TABLE business_corporation (
	cust_business_number	VARCHAR(14)	NOT NULL UNIQUE COMMENT '사업자/법인번호'
	,cust_id	BIGINT	NOT NULL COMMENT '고객 ID'
	,cust_company_name	VARCHAR(20)	NOT NULL COMMENT '회사명'
	,cust_fax	VARCHAR(30)	NOT NULL COMMENT '팩스 번호'
	,cust_business_yn	CHAR(1)	NOT NULL COMMENT '폐업 상태'
	,CONSTRAINT fk_business_customer
	FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);

CREATE TABLE `account`(
	acct_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '계좌 ID'
	,cust_id BIGINT NOT NULL COMMENT '고객 ID'
	,acct_tp TINYINT DEFAULT 0 COMMENT '계좌 타입'
	,acct_sav_tp VARCHAR(5) NOT NULL COMMENT '이체 여부'
	,acct_num VARCHAR(4) COMMENT '계좌 번호'
	,acct_pw VARCHAR(20) COMMENT '비밀 번호'
	,acct_bal BIGINT NOT NULL DEFAULT 0 COMMENT '보유 잔액'
	,acct_day_limit BIGINT NOT NULL COMMENT '일일 출금 한도'
	,acct_sts_cd VARCHAR(5) NOT NULL COMMENT '계좌 상태'
	,acct_is_ded_yn CHAR NOT NULL DEFAULT 'Y' COMMENT '요구불 여부'
	,acct_crt_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '거래 일시'
);

CREATE TABLE acct_internal (
	acct_id BIGINT NOT NULL COMMENT '계좌 ID'
	,acct_int_nm VARCHAR(20) NOT NULL COMMENT '내부 계좌 이름'
	,acct_int_tp VARCHAR(20) NOT NULL COMMENT '내부 계좌 유형'
	,acct_int_upd_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시'
	CONSTRAINT fk_acctInternal_acctount
)

CREATE TABLE employees (
	emp_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '직원 ID'
	,bran_id BIGINT NOT NULL COMMENT '지점 ID'
	,emp_email VARCHAR(30) NOT NULL COMMENT '직원 이메일'
	,emp_nm VARCHAR(15) NOT NULL COMMENT '직원명'
	,emp_phone VARCHAR(13) NOT NULL COMMENT '직원 연락처'
	,emp_hire_dt DATE NOT NULL COMMENT '입사 일자'
	,emp_resignation_at DATE COMMENT '퇴사 일자'
	,emp_position_nm VARCHAR(3) COMMENT '직급'
	,emp_crt_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시'
	,emp_upt_at TIMESTAMP 
    DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시'
	,CONSTRAINT fk_employees_branch
	FOREIGN KEY (bran_id) REFERENCES branch(bran_id)
);

CREATE TABLE prod_document (
	bran_id BIGINT NOT NULL COMMENT '지점 ID'
	,doc_prod_tp VARCHAR(5) NOT NULL COMMENT '상품 타입'
	,doc_prod_id BIGINT NOT NULL COMMENT '상품 ID'
	,doc_nm VARCHAR(20) NOT NULL COMMENT '문서 이름'
	,doc_crt_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '작성일' 
	,CONSTRAINT fk_prodDocument_branch
	FOREIGN KEY (bran_id) REFERENCES branch(bran_id)
);

CREATE TABLE `transaction` (
	trns_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '입출금 ID'
	,acct_id BIGINT NOT NULL COMMENT '계좌 ID'
	,trns_fee_id BIGINT NULL DEFAULT NULL COMMENT '수수료 ID'
	,trns_amt BIGINT NOT NULL COMMENT '거래 금액'
	,trns_acct_num VARCHAR(20) NULL DEFAULT NULL COMMENT '상대 계좌' 
	,trns_bal BIGINT NOT NULL COMMENT '거래 후 잔액'
	,trns_tp TINYINT NOT NULL COMMENT '거래 사유'
	,trns_crt_at DATETIME NULL DEFAULT (CURRENT_TIMESTAMP) COMMENT '거래 일시'
	,trns_des VARCHAR(30) NOT NULL COMMENT '결제 목적' 
	,CONSTRAINT fk_trns_account FOREIGN KEY (acct_id) REFERENCES `account`(acct_id) 
	,CONSTRAINT fk_trns_fee FOREIGN KEY (trns_fee_id) REFERENCES trns_fee(trns_fee_id)
);

CREATE TABLE trns_fee (
	trns_fee_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '수수료 ID',
	,trns_fee INT NOT NULL COMMENT '수수료',
	,trns_fee_des VARCHAR(30) NOT NULL COMMENT '설명' COLLATE 'utf8mb4_bin'
);

CREATE TABLE loan_product(
	loan_prod_id  BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '대출 상품 ID'
	,loan_prod_nm VARCHAR(20) NOT NULL COMMENT '상품 이름'
	,loan_des VARCHAR(255) NOT NULL COMMENT '상품 설명'
	,loan_max_amt BIGINT NOT NULL COMMENT '대출 한도'
	,loan_rpmt_tp VARCHAR(5) NOT NULL COMMENT '상환 방식'
	,loan_term_mo INT NOT NULL COMMENT '최대 대출 기간'
	,loan_st_dt DATE NOT NULL COMMENT '상품 판매 시작일'
	,loan_ed_dt DATE NOT NULL COMMENT '상품 판매 종료일'
	,loan_sts_yn CHAR(1) NOT NULL COMMENT '상품 상태'
	,loan_prod_crt_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시'
	,loan_prod_upd_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시'
);

CREATE TABLE loan_application(
	loan_app_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '대출 신청 ID'
	,cust_id BIGINT NOT NULL COMMENT '고객 ID'
	,loan_prod_id BIGINT NOT NULL COMMENT '대출 상품 ID'
	,emp_id BIGINT NOT NULL COMMENT '직원 ID'
	,loan_req_amt BIGINT NOT NULL COMMENT '대출 금액'
	,loan_req_trm TINYINT NOT NULL COMMENT '대출 기간'
	,loan_app_dt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '신청일'
	,loan_app_sts_cd VARCHAR(5) NOT NULL COMMENT '상태값'
	,loan_dcsn_dt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '검토 완료 시간'
	,loan_rjct_rsn VARCHAR(20) COMMENT '거부 사유'
	,CONSTRAINT fk_loanApp_cust FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
	,CONSTRAINT fk_loanApp_loanProd FOREIGN KEY (loan_prod_id) REFERENCES loan_product(loan_prod_id)
	,CONSTRAINT fk_loanApp_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE loan(
	loan_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '대출 ID'
	,loan_app_id BIGINT NOT NULL COMMENT '대출 신청 ID'
	,loan_num VARCHAR(20) NOT NULL COMMENT '계좌 번호'
	,loan_bnk_cd VARCHAR(5) NOT NULL COMMENT '계좌 은행 아이디'
	,loan_fn_intrst DECIMAL(6,4) NOT NULL COMMENT '실제 이자'
	,loan_ed_dt DATE NOT NULL COMMENT '대출 종료일'
	,loan_fn_rpmt_tp VARCHAR(5) NOT NULL COMMENT '최종 상환 방식'
	,loan_use_acct VARCHAR(20) NOT NULL COMMENT '납부 계좌'
	,loan_use_bnk_cd VARCHAR(5) NOT NULL COMMENT '납부 은행 아이디'
	,loan_crt_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시'
	,loan_upd_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시'
	,loan_due_sts VARCHAR(10) NOT NULL COMMENT '지불 현황'
	,CONSTRAINT fk_loan_loanApp FOREIGN KEY (loan_app_id) REFERENCES loan_application(loan_app_id)
);

CREATE TABLE loan_repayment(
	loan_rpmt_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '대출 상환 ID'
	,loan_id BIGINT NOT NULL COMMENT '대출 ID'
	,loan_rpmt_prncp BIGINT NOT NULL COMMENT '원금'
	,loan_rpmt_intrst DECIMAL(6,4) NOT NULL COMMENT '이자'
	,loan_rpmt_due BIGINT NOT NULL COMMENT '상환금'
	,loan_due_dt DATE NOT NULL COMMENT '상환일'
	,loan_due_sts VARCHAR(5) NOT NULL COMMENT '지불 현황'
	,CONSTRAINT fk_loanReayment_loan FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
);

CREATE TABLE loan_overdue(
	loan_rpmt_id BIGINT NOT NULL COMMENT '대출 상환 ID'
	,loan_id BIGINT NOT NULL COMMENT '대출 ID'
	,loan_od_due_sts VARCHAR(10) NOT NULL COMMENT '납부 완료 여부'
	,loan_od_amt BIGINT NOT NULL COMMENT '연체 금액'
	,loan_od_st_dt DATE NOT NULL COMMENT '연체 시작일'
	,loan_od_ed_dt DATE COMMENT '최종 납부일'
	,loan_od_intrst DECIMAL(6,4) NOT NULL COMMENT'연체 이자'
	,loan_od_fn_amt BIGINT NOT NULL COMMENT '총 납입 금액'
	,loan_od_month INT NOT NULL COMMENT '연체 월'
	,CONSTRAINT fk_loanOverdue_loanRepayment FOREIGN KEY (loan_rpmt_id) REFERENCES loan_repayment(loan_rpmt_id)
	,CONSTRAINT fk_loanOverdue_loan FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
);

CREATE TABLE overdue_history(
	od_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '연체 ID'
	,cust_id BIGINT NOT NULL COMMENT '고객 ID'
	,od_source_id BIGINT NOT NULL COMMENT '연체 ID'
	,od_tp ENUM('LOAN','INSURANCE','CARD') NOT NULL COMMENT '상품  타입'
	,od_st_dt DATE NOT NULL COMMENT '연체 시작일'
	,od_amt BIGINT NOT NULL COMMENT '연체 금액'
	,CONSTRAINT fk_overdueHistory_customer FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);







-- 근우님 테이블 사본용
CREATE TABLE card_option_param (
	card_option_detail_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '세부옵션 ID',
	card_option_def_id BIGINT NOT NULL COMMENT '카드옵션정의 ID',
	card_option_des VARCHAR(150) NULL DEFAULT NULL COMMENT '옵션 설명' COLLATE 'utf8mb4_bin',
	card_active_yn CHAR(1) NULL DEFAULT NULL COMMENT '활성화 여부 Y,N' COLLATE 'utf8mb4_bin',
	PRIMARY KEY (card_option_detail_id) USING BTREE,
	INDEX card_option_def_id (card_option_def_id) USING BTREE,
	CONSTRAINT card_option_param_ibfk_1 
	FOREIGN KEY (card_option_def_id) 
	REFERENCES card_option_def (card_option_def_id) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COMMENT='세부 옵션 테이블'
COLLATE='utf8mb4_bin'
ENGINE=InnoDB
AUTO_INCREMENT=4
;

-- 태원님 지점 사본
CREATE TABLE branch (
	bran_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '지점 ID',
	bran_nm VARCHAR(20) NOT NULL COMMENT '지점명' COLLATE 'utf8mb4_bin',
	bran_tel VARCHAR(13) NOT NULL COMMENT '전화번호' COLLATE 'utf8mb4_bin',
	bran_address VARCHAR(100) NOT NULL COMMENT '주소' COLLATE 'utf8mb4_bin',
	bran_latitude DECIMAL(9,7) NOT NULL COMMENT '위도',
	bran_longitude DECIMAL(10,7) NOT NULL COMMENT '경도',
	bran_opened_at DATE NULL DEFAULT NULL COMMENT '영업 시작일',
	bran_active VARCHAR(5) NOT NULL COMMENT '영업상태' COLLATE 'utf8mb4_bin',
	bran_region_cd VARCHAR(5) NOT NULL COMMENT '지역 코드' COLLATE 'utf8mb4_bin',
	bran_closed_at DATE NULL DEFAULT NULL COMMENT '영업 종료일',
	PRIMARY KEY (bran_id) USING BTREE
)

--                                                           삭제 테이블

DROP TABLE customer;

DROP TABLE business_corporation;

DROP TABLE branch;

DROP TABLE card_option_param;

DROP TABLE employees;

DROP TABLE `account`;

DROP TABLE `transaction`;

DROP TABLE trns_fee;

DROP TABLE loan_product;

DROP TABLE loan_application;

DROP TABLE loan;

DROP TABLE loan_repayment;

DROP TABLE loan_overdue;

DROP TABLE overdue_history;

--                                      							  수정 테이블
ALTER TABLE prod_rate
ADD CONSTRAINT uq_prod_combo
UNIQUE (prod_tp, prod_id, prod_rt_id);


ALTER TABLE prod_document
ADD CONSTRAINT uq_prod_document_combo
UNIQUE (doc_prod_tp, doc_prod_id);

ALTER TABLE cust_business_corporation
MODIFY COLUMN cust_business_yn CHAR(1) DEFAULT 'N';

ALTER TABLE customer
MODIFY COLUMN cust_id BIGINT AUTO_INCREMENT COMMENT '고객 ID';