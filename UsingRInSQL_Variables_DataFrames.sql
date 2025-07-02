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
-- must call it 'OutputDataSet'
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

-- full data example
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
OutputDataSet <- InputDataSet
',
@input_data_1 = N'SELECT CountryID, CountryName, Continent, Region, IsoNumericCode
FROM Application.Countries;'
-- need this part to get col names - in order of query, assign datatypes that sql supports
WITH RESULT SETS (([Country ID] int, [Country Name] nvarchar(60), [Continent] nvarchar(30), [Region] nvarchar(30),
[IsoNumericCode] int))

-- selecting data
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
#OutputDataSet <- data.frame(InputDataSet$CountryName)
OutputDataSet <- data.frame(unique(InputDataSet[,c("CountryName","Continent")]))
',
@input_data_1 = N'SELECT CountryID, CountryName, Continent, Region, IsoNumericCode
FROM Application.Countries;'
-- need this part to get col names - in order of query, assign datatypes that sql supports
WITH RESULT SETS ((CountryName nvarchar(60), Continent nvarchar(30)))


-- combining vectors -->
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
ItemName <- InputDataSet[,1]
OldPrice <- InputDataSet[,2]
# example of price with 50% discount
NewPrice <- OldPrice * .5
OutputDataSet <- data.frame(ItemName, OldPrice, NewPrice)
',
@input_data_1 = N'SELECT StockItemName, RecommendedRetailPrice
FROM Warehouse.StockItems
WHERE SupplierID = 1;'
WITH RESULT SETS (([Item Name] nvarchar(100), [Old Price] decimal(8,2), [New Price] decimal(8,2)));

-- subset filter
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
OutputDataSet <- subset(InputDataSet, SupplierID == 1, )
',
@input_data_1 = N' SELECT StockItemName, SupplierID FROM Warehouse.StockItems; '
WITH RESULT SETS (([StockItemName] nvarchar(100), [SupplierID] int))

-- example test - convert C to F temp...
-- formula1, F = (C * 1.8) + 32
-- formula2, C = (F - 32) / 1.8
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
Temp_C <- InputDataSet[,1]
Converted <- (Temp_C * 1.8) + 32
Temp_F <- Converted
OutputDataSet <- data.frame(Temp_C, Temp_F)
',
@input_data_1 = N'SELECT Top 10 Temperature FROM Warehouse.ColdRoomTemperatures'
WITH RESULT SETS (([Temp Celsius] float, [Temp Fahrenheit] decimal(10,2)))


--stored procedure and sample function -->
SELECT colorname from Warehouse.Colors;

--getting 5 random colors
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
# to pick random number from 1 to num of colors avaliable
indexSample <- sample(1:nrow(InputDataSet), 5)
# pick those colors in those positions
OutputDataSet <- data.frame(InputDataSet[indexSample, ])
',
@input_data_1 = N'SELECT ColorName FROM Warehouse.Colors;'
--name column(s)
WITH RESULT SETS (([5 Random Colors] nvarchar(20)))

-- now turn it into a stored procedure!
-- see "UsingRinSQL_storedProcedure.sql"