# Credit Portfolio Analysis

An end-to-end data analytics project exploring loan portfolio characteristics, borrower risk indicators, default patterns, and customer segments. The project uses Python for data preparation and analysis, SQL for portfolio queries, machine learning for baseline classification and exploratory segmentation, and Power BI for interactive reporting.

## Project objectives

- Understand the structure and quality of the loan dataset.
- Identify patterns associated with loan defaults across borrower, loan, geographic, and time-based attributes.
- Engineer useful analytical features for further analysis.
- Build a baseline Logistic Regression model to estimate default outcomes.
- Explore borrower segments using K-Means clustering.
- Query portfolio performance using MySQL.
- Present key indicators and trends in an interactive Power BI dashboard.

## Dataset overview

The working dataset contains **1,048,575 records**. The source file used during the project was named `loans_granting_model_dataset.csv`. The cleaned analytical dataset contains 26 columns, including original fields and engineered features.

Important fields include:

- `loan_amnt`: loan amount
- `revenue`: borrower-reported revenue
- `dti_n`: debt-to-income measure
- `fico_n`: FICO score field
- `emp_length`: employment-length category
- `purpose`: loan purpose
- `home_ownership_n`: home-ownership category
- `addr_state`: state abbreviation
- `issue_d` / `issue_year`: loan issue date and year
- `Default`: binary target field (0 or 1)

The original dataset had 15 columns. The cleaned dataset includes additional derived fields such as `loan_to_income`, `dti_group`, `employment_group`, `revenue_outlier`, `loan_category`, `fico_category`, and `income_category`.

> **Data availability:** The raw and processed CSV files are not included in this repository by default because the dataset is large. Add the original dataset's legitimate source link and access instructions here before publishing. Do not upload data unless its license and sharing terms allow redistribution.

## Tools and technologies

- Python: pandas, NumPy, scikit-learn, Matplotlib / Seaborn (where used)
- Jupyter Notebook
- MySQL and MySQL Workbench
- Power BI Desktop
- Git and GitHub

## Project workflow

1. **Data understanding and EDA** – inspected columns, data types, distributions, missing values, duplicates, and relationships with `Default`.
2. **Data cleaning** – retained the original DataFrame and created a cleaned working copy; removed very sparse free-text columns (`desc` and `title`) from the analytical copy; handled missing ZIP code values; investigated unusual DTI and revenue values without automatically deleting extreme observations.
3. **Feature engineering** – derived loan-to-income ratio, time features, and loan, FICO, and income categories.
4. **Model preparation** – selected numerical predictors and imputed 28 missing DTI values with the training dataset's median for the baseline model workflow.
5. **Classification** – trained a Logistic Regression baseline on a stratified 100,000-row sample, using a train/test split and feature standardization.
6. **Segmentation** – applied K-Means with four clusters to a 100,000-row sample; log-transformed revenue before scaling to reduce the impact of its skewed distribution.
7. **SQL analysis** – imported the cleaned data into MySQL and queried overall portfolio metrics, purpose-level defaults, employment-level defaults, state-level performance, and yearly performance.
8. **Power BI** – created KPI cards, trend and comparison charts, and slicers for interactive exploration.

## Key findings

### Portfolio overview

| Metric | Project result |
|---|---:|
| Records | 1,048,575 |
| Total loan amount | 15,172,154,075 |
| Average loan amount | 14,469.31 |
| Overall default rate | 19.95% |

### Exploratory analysis

- Defaulted loans had a lower average FICO score than non-defaulted loans in the initial analysis.
- The observed default rate was highest for the `small_business` purpose in the initial purpose analysis (29.54%); purpose-level rates vary and should be interpreted alongside group sizes.
- The `NI` employment-length category had a 26.56% default rate. Its meaning was not established from the available dataset documentation, so it was retained as an unknown category.
- In the category analysis, observed default rates decreased across higher FICO bands: Fair 26.1%, Good 19.9%, Very Good 9.8%, and Excellent 6.2%. There were no records in the Poor band under the chosen bins.
- Borrowers who defaulted had a higher average loan-to-income ratio than non-defaulted borrowers (0.243 versus 0.203).

### Logistic Regression baseline

The baseline model was trained and evaluated on a balanced 100,000-record stratified sample.

| Metric | Result |
|---|---:|
| Accuracy | 0.6091 |
| Precision | 0.6050 |
| Recall | 0.6287 |
| F1-score | 0.6166 |
| ROC-AUC | 0.6542 |

These metrics describe performance on the balanced test sample, not on the dataset's natural class distribution. This is an exploratory baseline and is **not production-ready**. Further validation, threshold analysis, calibration, feature review, and testing on a time-based holdout would be needed before any real lending use.

### K-Means segmentation

Four exploratory clusters were produced from a 100,000-record sample. Their observed default rates were:

| Cluster | Sample size | Observed default rate | Descriptive profile |
|---|---:|---:|---|
| 0 | 33,146 | 17.71% | Moderate income, lower DTI |
| 1 | 14,125 | 9.92% | Stronger credit score |
| 2 | 28,306 | 26.06% | Lower income, higher DTI |
| 3 | 24,423 | 22.17% | Higher income, larger loan |

These are descriptive segments, not official credit-risk grades or causal explanations.

## SQL analysis

The MySQL table used in the project was `credit_portfolio_cleaned` in database `credit_portfolio_db`. Five analyses were completed:

1. Overall portfolio size, total loan amount, average loan amount, and default rate.
2. Loan purpose by borrower count and default rate.
3. Employment length by borrower count and default rate.
4. State-wise loan count, loan amount, and default rate.
5. Year-wise loan count, loan amount, and default rate.

Store the runnable SQL statements in `sql/credit_portfolio_analysis.sql` when adding them to the repository.

## Power BI dashboard

The report page includes:

- Total Loans
- Total Amount
- Average Loan
- Default Rate
- Year-wise Default Rate Trend
- Default Rate by Purpose
- State-wise Loan Amount
- Default Rate by FICO Category
- Slicers for issue year, purpose, state, and employment length

Add a screenshot of the final report page under `images/` and keep the Power BI `.pbix` file under `powerbi/` if you intend to share it.

## Suggested repository structure

```text
Credit_Portfolio_Analysis/
├── README.md
├── .gitignore
├── notebooks/
│   └── 01_Data_Understanding.ipynb
├── sql/
│   └── credit_portfolio_analysis.sql
├── powerbi/
│   └── Credit_Portfolio_Analysis.pbix
├── reports/
│   └── Credit_Portfolio_Analysis_Final_Report.docx
├── images/
│   └── dashboard.png
└── data/
    ├── raw/          # Keep local; do not commit large or restricted data
    └── processed/    # Keep local; do not commit large or restricted data
```

## Limitations and responsible-use notes

- The analysis is observational; associations do not establish causation.
- The special DTI value `999` was treated as a missing/sentinel value for analysis, but this interpretation should be confirmed against the dataset documentation.
- Extreme DTI and revenue values were flagged and investigated rather than automatically deleted.
- `NI` was kept as a separate employment category because its definition was not confirmed.
- The Logistic Regression results come from a balanced sample and should not be read as expected real-world performance at the original default prevalence.
- The K-Means clusters are exploratory and depend on feature selection, scaling, sample selection, and the chosen number of clusters.
- This project is educational and should not be used to approve, reject, price, or otherwise make decisions about actual credit applicants.

## How to reproduce

1. Obtain the dataset from its permitted original source and place it in `data/raw/` using the filename `loans_granting_model_dataset.csv`.
2. Open `notebooks/01_Data_Understanding.ipynb` in Jupyter Notebook and run the cells in order.
3. Export the cleaned dataset to `data/processed/` as described in the notebook.
4. Create the MySQL database and table, then run the SQL statements in `sql/credit_portfolio_analysis.sql`.
5. Open the Power BI file in `powerbi/` and update the data source path if required.

## Author

**Name:** [Your Name]  
**Course:** [Your Course / Specialization]  
**Institution:** [Your College / Institution]  
**Contact:** [Your GitHub profile or professional email]
