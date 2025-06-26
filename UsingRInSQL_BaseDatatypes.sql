-- looking at database -->
--SELECT Top 10 * from Application.Cities;
--SELECT * from sys.fn_my_permissions(NULL, 'DATABASE');

-- enable external scripts (had to add to sql install the run this below) -->
--EXEC sp_configure 'external scripts enabled', 1;
--RECONFIGURE WITH OVERRIDE;

-- examples -->
EXECUTE sp_execute_external_script @language = N'R'
    , @script = N'
a <- 1
b <- 2
c <- a/b
d <- a*b
print(c(c, d))
'

EXECUTE sp_execute_external_script @language = N'R'
    , @script = N'OutputDataSet<-InputDataSet'
    , @input_data_1 = N'SELECT 2 AS hello'
WITH RESULT SETS(([Hello World] INT));
GO

-- looking at data types --> 

-- R data type for text
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
print(typeof("Hello World"))
'

-- R data type for decimal values
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
print(typeof(10.5))
'

-- R data type for integer data -->
-- R defaults to double
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
print(typeof(10))
'
-- from double to int
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
print(typeof(10))
print(typeof(as.integer(10)))
cat("or...\n")
print(typeof(10L))
cat("check if is int...\n")
print(is.integer(10))
print(is.integer(10L))
'

-- Floating point math with large and small values
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
cat("...these are examples of math...\n")
print(paste0("[2^-63 + 1 - 1] = ", 2^-63 + 1 - 1))
print(paste0("[(2^-63 + 1) - 1)] = ", (2^-63 + 1) - 1))
print(paste0("[2^-63 + (1 - 1)] = ", 2^-63 + (1 - 1)))
'