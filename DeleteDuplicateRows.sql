-- Step 1: Create the table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Step 2: Insert sample data
INSERT INTO Employees (Name, Department, Salary) VALUES
('John Doe', 'IT', 60000), 
('Jane Smith', 'HR', 50000), 
('John Doe', 'IT', 60000),  -- Duplicate
('Alice Johnson', 'Finance', 70000), 
('Jane Smith', 'HR', 50000),  -- Duplicate
('Bob Brown', 'IT', 65000);


-------------

SELECT Name, Department, Salary, COUNT(*) AS CountOfDuplicates
FROM Employees
GROUP BY Name, Department, Salary
HAVING COUNT(*) > 1;


-------------------------
With CTE_Employees  (
 SELECT 
        EmployeeID,
		ROW_NUMBER() OVER (PARTITION BY Name, Department, Salary ORDER BY EmployeeID) AS RowNum
		FROM Employees)

DELETE FROM Employees
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM CTE_Employees
    WHERE RowNum > 1
);


	


		    
    

