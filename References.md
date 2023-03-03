# SQL Reference

## Table of Contents
1. [SQL Compatibility](#sql-compatibility)
2. [Typical Users](#typical-users)
3. [Spreadsheets vs. Databases](#spreadsheets-vs-databases)
4. [SQL Statement Fundamentals](#sql-statement-fundamentals)
   1. [SELECT](#select-statement)
   2. [DISTINCT](#select-distinct)
   3. [COUNT](#count)
   4. [WHERE](#select-where)
   5. [ORDER BY](#order-by)
   6. [LIMIT](#limit)
   7. [BETWEEN](#between)
   8. [IN](#in)
   9. [LIKE, ILIKE](#like-and-ilike)
5. [GROUP BY Statements](#group-by-statements)
   1. [Aggregation Functions](#aggregation-functions)
   2. [GROUP BY](#group-by)
   3. [HAVING](#having)
6. [Joins](#joins)
   1. [AS](#as)
   2. [INNER JOIN](#inner-join)
   3. [FULL OUTER JOIN](#full-outer-join)
   4. [LEFT OUTER JOIN](#left-outer-join)
   5. [RIGHT JOIN](#right-outer-join)
   6. [UNION](#union)
   7. [Multiple JOINs](#multiple-joins)
7. [Advanced SQL Commands](#advanced-sql-commands)
   1. [Timestamps and EXTRACT](#timestamps-and-extract)
   2. [Mathematical Functions and Operators](#mathematical-functions-and-operators)
   3. [String Functions and Operators](#string-functions-and-operators)
   4. [SubQuery](#subquery)
   5. [Self-Join](#self-join)
8. [Creating Databases/Tables](#creating-databases-tables)
   1. [Data types](#data-types)
   2. [Primary Keys and Foreign Keys](#primary-keys-and-foreign-keys)
   3. [Constraints](#constraints)
   4. [CREATE](#create)
   5. [INSERT](#insert)
   6. [UPDATE](#update)
   7. [DELETE](#delete)
   8. [ALTER](#alter)
   9. [DROP](#drop)
   10. [CHECK Constraint](#check-constraint)
9. [Conditional Expressions and Procedures](#conditional-expressions-and-procedures)
   1. [CASE](#case)
   2. [COALESCE](#coalesce)
   3. [CAST](#cast)
   4. [NULLIF](#nullif)
   5. [Views](#views)
   6. [Import and Export](#import-and-export)
10. [Setup database UI](#setup-database-ui-pc)

*Disclaimer: images and subject matter sourced from Jose Portilla, Pierian Data, "The Complete SQL Bootcamp 2020"*


## SQL Compatibility
SQL can be used with most engines/software/databases that implement SQL (PostgreSQL, MySQL, Amazon RedShift, Microsoft SQL Server, MySQL, Oracle Database). 

PostgreSQL
- Free (open source)
- Widely used on internet
- Multi-platform

MySQL
- Free (open source)
- Widely used on internet
- Multi-platform

MS SQL Server Express
- Free but with some limitations
- Compatible with SQL Server
- Windows only

Microsoft Access
- Cost
- Not easy to use just SQL

SQLite
- Free (open source)
- Mainly command line

## Typical Users
SQL is used to store/retrieve/update/delete data. Databases have a wide variety of users, such as analysts (marketing, business, sales), technical users (data scientists, software engineers, web developers), and basically anyone needing to deal with data. 

## Spreadsheets vs. Databases
Spreadsheets are most useful for one-time analyses, quick charting, reasonable dataset sizes, and those untrained to work with data. Databases are most useful for data integrity, handling (very) large datasets, combining datasets, automating queries, and supporting data for websites and apps. 

[Back to Top](#table-of-contents)

## SQL Statement Fundamentals

### SELECT statement
At minimum, selects column/s from table/s. 

Format: `SELECT column_name FROM table_name;`

Specify multiple columns: `SELECT column_1, column_2 FROM table_1;`

Select all columns: `SELECT * FROM table_1;`
- Increases traffic between DB and application, which can slow retrieval of results. 

### SELECT DISTINCT
`DISTINCT` operates on a column to retrieve only **unique** values from a column. 

Format: `SELECT DISTINCT column_name FROM table_name;`. 

Optional to surround column name with parentheses for readability: `SELECT DISTINCT(column_name) FROM table_name;`. 

Example: `SELECT COUNT(DISTINCT(district)) FROM address;`

### COUNT
Returns number of input rows that match specific condition of a query. 

Can apply COUNT on specific column or pass COUNT(*) - both return the same result, since the number of columns in 1 table are always the same. 

Format: `SELECT COUNT(column_name) FROM table_name;` 

or `SELECT COUNT column_name FROM table_name;`

Find the number of rows in a table: `SELECT COUNT(*) FROM table_name;`. 

COUNT is more useful when combined with other commands. 

Format: `SELECT COUNT(DISTINCT name) FROM table;`

or `SELECT COUNT DISTINCT name FROM table;` 

or `SELECT COUNT(DISTINCT(name)) FROM table;`
- Selects the name column from the table
- `DISTINCT name`: filters for unique names
- `COUNT(DISTINCT name`): reduces query to the number of unique names

### SELECT WHERE
Most fundamental combination of a SQL statement. Allows specification of conditions on columns for the rows to be returned. 

Format: `SELECT column_name FROM table WHERE condition/s;`
- WHERE clause must appear immediately after FROM clause.

PostgreSQL provides variety of standard operators to construct the conditions.  

Comparison operators: `<`, `>`, `=`, `>=`, `<=`, `!=`. 

Logical operators allow combination of comparison operators: `AND`, `OR`, `NOT`. 

String/s denoted by single quotation marks, i.e. `SELECT name, choice FROM table WHERE name='Vik' AND choice='Red'`. 

[Back to Top](#table-of-contents)

### ORDER BY
Sort rows in columns based on a column value, ascending or descending. 

Format: `SELECT column_name FROM table ORDER BY column_1 ASC / DESC`

ORDER BY will be toward the end of the query, since sorting is ideal after filtering. 

If multiple columns specified to order, each column is prioritized by what was listed first. 

If ASC / DESC left blank, ASC is default. 

Example: `SELECT company, name, sales FROM table_1 ORDER BY company DESC, sales ASC` filters to company, name and sales columns from the table_1. Company column is ordered first by descending alphabetical order. Within each company, sales is ordered next by ascending value. 

### LIMIT
Limit number of rows returned for a query. Also useful in combination with `ORDER BY`. 

Format: `SELECT column_name FROM table WHERE condition ORDER BY column_1 ASC, column_2 DESC LIMIT quantity;`

`LIMIT` goes at the very end of the query, since it's the last command to be executed. 

Example: `SELECT * FROM payment WHERE amount != 0.00 ORDER BY payment_date DESC LIMIT 5;`

### BETWEEN
Can be used to match a value against a range of values. Useful in conjunction with WHERE to add on a numeric range condition. 

Equivalent to `WHERE value>=low AND value<=high`. 

Format: `SELECT column_name FROM table WHERE value BETWEEN low AND high;`

Also useful in conjunction with `NOT` to **exclude** a specified range. Example: `SELECT customer_id FROM payment WHERE customer_id NOT BETWEEN 5 AND 10`. 

Also possible to use the range with ISO 8601 date format (`YYYY-MM-DD`). Example: `BETWEEN '2012-09-21' AND '2016-06-13'`. 

Use caution when using this with dates that also include timestamp information, since datetime starts at 0:00. 

### IN
Can be used to check for multiple possible value options. 

Format: `SELECT column/s from table WHERE column IN (option1, option2);`

Example: `SELECT * from payment WHERE amount IN (0.99, 1.98, 1.99);`

### LIKE and ILIKE
Allows performing pattern matching against string data with the use of wildcard characters. 

`LIKE` matches case-sensitive-wise, and `ILIKE` matches case-insensitive-wise. 

Format: `SELECT column/s from table WHERE column LIKE string`;

Wildcard characters: 
- `%`: matches any sequence (number) of characters
- `_`: matches any single character. Multiple underscores can be used in a query

Example: `SELECT name from employees WHERE name LIKE 'A%';`
- Returns all names that begin with an uppercase A and any number and set of letters that procede it. 

Example: `SELECT animal from creatures WHERE animal ILIKE 'E%';`
- Returns all animals that begin with the letter e, case insensitive. 

Example: `SELECT name from film WHERE name LIKE 'Mission Impossible _';`
- Returns all names that begin with Mission Impossible, but only 1 character can be replaced with `_` (such as the sequel number). 

Example: `SELECT version from programs WHERE version LIKE 'VERSION#__';`
- Returns all versions of programs that have 2 digits in the version number. 

Example: `SELECT COUNT(*) from employees WHERE name LIKE '_her%';`
- Returns the number of all names that contain the letters 'her' with exactly one letter preceding it. 

[Back to Top](#table-of-contents)

## GROUP BY Statements

### Aggregation Functions
An aggregate function computes a single result from a set of input values. 

Aggregate function calls occur only in the `SELECT` clause or the `HAVING` clause. 

Most common aggregate functions:
- `AVG(expression)`: returns average
  - Returns floating point value to many decimal places. 
  - Recommended to use `round()` to specify precision after the decimal. 
- `COUNT(expression)`: returns number of values
  - Returns number of rows, which by convention can use `COUNT(*)`. 
- `MAX(expression)`: returns max
- `MIN(expression)`: returns min
- `SUM(expression)`: returns sum 

Example: `SELECT MIN(replacement_cost) FROM film;`

Example: `SELECT MAX(replacement_cost), MIN(replacement_cost) FROM film;`

Example: `SELECT ROUND(AVG(replacement_cost), 2) FROM film;`
- `ROUND()` accepts 2 parameters: the first being a floating point value, and the second being the number of decimal places desired. 

[PostgreSQL docs on aggregate functions](https://www.postgresql.org/docs/current/functions-aggregate.html)

### GROUP BY
Allows aggregation of columns per some category. 

Format: `SELECT category_col, AGG(data_col) FROM table GROUP BY category_col;`

`GROUP BY` must appear immediately after a `FROM` or `WHERE` statement. 

or `SELECT category_col, AGG(data_col) FROM table WHERE condition GROUP BY category_col;`. 

Categorical columns are non-continuous, but can still be numerical (e.g. Class 1, Class 2, Class 3). A categorical column must be chosen to `GROUP BY` with. 

Upon `GROUP BY`, data values associated with redundant categories in categorical columns are separated into tables unique to that specific category. When an aggregate function is performed on these separated tables, a new condensed table is formed that merges the repeated categories. 

![groupbyimg1](img/groupby1.JPG)
*Source: Jose Portilla, Pierian Data Inc.*

In the `SELECT` statement, columns must either have an aggregate function or be in the `GROUP BY` call. 

Example: `SELECT company, division, SUM(sales) FROM finance_table GROUP BY company, division;`
- Returns total sum of sales, per division and per company. 
- The company and division columns are not passed into the aggregate function, and thus must appear in the `GROUP BY` clause. 
- The sales column does not appear in the `GROUP BY` statement, and thus must be passed into the aggregate function. 

`WHERE` statements should not refer to the aggregation result. 

If sorting (`ORDER BY`) is needed based on the aggregate, the entire function must be referenced. 

Example: `SELECT company, SUM(sales) FROM finance_table GROUP BY company ORDER BY SUM(sales);`. 

Example: `SELECT customer_id, staff_id, SUM(amount) from payment WHERE customer_id=341 GROUP BY customer_id, staff_id ORDER BY customer_id;`

Example: `SELECT DATE(payment_date), SUM(amount) FROM payment GROUP BY DATE(payment_date) ORDER BY SUM(amount) DESC;`

### HAVING
Allows using the aggregate result as a filter along with a `GROUP BY` clause. This circumvents the issue of being unable to filter the aggregate via `WHERE`, since aggregation occurs after the `WHERE` clause, and `WHERE` filters non-aggregate properties.

Format: `SELECT column1, AGG(column2) FROM table WHERE condition GROUP BY column1/2 HAVING AGG(column2) [comparative condition];`

Example: `SELECT customer_id, sum(amount) FROM payment GROUP BY customer_id HAVING sum(amount) > 100 ORDER BY customer_id;`
- Returns customers in payment table that have a total amount greater than 100. 

Example: `SELECT store_id, COUNT(*) FROM customer GROUP BY store_id HAVING COUNT(*) > 300;`
- Returns store_id's that have more than 300 rows. 

Example: `SELECT customer_id, COUNT(*) FROM payment GROUP BY customer_id HAVING COUNT(*) >= 40;`
- Returns customers with 40 or more payments. 

Example: `SELECT customer_id, SUM(amount) from payment WHERE staff_id = 2 GROUP BY customer_id HAVING SUM(amount) > 100;`
- Returns customers associated with staff_id 2 whose sum amount is greater than 100. 

[Back to Top](#table-of-contents)

## Joins
Allows combination of multiple tables. 

In general, `INNER JOIN`s allow matching between column commonalities between both tables. `OUTER JOIN`s allow specifying how to deal with values present in only one of these tables. 

### AS
Allows creating an alias for a column or result. 

Format: `SELECT column AS new_name FROM table;`

Can also use this on aggregate functions to re-name the column to something more useful. 

Format: `SELECT SUM(column) AS new_name FROM table;`

Example: 
```
SELECT customer_id, COUNT(rental_id) AS all_rentals, SUM(amount) AS TOTAL_payment
FROM payment
GROUP BY customer_id
ORDER BY total_payment DESC;
```
- Returns number of rentals and total payments of each customer, sorted from most to least total payment. 

`AS` is executed at very end of the query, thus cannot use the alias name inside a `WHERE` operator. 

Example (wrong): `SELECT SUM(payment) AS total_payment FROM table WHERE total_payment > 100;`

Example (correct): `SELECT SUM(payment) AS total_payment FROM table WHERE SUM(payment) > 100;`

### INNER JOIN
Results in the set of records that match in **both** tables. Joined table is joined `ON` the specified column match between both tables. 

Format: `SELECT * FROM table1 INNER JOIN table2 ON table1.col_match = table2.col_match;`

Since the column names are identical, must specify what table the column is referring to in the `ON` clause, via `table1.col_match = table2.col_match`. 

If only `JOIN` written in query, PostgreSQL defaults to `INNER JOIN`. 

Format: `SELECT * FROM table1 JOIN table2 ON table1.col_match = table2.col_match;`

With `INNER JOIN`, the column commonality between both tables allows switching table references in the query. 

Format: `SELECT * FROM table2 INNER JOIN table1 ON table1.col_match = table2.col_match;`

Example: `SELECT * FROM Registrations INNER JOIN Logins ON Registrations.name = Logins.name;`

![innerjoin1](img/innerjoin1.JPG)

To remove redundancy of matched columns appearing more than once, specify the columns to be shown exactly once as part of the `SELECT` clause. 

Example: `SELECT reg_id, Logins.name, log_id FROM Registrations INNER JOIN Logins ON Registrations.name = Logins.name;`

![innerjoin2](img/innerjoin2.JPG)

Non-redundant column names do not necessitate referencing the table it is from. 

Example: `SELECT payment.customer_id, payment_id, first_name FROM payment INNER JOIN customer ON payment.customer_id = customer.customer_id;`
- `payment_id` and `first_name` columns are unique to their respective tables, while `customer_id` is in both tables. 

### FULL OUTER JOIN
Selects all information from both tables. 

Format: `SELECT * FROM table1 FULL OUTER JOIN table2 ON table1.col_match = table2.col_match;`

The joined table includes column commonality from the `ON` condition, unique information to table1, and unique information to table 2. Table areas adjacent to the unique information from each table are filled with `null`. 

Example: `SELECT * FROM Registrations FULL OUTER JOIN Logins ON Registrations.name = Logins.name;`

![fullouterjoin1](img/fullouterjoin1.JPG)

To return only rows unique to each table, specify a condition in a `WHERE` clause. Essentially a filtered `FULL OUTER JOIN`. 

Format: 
```
SELECT * FROM table2
FULL OUTER JOIN table1
ON table1.col_match = table2.col_match
WHERE table1.id IS null OR 
table2.id IS null;
```

Example: 
```
SELECT * FROM Registrations
FULL OUTER JOIN Logins
ON Registrations.name = Logins.name
WHERE Registrations.reg_id IS null OR
Logins.log_id IS null;
```

![fullouterjoin2](img/fullouterjoin2.JPG)

Example: 
```
SELECT * from customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null
OR payment_id IS null
```
- Returns a joined customer/payment table on customer id where the customer id or payment id do not exist. Ensures customer information (email, name, etc.) are stored only if payment or purchsae history exists for that customer. 

[Back to Top](#table-of-contents)

### LEFT (OUTER) JOIN
Results in set of records that are in the 'left' table; includes all left table results and commonalities between left and right table. If there is no match with the right table, results are `null`. 

Format: `SELECT * FROM table1 LEFT OUTER JOIN table2 ON table1.col_match = table2.col_match;`

or 

Format: `SELECT * FROM table1 LEFT JOIN table2 ON table1.col_match = table2.col_match;`

Example: `SELECT * FROM Registrations LEFT JOIN Logins ON Registrations.name = Logins.name;`

![leftjoin1](img/leftjoin1.JPG)

To return results **exclusive** to the left table, specify a condition in `WHERE` that accounts for the right table join results being `null`. 

Format: `SELECT * FROM table1 LEFT JOIN table2 ON table1.col_match = table2.col_match WHERE table2.id IS null;`

Example: `SELECT * FROM Registrations LEFT OUTER JOIN Logins ON Registrations.name = Logins.name WHERE Logins.log_id IS null;`

![leftjoin2](img/leftjoin2.JPG)

Example: 
```
SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory 
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS null;
```
- Lists film titles and their ids that are not in inventory. 

### RIGHT (OUTER) JOIN
Returns all results of the right table including commonalities with the left table. The same as a LEFT JOIN, except switched for the right table. 

Format: `SELECT * FROM table1 RIGHT OUTER JOIN table2 ON table1.col_match = table2.col_match;`
- Equivalent to `SELECT * FROM table2 LEFT OUTER JOIN table1 ON table1.col_match = table2.col_match;`.

### UNION
Used to combine the result-set of two or more SELECT statements. Concatenates, or literally merges, two resultant tables together - independent of column commonality. 

Format: `SELECT column_name(s) FROM table1 UNION SELECT column_name(s) FROM table2;`

Example: `SELECT * FROM Sales2021_Q1 UNION SELECT * FROM Sales2021_Q2;`

![union1](img/union1.JPG)
![union2](img/union2.JPG)

### Multiple JOINs
If more than 2 tables are involved in a query, use at least 2 joins to obtain the desired results. 

Example: 
```
SELECT title, first_name, last_name FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg';
```
- Returns all movies in which 'Nick Wahlberg' is an actor. `actor` table includes actor `first_name`s, `last_name`s, and `actor_id`s. `film` includes film information, including `film_id`. `film_actor` includes `actor_id` and associated `film_id`s. Since 3 tables are needed to obtain the requested information on the 2 commonalities of `film_id` and `actor_id`, 2 `INNER JOIN`s are required. 

[Back to Top](#table-of-contents)

## Advanced SQL Commands

### Timestamps and EXTRACT
SQL queries and tables can handle date and time information. [Datetime Functions, PostgreSQL](https://www.postgresql.org/docs/8.3/functions-datetime.html)
- `TIME`: contains only time
- `DATE`: contains only date
- `TIMESTAMP`: contains date and time
- `TIMESTAMPTZ`: contains date, time, and timezone

Caution: it is possible to remove information from datetime information, but not add. 

`SHOW ALL;`: Command and parameter that list all possible parameters. 

`SELECT NOW();` : Provides current date and time in `timestamp with time zone` format. Example: `2020-07-20 21:13:30.134498-07`

`SELECT TIMEOFDAY();` : Provides current date and time in `text` format. May be preferred over `SELECT NOW();` for better intelligibility. Example: `Mon Jul 20 21:13:14.860518 2020 PDT`

`SELECT CURRENT_TIME;` : Provides current time in `time with time zone` format. Example: `21:12:28.542536-07:00`

`SELECT CURRENT_DATE;` : Provides current date in `date` format. Example: `2020-07-20`

It is possible to extract infomration from time-based data type with the following functions: 
- `EXTRACT()` : allows extraction of a sub-component of a date value using the field parameters `YEAR`, `MONTH`, `DAY`, `WEEK`, `QUARTER`, `DOW`, `DECADE`, etc. 
  - Format: `EXTRACT(YEAR FROM date_col);`
  - Example: `SELECT EXTRACT(YEAR FROM payment_date) AS year FROM payment;`
    - Returns the year in each column and names the column as `year`. 
  - Example: `SELECT COUNT(*) FROM payment WHERE EXTRACT(DOW FROM payment_date) = 1;` 
    - Returns the number of payments made on a Monday (Sunday = 0, Saturday = 6). 
- `AGE()` : calculates and returns current age given a timestamp recorded in the database. 
  - Format: `AGE(date_col);`
  - Example return: `13 years 1 mon 5 days 01:35:13.003423`
- `TO_CHAR()` : general function to convert data types to text. Especially useful for timestamp formatting. [TO_CHAR, PostgreSQL](https://www.postgresql.org/docs/12/functions-formatting.html)
  - Format: `TO_CHAR(date_col, string_format);`
  - Example: `SELECT TO_CHAR(payment_date, 'MONTH-YYYY') FROM payment;`
    - Returns date as `MONTH-YYYY`. 
  - Example: `SELECT TO_CHAR(payment_date, 'mon/dd/YYYY') FROM payment;`
  - Example: `SELECT DISTINCT(TO_CHAR(payment_date, 'MONTH')) FROM payment;`
    - Returns unique months that payments were made in. 

### Mathematical Functions and Operators
Perform mathematical functions and use operators between columns in a table. [Mathematical Functions and Operators Docs, PostgreSQL](https://www.postgresql.org/docs/9.5/functions-math.html)

Example: `SELECT ROUND(rental_rate/replacement_cost)*100 FROM film;`
- Returns result of dividing `rental_rate` by `replacement` to 2 places, multiplied by 100 to obtain percentage. 

Example: `SELECT 0.1 * replacement_cost AS deposit FROM film;`
- Returns 10% of replacement costs. 

### String Functions and Operators
Perform functions and use operators on String types. [String functions and Operators, PostgreSQL](https://www.postgresql.org/docs/current/functions-string.html)

Example: `SELECT LENGTH(first_name) FROM customer;`
- Returns length of the string column `first_name`. 

Example: `SELECT upper(first_name) || ' ' || upper(last_name) AS full_name FROM customer;`
- Returns concatenated strings from `first_name` and `last_name` with a space inbetween all upper-cased, column alias `full_name`.  

Example: `SELECT lower(left(first_name, 1)) || lower(last_name) AS full_name FROM customer;`
- Returns first letter of `first_name` concatenated with `last_name`, all lower-cased with column alias `full_name`. 

### SubQuery
Allows construction of complex queries, essentially performing queries on the resultant of another query. One of the queries 

Example: the following two queries give separate results that eventually depend on each other to get a list of students who scored better than the average grade: 
- `SELECT student, grade FROM test_scores;` : returns student name and grade from `test_scores`. 
- `SELECT AVG(grade) FROM test_scores;` : returns average of grades in `grade`. 

To get the result in a 'single' query: 
- `SELECT student, grade FROM test_scores WHERE grade > (SELECT AVG(grade) FROM test_scores);`
  - Returns students with grades higher than the average, which was returned by the subquery using AVG(). 

Subqueries can also operate on a table separate from the main query's. 

Subqueries can be found within a condition of a WHERE clause. If the subquery returns more than 1 value, a comparison operator cannot be used, and must be replaced with `IN`. 

Example: `SELECT student, grade FROM test_scores WHERE student IN (SELECT student FROM honor_roll_table);`
- Returns grades of honors students only. 

The `EXISTS` operator tests for existence of rows in a subquery. Typically subqueries are passed in the `EXISTS()` function to check if any rows are returned with that subquery. 

Format: `SELECT column_name FROM table_name WHERE EXISTS(SELECT column_name FROM table_name WHERE condition);`

Example: 
```
SELECT first_name, last_name FROM customer AS c 
WHERE NOT EXISTS(
  SELECT * FROM payment AS p 
  WHERE p.customer_id = c.customer_id AND amount > 11
);
```
- Returns all customer names where customer didn't pay greater than $11. 

A `JOIN` operation in a subquery can be used in the `WHERE` condition in the main query. 

Example: 
```
SELECT film_id, title FROM film
WHERE film_id IN
(SELECT inventory.film_id FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30');
```
- Returns film titles where the film was returned between May 29th and May 30th. 

### Self-Join
A query in which a table is joined to itself. Useful for **comparing** values in a column of rows **within the same table**. Table is not internally copied, but SQL performs the command as though it were. No special keyword for self-join; just `JOIN` the same table in both parts. However, an alias is required for 'each table' as though they were separate tables. 

Format: 
```
SELECT tableA.col, tableB.col 
FROM table AS tableA
JOIN table AS tableB
ON tableA.some_col = tableB.other_col;
```

Example: 
```
SELECT emp.name, report.name
FROM employees AS emp
JOIN employees AS report 
ON emp.emp_id = report.report_id;
```
- ![selfjoin1](img/selfjoin1.JPG)
- Returns the names of employees that report to other employees. 

Example: 
```
SELECT f1.title, f2.title, f1.length
FROM film AS f1
JOIN film AS f2
ON f1.film_id != f2.film_id AND f1.length = f2.length;
```
- Returns all films that have the same film length as a given film. 

[Back to Top](#table-of-contents)

## Creating Databases/Tables

### Data Types
[Data types, PostgreSQL](https://www.postgresql.org/docs/10/datatype.html)

Common data types include: 
- Boolean 
- Character (`char`, `varchar`, `text`)
- Numeric (integer, float)
- Temporal (date, time, timestamp, interval)
- UUID, universally unique identifier
  - Created from an algorithm to ensure completely unique identifier for a data type
- Array (for strings, numbers, etc.)
- JSON
- Hstore key-value pair
- Special types (network address, geometric data, etc.)
- `SERIAL`
  - Creates a 'sequence'-type database object that generates a sequence of integers
  - Especially used for primary keys, since it logs unique integer entries automatically upon insertion
  - If a row is removed, the column with this data type will not adjust for it; this allows for easier visibility of removed rows
  - Types of `SERIAL`:
    - `SMALLSERIAL`
      - 2 bytes
      - Small autoincrementing integer
      - 1 to 32767
    - `SERIAL`
      - 4 bytes
      - Autoincrementing integer
      - 1 to 2147483647
    - `BIGSERIAL`
      - 8 bytes
      - Large autoincrementing integer
      - 1 to 9223372036854775807

### Primary Keys and Foreign Keys
A primary key is a column/group of columns used to identify a row uniquely in a table. 

A foreign key is a field/group of fields in a table that uniquely identifies a row (primary key) in another table. This other table is known as the referenced table/parent table, and the table that contains the foreign key is called the referencing table/child table. A table can have multiple foreign keys depending on its relationships with other tables. 

Primary keys/foreign keys typically make good column choices for joining together two or more tables. 

Generate a primary key column via `SERIAL` keyword as the data type for the column. 

### Constraints
The rules enforced on data columns on a table. Used to prevent invalid data from being entered into the database, and ensures accuracy/reliability of database data. 

The two categories of constraints are: 
- Column constraints: constrains data in a column to adhere to given conditions. 
- Table constraints: applied to the entire table rather than to an individual column. 

Common constraints used include: 
- Column constraints
  - `NOT NULL`: ensures that a column cannot contain `NULL` values. 
  - `UNIQUE`: ensures that all values in a column are different. 
  - `PRIMARY KEY`: uniquely identifies each row/record in a database table. 
  - `FOREIGN KEY`: constrains data based on columns in other tables. 
  - `CHECK`: ensures that all values in a column satisfy certain conditions. 
  - `EXCLUSION`: ensures that if any two rows are compared on specified column/expression using specified operator, not all of these comparisons will return `TRUE`. 
- Table constraints
  - `CHECK (condition)`: checks a condition when inserting/updating data. 
  - `REFERENCES`: constrains value stored in the column that must exist in a column in another table. 
  - `UNIQUE (column_list)`: forces the values stored in the columns listed within the parameters to be unique. 
  - `PRIMARY_KEY(column_list)`: allows defining the primary key to be defined within multiple columns. 

### CREATE
Allows creation of a table. 

Format: 
```
CREATE TABLE table_name(
  column_name1 TYPE column_constraint1,
  column_name2 TYPE column_constraint2,
  table_constraint1 table_constraint2
) INHERITS existing_table_name;
```
- Each defined column/column constraint set separated by a comma. 
- Each table constraint separated by a space. 

Tables can be created and then linked via an intermediary table. 

Example: 
```
CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
)
```
- Creates an `account` table. 

```
CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
)
```
- Creates a `job` table. 

```
CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
)
```
- Creates an `account_job` table. The `user_id` column specifically references the `user_id` column in the `user` table, and must specify as such. The `job_id` column specifically references the `job_id` column in the `job` table and must specify as such for the same reason. `hire_date` is information that is based on a given user and the type of job the user has. 

[Back to Top](#table-of-contents)

### INSERT
Allows insertion of rows into an existing table. 

Format: 
```
INSERT INTO table_name(column1, column2, ...)
  SELECT column1, column2, ...
  FROM another_table
  WHERE condition;
```

or 

Format: 
```
INSERT INTO table_name(column1, column2, ...)
  VALUES (value1, value2, ...)
```

`SERIAL` columns do not need to be provided a value. 

Example: 
```
INSERT INTO table_name(column1, column2, ...)
  VALUES 
  ('Vik', 'password', 'vik@gmail.com', CURRENT_TIMESTAMP)
```

Constraints will be checked to see if values exist in the other table. If the value doesn't exist, a similar error to this may appear: 
`ERROR:  insert or update on table "account_job" violates foreign key constraint "account_job_user_id_fkey"
DETAIL:  Key (user_id)=(10) is not present in table "account".`

### UPDATE
Allows for changing of values of columns in a table. 

Format: 
```
UPDATE table
  SET column1 = value1,
  column2 = value2, ...
  WHERE condition;
```

Example: `UPDATE account SET last_login = CURRENT_TIMESTAMP WHERE last_login IS NULL;`
- Sets `last_login` to `CURRENT_TIMESTAMP` wherever it is `null`. 

Can also update a column based on another column. 

Example: `UPDATE account SET last_login = created_on;`

Can also update a column using another table's column's values. Also known as an UPDATE join. 

Format: 
```
UPDATE table1
SET original_col = table2.new_col
FROM table2
WHERE table1.id = table2.id
```

Example: 
```
UPDATE account_job 
SET hire_date = account.created_on
FROM account 
WHERE account_job.user_id = account.user_id;
```

It's also possible to return the affected rows of an `UPDATE` query. 

Format: `UPDATE table SET col1 = col2 RETURNING col1, col3 (or any columns);`

Example: `UPDATE account SET last_login = created_on RETURNING *;`
- Updates the first column to the values in the second column, then returning all columns of the affected rows. 

### DELETE
Allows removal of rows from a table. 

Format: `DELETE FROM table WHERE condition;`

Can also delete from a table using rows from another table. 

Format: `DELETE FROM table1 USING table2 WHERE table1.id = table2.id;`

Can also delete all rows from a table. 

Format: `DELETE FROM table;`

Can also add in a `RETURNING` call to show affected rows. 

Example: `DELETE FROM job WHERE job_name = 'Acupuncturist' RETURNING job_id, job_name;`

### ALTER
Allows for changes to an existing table structure. 

Format: `ALTER TABLE table_name action;`

Possible changes include:
- Adding, dropping, renaming columns
  - Adding format: `ALTER TABLE table_name ADD COLUMN new_col TYPE;`
  - Dropping format: `ALTER TABLE table_name DROP COLUMN col_name;`
  - Altering column constraint format
    - `ALTER TABLE table_name ALTER COLUMN col_name SET NOT NULL;`
    - `ALTER TABLE table_name ALTER COLUMN col_name ADD CONSTRAINT constraint_name;`
    - `ALTER TABLE table_name ADD UNIQUE(col_name);`
    - 
- Setting `DEFAULT` values for a column
  - `ALTER TABLE table_name ALTER COLUMN col_name SET DEFAULT value;`
  - `ALTER TABLE table_name ALTER COLUMN col_name DROP DEFAULT;`
- Adding `CHECK` constraints
- Renaming table
  - `ALTER TABLE old_name RENAME TO new_name;`

### DROP
Allows for removal of column from a table. In PostgreSQL, will automatically remove all indexes and constraints involving column. However, will not remove columns used in views, triggers, or stored procedures without additional `CASCADE` clause. 

Format: `ALTER TABLE table_name DROP COLUMN col_name;`

To drop dependencies, append `CASCADE` at the end of the query. 

Attempting to drop a column that does not exist will throw an error. Check for existence to avoid a thrown error. 

Format: `ALTER TABLE table_name DROP COLUMN IF EXISTS col_name;`

Possible to drop multiple columns. 

Format: `ALTER TABLE table_name DROP COLUMN col1, DROP COLUMN col2;`

### CHECK Constraint
Allows customization of constraints that adhere to a desired condition. Errors should be thrown when 

Format: `CREATE TABLE example(ex_id SERIAL PRIMARY KEY, col_1 SMALLINT CHECK (condition_1), col_2 SMALLINT CHECK(condition_2);`

Example: 
```
CREATE TABLE employees(
  emp_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birthdate DATE CHECK(birthday > '1900-01-01'),
  hire_date DATE CHECK(hire_date > birthdate),
  salary INTEGER CHECK(salary > 0)
)
```
- If birthdate < '1900-01-01', hire_date < birthdate, or salary < 0, error thrown will read `ERROR: new row for relation "employees" violates check constraint`...

[Back to Top](#table-of-contents)

## Conditional Expressions and Procedures
Some keywords and functions allow adding logic to commands and workflows in SQL. 

### CASE
Execute SQL code only when certain conditions are met. Similar to `IF/ELSE` statements in other languages. General `CASE` or `CASE` expressions are two ways to use a `CASE` statement. Both methods can lead to the same result, but general `CASE` statements are useful for more complex operations on conditions, and `CASE` expressions are more useful when checking simple equality. 

Format (general): 
```
CASE 
  WHEN condition1 THEN result1 
  WHEN condition2 THEN result2 
  ELSE result3
END
```

Example: 
```
SELECT a,
CASE 
  WHEN a=1 THEN 'one'
  WHEN a=2 THEN 'two'
  ELSE 'other' AS label
END
FROM test;
```
- From the `a` column of `test` table, returns the `a` column alongside a column `label` that contains the results from each row evaluation. 

Example: 
```
SELECT customer_id,
CASE 
	WHEN (customer_id<=100) THEN 'Premium'
	WHEN (customer_id BETWEEN 100 and 200) THEN 'Plus'
	ELSE 'Regular'
END AS customer_class
FROM customer;
```
- Label the first 100 customers to purchase something as 'Premium' customers, the next 100 as 'Plus', and the rest as 'Regular. 

Format (expression):
```
CASE expression
  WHEN value1 THEN result1
  WHEN value2 THEN result2
  ELSE result3
END
```

Example:
```
SELECT a,
CASE a
  WHEN 1 THEN 'one'
  WHEN 2 THEN 'two'
  ELSE 'other'
END
FROM test;
```
- From the `a` column of `test` table, returns a specific result when the expression (in this case, the column) is equal to the given values. 

Example: 
```
SELECT customer_id,
CASE customer_id
	WHEN 1 THEN 'Winner'
	WHEN 2 THEN 'Second Place'
	ELSE 'Contender'
END AS raffle_results
FROM customer;
```
- Label the first customer to sign up the winner, the second as second place, and the rest as contender. 

Example: 
```
SELECT 
SUM(CASE rental_rate
	WHEN 0.99 THEN 1
	ELSE 0
END) AS bargains,
SUM(CASE rental_rate
  WHEN 2.99 THEN 1
  ELSE 0
END) AS regular,
SUM(CASE rental_rate
  WHEN 4.99 THEN 1
  ELSE 0
END) AS premium
FROM film
```
- Returns the sum of rental rates, or bargains, that are $0.99, the number of rental_rates that are $2.99, and the number of rental_rates that are $4.99. This may be more contrived than using a `GROUP BY` statement as follows:
  - ```
    SELECT rental_rate, COUNT(rental_rate) FROM film
    GROUP BY rental_rate
    HAVING rental_rate=0.99 or rental_rate=2.99 or rental_rate=4.99;
    ```

[Back to Top](#table-of-contents)

### COALESCE
Function that accepts an unlimited number of arguments. Returns the first argument that is not null. If all arguments are null, will return null. Useful when querying a table that contains null values and substituting it with another value. 

Format: `COALESCE(arg_1, arg_2, ..., arg_n)`

Example: `SELECT item, (price - COALESCE(discount,0)) AS final FROM table;`
- Returns the final price of each row with `null` values from the `discount` column replaced with 0. 

### CAST
Allows conversion to another data type (data type compatibility should be considered (e.g. int -> string, string -/-> int)). 

Format: `SELECT CAST(column_1 AS <data type>);`

Format, specific to PostgreSQL: `SELECT 'column_1'::<data type>;`
- `CAST` operator denoted as `::` . 

Example: `SELECT char_length(CAST(inventory_id AS VARCHAR)) FROM rental;`
- Returns the length of `inventory_id` values. 

### NULLIF
Function that accepts two inputs and returns `null` if both are equal, else returns first argument passed. Useful where a `null` result would throw an error or unwanted result. 

Format: `NULLIF(arg1,arg2)`

Example: 
```
SELECT (
SUM(CASE WHEN department = 'A' THEN 1 ELSE 0 END) / 
NULLIF(SUM(CASE WHEN department = 'B' THEN 1 ELSE 0 END),0)
) AS dept_ratio
FROM depts;
```
- With a division operation, the possibility that the divisor is 0, exists. Ensure that null is returned and an error is not thrown, by surrounding the result of the divisor with NULLIF(resultant, 0) to return null if the resultant is 0. 

### Views
A view is a database object resultant of a stored query. A view can be accessed as a 'virtual table' in PostgreSQL for later reference. Views only store the query, and not the data. Useful for repeated queries to refer to in subsequent queries. 

Format: `CREATE VIEW view_name AS query;`

Example: 
```
CREATE VIEW customer_info AS 
SELECT first_name, last_name, address FROM customer
INNER JOIN address
ON customer.address_id = address.address_id;
```

It's possible to update, alter, or drop existing views. 

Format: `CREATE OR REPLACE VIEW existing_view_name AS new_query;`

Example:
```
CREATE OR REPLACE VIEW customer_info AS
SELECT first_name, last_name, address, district FROM customer
INNER JOIN addres
ON customer.address_id = address.address_id;
```

Format: `DROP VIEW IF EXISTS view_name;`

Format: `ALTER VIEW old_view_name RENAME TO new_view_name;`

### Import and Export
Allows import/export of data from a .csv to an already existing table (not every external data file will be compatible, in which case must alter current table to align with .csv, or alter .csv to align with current table). [Compatible file types, PostgreSQL](https://postgresql.org/docs/12/sql-copy.html)

Note: a current table must exist in order for an import to run successfully. As of Jul 2020, no automation exists within PostgreSQL to create a table based on a .csv file. 

[Back to Top](#table-of-contents)

# Setup Database UI, PC

Practice running queries on a DVD rental store database 

PostgreSQL: SQL engine that reads queries, stores data, and returns information

pgAdmin: GUI for connecting with PostgreSQL and databases (.tar file)

1. Install PostgreSQL
- Visit [PostgreSQL](https://www.postgresql.com) (https://www.postgresql.com) and follow steps to download the latest version (will be redirected to enterprisedb.com)
  - Install all components
  - Choose default data store
  - Provide password for superuser (store somewhere important!)
  - Port #: 5432
  - Select default locale

2. Install pgAdmin
   - Visit [pgadmin](https://pgadmin.org) (https://pgadmin.org) and follow steps to download the latest version .exe

3. Download database (.tar)
   - Download the dvdrental.tar file available in this repo, which is a database that represents a DVD rental store with movies to rent and information on them. **NOTE: Do not open the .tar file directly**

4. Restart computer

5. Restore database
   - Open the pgAdmin 4 app (not the .exe), may take a moment to start up
   - Set a master password (can be the same as the PostgreSQL password)
   - In the pgAdmin browser, find the PostgreSQL 12 server and enter its password
   - Verify connection through the elephant symbol
   - Right click on the server, navigate to "Create" and "Database"
   - Under "General", name the database "dvdrental" - this is just a placeholder until it's linked to dvdrental.tar
   - Right click on the "dvdrental" database under "Databases"
   - Search for the .tar path and select it
   - Navigate to Restore options next to General
   - Select all Sections as "Yes"
   - Select Restore
   - Verify the "Restore job created" window appears

6. Test the database connection
   - Right click on database and select "Query tool"
   - A query editor should pop up. Run a query and select the play button or hit F5 on keyboard
   - Queried table should appear in the "Data Output" console below

[Back to Top](#table-of-contents)
