-- checking packages in R / SQL -->

-- View default library path for R packages (base folder location)
EXECUTE sp_execute_external_script
    @language = N'R',
    @script = N'
    OutputDataSet <- data.frame(.libPaths());
    '
WITH RESULT SETS (([DefaultLibraryName] varchar(max)));


-- View installed packages
EXECUTE sp_execute_external_script
    @language = N'R',
    @script = N'
    OutputDataSet <- data.frame(installed.packages()[ ,c("Package", "Version")])
    '
WITH result sets(([Package] nvarchar(255), [Version] nvarchar(100)));

