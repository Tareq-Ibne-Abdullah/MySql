SELECT * FROM bank_loan_data;

-- Total loan application
-- each id is an application, so we need to find total id in the table
SELECT COUNT(id) AS Total_Loan_Application FROM bank_loan_data

-- Month to data total loan application 
SELECT COUNT(id) AS MTD_Total_Loan_Application FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Total funded amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

-- Month to date funded amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
Where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Previous Month to date total funded amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan_data
Where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Total received amount
SELECT SUM(total_payment) AS Total_amount_received FROM bank_loan_data

-- Total month to date received
SELECT SUM(total_payment) AS MTD_Total_amount_received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Previous Month to date total received
SELECT SUM(total_payment) AS PMTD_Total_amount_received FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Avg Interest rate
SELECT AVG(int_rate) * 100 AS Avg_Interest_Rate FROM bank_loan_data

-- Avg Interest rate to 2 decimal point
SELECT ROUND(AVG(int_rate),4) * 100 AS Avg_Interest_Rate FROM bank_loan_data

-- Month to date average interest rate 
SELECT ROUND(AVG(int_rate),4) * 100 AS MTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- last Month to date average interest rate 
SELECT ROUND(AVG(int_rate),4) * 100 AS PMTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


-- Average Debt-to-Income Ratio (DTI)
SELECT ROUND(AVG(dti),4) * 100 AS Avg_DTI FROM bank_loan_data

-- Month to date average debt to income ratio
SELECT ROUND(AVG(dti),4) * 100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Previous Month DTI
SELECT ROUND(AVG(dti),4) * 100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

SELECT loan_status FROM bank_loan_data

-- Good loan percentage 
SELECT
	(COUNT(CASE WHEN loan_status = 'Fully Paid' or loan_status ='Current' THEN id END) * 100)
	/
	COUNT(id) As Good_loan_percentage
FROM bank_loan_data

-- Good loan Application
SELECT COUNT(id) AS Good_loan_application FROM bank_loan_data
	WHERE loan_status ='Fully Paid' OR loan_status ='Current'

-- Good loan funded amount 
SELECT SUM(loan_amount) AS Good_loan_funded_amount FROM bank_loan_data
	WHERE loan_status ='Fully Paid' OR loan_status ='Current'

-- Good loan Received amount
SELECT SUM(total_payment) AS Good_loan_received_amount FROM bank_loan_data
	WHERE loan_status ='Fully Paid' OR loan_status ='Current'

-- bad loan parcentage
SELECT
	(COUNT(CASE WHEN loan_status = 'Charged off' THEN id END) * 100)
	/
	COUNT(id) As bad_loan_percentage
FROM bank_loan_data

-- total bad application	
SELECT COUNT(id) AS Bad_Loan_Application FROM bank_loan_data
WHERE loan_status ='Charged off'

-- Total BAd loan amount
SELECT SUM(loan_amount) AS Bad_Loan_Amount FROM bank_loan_data
WHERE loan_status ='Charged off'

-- Total bad loan amount received 
SELECT SUM(total_payment) AS Bad_Loan_received FROM bank_loan_data
WHERE loan_status ='Charged off'

-- Loan Status 
SELECT
        loan_status,
        COUNT(id) AS Total_Loan_Application,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status

-- Month to date Loan Status
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

-- Monthly trend by issue date
SELECT
	MONTH(issue_date) AS Month_number,
	DATENAME(MONTH, issue_date) AS Month_name,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) AS Total_loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

-- Regional analysis by state
SELECT
	address_state AS State,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) AS Total_loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY COUNT(id) DESC

--Loan Term Analysis

SELECT
	term,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) AS Total_loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term

-- Loan Purpose Breakdown 
SELECT
	purpose,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) AS Total_loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC

-- Home ownership Breakdown
SELECT
	home_ownership,
	COUNT(id) AS Total_Application,
	SUM(loan_amount) AS Total_loan_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC