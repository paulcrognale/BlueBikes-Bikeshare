# Project Background

Blue Bikes is a bike-sharing program in Boston that allows residents and visitors to rent bicycles for short trips around the city. Operated by Blue Cross Blue Shield of Massachusetts and managed by Lyft, it offers a convenient and eco-friendly transportation option since 2011.

The company has a data set of over 6 million bike trips taken from 2016-2019. This project thouroughly analyzes and synthesizes this data in order to uncover critical insights that will improve user satisfaction at Blue Bikes.

Insights and recommendations are provided on the following key areas:

- __General overview of bike station usage__
- __Identification of popular and underperforming stations__
- __Comparison analysis__
- __Resource reallocation__

An Interactive PowerBI dashboard can be downlaoded [here](https://github.com/paulcrognale/BlueBikes-Bikeshare/blob/main/BlueBike_Final_BI.pbix)

The SQL queries regarding various business questions can be found [here](https://github.com/paulcrognale/BlueBikes-Bikeshare/blob/main/Final_SQL.sql)

# Data Structure Overview
Blue Bikes data structure as seen below consists of five tables: bluebikes_stations, bluebikes_2016, bluebikes_2017, bluebikes_2018, bluebikes_2019 with a total row count of 6,840,320 records.

Prior to the beginning the analysis, a variety of checks were conducted for quality control and familiarization with the dataset.

# Executive Summary

##__Overview of Findings__

Overall ridership has been steadlily increasing over the entire four year period by an average of 11% per year as well as an increase of $11.45 revenue generated per trip in 2016 to $14.61 in 2019. The bike share also shows great disparity between the most successful and least successful stations based off total revenue generated, total trips and revenue per bike dock. Outside of Harvard and MIT, where the majority of customers are subscriber based, there are two main hubs that operate out of Boston's South Central Station and Central Square in Cambridge. The former representing the largest transit hub in the city and the latter being a popular destination amongst tourists. 

**Insert Gif********

## __Station Usage__

- The top 10 performing stations are all near either MIT or Harvard
- There is a clear corelation between trips and revenue, although, several outliers are present due to the makeup of subscribers vs single ride users
**Insert first dash on power bi****
- Outtside of the universities there are two main hubs: Central Station and Central Square
- There are also several stations that operate near shorelines and bike baths that act as both a starting and ending station
**insert spider web from tableau**

## __Comparison Analysis__
- The 5 worst performing stations generate less than 10% of the average revenue of the top performing stations
- Most notably, Central Sqaure and Glendan st both have 19 bike docks while the former had 101,992 trips and the latter just 392

## __Resource Realocation__
- The top 10 worst performing stations for each were were then tracked over the entire time series to identify potential targets for retirement
- All stations have atleast 3 years of time on the grid, consistently rank among the lowest each year and have negative growth rates:
  1. The Eddy
  2. Bennington St
  3. Chelsea St
  4. Glendon St
  5. Four Corners
  ***Insert connors fav graph***

# Recommendations

Based on the analysis of the data the following reccomendations have been provided:

- The five stations highlighted should be fully retired or alotted resources should be scaled back
- The newly gained bike docks should then be redeployed to the stations with the highest trips to docks ratio
- If preexisting stations cannot accomadate additional bike docks due to space restrictions then nearby stations should be created

This will result in increased revenues of up tp 500% for the newly relocated bike costs while incurring no additional operating costs once the bikes have been moved.
