# common notes

- change directory after connecting mysql use following command
    ```sql
    system cd /home/mfyounus    
    ```
 

Notes from <<High Performance MyQSL, 3rd Edition>>

## Logical Architecture

<img src='../img/mysql.png'>

## Concurrency Control

- mysql use read/write lock to prevent corruption.

## LOCK GRANULARITY

- table locks
    the server uses a table-level lock for statements such as ALTER TABLE, regardless of the storage engine. 
- row locks
     Row-level locking is available in the InnoDB and XtraDB storage engines  
     Row locks are implemented in the storage engine, not the server. The server is completely unaware of locks implemented in the storage engines.

## Transactions(事物)

> A transaction is a group of SQL queries that are treated atomically, as a single unit of work. If the database engine can apply the entire group of queries to a database, it does so, but if any of them can’t be done because of a crash or other reason, none of them is applied. It’s all or nothing.

- start a transaction with the `START TRANSACTION` statement and make changes permanent with `COMMIT` or discard with `ROLLBACK`.
    ```sql
    START TRANSACTION;
    SELECT balance FROM checking WHERE customer_id = 10233276;
    UPDATE checking SET balance = balance - 200.00 WHERE customer_id = 10233276;
    UPDATE savings  SET balance = balance + 200.00 WHERE customer_id = 10233276;
    COMMIT;
    ``` 

## Transactions in MySQL

- two storage in MySQL: InnoDB and NDB Cluster.



# MySQL Tutorial

## Normalization

> The normalization process consists of breaking tables into smaller tables that form a better design.

### First Normal Form(1NF)

> each attribute or column value must be atomic. That is, each attribute must contain a single value, not a set of values or another database row. 

### Second Normal Form

> all attributes that are not part of the primary key are fully functionally dependent on the primary key. That is, if the primary key is made up of multiple columns, every other attribute in the table must be dependent on the combination of these columns. (完全依赖于主键[组合])

### Third Normal Form

> Formally, for a schema to be in third normal form (3NF), we must remove all transitive dependencies, and the schema must already be in second normal form.(去除传递性依赖)

1. Normalization is a formal process for improving database design.

2. First normal form (1NF) means atomic column or attribute values.

3. Second normal form (2NF) means that all attributes outside the key must depend on the whole key.

4. Third normal form (3NF) means no transitive dependencies.

5. Boyce-Codd normal form (BCNF) means that all attributes must be functionally determined by a superkey.

## create database and table

```sql
create database dbname;
create table tbname [( table definition )] [engine=table_type];
```

<img src='../img/sql_create.png'>

- foreign key: declare by using `references`
    ```sql
    departmentID int not null references department(departmentID)
    ``` 
- declare primary key with multiple column:
    ```sql
    primary key (employeeID, skill)
    ``` 
- The `TEMPORARY` keyword is used to create a table that will be visible only in your current database session, and that will be automatically deleted when your connection is closed. 
- use the `LIKE` old_table_name clause to create a new table with the same schema as old_table_name. 
    ```sql
    CREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name LIKE old_table_name;
    ``` 
- The default is that columns may contain NULLs
- declare a default value for a column using the `DEFAULT` keyword followed by the default value we want.
- can have only one `AUTO_INCREMENT` column per table, and it must be indexed
- some were automatically created for us. Indexes are automatically created for columns that are declared as `PRIMARY KEY`
- UNIQUE can be used to specify that a particular column must contain unique values. UNIQUE columns will also be indexed.
- default table engine: `MyISAM`
- InnoDB is the ACID-compliant storage engine that supports transactions, foreign keys, and row-level locking.
  

## Column and Data Types in MySQL

- three basic types in MySQL:
    - numerical
    - string and text
    - date and time

- Numerical
    ```sql
    salary decimal(10, 2)
    ``` 
    display width of 10 with two digits after the decimal point.

    - may also be followed by the keywords UNSIGNED and/or ZEROFILL. 
    - DECIMAL may also be abbreviated to DEC. 
    - INTEGER can be abbreviated as INT, stored in 4 bytes, giving a range of 232 possible values
    - TINYINT is 1 byte, sunonyms as BIT and BOOL
    - SMALLINT is 2 bytes 
    - MEDIUMINT is 3 bytes
    - BIGINT is 8 bytes 
    - FLOAT, DOUBLE
- String and Text Types
    - CHAR
        - store fixed-length strings, usually followed by a string length
        - If you do not specify a length, you will get a CHAR(1).
        - CHAR and VARCHAR can both be followed by the keyword `BINARY`, meaning that they should be treated as case sensitive when evaluating string comparisons. The default is for strings to be compared in a case insensitive fashion. 
    - VARCHAR
        - stores variable-length strings.
    - TEXT, BLOB and Variations
        - the TEXT types are used for storing longer pieces of text than you can fit in a CHAR or VARCHAR
        - BLOB stands for Binary Large OBject. 
        - These types are the same except that BLOBs are intended to store binary data rather than text.
        - Comparisons on BLOBs are case sensitive, and on TEXTs, they are not.
        - TINYTEXT or TINYBLOB can hold up to 255 (that's 28-1) characters or bytes.
        - TEXT or BLOB can hold up to 65,535 (216-1) characters or bytes (64KB).
        - MEDIUMTEXT or MEDUIMBLOB can hold up to 16,777,215 (224-1) characters or bytes (16MB).
        - LONGTEXT or LONGBLOB can hold up to 4,294,967,295 (232-1) characters or bytes (4GB).
        - ENUM
            declare as: 
            ```sql
            gender enum('m', 'f')
            ``` 
    - SET
        - TODO ??
- Date and Time Types
    - DATE
        - Dates are displayed as YYYY-MM-DD. 
    - TIME
        - displayed as HH:MM:SS.
    - DATETIME
        - The format is YYYY-MM-DD HH:MM:SS. 
    - TIMESTAMP
        - If you do not set this column in a particular row, or set it to NULL, it will store the time that row was inserted or last changed. 
        - When you retrieve a timestamp, it will be displayed in the DATETIME format. 
        - YEAR
  
## Create Indexes

> Any column declared as PRIMARY KEY, KEY, UNIQUE, or INDEX will be indexed. 
```sql
create index name on employee(name);
```
- limit indexes on char and varchar types to index just the first few characters in each field. You can do this by specifying the number of characters you want to be indexed in parentheses after the name of the index column, for example, 
    ```sql
    create index part_name on employee(name(5));
    ``` 
    indexes on text types are not as efficient as indexes on numeric types, and just indexing the first few characters improves performance. 

## Deleting Databases, Tables and Indexes

```sql
drop database employee;
drop table assignment;

DROP [TEMPORARY] TABLE [IF EXISTS] tbl_name [, tbl_name,...]

drop index part_name on employee;
```

## Altering Existing Table

```sql
alter table employee
add index name (name);
```

<img src='../img/sql_alter.png'>

- DISABLE KEYS clause tells MySQL to stop updating indexes for a MyISAM table only. ENABLE KEYS turns index updating back on. 

## Using INSERT

<img src='../img/sql_insert.png'>

## Using DELETE

<img src='../img/sql_delete.png'>

## Using TRUNCATE

```sql
TRUNCATE TABLE employee;
```
delete all the rows from a table. TRUNCATE is not transaction safe.

## Using UPDATE

<img src='../img/sql_update.png'>

## Uploading Data with LOAD

<img src='../img/sql_upload.png'>

- LOCAL, meaning that the data file is on the client machine. If this is not specified, MySQL will look for the infile on the server.
- If you have key clashes while inserting data, REPLACE and IGNORE provide two methods for dealing with this. Specifying REPLACE tells MySQL to replace the old row with the new row, while IGNORE tells MySQL to keep the old row.
- The values in the general form are the defaultseach row on a new line, column values separated by tabs
- The IGNORE number LINES clause tells MySQL to ignore the first number lines in the infile.
- The final clause allows you to specify that you only want to read data into some of the table's columns

# Chapter 6. Querying MySQL

## Aliases

rename columns or expressions in a SELECT statement, and the new name will be what is shown in the output.
```sql
select name as employeeName
from employee;
```
- as is optional
    ```sql
    select name employeeName
    from employee;

    select e.name
    from employee e;
    ``` 

## WHERE

- cannot use any column aliases in the WHERE clause.

## Removing Duplicates with DISTINCT

## Using the GROUP BY Clause

- consider retrieved rows in groups
- useful when we use it in combination with functions that operate over a group of rows
- sort the group order in which the results are presented by ASC/DESC. The default order is ascending
- A GROUP BY with a HAVING clause is like a SELECT with a WHERE clause. For example: 
    ```SQL
    select count(*), job from employee
    group by job having count(*)=1;
    ```

## Sorting Search Results with ORDER BY

- sort the result rows on one or more columns. The sort can be either ascending
    ```sql
    select * from employee
    order by job asc, name desc;
    ``` 

# LIMIT

- When we pass two parameters to limit, the first parameter is the offset (start point) and the second parameter is the maximum number of rows we would like returned.

    ```sql
    select *
    from employeeSkills
    limit 5, 3;
    ```

## Summary
- SELECT statement:
    ```sql
    SELECT columns
    FROM tables
    [WHERE conditions]
    [ GROUP　BY group 
        [HAVING group_conditions ] 
    ]
    [ORDER BY sort_columns]
    [LIMIT limits];`
    ``` 

# Chapter 7. Advanced Queries

