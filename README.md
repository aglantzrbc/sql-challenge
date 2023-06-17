# Adam Glantz - SQL Challenge Module 9
Bootcamp: RUT-VIRT-DATA-PT-04-2023-U-LOLC-MWTH

## TABLE OF CONTENTS

1. Project Description
   - Data Modeling
   - Data Engineering
   - Data Analysis
2. Installation
3. Contributing
4. Acknowledgements

### 1. PROJECT DESCRIPTION

In this project, we were tasked with helping a fictional company begin a research project about people whom the company employed during the 1980s and 1990s using archival .csv files from that period. It proceeded in three stages: **Data Modeling**, **Data Engineering**, and **Data Analysis**.

- Data Modeling

Prior to expending the considerable effort to create and populate tables, lists and the interrelationships of their attributes were sketched using an Entity Relationship Diagram (ERD) (see **Figure 1**, below). I considered using pgAdmin 4's built-in *ERD For Database* tool, but ultimately employed the free [*QuickDBD*](http://www.quickdatabasediagrams.com/) functionality, whose output looks less convoluted than *ERD For Database*.

The *emp_no* (Employee Number) variable served to link several, though not all, lists as a foreign key. The *dept_emp* (presumably: Department *of* or *by* Employee) list didn't have a unique attribute, so both *emp_no* and *dept_no* (Department Number) were used as a [composite key](https://en.wikipedia.org/wiki/Composite_key).

![Uploading Data Modeling EmployeeSQL QuickDBD Diagram.png…](https://github.com/aglantzrbc/sql-challenge/assets/127694342/9e1ec000-c371-46a7-81aa-9ac5230fa402)

**Figure 1** | *Entity Relationship Diagram (ERD) for lists and their attributes*

- Data Modeling

departments list

![departments_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/bd482117-1dc0-480a-b2d9-8876a09eeb92)

**Figure 2** | *departments list table and postgreSQL code*

dept_emp list

![dept_emp_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/9177f09b-1d77-4221-bccf-5a8d4f9ce06d)

**Figure 3** | *dept_emp list table and postgreSQL code*


For WeatherPy: Dependencies were installed. For a particular day, random combinations of latitude and logitude were generated at set intervals, and then cities close to those coordinates were identified in the citipy dataset and printed. Each city was matched against the data in https://api.openweathermap.org/data/2.5/weather and sequentially printed as meteorlogical data for them was captured in a list, with unmatched cities ignored. After verification of the volume and variables of the list, scatter plots were created from the city data of latitude vs. maximum temperature, humidity, cloudiness, and wind speed. The data was divided into northern hemisphere and southern hemisphere subsets by latitude ranges, and the operation was confirmed by printing out samples. Scatter plots using the same variables as before were created from the data in each hemisphere, this time with a regression model and line added and Pearson's r calculated for each plot. Analysis for each set of scatterplots' linear relationships was provided.

RESULT: The fact that temperature increases as one travels closer to the equator and decreases as one moves further away from it was established with empirical data. None of the other variables had an enduring or marked correlation with latitude.

It should be stated at the outset that the generalizability of the findings across all plots is limited because the plots represent a single day, 5/19/2023. Since the weather fluctuates in any locale, this day may exhibit atypical meteorological patterns in many places and thus not convey more enduring weather features. Analyzing data over time would address this small-n problem. I have endeavored to partly approximate this approach by running the code several times over four days: the hemispheric relationships between latitude and temperature remain noticeable and enduring, while lines of best fit for latitude vs. the other weather variables often differ in direction and r score, though each holding at a low absolute value. This meshes with my ultimate conclusion: there is a reliable correlation only between latitude and temperature.

Basing the analysis on the citipy dataset may overrepresent regions that have more major cities and correspondingly underrepresent those with fewer large cities or fewer cities in general. When "eyeballed", it appears that the datapoint positions blanket the entire earth, but there could be an urban bias buried in the data that may be partially mitigated by weighting regions by the number and size of their cities.

For VacationPy: City data from citipy was plotted on a map of the world. Cities characterized by the author's ideal weather conditions were isolated and displayed in tabular form. Hotels within a set proximity to each city were pulled in from https://api.geoapify.com/v2/places, with the list of city by hotel (or of failures to match cities with hotels) noted - as instructed, the results were capped at approximately 10 hotels to limit excess API calls. The author's ideal cities were then plotted on another map.

-- OBSERVATIONS FROM THE ANALYSIS ARE ALSO PROVIDED IN THE WEATHERPY FILE OF THE JUPYTER NOTEBOOK FILE

### 2. INSTALLATION

This project is coded in Python 3.10.9 The project files have an .ipynb extension, so they are meant to be viewed in Jupyter Notebook.

Project files - WeatherPy, VacationPy

Data file in output_file subfolder = cities.csv, 10 printouts of scatterplots as requested in the instructions

Dependencies -

WeatherPy: matplotlib.pyplot, pandas, numpy, requests, time, scipy.stats, including linregress, json

VacationPy: hvplot.pandas, pandas, requests

Resources - cities.csv (from citipy, for both projects), https://api.openweathermap.org/data/2.5/weather (for WeatherPy), https://api.geoapify.com/v2/place (for VacationPy)

NOTES

We were instructed to put WeatherPy and VacationPy in their own subdirectories, but I kept them at top level for ease of access.

I limited the output of hotels by city in the VacationPy code to approximately 10 (i.e., 15 to correct for cities distant from hotels and hence umatched), as requested by the instructions.

This project assumes that the source .csv file listed above retains its original name and is in a folder labeled "output_data" that is one level below where the Python files reside. If you do not follow this relative placement, the programs will not run and the paths will need to be updated.

### 3. CONTRIBUTING

Adam Glantz: adamglantz@yahoo.com

### 4. ACKNOWLEDGEMENTS

I shared code with two classmates, Karishma Sanghvi and Nancy K. Sakyi. I also consulted with three GitHub repos regarding very similar API / plotting / mapping challenges I found through a Google Search:

Author: Miles Lucey: San Jose, CA USA, Feb 2019 (mileslucey@gmail.com) = https://github.com/mileslucey/weatherpy/blob/master/WeatherPy.ipynb
Author: Matt Debnar: New York, NY USA, June 2020 (https://debnar.com / @debnar) = https://github.com/bbixby/python-api-challenge/blob/master/WeatherPy/WeatherPy.ipynb
Author: Khoi-Duong [sic]: Jan 2023 = https://github.com/Khoi-Duong/WeatherPy-VacationPy/blob/main/WeatherPy_VacationPy_FinalCode/VacationPy_Solved.ipynb
