-- create new stored procedure to filter data to continent of user choosing
CREATE PROCEDURE ContinentPick
	@userPick NVARCHAR(36)
AS

EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
OutputDataSet <- subset(InputDataSet, Continent == cPick, )
',
@input_data_1 = N'SELECT CountryName, Continent
FROM Application.Countries;',
@params = N' @cPick NVARCHAR(36)',
@cPick = @userPick
WITH RESULT SETS (( [CountryName] nvarchar(36), [Continent] nvarchar(36) ))


-- Execute the stored procedure
--EXEC ContinentPick @userPick  = "Asia"

