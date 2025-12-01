
-- 대출 상환 테이블에 연체된 애들 중 적용된 가산 금리가 몇 퍼인지 확인하는 셀렉트
-- 처음 9.797초
EXPLAIN
SELECT a.loan_id, a.loan_rpmt_id, a.loan_rpmt_due, a.loan_due_dt, a.loan_rpmt_intrst, b.rt_pct
FROM (SELECT DISTINCT lr.loan_id, lr.loan_rpmt_id, lr.loan_rpmt_due, lr.loan_due_dt, lr.loan_rpmt_intrst
FROM loan_repayment lr
WHERE lr.loan_due_sts = 'TX007'
AND lr.loan_id IN (SELECT p.prod_id
FROM prod_rate p
WHERE p.prod_tp = 'RT007')) AS a
LEFT JOIN
(SELECT DISTINCT pr.prod_id, rr.rt_id,rr.rt_rule, rr.rt_pct
FROM prod_rate pr
LEFT JOIN rate_rule rr
ON pr.prod_rt_id = rr.rt_id
WHERE rr.rt_tp = 'RT002') AS b
ON a.loan_id = b.prod_id;

/*																				쿼리 개선	 총  0.157초																*/

-- 쿼리 개선
EXPLAIN
SELECT
  lr.loan_id,
  lr.loan_rpmt_id,
  lr.loan_rpmt_due,
  lr.loan_due_dt,
  lr.loan_rpmt_intrst,
  rs.total_rt_pct
FROM loan_repayment lr
LEFT JOIN (
    SELECT 
        pr.prod_id,
        SUM(rr.rt_pct) AS total_rt_pct
    FROM prod_rate pr
    JOIN rate_rule rr
        ON rr.rt_id = pr.prod_rt_id
        AND rr.rt_tp = 'RT002'
    WHERE pr.prod_tp = 'RT007'
        AND pr.prod_id IN (SELECT loan_id FROM loan_repayment WHERE loan_due_sts = 'TX007')
    GROUP BY pr.prod_id
) rs
    ON rs.prod_id = lr.loan_id
WHERE lr.loan_due_sts = 'TX007';


-- 대출 상환에 필요한건 연체 됐는지 안 됐는지 확인, 해당 대출의 아이디
CREATE INDEX I_loanId_dueSts ON loan_repayment(loan_due_sts, loan_id);
DROP	INDEX	 I_loanId_dueSts ON loan_repayment;

-- 금리에서 필요한 건  PK와 적용된 금리ID값
CREATE INDEX I_prodId_rateId ON prod_rate(prod_rt_id, prod_id);
DROP	INDEX	 I_prodId_rateId ON prod_rate;

-- 금리 테이블에서 ID랑 타입 묶어두기
CREATE INDEX I_rateId_rateTp ON rate_rule(rt_tp,rt_id);
DROP	INDEX	 I_rateId_rateTp ON rate_rule;
