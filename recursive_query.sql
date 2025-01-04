-- Create Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    ManagerID INT
);

-- Insert Sample Data
INSERT INTO Employees (EmployeeID, Name, ManagerID) VALUES
(1, 'Alice', NULL), -- Alice is the CEO (no manager)
(2, 'Bob', 1),      -- Bob reports to Alice
(3, 'Charlie', 1),  -- Charlie reports to Alice
(4, 'David', 2),    -- David reports to Bob
(5, 'Eve', 2),      -- Eve reports to Bob
(6, 'Frank', 3);    -- Frank reports to Charlie

GO

WITH EmployeeHierarchy AS (
    -- Base Case: Top-level manager
    SELECT 
        e.EmployeeID, 
        e.Name AS EmployeeName, 
        e.ManagerID, 
        CAST(NULL AS VARCHAR(100)) AS ManagerName
    FROM Employees e
    WHERE e.ManagerID IS NULL

    UNION ALL

    -- Recursive Case: Get subordinates
    SELECT 
        e.EmployeeID, 
        e.Name AS EmployeeName, 
        e.ManagerID, 
        CAST(eh.EmployeeName AS VARCHAR(100)) AS ManagerName
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh
    ON e.ManagerID = eh.EmployeeID
)
-- Final Query
SELECT 
    EmployeeID, 
    EmployeeName, 
    ManagerID, 
    ManagerName
FROM EmployeeHierarchy  
