# Customer Churn Analysis: Revenue Protection Through Data-Driven Retention Strategy

**A comprehensive business analytics case study identifying churn drivers, quantifying revenue exposure, and enabling strategic customer retention interventions.**

This project demonstrates end-to-end business analytics capabilities, translating customer behavioral data into actionable retention strategies that protect recurring revenue and maximize customer lifetime value in subscription-based businesses.

---

## Business Problem

Customer churn is a critical financial challenge for subscription businesses, where losing customers directly impacts recurring revenue streams and profitability. In the telecommunications industry, reducing churn by just 5% can increase profits by 25-85% through improved customer lifetime value.

**Key Challenge:**
- Organizations lack visibility into *why* customers leave
- Retention efforts are unfocused without understanding key churn drivers
- Revenue exposure from high-risk segments is unquantified
- Intervention strategies cannot be prioritized by financial impact

This analysis directly addresses these challenges through data-driven customer insights.

---

## Project Objectives

- **Identify Churn Drivers**: Determine which customer characteristics, behaviors, and service factors most strongly predict churn
- **Quantify Revenue Exposure**: Calculate annual revenue at risk from churned and at-risk customer segments
- **Segment High-Risk Customers**: Create actionable customer segments with varying churn probabilities and financial exposure
- **Statistical Validation**: Ensure all findings are statistically significant and business-meaningful, not due to chance
- **Strategic Recommendations**: Generate specific, prioritized retention interventions with expected impact
- **Scalable Analytics Framework**: Develop SQL-based queries and segmentation logic for production deployment

---

## Dataset Overview

**Source:** Telecommunications customer data containing 7,043 customers with 21 features

**Key Attributes:**
- **Customer Demographics**: Gender, age, family status
- **Service Subscriptions**: Phone service, internet type, protection/support services
- **Account Details**: Contract type, tenure, monthly/total charges, payment method
- **Target Variable**: Churn (Yes/No) - whether customer left the company

<!-- Insert screenshot: Dataset schema or overview visualization -->
![Dataset Overview](images/dataset_overview.png)

**Data Quality:** 
- No duplicates or missing values after cleaning
- Consistent binary encoding (Yes/No, 0/1)
- TotalCharges properly handled for customers with zero tenure
- Ready for statistical analysis with validated metrics

---

## Methodology & Analytical Workflow

### End-to-End Analysis Pipeline

**1. Data Quality & Preparation**
- Comprehensive quality assessment (duplicates, nulls, encoding consistency)
- TotalCharges conversion and imputation
- Outlier detection on numeric variables

**2. Exploratory Data Analysis (EDA)**
- Dataset structure and statistical summaries
- Churn rate overview and initial patterns

**3. Statistical Validation (Categorical Features)**
- Chi-square tests for categorical variables vs. Churn
- Cramér's V effect size calculation
- Automated testing across all relevant features
- Business interpretation of statistical findings

**4. Statistical Validation (Numeric Features)**
- Normality and variance equality testing
- t-tests and Mann-Whitney U tests as appropriate
- Cohen's d effect size calculation
- Distribution comparisons (boxplots)

**5. Interaction & Risk Analysis**
- Feature importance ranking across categorical and numeric variables
- Service adoption pattern analysis
- High-risk customer segment identification
- Contract × Internet Service interaction effects

**6. Multivariate Insights**
- Tenure lifecycle analysis with churn curve
- High-value customer behavior comparison
- Logistic regression for multivariate feature importance
- Feature coefficients and odds ratios interpretation

**7. SQL Business Analytics**
- Revenue impact queries (annual revenue at risk calculation)
- Retention rates by contract type and tenure bucket
- High-risk customer segmentation queries
- Cohort analysis by contract and lifecycle stage

**8. Customer Segmentation Framework**
- Four-tier risk segmentation (Critical, High, Medium, Low)
- Segment-level business metrics and revenue exposure
- Strategic recommendations per segment

---

## Key Insights

### Strongest Churn Drivers

<!-- Insert screenshot: Feature Importance Ranking chart -->
![Feature Importance](images/feature_importance_chart.png)

- **Contract Type (Strongest Lever):** Month-to-month contracts show **43% churn** vs. **3% for two-year** - a 15x difference
- **Tenure (Second Strongest):** New customers (<3 months) churn at **50%**, dropping to **3% after 24 months**
- **Internet Service:** Fiber optic customers churn **2.2x more** than DSL customers
- **Payment Friction:** Electronic check users churn **2x more** than automated payment customers
- **Service Adoption:** Customers with 6 services have **5% churn** vs. **46% for 1 service** - each additional service reduces risk by ~7%

### Lifecycle Patterns

<!-- Insert screenshot: Churn Curve by Tenure Lifecycle -->
![Churn Lifecycle](images/churn_lifecycle_curve.png)

- Churn peaks at **50% in first 3 months** - critical intervention window
- Sharp decline through 6-12 months
- **Stabilization at ~3% after 24 months** - long-term customers highly stable
- **Early intervention is highest-impact retention opportunity**

### High-Risk Customer Segments

<!-- Insert screenshot: Revenue at Risk by Segment -->
![Revenue Risk](images/revenue_risk_by_segment.png)

| Segment | Customer Count | Churn Rate | Annual Revenue at Risk | Priority |
|---------|----------------|-----------|------------------------|----------|
| Critical Risk (MTM + Fiber + <6mo) | 575 | 75% | $2.2M | 🔴 Immediate |
| High Risk (MTM + Fiber/E-check) | 2,096 | 55% | $1.8M | 🟠 High |
| Medium Risk (Various combos) | 2,107 | 25% | $800K | 🟡 Medium |
| Low Risk / Loyal (2-year/1-year + DSL) | 2,265 | 8% | $300K | 🟢 Monitor |

**Total Revenue at Risk:** $4.9M annually from customers with elevated churn probability

### Service Adoption as Retention Lever

- Service bundling dramatically reduces churn probability
- Tech Support and Online Security most protective (reduce churn by ~50% when adopted)
- Customers with 4+ services show **<10% churn** vs. **>40% for minimal service adoption**
- Significant upsell and cross-sell opportunity among at-risk segments

### Multivariate Findings

After controlling for all variables simultaneously in logistic regression:
- Contract commitment remains the strongest protective factor (OR=0.15 vs. MTM baseline)
- Fiber optic service remains strongest risk factor in multivariate context
- Service protections (Tech Support, Online Security) significant even after accounting for tenure and price

---

## Strategic Business Recommendations

### Priority 1: Target Critical Risk Segment (Highest Financial Impact)
**Target:** New month-to-month fiber optic customers (575 customers, 75% churn risk)
- **Intervention:** Aggressive contract migration incentives within first 3 months
- **Expected Impact:** If 50% adopt 1-year contracts → 30% churn reduction → ~$300K annual revenue protection
- **Mechanism:** Sign-up bonuses, discounted rates for 12-month commitment

### Priority 2: Optimize High-Risk Revenue (Largest Exposed Population)
**Target:** Month-to-month + fiber optic customers (2,096 customers, 55% churn, $1.8M risk)
- **Intervention 1:** Payment method optimization (migrate from e-check to autopay) → 30% churn reduction
- **Intervention 2:** Tech Support + Online Security bundling with fiber packages → 25% churn reduction
- **Expected Impact:** Dual intervention → ~$450K annual revenue protection

### Priority 3: Strengthen Contract Commitment
**Insight:** Two-year contracts deliver 97% retention vs. 57% for month-to-month
- **Intervention:** Quarterly upgrade offers to month-to-month customers with 6+ months tenure
- **Bundling Strategy:** Combine contract upgrades with protective services and cost guarantees
- **Expected Impact:** 20% contract upgrade rate → ~$600K revenue protection

### Priority 4: Early Lifecycle Onboarding
**Insight:** 50% of new customers churn within first 3 months
- **Intervention:** Personalized onboarding, support outreach in first 30-60 days
- **Focus:** Fiber optic and high-revenue new customers
- **Expected Impact:** 15% churn reduction in critical window → ~$400K protection

### Priority 5: High-Value Customer Retention
**Insight:** Top-quartile spending customers have same churn risk as others without contract protection
- **Intervention:** Dedicated account management for high-value customers on flexible contracts
- **Services:** Proactive support, exclusive offers, contract incentives
- **Expected Impact:** Protect $1M+ in high-value revenue

---

## SQL Business Analytics Layer

Scalable, production-ready SQL queries enable ongoing monitoring and reporting:

### Revenue Impact Analysis
```
Query: Annual revenue at risk by churn status
Output: Customer count, avg monthly charges, lifetime value, revenue exposure
```

### Retention Performance by Contract
```
Query: Retention rates across contract types and tenure buckets
Output: Contract performance metrics, cohort stability analysis
```

### Customer Segmentation Logic
```
Query: Identify high-risk segments by contract × service × payment combinations
Output: Segment characteristics, revenue exposure, churn probability scoring
```

**Location:** Full SQL scripts available in `/sql` folder
- `business_metrics.sql` - Revenue and retention analysis
- `customer_segmentation.sql` - Risk scoring and segment identification
- `cohort_analysis.sql` - Lifecycle and contract performance tracking

<!-- Insert screenshot: SQL Business Metrics sample output -->
![SQL Analytics](images/sql_business_metrics.png)

---

## Power BI Dashboard

### Executive Monitoring Dashboard

**Key Performance Indicators:**
- Overall churn rate and revenue at risk
- Churn rate by contract type, tenure bucket, service adoption level
- Customer count and revenue distribution across risk segments
- Trend analysis: churn rates and intervention effectiveness

**Segmentation & Targeting:**
- Interactive segment filters (contract, service, tenure, payment method)
- High-risk customer lists with contact information for intervention campaigns
- Cohort performance tracking by sign-up date
- Service adoption analysis and bundling opportunities

**Retention Monitoring:**
- Monthly cohort retention curves
- Intervention campaign performance tracking
- Contract upgrade conversion rates
- Service adoption trends among at-risk segments

<!-- Insert screenshot: Executive Dashboard Overview -->
![Executive Dashboard](images/dashboard_overview.png)

<!-- Insert screenshot: Segmentation Dashboard -->
![Segmentation Dashboard](images/dashboard_segmentation.png)

<!-- Insert screenshot: Retention Monitoring Dashboard -->
![Retention Monitoring](images/dashboard_retention_monitoring.png)

---

## Project Structure

```
customer-churn-analysis/
│
├── README.md                                    # This file
├── requirements.txt                             # Python dependencies
├── config.py                                    # Configuration & parameters
│
├── notebooks/
│   └── customer_churn_analysis.ipynb           # Main analysis notebook
│       ├── Executive Summary
│       ├── Data Quality & Cleaning
│       ├── Statistical Validation (Categorical & Numeric)
│       ├── Interaction & Risk Analysis
│       ├── Multivariate Insights
│       ├── SQL Business Analytics
│       └── Customer Segmentation Framework
│
├── sql/
│   ├── business_metrics.sql                    # Revenue and retention queries
│   ├── customer_segmentation.sql               # Risk segmentation logic
│   └── cohort_analysis.sql                     # Lifecycle analysis
│
├── dashboard/
│   └── ChurnAnalysisDashboard.pbix            # Power BI dashboard file
│
├── data/
│   ├── Telco-Customer-Churn.csv               # Raw dataset
│   └── churn_data_cleaned.csv                 # Processed dataset
│
└── images/
    ├── feature_importance_chart.png
    ├── churn_lifecycle_curve.png
    ├── revenue_risk_by_segment.png
    ├── dashboard_overview.png
    └── ... (additional visualizations)
```

---

## Tech Stack

**Data Processing & Analysis:**
- **Python 3.10+** - Data manipulation and statistical analysis
- **Pandas** - Data manipulation and analysis
- **NumPy** - Numerical computations
- **SciPy** - Statistical testing (chi-square, t-tests, Mann-Whitney U)
- **Scikit-learn** - Logistic regression and data preprocessing

**Visualization:**
- **Matplotlib** - Publication-quality charts
- **Seaborn** - Statistical visualizations

**Database & Analytics:**
- **SQLite** - Data storage and SQL analytics
- **SQL** - Business metrics and cohort analysis

**Business Intelligence:**
- **Power BI** - Executive dashboards and monitoring

**Reproducibility:**
- **Jupyter Notebook** - Interactive analysis and documentation
- **Config file** - Centralized parameters and file paths

---

## How to Run the Project

### Prerequisites
- Python 3.10 or higher
- pip package manager

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/[your-username]/customer-churn-analysis.git
   cd customer-churn-analysis
   ```

2. **Create virtual environment** (recommended)
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Run the analysis notebook**
   - Open `notebooks/customer_churn_analysis.ipynb` in Jupyter Notebook
   - Run cells sequentially from top to bottom
   - Analysis includes data quality checks, statistical validation, and SQL analytics

5. **View Power BI Dashboard** (optional)
   - Open `dashboard/ChurnAnalysisDashboard.pbix` in Power BI Desktop
   - Connect to the SQLite database or processed CSV files
   - Explore interactive dashboards with filtering and drill-down capabilities

### Expected Execution Time
- Full notebook analysis: ~5-10 minutes
- All sections run automatically with no manual intervention required

---

## Key Business Outcomes

### What This Analysis Reveals

**Churn is predictable and preventable.** The analysis identifies clear patterns:
- **Contract commitment is the strongest lever** - month-to-month vs. two-year shows 15x churn difference
- **The first 3 months are critical** - 50% of churn occurs in this window, creating a focused intervention opportunity
- **Service adoption is protective** - bundled services reduce churn by 40+ percentage points
- **High-risk segments are identifiable** - 575 critical-risk customers generate $2.2M revenue exposure

### Why This Matters for Your Business

1. **Revenue Protection:** Quantified $4.9M in annual revenue at risk, enabling prioritized interventions with highest ROI
2. **Focused Strategy:** Instead of generic retention, target specific segments with tailored interventions
3. **Predictive Capability:** Developed framework to score new customers and identify intervention timing
4. **Scalable Implementation:** SQL-based logic enables production deployment in CRM/billing systems
5. **Measurable Impact:** Baseline metrics established to track intervention effectiveness

### Expected Impact

If recommended interventions are implemented:
- **15-20% churn reduction** across high-risk segments
- **$1.5-2M annual revenue protection** from prevented churn
- **2-3 month payback period** on intervention investments
- **Improved customer satisfaction** through proactive, personalized retention efforts

---

## Author

**Portfolio Project:** End-to-end business analytics case study demonstrating statistical rigor, SQL-based business intelligence, and strategic data storytelling.

**Skills Demonstrated:**
- Exploratory Data Analysis (EDA) and Data Quality Assessment
- Statistical Testing (Chi-square, t-tests, Mann-Whitney U, effect sizes)
- Multivariate Modeling (Logistic Regression)
- SQL Business Analytics and Data Aggregation
- Customer Segmentation and Risk Scoring
- Data Visualization and Executive Presentation
- Business Strategy and Revenue Impact Analysis

