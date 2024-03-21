--select location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as RatioDeath_per_Case
--from CovidDeaths$
--where location like '%state%'
--order by location,date


--select location, date, total_cases, population, (total_cases/population)*100 as RatioCase_per_pop
--from CovidDeaths$
--where location like '%state%'
--order by location,date


--select location, MAX(total_cases/population)*100 as RatioInfectionPerCountry
--from CovidDeaths$
--group by location
--order by RatioInfectionPerCountry Desc

--select location, population  ,MAX(cast(total_deaths as int)) as Total_Death 
--from CovidDeaths$
--where continent is not null
--group by location, population
--order by Total_Death desc

-- Looking at total Pop vs Vaccinations 

--With rollingTest( Continent,location , Date, Population, NewVaccination, RollPopVaccinated)  as
--(
--select dea.continent, dea.location, dea.date ,dea.population , vac.new_vaccinations , SUM( cast(vac.new_vaccinations as int)) over (partition by  dea.location order by dea.location, dea.date) as RollingCountVaccinated
--from CovidDeaths$ dea join CovidVaccinations$ vac on dea.location = vac.location and dea.date = vac.date
--where dea.continent is not null

--)
--select *, (RollPopVaccinated/Population)*100
--from rollingTest



Create View PercentPopVaccinated as 
select dea.continent, dea.location, dea.date ,dea.population , vac.new_vaccinations , SUM( cast(vac.new_vaccinations as int)) over (partition by  dea.location order by dea.location, dea.date) as RollingCountVaccinated
from CovidDeaths$ dea join CovidVaccinations$ vac on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
