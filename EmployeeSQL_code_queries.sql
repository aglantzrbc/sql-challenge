-- Pewlett Hackard 1980s-1990s employees research project

-- Data Analysis: queries

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