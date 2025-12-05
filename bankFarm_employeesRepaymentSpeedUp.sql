-- 1년간 실적이 좋은 직원의 정보
EXPLAIN
SELECT e.emp_id, e.emp_nm, e.emp_position_nm, COUNT(1) AS total_cnt, b.bran_id
FROM employees e 
LEFT JOIN user_card uc
ON e.emp_id = uc.emp_id
	AND uc.card_crt_at BETWEEN '2020-01-01' AND '2021-01-01'
LEFT JOIN depo_contract dc
ON e.emp_id = dc.emp_id
	AND dc.depo_contract_dt BETWEEN '2020-01-01' AND '2021-01-01'
LEFT JOIN loan_application la
ON e.emp_id = la.emp_id
	AND la.loan_dcsn_dt  BETWEEN '2020-01-01' AND '2021-01-01'
LEFT JOIN branch b
ON e.bran_id = b.bran_id 
GROUP BY e.emp_id
ORDER BY total_cnt DESC
LIMIT 10;

-- 개선 시작

CREATE INDEX I_empId_cardCrtAt ON user_card(emp_id, card_crt_at);
DROP	INDEX	 I_empId_cardCrtAt ON user_card;

CREATE INDEX I_empId_depoCrnDt ON depo_contract(emp_id, depo_contract_dt);
DROP	INDEX	 I_empId_depoCrnDt ON depo_contract;

CREATE INDEX I_empId_loanDcsnDt ON loan_application(emp_id, loan_dcsn_dt);
DROP	INDEX	 I_empId_loanDcsnDt ON loan_application;

-- 쿼리 변경 불필요한 LEFT JOIN 삭제
EXPLAIN
SELECT
    e.emp_id,
    e.emp_nm,
    e.emp_position_nm,
    COALESCE(t.total_cnt, 0) AS total_cnt, 
    b.bran_id
FROM
    employees e
LEFT JOIN
    branch b ON e.bran_id = b.bran_id
LEFT JOIN
    (
        SELECT
            emp_id,
            COUNT(1) AS total_cnt
        FROM
            (
                SELECT emp_id FROM user_card
                WHERE card_crt_at BETWEEN '2020-01-01' AND '2021-01-01'
                UNION ALL
                SELECT emp_id FROM depo_contract
                WHERE depo_contract_dt BETWEEN '2020-01-01' AND '2021-01-01'
                UNION ALL
                SELECT emp_id FROM loan_application
                WHERE loan_dcsn_dt BETWEEN '2020-01-01' AND '2021-01-01'
            ) AS combined_transactions
        GROUP BY emp_id
    ) AS t ON e.emp_id = t.emp_id
ORDER BY
    total_cnt DESC
LIMIT 10;