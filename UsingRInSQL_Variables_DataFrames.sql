-- Variables in T-SQL
DECLARE @MyValue int;
SET @MyValue = 23;
SELECT @MyValue as Number;

-- Variables in R
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
MyValue <- 23
print(MyValue)
'

EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
MyValue <- c(23, 26, 32)
cat("my original values are: ", MyValue,"\n")
# update values
MyValue[1] <- 100
MyValue[4] <- 96
MyValue[5] <- MyValue[4]+100
MyValue <- as.integer(MyValue)
cat("my new values are: ", MyValue,"\n")
print(paste("my 2nd value is: ",MyValue[2]))
# check type
print(typeof(MyValue))
'

-- importing data -->
-- template
EXEC sp_execute_external_script
@language = N'R',
@script = N'
# script here
',
@input_data_1 = N' -- sql query to get data from database here'

-- Query data from the Wide World Importers database
SELECT CountryID, CountryName, Continent, Region, IsoNumericCode
FROM Application.Countries;

-- Print a data frame to the messages window
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
print(InputDataSet)
',
@input_data_1 = N'SELECT CountryID, CountryName, Continent, Region, IsoNumericCode
FROM Application.Countries;'

-- Print structure of data frame
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
print(str(InputDataSet))
',
@input_data_1 = N'SELECT CountryID, CountryName, Continent, Region, IsoNumericCode
FROM Application.Countries;'

-- Print summary of data frame
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
print(summary(InputDataSet))
',
@input_data_1 = N'SELECT CountryID, CountryName, Continent, Region, IsoNumericCode
FROM Application.Countries;'


-- getting data back to sql server to use
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
# limiting results for now
QuickLook <- head(InputDataSet)
print(QuickLook)
# assigning to OutputDataSet (must be data.frame())
OutputDataSet <- QuickLook
',
@input_data_1 = N'SELECT CountryID, CountryName, Continent, Region, IsoNumericCode
FROM Application.Countries;'
-- need this part to get col names - in order of query, assign datatypes that sql supports
WITH RESULT SETS (([Country ID] int, [Country Name] nvarchar(60), [Continent] nvarchar(30), [Region] nvarchar(30),
[IsoNumericCode] int))







-- Convert Celsius to Fahrenheit
EXEC sp_execute_external_script
@language = N'R',
@script = N'
Celsius <- InputDataSet[,1]
Fahrenheit <- (Celsius * 1.8) + 32
OutputDataSet <- data.frame(Celsius, Fahrenheit)
',
@input_data_1 = N'SELECT Temperature FROM Warehouse.ColdRoomTemperatures;'
WITH RESULT SETS (([Degrees C] decimal(10,2), [Degrees F] decimal(10,2)));


-- Another approach does the same thing on a single line. Try:
-- OutputDataSet <- data.frame(InputDataSet[,1], (InputDataSet[,1] * 1.8) + 32)