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

- **Data Modeling**

Prior to expending the considerable effort to create and populate tables, lists and the interrelationships of their attributes were sketched using an Entity Relationship Diagram (ERD) (see **Figure 1**, below). I considered using pgAdmin 4's built-in *ERD For Database* tool, but ultimately employed the free [*QuickDBD*](http://www.quickdatabasediagrams.com/) functionality, whose output looks less convoluted than *ERD For Database*.

The *emp_no* (Employee Number) variable served to link several, though not all, lists as a foreign key. The *dept_emp* (presumably: Department *of* or *by* Employee) list didn't have a unique attribute, so both *emp_no* and *dept_no* (Department Number) were used as a [composite key](https://en.wikipedia.org/wiki/Composite_key).

![Uploading Data Modeling EmployeeSQL QuickDBD Diagram.png…](https://github.com/aglantzrbc/sql-challenge/assets/127694342/9e1ec000-c371-46a7-81aa-9ac5230fa402)

**Figure 1** | *Entity Relationship Diagram (ERD) for lists and their attributes*

- **Data Engineering**

*departments list:*

The *dept_name* attribute was made unique, since this is the "source of truth" for department names on all other lists.

![departments_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/bd482117-1dc0-480a-b2d9-8876a09eeb92)

**Figure 2** | *departments list table and postgreSQL code*

*dept_emp list:*

As aforementioned, this list didn't have a unique attribute, so both *emp_no* and *dept_no* (Department Number) were used as a [composite key](https://en.wikipedia.org/wiki/Composite_key), as commented in the code.

![dept_emp_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/fa213313-aee5-40f9-8d2d-698e778ce983)

**Figure 3** | *dept_emp list table and postgreSQL code*

*dept_manager list:*

![dept_manager_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/05b99a6e-26a4-479d-9d83-d11924129210)

**Figure 4** | *dept_manager list table and postgreSQL code*

*employees list:*

![employees_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/1de3b73f-2650-4bc6-ac8c-4eac6379582b)

**Figure 5** | *employees list table and postgreSQL code*

*salaries list:*

![salaries_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/feea46f8-99d6-4bf9-bcf1-8f2618f4859d)

**Figure 6** | *salaries list table and postgreSQL code*

*titles list:*

The *title* attribute was made unique, since this is the "source of truth" for titles on all other lists.

![titles_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/51f55f56-4a51-4b05-bd34-d4b8a425a855)

**Figure 7** | *titles list table and postgreSQL code*

*Scan of code to display tables:*

The order of tables, above, is alphabetical, but the tables were coded and run in a sequence to allow foreign keys to refer back to where they originate in previous blocks of code.

![display_tables](https://github.com/aglantzrbc/sql-challenge/assets/127694342/38b52fad-29c8-42e9-9b7e-260153578403)

**Figure 8** | *Scan of postgreSQL code showing the coding block sequence for the tables*

- **Data Analysis**

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
