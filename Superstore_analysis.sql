-- Q1: Monthly revenue trend and seasonal pattern
SELECT region, 
       SUM(sales) AS total_revenue
FROM superstore
GROUP BY region
ORDER BY total_revenue DESC;

-- Q2: Revenue by region
SELECT 
    region,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_revenue
FROM superstore
GROUP BY region
ORDER BY total_revenue DESC;

-- Q3: Revenue vs profit by category
SELECT 
    category,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_revenue,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales)*100)::NUMERIC, 2) AS profit_margin_pct
FROM superstore
GROUP BY category
ORDER BY total_revenue DESC;

-- Q4: Gap between revenue and profit by region and category
SELECT 
    region,
    category,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_revenue,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales)*100)::NUMERIC, 2) AS profit_margin_pct
FROM superstore
GROUP BY region, category
ORDER BY profit_margin_pct ASC;

--CUSTOMER ANALYSIS
-- Q5: Top 10 customers by total spend and their categories
SELECT 
    customer_name,
    category,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_spend
FROM superstore
GROUP BY customer_name, category
ORDER BY total_spend DESC
LIMIT 10;

-- Q6: Average purchase frequency per customer
SELECT 
    ROUND(AVG(order_count)::NUMERIC, 2) AS avg_orders_per_customer,
    COUNT(CASE WHEN order_count = 1 THEN 1 END) AS one_time_buyers,
    COUNT(CASE WHEN order_count > 1 THEN 1 END) AS repeat_buyers
FROM (
    SELECT 
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM superstore
    GROUP BY customer_id
) AS customer_orders;

-- Q7: Average order value per segment
SELECT 
    segment,
    ROUND(SUM(sales)::NUMERIC / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM superstore
GROUP BY segment
ORDER BY avg_order_value DESC;

-- Q8: Customer lifetime value by segment
SELECT 
    segment,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_revenue,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(sales)::NUMERIC / COUNT(DISTINCT customer_id), 2) AS lifetime_value_per_customer
FROM superstore
GROUP BY segment
ORDER BY lifetime_value_per_customer DESC;

--PRODUCT ANALYSIS
-- Q9: Top 10 best selling products by quantity and their profitability
SELECT 
    product_name,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_revenue,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 10;

-- Q10: Sub-categories with high sales but low profit margin (loss leaders)
SELECT 
    sub_category,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales)*100)::NUMERIC, 2) AS profit_margin_pct
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC, profit_margin_pct ASC;

-- Q11: Products with consistent discounts hurting profitability
SELECT 
    product_name,
    ROUND(AVG(discount)::NUMERIC, 2) AS avg_discount,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit
FROM superstore
GROUP BY product_name
HAVING AVG(discount) > 0.3
ORDER BY total_profit ASC
LIMIT 10;

-- Q12: Most profitable category per unit sold
SELECT 
    category,
    SUM(quantity) AS total_units,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit,
    ROUND((SUM(profit)/SUM(quantity))::NUMERIC, 2) AS profit_per_unit
FROM superstore
GROUP BY category
ORDER BY profit_per_unit DESC;

--GROWTH METRICS
-- Q13: Month over month revenue growth rate
WITH monthly_revenue AS (
    SELECT 
        TO_CHAR(order_date, 'YYYY-MM') AS month,
        SUM(sales) AS total_revenue
    FROM superstore
    GROUP BY month
    ORDER BY month
)
SELECT 
    month,
    ROUND(total_revenue::NUMERIC, 2) AS total_revenue,
    ROUND(LAG(total_revenue) OVER (ORDER BY month)::NUMERIC, 2) AS prev_month_revenue,
    ROUND(((total_revenue - LAG(total_revenue) OVER (ORDER BY month)) 
        / LAG(total_revenue) OVER (ORDER BY month) * 100)::NUMERIC, 2) AS growth_rate_pct
FROM monthly_revenue;

-- Q14: Fastest growing region year over year
SELECT 
    region,
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_revenue
FROM superstore
GROUP BY region, year
ORDER BY region, year;

-- Q15: Profit margin trend year over year
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_revenue,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales)*100)::NUMERIC, 2) AS profit_margin_pct
FROM superstore
GROUP BY year
ORDER BY year;

-- Q16: Categories where revenue grows but profit margin shrinks
SELECT 
    category,
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_revenue,
    ROUND((SUM(profit)/SUM(sales)*100)::NUMERIC, 2) AS profit_margin_pct
FROM superstore
GROUP BY category, year
ORDER BY category, year;

--CROSS-CUTTING
-- Q17: Discount vs profit correlation
SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.2 THEN 'Low (0-20%)'
        WHEN discount <= 0.4 THEN 'Medium (20-40%)'
        ELSE 'High (40%+)'
    END AS discount_bucket,
    COUNT(*) AS total_orders,
    ROUND(AVG(sales)::NUMERIC, 2) AS avg_sales,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit,
    ROUND(AVG(profit)::NUMERIC, 2) AS avg_profit
FROM superstore
GROUP BY discount_bucket
ORDER BY discount_bucket;

-- Q18: State with most orders but worst profit margin
SELECT 
    state,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_revenue,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales)*100)::NUMERIC, 2) AS profit_margin_pct
FROM superstore
GROUP BY state
ORDER BY total_orders DESC, profit_margin_pct ASC
LIMIT 10;

-- Q19: Average shipping time by ship mode
SELECT 
    ship_mode,
    ROUND(AVG(ship_date - order_date)::NUMERIC, 2) AS avg_shipping_days,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY ship_mode
ORDER BY avg_shipping_days;
