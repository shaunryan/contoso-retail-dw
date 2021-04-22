


CREATE VIEW DaxBook.[Delivery Date]
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
    SELECT  [Delivery Date] = CAST ([Datekey] AS DATE),
            [Delivery DateKey] = YEAR(Datekey) * 10000 + MONTH(Datekey) * 100 + DAY(Datekey),
            [Delivery Year Number] = [CalendarYear],
            [Delivery Year] = 'DY ' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Delivery Year Quarter Number] = [CalendarQuarter],
            [Delivery Year Quarter] = [CalendarQuarterLabel] + '-' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Delivery Year Month Number] = [CalendarMonth],
            [Delivery Year Month] = [CalendarMonthLabel] + ' ' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Delivery Month Number] = DATEPART(MONTH, [Datekey]),
            [Delivery Month] = [CalendarMonthLabel]
    FROM    fiscalCalendar

GO

