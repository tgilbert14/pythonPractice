
-- to crate stored Procedure by adding -->
/*
CREATE PROCEDURE RandomColors
AS
-- we can also add parameters as well with @ inbetween -->
CREATE PROCEDURE RandomColors
    @Count int
AS
---------------------------------------------------------->

--getting 5 random colors (original)
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
*/


-- Create a stored procedure
CREATE PROCEDURE RandomColors
	@Count int
AS

EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
indexSample <- sample(1:nrow(InputDataSet), num)
OutputDataSet <- data.frame(InputDataSet[indexSample, ])
',
@input_data_1 = N'SELECT ColorName FROM Warehouse.Colors;',
@params = N' @num int', --notice the 'num' replaces the '5' variable from before
@num = @Count
WITH RESULT SETS (([Colors] nvarchar(20)))


-- Execute the stored procedure
--EXEC RandomColors @Count = 2


