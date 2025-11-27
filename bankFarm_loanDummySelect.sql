/*																									대출 SELECT 																*/
-- 승인된 대출에 총 액수와 대출 월 수 불러오는 SELECT
SELECT loan_app_id, loan_req_amt, loan_req_trm, loan_dcsn_dt
FROM loan_application
WHERE loan_app_sts_cd = 'AP002'
ORDER BY loan_dcsn_dt;

-- 대출 하나당 스케줄이 몇인지 SELECT 
SELECT l.loan_id
FROM loan l 
JOIN loan_repayment lr
ON l.loan_id = lr.loan_id
GROUP BY l.loan_id;

-- 연체에 대한 정보 불러오는 SELECT
SELECT l.loan_id, la.loan_dcsn_dt, la.loan_req_amt, la.loan_req_trm, l.loan_fn_intrst
FROM loan l
JOIN loan_application la
ON l.loan_app_id = la.loan_app_id
WHERE l.loan_id = 1;

-- 연체 테이블에 이동할 대출 상환 기록 SELECT
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

-- 공통 연체로 이동할 SELECT 
-- 연체 아이디 / 대출 아이디 / 연체 시작일 / 연체 금액, 고객 ID
SELECT a.loan_rpmt_id, a.loan_od_fn_amt, a.loan_od_st_dt, b.cust_id, b.emp_id
FROM (
    SELECT lo.loan_id, lo.loan_rpmt_id, lo.loan_od_fn_amt, lo.loan_od_st_dt
    FROM loan_overdue lo
) AS a
LEFT JOIN (
    SELECT l.loan_id, la.cust_id, la.emp_id
    FROM loan_application la
    LEFT JOIN loan l
        ON la.loan_app_id = l.loan_app_id
) AS b
    ON a.loan_id = b.loan_id;

-- 직원 아이디 찾기
SELECT b.bran_id
FROM branch b
LEFT JOIN employees e
ON b.bran_id = e.bran_id
WHERE e.emp_id = 1;
