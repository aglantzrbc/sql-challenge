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

![Data Modeling EmployeeSQL QuickDBD Diagram](https://github.com/aglantzrbc/sql-challenge/assets/127694342/beef1c16-de3e-445d-bcae-5e4e7cca7067)

**Figure 1** | *Entity Relationship Diagram (ERD) for lists and their attributes*

- **Data Engineering**

A dedicated *EmployeeSQL_db* database was created for this project, associated with postgreSQL server 15 in pgAdmin 4 version 7.

The name conversions from the ERD are as follows, in alphabetical order by diagram entity name and with the construction ERD ENTITY = LIST.

1. Departments ERD item = departments list
2. Department_of_Employee ERD item = dept_emp list
3. Employees ERD item = employees list
4. Managers ERD item = dept_manager list
5. Salaries ERD item = salaries list
6. Titles ERD item = titles list
   
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

Below is the full quoted *employees* list table postgreSQL code (**Code Block 1**), since it can't be completely seen in **Figure 5**.

```
-- Create employees table
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex VARCHAR NOT NULL,
    hire_date DATE NOT NULL, 
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
    PRIMARY KEY (emp_no)
);
```
**Code Block 1** | *Full employees postgreSQL code block*

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

1. *TASK:* List the employee number, last name, first name, sex, and salary of each employee.

![task1_employees_general](https://github.com/aglantzrbc/sql-challenge/assets/127694342/7dbdfe8e-53ba-4cb6-a64f-f8f86e52f8f8)

**Figure 9** | *List of the employee number, last name, first name, sex, and salary of each employee*

```
/* List the employee number, last name, first name, sex, and salary 
of each employee. */

SELECT
    e.emp_no AS "Employee Number",
    e.last_name AS "Last Name",
    e.first_name AS "First Name",
    e.sex AS "Sex",
    CONCAT('$', TO_CHAR(s.salary, '999,999')) AS "Salary"
FROM
    employees e
    INNER JOIN salaries s ON e.emp_no = s.emp_no;
```

**Code Block 2** | *Code for the List of the employee number, last name, first name, sex, and salary of each employee*

2. *TASK:* List the first name, last name, and hire date for the employees who were hired in 1986.

![task2_employees_1986](https://github.com/aglantzrbc/sql-challenge/assets/127694342/3cc1fe99-4760-4805-ae8f-a647966d15af)

**Figure 10** | *List of employees who were hired in 1986 by their first name, last name, and hire date*

```
/* List the first name, last name, and hire date for the 
employees who were hired in 1986. */

SELECT
    first_name AS "First Name",
    last_name AS "Last Name",
    hire_date AS "Hire Date"
FROM
    employees e
WHERE
    hire_date >= DATE '1986-01-01'
    AND hire_date < DATE '1987-01-01'
ORDER BY
    hire_date ASC;
```

**Code Block 3** | *Code for the List of the employee number, last name, first name, sex, and salary of each employee*

3. *TASK:* List the manager of each department along with their department number, department name, employee number, last name, and first name.

![task3_managers_details](https://github.com/aglantzrbc/sql-challenge/assets/127694342/19002efa-dcf7-464c-9b8a-ed671460231a)

**Figure 11** | *List of the managers of each department along with their department number, department name, employee number, last name, and first name*

```
/* List the manager of each department along with their department 
number, department name, employee number, last name, and first name */

SELECT
    m.dept_no AS "Department Number",
    d.dept_name AS "Department Name",
    m.emp_no AS "Employee Number",
    e.last_name AS "Last Name",
    e.first_name AS "First Name"
FROM
    dept_manager m
INNER JOIN
    employees e ON e.emp_no = m.emp_no
INNER JOIN
    departments d ON d.dept_no = m.dept_no;
```

**Code Block 4** | *Code for the list of the managers of each department along with their department number, department name, employee number, last name, and first name*

4. *TASK:* List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

![department_employee](https://github.com/aglantzrbc/sql-challenge/assets/127694342/be4185b7-5aae-4e4b-9988-56a64d95b0a8)

**Figure 12** | *List of the department number for each employee along with that employee’s employee number, last name, first name, and department name*

```
/* List the department number for each employee along with that 
employee’s employee number, last name, first name, and department 
name */

SELECT
    b.dept_no AS "Department Number",
    e.emp_no AS "Employee Number",
    e.last_name AS "Last Name",
    e.first_name AS "First Name",
	d.dept_name AS "Department Name"
FROM
    employees e
INNER JOIN
    dept_emp b ON b.emp_no = e.emp_no
INNER JOIN
    departments d ON d.dept_no = b.dept_no;
```

**Code Block 5** | *Code for the list of the department number for each employee along with that employee’s employee number, last name, first name, and department name*

5. *TASK:* List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

![task5_hercules_nameb](https://github.com/aglantzrbc/sql-challenge/assets/127694342/456ca428-4fb6-4c55-a07e-dcfce0f84bf5)

**Figure 13** | *List of the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.*

```
/* List first name, last name, and sex of each employee whose first
name is Hercules and whose last name begins with the letter B */

SELECT
    first_name AS "First Name",
    last_name AS "Last Name",
    sex AS "Sex"
FROM
    employees e
WHERE
    first_name = 'Hercules'
    AND last_name LIKE 'B%';
```

**Code Block 6** | *Code for the list of the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B*

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
