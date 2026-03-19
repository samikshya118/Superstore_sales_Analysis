📊 Superstore Sales Analysis
🔍 Project Overview

This project analyzes the Superstore dataset to evaluate business performance across regions, product categories, and customer segments.

The goal is to:

Identify key revenue drivers

Evaluate profitability

Understand customer behavior

Analyze the impact of discounts and regional trends

The analysis combines Python (EDA) and SQL (business queries) to extract actionable insights.

📁 Dataset Summary

Rows: 9,994

Columns: 21

Key Features:

Order Details: Order ID, Order Date, Ship Date, Ship Mode

Customer Info: Customer ID, Customer Name, Segment

Location: Country, City, State, Region

Product Info: Category, Sub-Category, Product Name

Metrics: Sales, Quantity, Discount, Profit

Data Quality:

No missing values

Clean and ready for analysis

⚙️ Tech Stack

Python: Pandas, NumPy, Matplotlib, Seaborn

SQL: Business query analysis

Jupyter Notebook

📊 Exploratory Data Analysis (EDA)

Performed using Python to understand data structure and patterns:

Checked data types and structure

Analyzed distributions of Sales, Profit, Quantity, Discount

Identified negative profit (loss-making transactions)

Created Year & Month features for time-based analysis

📈 Key Business Analysis (SQL)
1. Revenue by Region

West → Highest revenue

South → Lowest revenue

2. Category Performance

Technology & Office Supplies → Highly profitable

Furniture → Low profit margins

3. Customer Insights

Majority are repeat customers

Corporate segment → Highest lifetime value

Home Office → Highest average order value

4. Product Insights

High sales ≠ High profit

Some products are loss-making despite strong sales

5. Discount Impact

Higher discounts → Lower profit

Discounts above 40% lead to heavy losses

6. Growth Trends

Revenue fluctuates monthly (no strong seasonality)

West & East regions show consistent growth

🚨 Key Insights

West region leads revenue significantly

Furniture category underperforms in profitability

Corporate customers are the most valuable

High discounts negatively impact profits

Some states generate high sales but negative margins

💡 Business Recommendations

Optimize Discount Strategy

Cap discounts at ≤ 20%

Avoid high-discount loss scenarios

Improve Furniture Profitability

Re-evaluate pricing and supplier costs

Focus on loss-making regions

Focus on Underperforming Regions

Improve sales strategy in South region

Leverage Customer Retention

Introduce loyalty programs

Strengthen repeat customer engagement

State-Level Optimization

Investigate inefficiencies in:

Texas

Ohio

Illinois

📌 Conclusion

This project highlights how data-driven decision making can improve profitability, optimize pricing strategies, and enhance customer targeting.

By combining EDA + SQL analytics, the analysis uncovers actionable insights that can directly impact business growth.

🚀 Future Improvements

Build an interactive dashboard (Power BI / Tableau)

Add predictive models (Sales/Profit forecasting)

Deploy as a web analytics dashboard
