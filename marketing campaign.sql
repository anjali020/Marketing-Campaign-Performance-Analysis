CREATE DATABASE marketing_db;
USE marketing_db;
 
show tables;
 

DESCRIBE `campaign details`;
DESCRIBE `campaign performance`;
DESCRIBE `region performance`;


-- Campaign Details + Campaign Performance
SELECT
    cp.CampaignID,
    cp.CampaignName,
    cd.Type,
    cp.Industry,
    cp.Region,
    cp.Spend,
    cp.Revenue,
    cp.ROI,
    cd.AverageSpend,
    cd.AverageROI
FROM `campaign performance` cp
INNER JOIN `campaign details` cd
ON cp.CampaignName = cd.CampaignName;


-- Join Campaign Performance + Region Performance
SELECT
    cp.CampaignName,
    cp.Region,
    cp.Revenue,
    cp.Spend,
    cp.ROI,
    rp.TotalRevenue,
    rp.TotalSpend,
    rp.AverageROI
FROM `campaign performance` cp
INNER JOIN `region performance` rp
ON cp.Region = rp.Region;


-- Join All Three Tables
SELECT
    cp.CampaignID,
    cp.CampaignName,
    cd.Type,
    cp.Industry,
    cp.Region,
    cp.Spend,
    cp.Revenue,
    cp.ROI,
    cd.AverageSpend,
    cd.AverageROI,
    rp.TotalRevenue,
    rp.TotalSpend,
    rp.AverageROI AS RegionROI
FROM `campaign performance` cp
INNER JOIN `campaign details` cd
ON cp.CampaignName = cd.CampaignName
INNER JOIN `region performance` rp
ON cp.Region = rp.Region;


-- Top 10 Campaigns by Revenue
SELECT
    CampaignName,
    Revenue
FROM `campaign performance`
ORDER BY Revenue DESC
LIMIT 10;


-- Top 10 Campaigns by ROI
SELECT
    CampaignName,
    ROI
FROM `campaign performance`
ORDER BY ROI DESC
LIMIT 10;


-- Industry-wise Revenue
SELECT
    Industry,
    SUM(Revenue) AS TotalRevenue
FROM `campaign performance`
GROUP BY Industry
ORDER BY TotalRevenue DESC;


-- Industry-wise ROI
SELECT
    Industry,
    ROUND(AVG(ROI),2) AS AvgROI
FROM `campaign performance`
GROUP BY Industry
ORDER BY AvgROI DESC;


-- Region-wise Revenue
SELECT
    Region,
    SUM(Revenue) AS Revenue
FROM `campaign performance`
GROUP BY Region
ORDER BY Revenue DESC;


-- Conversion Rate
SELECT
    CampaignName,
    ROUND((Conversions / Clicks) * 100,2) AS ConversionRate
FROM `campaign performance`
ORDER BY ConversionRate DESC;


-- Campaign Type Performance
SELECT
    cd.Type,
    COUNT(cp.CampaignID) AS TotalCampaigns,
    ROUND(AVG(cp.ROI),2) AS AvgROI,
    SUM(cp.Revenue) AS TotalRevenue
FROM `campaign performance` cp
JOIN `campaign details` cd
ON cp.CampaignName = cd.CampaignName
GROUP BY cd.Type;


-- Best Performing Region
SELECT
    Region,
    AverageROI
FROM `region performance`
ORDER BY AverageROI DESC
LIMIT 1;


-- High Spend but Low ROI Campaigns
SELECT
    CampaignName,
    Spend,
    ROI
FROM `campaign performance`
WHERE Spend > (
    SELECT AVG(Spend)
    FROM `campaign performance`
)
AND ROI < (
    SELECT AVG(ROI)
    FROM `campaign performance`
);


-- Revenue vs Spend
SELECT
    CampaignName,
    Spend,
    Revenue,
    (Revenue - Spend) AS Profit
FROM `campaign performance`
ORDER BY Profit DESC;


-- KPI Summary
SELECT
    COUNT(*) AS TotalCampaigns,
    SUM(Spend) AS TotalSpend,
    SUM(Revenue) AS TotalRevenue,
    ROUND(AVG(ROI),2) AS AvgROI,
    SUM(Clicks) AS TotalClicks,
    SUM(Conversions) AS TotalConversions
FROM `campaign performance`;






