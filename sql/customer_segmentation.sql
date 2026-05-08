-- Customer Segmentation SQL Queries
-- Production-ready queries for identifying high-risk customer segments
-- Uses CTEs for modular and maintainable code

-- 1. High-Risk Customer Segmentation
-- Identifies customers in high-risk combinations based on contract, internet service, and tenure
WITH risk_segments AS (
    SELECT
        customerID,
        CASE
            WHEN Contract = 'Month-to-month' AND InternetService = 'Fiber optic' THEN 'High Risk: Month-to-month + Fiber'
            WHEN Contract = 'Month-to-month' AND PaymentMethod = 'Electronic check' THEN 'High Risk: Month-to-month + E-check'
            WHEN InternetService = 'Fiber optic' AND TechSupport = 'No' THEN 'High Risk: Fiber + No Support'
            WHEN Contract = 'Month-to-month' AND MonthlyCharges > 75 THEN 'High Risk: Expensive Month-to-month'
            WHEN tenure < 6 AND InternetService = 'Fiber optic' THEN 'High Risk: New Fiber Customer'
            ELSE 'Standard Risk'
        END as risk_segment,
        MonthlyCharges,
        TotalCharges,
        Churn
    FROM customers
),
segment_summary AS (
    SELECT
        risk_segment,
        COUNT(*) as customer_count,
        ROUND(AVG(MonthlyCharges), 2) as avg_monthly_charges,
        ROUND(SUM(MonthlyCharges * 12), 0) as annual_revenue_at_risk,
        ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_rate
    FROM risk_segments
    WHERE risk_segment != 'Standard Risk'
    GROUP BY risk_segment
)
SELECT * FROM segment_summary ORDER BY annual_revenue_at_risk DESC;

-- 2. Revenue Concentration in Risky Segments
-- Shows how much revenue is concentrated in high-risk customer groups
WITH revenue_concentration AS (
    SELECT
        SUM(CASE WHEN Contract = 'Month-to-month' THEN MonthlyCharges * 12 ELSE 0 END) as month_to_month_revenue,
        SUM(CASE WHEN InternetService = 'Fiber optic' THEN MonthlyCharges * 12 ELSE 0 END) as fiber_revenue,
        SUM(MonthlyCharges * 12) as total_revenue
    FROM customers
)
SELECT
    ROUND(month_to_month_revenue, 0) as month_to_month_annual_revenue,
    ROUND(100.0 * month_to_month_revenue / total_revenue, 1) as pct_of_total_revenue,
    ROUND(fiber_revenue, 0) as fiber_annual_revenue,
    ROUND(100.0 * fiber_revenue / total_revenue, 1) as fiber_pct_of_total_revenue,
    ROUND(total_revenue, 0) as total_annual_revenue
FROM revenue_concentration;

-- 3. Customer Risk Scoring
-- Creates a simple risk score based on key churn drivers
WITH risk_scoring AS (
    SELECT
        customerID,
        -- Contract risk: Month-to-month = 3, One year = 1, Two year = 0
        CASE Contract
            WHEN 'Month-to-month' THEN 3
            WHEN 'One year' THEN 1
            ELSE 0
        END +
        -- Internet service risk: Fiber optic = 2, DSL = 1, No internet = 0
        CASE InternetService
            WHEN 'Fiber optic' THEN 2
            WHEN 'DSL' THEN 1
            ELSE 0
        END +
        -- Tenure risk: Lower tenure = higher risk
        CASE
            WHEN tenure < 6 THEN 3
            WHEN tenure < 12 THEN 2
            WHEN tenure < 24 THEN 1
            ELSE 0
        END +
        -- Payment method risk: Electronic check = 2, others = 0
        CASE WHEN PaymentMethod = 'Electronic check' THEN 2 ELSE 0 END as risk_score,
        Churn,
        MonthlyCharges * 12 as annual_revenue
    FROM customers
),
risk_distribution AS (
    SELECT
        CASE
            WHEN risk_score >= 6 THEN 'Very High Risk'
            WHEN risk_score >= 4 THEN 'High Risk'
            WHEN risk_score >= 2 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END as risk_category,
        COUNT(*) as customer_count,
        ROUND(AVG(annual_revenue), 0) as avg_annual_revenue,
        ROUND(SUM(annual_revenue), 0) as total_annual_revenue,
        ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) as churn_rate
    FROM risk_scoring
    GROUP BY CASE
        WHEN risk_score >= 6 THEN 'Very High Risk'
        WHEN risk_score >= 4 THEN 'High Risk'
        WHEN risk_score >= 2 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END
)
SELECT * FROM risk_distribution ORDER BY churn_rate DESC;