

USE credit_portfolio_db;

SELECT
    COUNT(*) AS total_loans,
    SUM(loan_amnt) AS total_loan_amount,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
FROM credit_portfolio_cleaned;


SELECT
    purpose,
    COUNT(*) AS total_loans,
    SUM(`Default`) AS defaulted_loans,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
FROM credit_portfolio_cleaned
GROUP BY purpose
ORDER BY default_rate DESC;



SELECT
    emp_length,
    COUNT(*) AS total_borrowers,
    SUM(`Default`) AS defaulted_borrowers,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
FROM credit_portfolio_cleaned
GROUP BY emp_length
ORDER BY default_rate DESC;


SELECT
    addr_state,
    COUNT(*) AS total_loans,
    SUM(loan_amnt) AS total_loan_amount,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
FROM credit_portfolio_cleaned
GROUP BY addr_state
ORDER BY default_rate DESC;



SELECT
    issue_year,
    COUNT(*) AS total_loans,
    SUM(loan_amnt) AS total_loan_amount,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
FROM credit_portfolio_cleaned
GROUP BY issue_year
ORDER BY issue_year;
