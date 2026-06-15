USE creditcard_analysis;

-- Total Transactions
SELECT COUNT(*) AS Total_Transactions
FROM transactions;

-- Fraud Transactions
SELECT COUNT(*) AS Fraud_Transactions
FROM transactions
WHERE IsFraud = 1;

-- Fraud Rate
SELECT ROUND(
    (COUNT(CASE WHEN IsFraud = 1 THEN 1 END) * 100.0)
    / COUNT(*),
    2
) AS Fraud_Rate_Percentage
FROM transactions;

-- Fraud by Location
SELECT Location,
       COUNT(*) AS Fraud_Count
FROM transactions
WHERE IsFraud = 1
GROUP BY Location
ORDER BY Fraud_Count DESC
LIMIT 10;

-- Fraud by Hour
SELECT Hour,
       COUNT(*) AS Fraud_Count
FROM transactions
WHERE IsFraud = 1
GROUP BY Hour
ORDER BY Fraud_Count DESC;

-- High Risk Transactions
SELECT RiskFlag,
       COUNT(*) AS Total
FROM transactions
GROUP BY RiskFlag;

-- Fraud by Transaction Type
SELECT TransactionType,
       COUNT(*) AS Fraud_Count
FROM transactions
WHERE IsFraud = 1
GROUP BY TransactionType;

-- Fraud by Month
SELECT Month,
       COUNT(*) AS Fraud_Count
FROM transactions
WHERE IsFraud = 1
GROUP BY Month
ORDER BY Fraud_Count DESC;

-- Top Merchants by Fraud
SELECT MerchantID,
       COUNT(*) AS Fraud_Count
FROM transactions
WHERE IsFraud = 1
GROUP BY MerchantID
ORDER BY Fraud_Count DESC
LIMIT 10;

-- Average Fraud Amount
SELECT ROUND(AVG(Amount),2) AS Avg_Fraud_Amount
FROM transactions
WHERE IsFraud = 1;

-- Average Normal Amount
SELECT ROUND(AVG(Amount),2) AS Avg_Normal_Amount
FROM transactions
WHERE IsFraud = 0;

-- Fraud Count by Risk Level
SELECT RiskFlag,
       COUNT(*) AS Fraud_Count
FROM transactions
WHERE IsFraud = 1
GROUP BY RiskFlag;

-- Fraud Percentage by Location
SELECT Location,
       ROUND(
           COUNT(CASE WHEN IsFraud = 1 THEN 1 END) * 100.0
           / COUNT(*),
           2
       ) AS Fraud_Percentage
FROM transactions
GROUP BY Location
ORDER BY Fraud_Percentage DESC;

-- Fraud Summary View
CREATE VIEW fraud_summary AS
SELECT
    TransactionID,
    Amount,
    Location,
    TransactionType,
    Hour,
    RiskFlag
FROM transactions
WHERE IsFraud = 1;

SELECT * FROM fraud_summary LIMIT 10;