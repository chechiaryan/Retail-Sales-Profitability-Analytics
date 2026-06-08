-- =====================================================
-- Retail Analytics Dashboard Suite
-- SQL PROJECT
-- Analyst: Aryan Chechi
-- =====================================================

-- =====================================================
-- PROJECT OVERVIEW
-- =====================================================

-- Dataset: Superstore Sales Dataset
-- Records Analyzed: 9,977
-- Source: Superstore Retail Sales Dataset
-- Total Sales: $2.30 Million
-- Total Profit: $286.24 Thousand
-- Average Discount: 15.63%
--
-- PROJECT OBJECTIVE:
-- Analyze sales performance, profitability,
-- customer segments, regional trends,
-- discount impact, shipping performance,
-- and business growth opportunities.
--
-- KEY BUSINESS QUESTIONS:
-- 1. Which categories generate the highest sales and profit?
-- 2. Which sub-categories drive profitability?
-- 3. Which regions and states perform best?
-- 4. Which states and categories generate losses?
-- 5. How do discounts impact profitability?
-- 6. Which customer segments contribute most revenue?
-- 7. Which shipping modes perform best?
-- 8. What strategic recommendations can improve profitability?
--
-- SQL CONCEPTS DEMONSTRATED:
-- • Aggregations (SUM, AVG, ROUND)
-- • GROUP BY & ORDER BY
-- • CASE WHEN Statements
-- • Subqueries
-- • Common Table Expressions (CTEs)
-- • Window Functions (RANK)
-- • Business Performance Classification
-- =====================================================

USE superstore;

-- =====================================================
-- SECTION A: DATA VALIDATION & OVERALL PERFORMANCE
-- =====================================================

-- =====================================================
-- QUERY 01: OVERALL BUSINESS PERFORMANCE
-- Business Question:
-- What are the total sales, total profit, and average discount?
-- =====================================================

SELECT
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(AVG(Discount)*100,2) AS Avg_Discount_Percent
FROM superstore_data;

-- =====================================================
-- SECTION B: BUSINESS PERFORMANCE ANALYSIS
-- =====================================================

-- =====================================================
-- QUERY 02: CATEGORY PERFORMANCE ANALYSIS
-- Business Question:
-- Which category generates the highest sales and profit?
-- =====================================================

SELECT
    Category,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY Category
ORDER BY Total_Sales DESC;


-- =====================================================
-- QUERY 03: SUB-CATEGORY PERFORMANCE ANALYSIS
-- Business Question:
-- Which sub-categories drive the most sales and profit?
-- =====================================================

SELECT
    Sub_Category,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;


-- =====================================================
-- QUERY 04: REGION PERFORMANCE ANALYSIS
-- Business Question:
-- Which region generates the highest sales and profit?
-- =====================================================

SELECT
    Region,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY Region
ORDER BY Total_Sales DESC;


-- =====================================================
-- QUERY 05: SEGMENT PERFORMANCE ANALYSIS
-- Business Question:
-- Which customer segment contributes the most sales and profit?
-- =====================================================

SELECT
    Segment,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY Segment
ORDER BY Total_Sales DESC;

-- =====================================================
-- SECTION C: GEOGRAPHIC PERFORMANCE ANALYSIS
-- =====================================================

-- =====================================================
-- QUERY 06: TOP 10 STATES BY SALES
-- Business Question:
-- Which states generate the highest revenue?
-- =====================================================

SELECT
    State,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;


-- =====================================================
-- QUERY 07: TOP 10 STATES BY PROFIT
-- Business Question:
-- Which states generate the highest profit?
-- =====================================================

SELECT
    State,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY State
ORDER BY Total_Profit DESC
LIMIT 10;


-- =====================================================
-- QUERY 08: WORST PERFORMING STATES
-- Business Question:
-- Which states are generating losses?
-- =====================================================

SELECT
    State,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY State
ORDER BY Total_Profit ASC
LIMIT 10;

-- =====================================================
-- SECTION D: DISCOUNT & PROFITABILITY ANALYSIS
-- =====================================================

-- =====================================================
-- QUERY 09: DISCOUNT IMPACT BY CATEGORY
-- Business Question:
-- How do discounts affect category profitability?
-- =====================================================

SELECT
    Category,
    ROUND(AVG(Discount)*100,2) AS Avg_Discount_Percent,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY Category
ORDER BY Avg_Discount_Percent DESC;


-- =====================================================
-- QUERY 10: DISCOUNT IMPACT BY REGION
-- Business Question:
-- How do discounts affect regional profitability?
-- =====================================================

SELECT
    Region,
    ROUND(AVG(Discount)*100,2) AS Avg_Discount_Percent,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY Region
ORDER BY Avg_Discount_Percent DESC;


-- =====================================================
-- QUERY 11: PROFITABILITY CLASSIFICATION
-- Business Question:
-- Can categories be classified based on profit margins?
-- =====================================================

SELECT
    Category,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin,

    CASE
        WHEN (SUM(Profit)/SUM(Sales))*100 >= 15 THEN 'High Profitability'
        WHEN (SUM(Profit)/SUM(Sales))*100 >= 10 THEN 'Medium Profitability'
        ELSE 'Low Profitability'
    END AS Profitability_Category

FROM superstore_data
GROUP BY Category
ORDER BY Profit_Margin DESC;


-- =====================================================
-- QUERY 12: SHIP MODE ANALYSIS
-- Business Question:
-- Which shipping mode generates the highest sales and profit?
-- =====================================================

SELECT
    Ship_Mode,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore_data
GROUP BY Ship_Mode
ORDER BY Total_Sales DESC;

-- =====================================================
-- SECTION E: ADVANCED SQL ANALYSIS
-- =====================================================

-- =====================================================
-- QUERY 13: STATE PROFIT RANKING
-- Business Question:
-- How do states rank based on profit?
-- =====================================================

SELECT
    State,
    ROUND(SUM(Profit),2) AS Total_Profit,

    RANK() OVER(
        ORDER BY SUM(Profit) DESC
    ) AS Profit_Rank

FROM superstore_data
GROUP BY State;


-- =====================================================
-- QUERY 14: CATEGORY CONTRIBUTION TO TOTAL SALES
-- Business Question:
-- What percentage of total sales comes from each category?
-- =====================================================

SELECT
    Category,
    ROUND(SUM(Sales),2) AS Total_Sales,

    ROUND(
        (
            SUM(Sales) /
            (
                SELECT SUM(Sales)
                FROM superstore_data
            )
        ) * 100,
        2
    ) AS Sales_Contribution_Percent

FROM superstore_data
GROUP BY Category
ORDER BY Total_Sales DESC;


-- =====================================================
-- QUERY 15: ABOVE-AVERAGE PROFITABLE CATEGORIES
-- Business Question:
-- Which categories perform above average profitability?
-- =====================================================

WITH Category_Margins AS
(
    SELECT
        Category,
        ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin
    FROM superstore_data
    GROUP BY Category
)

SELECT *
FROM Category_Margins
WHERE Profit_Margin >
(
    SELECT AVG(Profit_Margin)
    FROM Category_Margins
);


-- =====================================================
-- QUERY 16: STATE PERFORMANCE CLASSIFICATION
-- Business Question:
-- How can states be categorized based on profitability?
-- =====================================================

WITH State_Performance AS
(
    SELECT
        State,
        ROUND(SUM(Sales),2) AS Total_Sales,
        ROUND(SUM(Profit),2) AS Total_Profit,
        ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin
    FROM superstore_data
    GROUP BY State
)

SELECT
    State,
    Total_Sales,
    Total_Profit,
    Profit_Margin,

    CASE
        WHEN Profit_Margin >= 20 THEN 'Excellent'
        WHEN Profit_Margin >= 10 THEN 'Good'
        WHEN Profit_Margin >= 0 THEN 'Average'
        ELSE 'Loss Making'
    END AS Performance_Category

FROM State_Performance
ORDER BY Profit_Margin DESC;

-- =====================================================
-- FINAL BUSINESS CONCLUSIONS
-- =====================================================
--
-- 1. Technology is the strongest-performing category,
--    generating the highest sales and profit.
--
-- 2. Furniture contributes significant revenue but
--    delivers very low profitability, indicating
--    pricing or discounting concerns.
--
-- 3. Phones generate the highest sales among all
--    sub-categories, while Copiers generate the
--    highest profit.
--
-- 4. West Region is the strongest-performing region
--    in terms of sales, profit, and margin.
--
-- 5. Consumer Segment generates the highest revenue,
--    while Home Office achieves the highest margin.
--
-- 6. California and New York are the largest profit
--    contributors to the business.
--
-- 7. Texas, Ohio, Pennsylvania, and Illinois are
--    major loss-making states despite strong sales.
--
-- 8. Higher discount levels are consistently
--    associated with lower profit margins across
--    categories and regions.
--
-- 9. Furniture and the Central Region exhibit
--    the highest discount levels and weakest
--    profitability.
--
-- 10. Review of discounting strategy in high-volume
--     loss-making markets may significantly improve
--     overall profitability.
--
-- =====================================================
-- END OF PROJECT
-- =====================================================