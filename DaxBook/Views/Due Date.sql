
CREATE VIEW DaxBook.[Due Date]
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
    SELECT  [Due Date] = CAST ([Datekey] AS DATE),
            [Due DateKey] = YEAR(Datekey) * 10000 + MONTH(Datekey) * 100 + DAY(Datekey),
            [Due Year Number] = [CalendarYear],
            [Due Year] = 'EY ' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Due Year Quarter Number] = [CalendarQuarter],
            [Due Year Quarter] = [CalendarQuarterLabel] + '-' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Due Year Month Number] = [CalendarMonth],
            [Due Year Month] = [CalendarMonthLabel] + ' ' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Due Month Number] = DATEPART(MONTH, [Datekey]),
            [Due Month] = [CalendarMonthLabel]
    FROM    fiscalCalendar

GO

