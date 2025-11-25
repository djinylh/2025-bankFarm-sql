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


--                                                           수정 테이블

ALTER TABLE customer
MODIFY COLUMN cust_id	BIGINT 	COMMENT '고객 ID';

ALTER TABLE `account`
MODIFY COLUMN acct_num VARCHAR(20) NOT NULL UNIQUE COMMENT '계좌 번호';




ALTER TABLE business_corporation
MODIFY COLUMN cust_id	BIGINT 	COMMENT '고객 ID';


ALTER TABLE business_corporation
DROP FOREIGN KEY fk_business_customer;


ALTER TABLE business_corporation
ADD CONSTRAINT fk_business_customer
FOREIGN KEY (cust_id) REFERENCES customer(cust_id);