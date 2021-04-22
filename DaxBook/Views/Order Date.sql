
CREATE VIEW DaxBook.[Order Date]
AS
WITH    fiscalCalendar
          AS ( SELECT   Datekey,
                        FullDateLabel,
                        DateDescription,
                        CalendarYear,
                        CalendarYearLabel,
                        CalendarHalfYear,
                        CalendarHalfYearLabel,
                        CalendarQuarter,
                        CalendarQuarterLabel,
                        CalendarMonth,
                        CalendarMonthLabel,
                        CalendarWeek,
                        CalendarWeekLabel,
                        CalendarDayOfWeek,
                        CalendarDayOfWeekLabel,
                        FiscalYear = [CalendarYear] + CASE WHEN [CalendarMonth] > 6 THEN 1
                                                           ELSE 0
                                                      END,
                        FiscalQuarter = ( ( MONTH(Datekey) - 1 ) / 3 + 2 ) % 4 + 1,
                        FiscalMonthNumber = ( MONTH(Datekey) + 5 ) % 12 + 1,
                        IsWorkDay,
                        IsHoliday,
                        HolidayName,
                        EuropeSeason,
                        NorthAmericaSeason,
                        AsiaSeason
               FROM     dbo.DimDate
             )
    SELECT  [Order Date] = CAST ([Datekey] AS DATE),
            [Order DateKey] = YEAR(Datekey) * 10000 + MONTH(Datekey) * 100 + DAY(Datekey),
            [Order Year Number] = [CalendarYear],
            [Order Year] = 'OY ' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Order Year Quarter Number] = [CalendarQuarter],
            [Order Year Quarter] = [CalendarQuarterLabel] + '-' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Order Year Month Number] = [CalendarMonth],
            [Order Year Month] = [CalendarMonthLabel] + ' ' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Order Month Number] = DATEPART(MONTH, [Datekey]),
            [Order Month] = [CalendarMonthLabel]
    FROM    fiscalCalendar

GO

