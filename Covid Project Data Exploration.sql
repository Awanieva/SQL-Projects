
Select *
from CovidDeaths
where continent is not NULL
order by 3, 4

select *
from CovidVaccinations
order by 3, 4

--Select Data that we are goin to be using
Select location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
where continent is NOT NULL
order by 1,2

--Loking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths
where location like '%italy%'
and continent is NOT NULL
order by 1,2

--Loking at Total Cases vs Population
--Shows what percentage of population got covid

Select location, date, population, total_cases, (total_cases/population) * 100 as  PercentageOfPopulationInfected
from CovidDeaths
where location like '%italy%' and continent is NOT NULL
order by 1,2

--Looking at countries with highest infection rate compared to population

Select location, population, MAX(Total_cases) as HighestInfectionRate, MAX(total_cases/population)* 100 as PercentageOfPopulationInfected
from CovidDeaths
where continent is NOT NULL
Group by location, population
order by PercentageOfPopulationInfected desc

--Showing Countries with HighestDeath Count per population

Select location, MAX(cast (total_deaths as int)) as TotalDeathCount
from CovidDeaths
where continent is NOT NULL
group by location
order by TotalDeathCount desc

--LETS BREAK THINGS DOWN BY CONTINENT
--Showing Continent with highest death count per population

Select continent, MAX(cast (total_deaths as int)) as TotalDeathCount
from CovidDeaths
where continent is NOT NULL
group by continent
order by TotalDeathCount desc


--GLOBAL NUMBERS

SELECT  SUM(new_cases) as Totalcases, SUM(cast (new_deaths as int)) as TotalDeaths, 
SUM(cast(new_deaths as int)) / SUM(new_cases) *100 as DeathPercentage
From CovidDeaths
Where continent is not null
--group by date
order by 1, 2

--Looking at Total Population Vs Vaccinations
Select Deaths.continent, deaths.location, Deaths.date,population, Vaccine.new_vaccinations
,SUM(cast (Vaccine.new_vaccinations as int)) OVER (Partition by deaths.location order by deaths.location, 
deaths.date) as TotalPeopleVacinated
from CovidDeaths Deaths
JOIN CovidVaccinations Vaccine 
ON Deaths.location = Vaccine.location
and Deaths.date = Vaccine.date
where deaths.continent is not null
order by 2,3


--USING CTE

With PopvsVac (Continent, Location, Date, population, new_vaccinations, TotalPeopleVacinated)
as
(
Select Deaths.continent, deaths.location, Deaths.date, population, Vaccine.new_vaccinations
,SUM(cast (Vaccine.new_vaccinations as int)) OVER (Partition by deaths.location order by deaths.location,
deaths.date) as TotalPeopleVacinated
from CovidDeaths Deaths
JOIN CovidVaccinations Vaccine 
ON Deaths.location = Vaccine.location
and Deaths.date = Vaccine.date
where deaths.continent is not null
)
Select *, (TotalPeopleVacinated/population)*100 as TotalPercentageVacinated
From PopvsVac


--TEMP TABLE 

DROP Table if exists #PercentageOfPeopleVacinated 
CREATE TABLE #PercentageOfPeopleVacinated 
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population Numeric,
new_vaccinations numeric,
TotalPeopleVacinated numeric,
)

INSERT INTO #PercentageOfPeopleVacinated
Select Deaths.continent, deaths.location, Deaths.date,population, Vaccine.new_vaccinations
,SUM(cast (Vaccine.new_vaccinations as int)) OVER (Partition by deaths.location order by deaths.location, 
deaths.date) as TotalPeopleVacinated
--(TotalPeopleVacinated/population)*100
from CovidDeaths Deaths
JOIN CovidVaccinations Vaccine 
ON Deaths.location = Vaccine.location
and Deaths.date = Vaccine.date
where deaths.continent is not null
order by 2,3

Select *, (TotalPeopleVacinated/population)*100 as TotalPercentageVacinated
From #PercentageOfPeopleVacinated


--CREATING VIEW TO STORE DATA FOR  LATER VISUALIZATION

Create View TotalPeopleVacinated as
Select Deaths.continent, deaths.location, Deaths.date,population, Vaccine.new_vaccinations
,SUM(cast (Vaccine.new_vaccinations as int)) OVER (Partition by deaths.location order by deaths.location, 
deaths.date) as TotalPeopleVacinated
from CovidDeaths Deaths
JOIN CovidVaccinations Vaccine 
ON Deaths.location = Vaccine.location
and Deaths.date = Vaccine.date
where deaths.continent is not null
