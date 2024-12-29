-- Exploratory Data Analysis (EDA)

# Finding duration of this layoff data. 
SELECT MIN(`date`), MAX(`date`)
FROM layoffs2; # So this data set contains 4 years and 9 months of data, earliest being 2020-03-11
               # and latest layoff data is of 2024-12-11

# Finding maximum total layoffs by a company at one location/time 
# and max percentage layoffs at one location/time. 
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs2; # maximum total laid of = 15000 and maximum percentage laid off = 100

# Finding company with highest total layoffs (including all location and time). 
SELECT company, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs2 
GROUP BY company
ORDER BY Total_Laid_Off DESC ; # Amazon had the highest total layoffs with total being 27840

# Finding which industry had highest/lowest layoffs.
SELECT industry, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs2 
GROUP BY industry
ORDER BY Total_Laid_Off DESC ;# Retail industry had highest layoffs at 71979, with consumer
                              # industry a close second at 71046, lowest layoffs were in AI 
                              # industry at 288. 
                              
# Finding which country had highest/lowest layoffs.
SELECT country, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs2 
GROUP BY country
ORDER BY Total_Laid_Off DESC; # United States had highest layoffs at 455843 
						      # and Malta had the lowest at 29. 
							
# Finding total layoffs by Year.
SELECT YEAR(`date`) AS Year, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs2 
GROUP BY Year
ORDER BY Total_Laid_Off DESC; # So in 2023 we had highest layoffs at 264220. 

# Finding rolling sum of total layoffs by month. 
WITH rolling_total AS (
SELECT SUBSTRING(`date`,1,7) AS `Month`,SUM(total_laid_off) AS Layoffs
FROM layoffs2
GROUP BY `Month`
ORDER BY 1
)
SELECT `Month`,Layoffs, SUM(Layoffs) OVER(ORDER BY `Month`) AS Rolling_Total
FROM rolling_total;

# Finding layoffs per year by companies and ranking them. 
WITH company_layoffs AS (
SELECT company, YEAR(`date`) AS `Year`, SUM(total_laid_off) AS Total_Layoffs
FROM layoffs2
GROUP BY company,`Year`
ORDER BY `Year`, company
 )
SELECT *, DENSE_RANK() OVER (PARTITION BY `Year`ORDER BY Total_Layoffs DESC ) AS `Rank`
FROM company_layoffs;
 













 

SELECT * FROM layoffs2 WHERE percentage_laid_off = 100;