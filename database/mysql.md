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