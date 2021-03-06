# Covid19Project
In this case study, I will explore covid-19 data from 1-Jan-2020 to 3-March-2022. Identify the effectiveness of vaccination on covid positive cases and death.

**Guiding questions**

-Where is your data located?

The data is located in Our World in Data(OWID) dataset.
Raw Data: https://ourworldindata.org/covid-deaths

-Does your data ROCCC?

Reliable-(MEDIUM) The data source from OWID sourced it's data from World Health Organization.
          The actual death toll from COVID-19 is likely to be higher than the number of confirmed deaths,
					this is due to limited testing and problems in the attribution of the cause of death. Some countries
					may only count hospital deaths, whilst others also include deaths in homes. 

Original-(MEDIUM) Second Party Source: Our World in Data and the open-access data tools that make the online publication possible, 
is funded through a mix of grants, sponsors and reader donations.

Comprehensive-(MEDIUM) In this dataset it provide the numbers of daily vaccination, postive cases and death of each country. But out of the daily cases and deaths, it did not show how many have been vaccinated.

Current-(HIGH) The data are updated on daily basis.

Cited-(HIGH) The dataset is sourced from World Health Organization which is part of a credible organization.

**Data Cleaning & Manipulation in MySQL**

1.Standardise date formate YYYY.MM.DD

2.Check for duplicate rows

3.Check the start date of the 1st positive covid case

4.Looking at iso_code in covid_cases table to determine if they are its primary key

5.Create new column for 7 days moving average cases and deaths.

**Data Visualisation using Tableau**

https://public.tableau.com/views/Covid19MilestoneProject/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link

![Map](https://user-images.githubusercontent.com/100673174/166651469-55b69895-2a69-4b40-b610-3851dfd0498e.PNG)

The positive covid cases are represented in this map with a red circle and the larger the circle the higher number of total covid cases in that country.

![top 5 cases](https://user-images.githubusercontent.com/100673174/166873964-796931f8-146a-4406-95d1-543b133cb9f3.PNG)

This bar chart shown the top 5 positive covid cases on 13 March 2022

![top 5 deaths](https://user-images.githubusercontent.com/100673174/166874059-1678883a-49e6-405e-bb24-bd04e077f838.PNG)

This bar chart shown the top 5 deaths cases on 13 March 2022.

As United States is in the top spot of positive and death cases, the next few figures will study about the relationship
between Vaccination, positive cases and deaths of United States.


![line graph cases](https://user-images.githubusercontent.com/100673174/166878754-f481f398-c9f1-4f3b-8827-e3df3de99f6a.PNG)

From this line graph, we can see:

1. There is a high surge in positive cases between late Dec-2021 and Mid-Jan-2022. Which could be due to new variant of virus, Omicron.

2. A positive slope trendline showing that with each day past there is a gain of ~278 7-Days AVG cases.

![40percen](https://user-images.githubusercontent.com/100673174/167079188-bfb95181-6c2f-417e-8e11-f98002a73f37.png)

From this scatter plot, we can see:

1. In this scatter plot shown the relationship of the changes in 7-Days Avg cases and percentage of USA Population Vaccination.
2. On 14-May-2021, the country achived 40% of its population vaccinated.
3. A negative slope trendline showing with each percentage increase, there will be an approximately of 3997 ???7-Days AVG cases decrease.

![image](https://user-images.githubusercontent.com/100673174/167090264-0c943a97-eaaa-44e6-928f-0e13bfd7faa5.png)

From this scatter plot, we can see:

1. On 9-Sept-2021, the country achived 55% of its ppopulation vaccinated.
2. A cluster is formed above the trendline between 45%~55% of population vaccinated. This cluster could come from the first and second batch of people who took the vaccine and their vaccine's effectiveness has wore off.
3. The trendline has changed from a negative slope to positive.

![surge in cases during jan](https://user-images.githubusercontent.com/100673174/166891252-2cbc5294-f5cc-4160-999b-c7c4039c410c.png)

From this scatter plot, we can see:

1. Despite that the country has achived 63.5% of its population vaccinated, there still a high surge in positive cases during Mid-Jan due to Omicron variant.

![cases plunge](https://user-images.githubusercontent.com/100673174/166892257-83071872-7eac-4c55-92e7-dba9525497fd.png)

From this scatter plot, we can see:

1. With increased in the percentage of population fully vaccinated from 63% to 65% and booster, the cases plunged and the trendline changed to negative slope.

![Screenshot (18)](https://user-images.githubusercontent.com/100673174/167077274-5ffd0648-813d-4416-ada7-1524890b0f44.png)

This line graph shown:

1. The 7-Days AVG and daily deaths cases of USA.
2. With a positive slope trendline showing that with each day past there is a gain of ~1.06 7-Days AVG cases.
3. High surge records happened on Jan to Feb of 2021 and 2022.

![40perce](https://user-images.githubusercontent.com/100673174/167079155-cb4d5f7a-8b8b-4e9f-a746-e153c1d3374c.png)

From this scatter plot, we can see:

1. In this scatter plot shown the relationship of the changes in 7-Days Avg deaths and percentage of USA Population Vaccination.
2. On 14-May-2021, the country achived 40% of its population vaccinated.
3. A negative slope trendline showing with each percentage increase, there will be an approximately of 76.7 ???7-Days AVG death decrease.

![55percen](https://user-images.githubusercontent.com/100673174/167079532-1affef6c-2ae1-496e-8a6f-e8a80b60188b.png)

From this scatter plot, we can see:

1. On 9-Sept-2021, the country achived 55% of its population vaccinated.
2. The trendline has changed from a negative slope to positive. 

![image](https://user-images.githubusercontent.com/100673174/167096494-96d63f9b-60c4-42bd-b50f-f7aee9ce1f82.png)

From this scatter plot, we can see:

1. Between 58%~63.25%, there were 2 clusters with almost similar size and numbers which cause the trendline slope to be gentle slope with 1.45 ???7-Days AVG death increase.


![plunge in deaths](https://user-images.githubusercontent.com/100673174/167084154-07464ba9-0fa9-4cc1-a302-82318e0c5caa.png)

From this scatter plot, we can see:

1. With increased in the percentage of population fully vaccinated from 63% to 65% and booster, the cases plunged and the trendline changed to negative slope.

**Conclusion**
1. Both death and positive case scatter plots have similar trend at 40% & 55% population vaccinated. 55% of population vaccinated on 9-Sept-2021 but there was a cluster of positive ???7-Days AVG death which could be from people whom vaccine's effectiveness has wore off after 4~6 months from their second vaccination done during Jan-2021.
2. Despite there was a high surge in the number of positive cases between Dec-2021 and Mid-Jan 2022, the ???7-Days AVG death cases did not surge as drastically as ???7-Days AVG positive cases. 
3.  New variant of covid virus can cause an increased of positive cases despite on the high percentage rate of vaccination in the country.
4.  Comparing in Jan-2021 which has a low percentage of population vaccinated with the high percentage rate of vaccination in Jan-2022, the number of death cases did reduce ~20%.
