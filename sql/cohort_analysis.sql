-- Cohort Analysis SQL Queries
-- Production-ready queries for retention and cohort analysis
-- Focuses on contract type and tenure bucket analysis

-- 1. Retention/Cohort Analysis by Contract Type and Tenure Bucket
-- Analyzes retention patterns across different contract types and customer lifecycle stages
WITH tenure_buckets AS (
    SELECT
        customerID,
        CASE
            WHEN tenure < 3 THEN '0-3 months'
            WHEN tenure < 6 THEN '3-6 months'
            WHEN tenure < 12 THEN '6-12 months'
            WHEN tenure < 24 THEN '12-24 months'
            ELSE '24+ months'
        END as tenure_bucket,
        Contract,
        Churn,
        MonthlyCharges,
        TotalCharges
    FROM customers
),
cohort_analysis AS (
    SELECT
        Contract,
        tenure_bucket,
        COUNT(*) as customer_count,
        SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) as retained_count,
        ROUND(100.0 * SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) / COUNT(*), 2) as retention_rate,
        ROUND(AVG(MonthlyCharges), 2) as avg_monthly_charges,
        ROUND(AVG(TotalCharges), 2) as avg_lifetime_value
    FROM tenure_buckets
    GROUP BY Contract, tenure_bucket
)
SELECT * FROM cohort_analysis ORDER BY Contract, tenure_bucket;

-- 2. Contract Type Performance Summary
-- Aggregated view of contract type effectiveness across all tenure buckets
WITH contract_performance AS (
    SELECT
        Contract,
        COUNT(*) as total_customers,
        SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) as total_retained,
        ROUND(100.0 * SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) / COUNT(*), 2) as overall_retention_rate,
        ROUND(AVG(MonthlyCharges), 2) as avg_monthly_revenue,
        ROUND(SUM(MonthlyCharges * 12), 0) as annual_contract_revenue,
        ROUND(AVG(TotalCharges), 2) as avg_customer_ltv
    FROM customers
    GROUP BY Contract
)
SELECT * FROM contract_performance ORDER BY overall_retention_rate DESC;

-- 3. Tenure Bucket Churn Trends
-- Shows how churn rates evolve across customer lifecycle stages
WITH tenure_trends AS (
    SELECT
        CASE
            WHEN tenure < 3 THEN '0-3 months'
            WHEN tenure < 6 THEN '3-6 months'
            WHEN tenure < 12 THEN '6-12 months'
            WHEN tenure < 24 THEN '12-24 months'
            ELSE '24+ months'
        END as tenure_bucket,
        COUNT(*) as customer_count,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned_count,
        ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_rate,
        ROUND(AVG(MonthlyCharges), 2) as avg_monthly_charges,
        ROUND(SUM(MonthlyCharges * 12), 0) as annual_revenue_at_risk
    FROM customers
    GROUP BY CASE
        WHEN tenure < 3 THEN '0-3 months'
        WHEN tenure < 6 THEN '3-6 months'
        WHEN tenure < 12 THEN '6-12 months'
        WHEN tenure < 24 THEN '12-24 months'
        ELSE '24+ months'
    END
)
SELECT * FROM tenure_trends ORDER BY churn_rate DESC;