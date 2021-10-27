
SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4
SELECT location, date, new_cases, new_deaths, total_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths;

--General Formatting
--Looking at Total Cases vs Total Deaths
--Percentage of the population that contracted Covid

SELECT 
  location AS Country
, YEAR(date) AS 'Year'
, MONTH(date) AS 'Month'
, total_cases AS 'Total Cases'
, total_deaths AS 'Total Deaths'
, population AS 'Total Population'
, ROUND(total_cases/population*100,2) AS 'Covid Spread Rate'
, ROUND((total_deaths/total_cases)*100,2)AS 'Death %'
--, new_cases AS 'New Cases'
--, new_deaths AS 'Deaths'
--, CONVERT(date,date) AS 'Date'
FROM PortfolioProject..CovidDeaths
WHERE location = 'United States'
ORDER BY 5 DESC;

--Countries with Highest Covid Contraction Rate compared to Popluation

SELECT 
location AS Country
--, YEAR(date) AS 'Year'
--, MONTH(date) AS 'Month'
, population
, MAX(total_cases) AS 'HighestCovidContractionCount'
, MAX(ROUND(total_cases/population*100,2)) AS 'PercentPopulationInfected' /*Covid Spread % by the population*/
FROM PortfolioProject..CovidDeaths
--WHERE location = 'INDIA'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--Countries with Highest Death Count

SELECT 
location AS Country
, MAX(total_deaths) AS 'TotalDeathCount'
, MAX(ROUND(total_cases/population*100,2)) AS 'PercentPopulationInfected' /*Covid Spread % by the population*/
FROM PortfolioProject..CovidDeaths
GROUP BY location
ORDER BY TotalDeathCount DESC;


--Death Count and Rate of Infected Population 

SELECT 
location AS Country
, MAX(CAST(total_deaths as INT)) AS 'TotalDeathCount'
, MAX(ROUND(total_cases/population*100,2)) AS 'PercentPopulationInfected' /*Covid Spread % by the population*/
, MAX(ROUND(total_deaths/total_cases*100,2)) AS 'DeathPercentofInfectedPopulation'
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL /* To remove the continent groupings from the location column*/
GROUP BY location
ORDER BY TotalDeathCount DESC;

--STATS BY CONTINENT

SELECT 
  continent AS 'Continent'
, MAX(CAST(total_deaths as INT)) AS 'TotalDeathCount'
, MAX(ROUND(total_cases/population*100,2)) AS 'PercentPopulationInfected' /*Covid Spread % by the population*/
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;