# Data Dictionary: Telco Customer Churn Dataset

This dictionary describes all 21 features in the dataset used for churn analysis.

| Column | Description | Data Type | Example Values | Missing Count | Notes |
|--------|-------------|-----------|----------------|---------------|-------|
| customerID | Unique customer identifier | String | 7590-VHVEG | 0 | Primary key, no duplicates |
| gender | Customer gender | Category | Male, Female | 0 | Binary categorical |
| SeniorCitizen | Whether customer is 65+ | Integer | 0, 1 | 0 | 0=No, 1=Yes |
| Partner | Whether customer has partner | Category | Yes, No | 0 | Binary categorical |
| Dependents | Whether customer has dependents | Category | No, Yes | 0 | Binary categorical |
| tenure | Months customer has been with company | Integer | 1, 12, 72 | 0 | Range: 0-72 months |
| PhoneService | Whether customer has phone service | Category | No, Yes | 0 | Binary categorical |
| MultipleLines | Whether customer has multiple lines | Category | No, Yes, No phone service | 0 | Three categories |
| InternetService | Type of internet service | Category | DSL, Fiber optic, No | 0 | Three categories |
| OnlineSecurity | Whether customer has online security | Category | No, Yes, No internet service | 0 | Three categories |
| OnlineBackup | Whether customer has online backup | Category | No, Yes, No internet service | 0 | Three categories |
| DeviceProtection | Whether customer has device protection | Category | No, Yes, No internet service | 0 | Three categories |
| TechSupport | Whether customer has tech support | Category | No, Yes, No internet service | 0 | Three categories |
| StreamingTV | Whether customer streams TV | Category | No, Yes, No internet service | 0 | Three categories |
| StreamingMovies | Whether customer streams movies | Category | No, Yes, No internet service | 0 | Three categories |
| Contract | Type of contract | Category | Month-to-month, One year, Two year | 0 | Three categories |
| PaperlessBilling | Whether billing is paperless | Category | Yes, No | 0 | Binary categorical |
| PaymentMethod | Payment method used | Category | Electronic check, Mailed check, Bank transfer, Credit card | 0 | Four categories |
| MonthlyCharges | Monthly subscription cost | Float | 18.25, 56.05, 118.75 | 0 | Range: ~18-118 |
| TotalCharges | Total amount charged to date | String (needs conversion) | 29.85, 1889.5,  | 11 | Numeric after cleaning, 11 nulls become 0 |
| Churn | Whether customer left company | Category | No, Yes | 0 | Target variable, binary |

## Data Source
- Original dataset: Telco Customer Churn from Kaggle
- Size: 7,043 rows × 21 columns
- Collection date: Not specified in source
- Last updated: Current analysis uses version as of May 2026

## Data Quality Notes
- No missing values except TotalCharges (11 rows with empty strings)
- All categorical variables properly encoded
- No duplicate customerIDs
- Numeric columns (tenure, MonthlyCharges) have no IQR-defined outliers
- TotalCharges requires pd.to_numeric() conversion with errors='coerce'