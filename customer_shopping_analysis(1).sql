USE shopping_db;

SELECT
    CLV_Segment,
    COUNT(*) AS customers,
    SUM(Estimated_CLV) AS total_clv,
    ROUND(
        SUM(Estimated_CLV) * 100.0 /
        SUM(SUM(Estimated_CLV)) OVER(),
        2
    ) AS contribution_percentage

FROM customer_clv

GROUP BY CLV_Segment

ORDER BY total_clv DESC;

DESCRIBE customer_clv;

SELECT
    CLV_Segment,
    COUNT(*) AS customers,
    SUM(Estimated_CLV) AS total_clv,
    ROUND(
        SUM(Estimated_CLV) * 100 /
        (SELECT SUM(Estimated_CLV) FROM customer_clv),
        2
    ) AS contribution_percentage

FROM customer_clv

GROUP BY CLV_Segment

ORDER BY total_clv DESC;

SELECT
    CLV_Segment,
    Churn_Category,
    COUNT(*) AS customer_count,
    SUM(Estimated_CLV) AS value_at_risk

FROM customer_clv

WHERE Churn_Category = 'High Risk'

GROUP BY
    CLV_Segment,
    Churn_Category

ORDER BY value_at_risk DESC;

DESCRIBE customer_clv;

USE shopping_db;

SHOW TABLES;

DESCRIBE customer_churn_analysis;

USE shopping_db;

SELECT
    CLV_Segment,
    Churn_Category,
    COUNT(*) AS customers,
    SUM(Estimated_CLV) AS value_at_risk

FROM customer_churn_analysis

WHERE Churn_Category = 'High Risk'

GROUP BY
    CLV_Segment,
    Churn_Category

ORDER BY value_at_risk DESC;

SELECT
    Product_Segment,
    COUNT(*) AS products,
    ROUND(SUM(`Purchase Amount (USD)`),2) AS revenue,
    ROUND(AVG(`Review Rating`),2) AS avg_rating

FROM product_performance

GROUP BY Product_Segment

ORDER BY revenue DESC;

SELECT
    `Item Purchased`,
    `Purchase Amount (USD)`,
    `Review Rating`

FROM product_performance

WHERE Product_Segment = 'Problem Product'

ORDER BY `Purchase Amount (USD)` DESC;

SELECT
    Customer_Persona,
    COUNT(*) AS customers,
    SUM(Estimated_CLV) AS total_clv,
    ROUND(
        SUM(Estimated_CLV)*100/
        (SELECT SUM(Estimated_CLV) FROM customer_personas),
        2
    ) AS clv_percentage

FROM customer_personas

GROUP BY Customer_Persona

ORDER BY total_clv DESC;

DESCRIBE customer_clv;
DESCRIBE customer_churn_analysis;
DESCRIBE customer_personas;