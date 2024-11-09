CREATE DATABASE ToDoList;
USE ToDoList;
--CREATE TABLE 
--SHOW TABLE
SHOW TABLES;
SELECT*FROM tasks;
--filter tasks based on status or priority:
SELECT * FROM tasks 
WHERE status = 'pending';
SELECT *FROM tasks
 WHERE priority='medium';
 --When a task is completed, update the status:
 UPDATE tasks
 SET status='completed'
 WHERE task_id=1;
 
 --: View Only Task Names and Statuses
 SELECT task_name , status
 FROM tasks;

--View Tasks Due in the Next 7 Days
SELECT *FROM tasks
WHERE due_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURDATE(),INTERVAL 7 DAY); 
--Count of Tasks by Status
SELECT status , COUNT(*) AS task_status
FROM tasks
GROUP BY status;

--View Overdue Tasks
SELECT*FROM tasks
WHERE due_date < CURDATE() AND status='pending';

--View Tasks by Priority (Sorted)
SELECT *FROM tasks
ORDER BY FIELD(priority,'high','medium','low'),due_date;

--MOst recently added task 
SELECT * FROM tasks
ORDER BY created_at DESC
LIMIT 1;

-- Count of Tasks by Due Date
SELECT due_date, COUNT(*) AS task_count
FROM tasks
GROUP BY due_date
ORDER BY due_date;