-- see what continents to pick form -->
CREATE PROCEDURE ContinentChoices

AS

EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
OutputDataSet <- InputDataSet
',
@input_data_1 = N'SELECT Distinct Continent
FROM Application.Countries;'
WITH RESULT SETS (( [Continent] nvarchar(36) ))


-- now can check choices and then use it to filter ->

-- View available continent choices
EXEC ContinentChoices;

-- Declare and set your continent of interest
DECLARE @MyPick NVARCHAR(36);
SET @MyPick = 'Africa';
-- Use the selected continent to filter results
EXEC ContinentPick @userPick = @MyPick;

