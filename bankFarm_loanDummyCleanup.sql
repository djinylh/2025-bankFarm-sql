/*											대출 테이블													*/


-- 2025-11-27 미만 대출 상환 스케줄 확인
SELECT *
FROM loan_repayment
WHERE loan_due_dt <= '2025-11-27'
LIMIT 1000;

-- 2025-11-27 미만 대출 상환 테이블은 다 지급 완료로 변경
UPDATE loan_repayment
SET loan_due_sts = 'TX004'
WHERE loan_due_dt <= '2025-11-27';

-- 대출 하나당 스케줄이 몇인지 확인
SELECT l.loan_id
FROM loan l 
JOIN loan_repayment lr
ON l.loan_id = lr.loan_id
GROUP BY l.loan_id;

-- 대출 하나에 스케줄들이 다 지급 완료인지 확인
SELECT l.loan_id
FROM loan l
JOIN loan_repayment lr
    ON l.loan_id = lr.loan_id
GROUP BY l.loan_id
HAVING COUNT(*) = SUM(CASE WHEN lr.loan_due_sts = 'TX004' THEN 1 ELSE 0 END);

-- 스케줄이 끝난 대출은 납부 완료로 바꿔주기
UPDATE loan
SET loan_due_sts = 'TX004'
WHERE loan_id IN (
    SELECT loan_id FROM (
        SELECT l.loan_id
        FROM loan l
        JOIN loan_repayment lr ON l.loan_id = lr.loan_id
        GROUP BY l.loan_id
        HAVING COUNT(*) = SUM(CASE WHEN lr.loan_due_sts = 'TX004' THEN 1 ELSE 0 END)
    ) AS t
);

-- 바뀌었는지 확인
SELECT *
FROM loan_application la
JOIN loan l
ON la.loan_app_id = l.loan_app_id
WHERE l.loan_due_sts = 'TX004';

-- 대출 데이터가 너무 많아서 순차적으로 삭제하기 대출 10만개만 유지
DELETE FROM loan
WHERE loan_id BETWEEN 100001 AND 300000;

-- la가 승인 상태인데 loan 테이블에 la.Id가 없는 애들 삭제
DELETE la
FROM loan_application la
LEFT JOIN loan l ON la.loan_app_id = l.loan_app_id
WHERE la.loan_app_sts_cd = 'AP002'
  AND l.loan_id IS NULL;

-- 아무거나 확인
SELECT *
FROM loan_application la
JOIN loan l
ON la.loan_app_id = l.loan_app_id
WHERE l.loan_id = 10000;
  
  
