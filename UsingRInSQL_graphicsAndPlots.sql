-- graphics

-- find outputs for when creating an image -->
-- generates new working dir for each query which gets deleted after run..
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
print(getwd())
'
-- so need to output to parent folder -->
-- Create an X-Y Plot
EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
XAxis <- c(1,2,3,4,5)
YAxis <- c(20,96,36,84,35)
MyData <- data.frame(XAxis, YAxis)
png(filename = "../MyPlot.png")
plot(MyData)
dev.off()
'

--actually found here, the one shown is actually a shortcut to here...
-- "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\ExtensibilityData\Appcontainer1\MyPlot.png"

EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
pdf(file="../Countries.pdf", width = 11, height = 6 )
par(mai=c(1, 2.5, .5, .5))
barplot(
    height = InputDataSet[,2],
    main = "Countries per Continent",
    xlab = "Number of Countries",
    names.arg = InputDataSet[,1],
    col = "cadetblue",
    horiz = TRUE,
    las = 1
)
dev.off()
',
@input_data_1 = N'
SELECT Continent, COUNT(CountryName) AS NumberOfCountries
FROM Application.Countries
GROUP BY Continent
ORDER BY COUNT(CountryName) DESC;
'

-- creating pie chart -->
-- Percent of countries in each region
SELECT Region,
    CAST(COUNT(CountryID) AS float)
        / CAST((SELECT COUNT(CountryID) FROM Application.Countries) AS float)
    AS PercentOfCountries
FROM Application.Countries
GROUP BY Region
ORDER BY PercentOfCountries DESC;

/*
#pie() examples from R
n <- 200
pie(rep(1, n), labels = "", col = rainbow(n), border = NA,
    main = "pie(*, labels=\"\", col=rainbow(n), border=NA,..")

## Another case showing pie() is rather fun than science:
## (original by FinalBackwardsGlance on http://imgur.com/gallery/wWrpU4X)
pie(c(Sky = 78, "Sunny side of pyramid" = 17, "Shady side of pyramid" = 5),
    init.angle = 315, col = c("deepskyblue", "yellow", "yellow3"), border = FALSE)
*/

EXECUTE sp_execute_external_script
@language = N'R',
@script = N'
pdf(file="../CountriesPieChart_2.pdf", width = 8, height = 8)
graphics::pie(
    x = InputDataSet$PercentOfCountries,
    labels = InputDataSet$Region,
    radius = 0.8,
    edges = 75,
    clockwise = TRUE,
    col = c("thistle", "cadetblue", "slateblue", "seagreen", "orange", "purple"),
    main = "Percent of Countires in Each Region",
    sub = "from Wide World Importers Database"
)
dev.off()
',
@input_data_1 = N'
SELECT Region,
    CAST(COUNT(CountryID) AS float)
        / CAST((SELECT COUNT(CountryID) FROM Application.Countries) AS float)
    AS PercentOfCountries
FROM Application.Countries
GROUP BY Region
ORDER BY PercentOfCountries DESC;

'