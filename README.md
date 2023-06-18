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

Prior to expending the effort to create and populate tables, lists and the interrelationships of their attributes were sketched using an Entity Relationship Diagram (ERD) (see **Figure 1**, below). The author considered using [pgAdmin 4's](https://www.pgadmin.org/) built-in *ERD For Database* tool, but ultimately employed the free [*QuickDBD*](http://www.quickdatabasediagrams.com/) functionality, whose output looks less convoluted than *ERD For Database*. However, even with this choice, not every permuation of entity placement could be adequately displayed, so some foreign key connection lines overlap, which is not optimal.

The *emp_no* (Employee Number) variable served to link several, though not all, lists as a foreign key. The *dept_emp* (presumably: Department *of* or *by* Employee) list didn't have a unique attribute, so both *emp_no* and *dept_no* (Department Number) were used as a [composite key](https://en.wikipedia.org/wiki/Composite_key).

![Data Modeling EmployeeSQL QuickDBD Diagram](https://github.com/aglantzrbc/sql-challenge/assets/127694342/beef1c16-de3e-445d-bcae-5e4e7cca7067)

**Figure 1** | *Entity Relationship Diagram (ERD) for lists and their attributes*

- **Data Engineering**

A dedicated *EmployeeSQL_db* database was created for this project, associated with postgreSQL server 15 in pgAdmin 4 version 7.

The name conversions from the ERD are as follows, in alphabetical order by diagram entity name and with the construction ERD ENTITY = LIST.

1. Departments ERD item = *departments* list
2. Department_of_Employee ERD item = *dept_emp* list
3. Employees ERD item = *employees* list
4. Managers ERD item = *dept_manager* list
5. Salaries ERD item = *salaries* list
6. Titles ERD item = *titles* list
   
*departments list:*

The *dept_name* attribute was made unique, since this is the "source of truth" for department names on all other lists.

![departments_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/bd482117-1dc0-480a-b2d9-8876a09eeb92)

**Figure 2** | *departments list table and postgreSQL code*

```
-- Create departments table
CREATE TABLE departments (
    dept_no VARCHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE (dept_name) -- source of truth for rest of tables
);

SELECT * FROM departments;
```
**Code Block 1** | *departments list table postgreSQL code block*

*dept_emp list:*

As aforementioned, this list didn't have a unique attribute, so both *emp_no* and *dept_no* (Department Number) were used as a [composite key](https://en.wikipedia.org/wiki/Composite_key), as commented in the code.

![dept_emp_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/fa213313-aee5-40f9-8d2d-698e778ce983)

**Figure 3** | *dept_emp list table and postgreSQL code*

```
-- Create dept_emp table
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no) -- composite key
);

SELECT * FROM dept_emp;
```
**Code Block 2** | *dept_emp list table postgreSQL code block*

*dept_manager list:*

![dept_manager_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/05b99a6e-26a4-479d-9d83-d11924129210)

**Figure 4** | *dept_manager list table and postgreSQL code*

```
-- Create dept_manager table
CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
);

SELECT * FROM dept_manager;
```
**Code Block 3** | *dept_manager list table postgreSQL code block*

*employees list:*

![employees_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/1de3b73f-2650-4bc6-ac8c-4eac6379582b)

**Figure 5** | *employees list table and postgreSQL code*

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

SELECT * FROM employees;
```
**Code Block 4** | *employees list table postgreSQL code block*

*salaries list:*

![salaries_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/feea46f8-99d6-4bf9-bcf1-8f2618f4859d)

**Figure 6** | *salaries list table and postgreSQL code*

```
-- Create salaries table
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
);

SELECT * FROM salaries;
```
**Code Block 5** | *salaries list table postgreSQL code block*

*titles list:*

The *title* attribute was made unique, since this is the "source of truth" for titles on all other lists.

![titles_list](https://github.com/aglantzrbc/sql-challenge/assets/127694342/51f55f56-4a51-4b05-bd34-d4b8a425a855)

**Figure 7** | *titles list table and postgreSQL code*

```
-- Create titles table
CREATE TABLE titles (
    title_id VARCHAR(5) NOT NULL,
    title VARCHAR(40) NOT NULL,
    PRIMARY KEY (title_id),
    UNIQUE (title) -- source of truth for rest of tables
);

SELECT * FROM titles;
```
**Code Block 6** | *titles list table postgreSQL code block*

*Scan of code to display tables:*

The order of tables, above, is alphabetical, but the tables were coded and run in a sequence to allow foreign keys to refer back to where they originate in previous blocks of code.

![display_tables](https://github.com/aglantzrbc/sql-challenge/assets/127694342/38b52fad-29c8-42e9-9b7e-260153578403)

**Figure 8** | *Scan of postgreSQL code showing the coding block sequence for the tables*

- **Data Analysis**

1. **_TASK:_** List the employee number, last name, first name, sex, and salary of each employee.

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

**Code Block 7** | *Code block for the List of the employee number, last name, first name, sex, and salary of each employee*

2. **_TASK:_** List the first name, last name, and hire date for the employees who were hired in 1986.

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

**Code Block 8** | *Code block for the List of the employee number, last name, first name, sex, and salary of each employee*

3. **_TASK:_** List the manager of each department along with their department number, department name, employee number, last name, and first name.

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

**Code Block 9** | *Code block for the list of the managers of each department along with their department number, department name, employee number, last name, and first name*

4. **_TASK:_** List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

![task4_department_employee](https://github.com/aglantzrbc/sql-challenge/assets/127694342/c28655f4-787c-4b0b-8360-85c69545e66e)

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

**Code Block 10** | *Code block for the list of the department number for each employee along with that employee’s employee number, last name, first name, and department name*

5. **_TASK:_** List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

![task5_hercules_nameb](https://github.com/aglantzrbc/sql-challenge/assets/127694342/456ca428-4fb6-4c55-a07e-dcfce0f84bf5)

**Figure 13** | *List of the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B*

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

**Code Block 11** | *Code block for the list of the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B*

6. **_TASK:_** List each employee in the Sales department, including their employee number, last name, and first name.

![task6_employee_sales](https://github.com/aglantzrbc/sql-challenge/assets/127694342/1ab073b9-9405-479e-8fe2-7d16341376d3)

**Figure 14** | *List of each employee in the Sales department, including their employee number, last name, and first name*

```
/* List each employee in the Sales department, including their 
employee number, last name, and first name */

SELECT
    e.emp_no AS "Employee Number",
    e.last_name AS "Last Name",
    e.first_name AS "First Name"
FROM
    departments d
    INNER JOIN dept_emp b ON d.dept_no = b.dept_no
    INNER JOIN employees e ON b.emp_no = e.emp_no
WHERE
    d.dept_name = 'Sales';
```

**Code Block 12** | *Code block for the list of each employee in the Sales department, including their employee number, last name, and first name*

7. **_TASK:_** List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

![task7_sales_development](https://github.com/aglantzrbc/sql-challenge/assets/127694342/d258720c-e88c-49c5-b912-4f1adcc439ea)

**Figure 15** | *List of each employee in the Sales and Development departments, including their employee number, last name, first name, and department name*

```
/* List each employee in the Sales and Development departments, 
including their employee number, last name, first name, and department 
name */

SELECT
    e.emp_no AS "Employee Number",
    e.last_name AS "Last Name",
    e.first_name AS "First Name",
    d.dept_name AS "Department Name"
FROM
    employees e
    INNER JOIN dept_emp b ON e.emp_no = b.emp_no
    INNER JOIN departments d ON b.dept_no = d.dept_no
WHERE
    d.dept_name IN ('Sales', 'Development');
```

**Code Block 13** | *Code block for the list of each employee in the Sales and Development departments, including their employee number, last name, first name, and department name*

8. **_TASK:_** List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

![task8_frequency_lastname](https://github.com/aglantzrbc/sql-challenge/assets/127694342/2f3b4bfe-7058-42e5-b258-547da48b9766)

**Figure 16** | *List of the frequency counts, in descending order, of all the employee last names*

```
/* List the frequency counts, in descending order, of all the 
employee last names (that is, how many employees share each 
last name) */

SELECT
	COUNT(*) AS "Frequency",
	last_name AS "Last Name"
FROM
    employees e
GROUP BY
    last_name
ORDER BY
    "Frequency" DESC;
```

**Code Block 14** | *Code block for the list of the frequency counts, in descending order, of all the employee last names*

### 2. INSTALLATION

- The [GitHub repository](https://github.com/aglantzrbc/sql-challenge) containing all project files is publicly accessible.
- The assignment details and starter code are proprietary and located on the Rutgers Bootcamp Spot [module 9 SQL Challenge](https://courses.bootcampspot.com/courses/3337/assignments/54030?module_item_id=961277) page.
- This project's source file **EmployeeSQL.sql** was coded in [postgreSQL](https://www.postgresql.org/) version 11 through the [pgAdmin](https://www.pgadmin.org/) version 4 application.
- The data modeling diagram file is **EmployeeSQL_diagram.pgerd** and can be accessed using the [*QuickDBD*](http://www.quickdatabasediagrams.com/) functionality.
- A scan of the data modeling diagram file is available as **Data Modeling EmployeeSQL QuickDBD Diagram.png**.

### 3. CONTRIBUTING

Adam Glantz: adamglantz@yahoo.com

### 4. ACKNOWLEDGEMENTS

In addition to using the Rutgers, postgreSQL, pgAdmin 4, and QuickDBD resources listed above, the author consulted code and results from similar projects publicly accessible in GitHub repositories and searchable through Google:

- [Jakins, Karen](https://www.linkedin.com/in/karen-ej20/): Toronto, Ontario, Canada, April 2021. [Pewlett-Hackard-Analysis](https://github.com/Karenjakins/Pewlett-Hackard-Analysis)
- [Martinez, Emmanuel](https://www.linkedin.com/in/emmanuelmartinezs/): Atlanta, Georgia, USA, November 2020. [Pewlett-Hackard-Analysis](https://github.com/emmanuelmartinezs/Pewlett-Hackard-Analysis)
