
/* 
Creating the database and initializing the schema layers 

Script Purpose - 
    It is used to create a new database named 'DataWarehouse' inside Microsoft SQL server and 
    add three schema layers (bronze, silver and gold). 

Warning -
    This will delete the previous DataWarehouse database if present and all those data will be deleted.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO