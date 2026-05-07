# Configuration file for customer churn analysis
# Centralizes file paths and reusable parameters for reproducibility

# File paths
RAW_DATA_PATH = "data/Telco-Customer-Churn.csv"
CLEANED_DATA_PATH = "data/churn_data_cleaned.csv"
DB_PATH = "sql/churn.db"

# Analysis parameters
TENURE_BUCKETS = [0, 12, 24, float('inf')]
TENURE_LABELS = ['0-1 year', '1-2 years', '2+ years']
CHARGE_BUCKETS = [0, 40, 80, float('inf')]
CHARGE_LABELS = ['Low', 'Medium', 'High']

# Statistical test thresholds
SIGNIFICANCE_LEVEL = 0.05

# Outlier detection parameters
IQR_MULTIPLIER = 1.5