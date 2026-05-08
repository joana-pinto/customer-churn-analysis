-- Business Metrics SQL Queries
-- This file contains production-ready SQL queries for key business metrics related to customer churn
-- All queries use CTEs for clarity and reusability

-- 1. Revenue Impact of Churn
-- Calculates annual revenue at risk and average lifetime value by churn status
WITH churn_revenue AS (
    SELECT
        Churn,
        COUNT(*) as customer_count,
        AVG(MonthlyCharges) as avg_monthly_charges,
        AVG(TotalCharges) as avg_lifetime_value,
        SUM(MonthlyCharges * 12) as annual_revenue_at_risk
    FROM customers
    GROUP BY Churn
),
overall_metrics AS (
    SELECT
        SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges * 12 ELSE 0 END) as total_annual_revenue_at_risk,
        AVG(CASE WHEN Churn = 'No' THEN TotalCharges ELSE NULL END) as avg_retained_ltv,
        AVG(CASE WHEN Churn = 'Yes' THEN TotalCharges ELSE NULL END) as avg_churned_ltv
    FROM customers
)
SELECT
    cr.Churn,
    cr.customer_count,
    ROUND(cr.avg_monthly_charges, 2) as avg_monthly_charges,
    ROUND(cr.avg_lifetime_value, 2) as avg_lifetime_value,
    ROUND(cr.annual_revenue_at_risk, 0) as annual_revenue_at_risk,
    ROUND(om.total_annual_revenue_at_risk, 0) as total_annual_revenue_at_risk,
    ROUND(om.avg_retained_ltv, 2) as avg_retained_ltv,
    ROUND(om.avg_churned_ltv, 2) as avg_churned_ltv
FROM churn_revenue cr
CROSS JOIN overall_metrics om;

-- 2. Retention Rates by Contract Type
-- Shows retention rates and customer counts by contract type
WITH contract_retention AS (
    SELECT
        Contract,
        COUNT(*) as total_customers,
        SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) as retained_customers,
        ROUND(100.0 * SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) / COUNT(*), 2) as retention_rate
    FROM customers
    GROUP BY Contract
)
SELECT * FROM contract_retention ORDER BY retention_rate DESC;

-- 3. Service Adoption and Churn Relationship
-- Analyzes how service count correlates with churn rates
WITH service_adoption AS (
    SELECT
        CASE
            WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END as service_count,
        Churn,
        MonthlyCharges,
        COUNT(*) as customer_count
    FROM customers
    GROUP BY service_count, Churn, MonthlyCharges
),
service_summary AS (
    SELECT
        service_count,
        SUM(CASE WHEN Churn = 'Yes' THEN customer_count ELSE 0 END) as churned_count,
        SUM(customer_count) as total_count,
        ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN customer_count ELSE 0 END) / SUM(customer_count), 2) as churn_rate,
        ROUND(AVG(MonthlyCharges), 2) as avg_monthly_charges
    FROM service_adoption
    GROUP BY service_count
)
SELECT * FROM service_summary ORDER BY service_count;