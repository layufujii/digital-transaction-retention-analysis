# Digital Transaction Retention Analysis
This project analyzes digital transaction data to understand transaction trends, repeat customer behavior, and customer retention.
The dataset covers transactions from June 2, 2021 to June 30, 2022.
## Dataset Overview
- 361,207 transactions
- 33,856 unique customers
- 2,101 stores
- 13 months of transaction data
- All records represent completed transactions
## Questions
The analysis focuses on the following questions:
1. How did transactions, revenue, and active customers change each month?
2. How many customers made more than one transaction?
3. What percentage of customers were new or returning each month?
4. How did customer retention develop from M0 to M6?
5. Which brands, categories, and payment methods contributed the most transactions and revenue?
## Analysis
The SQL analysis includes:
- Data quality checks
- Overall transaction KPIs
- Monthly transaction trends
- One-time and repeat customer analysis
- Monthly new and returning customer analysis
- Cohort retention analysis from M0 to M6
- Brand, category, and payment method performance
## Initial Findings
- 19,033 customers made more than one transaction.
- The repeat customer rate was 56.22%.
- 14,823 customers, or 43.78%, made only one transaction.
- Returning customer contribution varied across the observation period.
- Cohorts from June to December 2021 have a complete M0–M6 observation period. Later cohorts have shorter observation periods because the dataset ends in June 2022.
## Files
- `data_quality.sql` contains queries for checking missing values, duplicates, invalid values, transaction status, and the dataset period.
- `transaction_analysis.sql` contains transaction KPIs, monthly trends, and customer transaction analysis.
- `Cohort.sql` contains the M0–M6 cohort retention analysis.
- `performance.sql` contains brand, category, and payment method analysis.
## Tools
- PostgreSQL
- DBeaver
- SQL
## Data Privacy

The dataset used in this project has been anonymized and modified. It does not contain personally identifiable information or confidential company details. The raw transaction file is not included in this repository.
