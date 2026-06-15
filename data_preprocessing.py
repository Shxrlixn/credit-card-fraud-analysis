import pandas as pd

# Load dataset
df = pd.read_csv("credit_card_fraud.csv")

# Convert transaction date to datetime
df["TransactionDate"] = pd.to_datetime(df["TransactionDate"])

# Feature Engineering
df["Hour"] = df["TransactionDate"].dt.hour
df["Day"] = df["TransactionDate"].dt.day
df["Month"] = df["TransactionDate"].dt.month
df["Year"] = df["TransactionDate"].dt.year

# Risk Classification
df["RiskFlag"] = df["Amount"].apply(
    lambda x: "High Risk" if x > 4500 else "Normal"
)

# Data Validation
df = df.drop_duplicates()
df = df.dropna()

# Export cleaned dataset
df.to_csv("credit_card_fraud_cleaned.csv", index=False)

print("Data preprocessing completed successfully.")
print(f"Total records: {len(df)}")
