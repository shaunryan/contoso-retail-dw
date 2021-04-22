

CREATE VIEW DaxBook.[Date]
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
                        FiscalYear = [CalendarYear] + CASE WHEN MONTH(Datekey) > 6 THEN 1
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
    SELECT  [Date] = CAST ([Datekey] AS DATE),
            [DateKey] = YEAR(Datekey) * 10000 + MONTH(Datekey) * 100 + DAY(Datekey),
            [Calendar Year Number] = [CalendarYear],
            [Calendar Year] = 'CY ' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Calendar Year Quarter Number] = [CalendarQuarter],
            [Calendar Year Quarter] = [CalendarQuarterLabel] + '-' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Calendar Year Month Number] = [CalendarMonth],
            [Calendar Year Month] = [CalendarMonthLabel] + ' ' + CAST ([CalendarYear] AS VARCHAR(4)),
            [Month Number] = DATEPART(MONTH, [Datekey]),
            [Month] = [CalendarMonthLabel],
            [Day of Week Number] = DATEPART(dw, [Datekey]),
            [Day of Week] = [CalendarDayOfWeekLabel],
            [Fiscal Year Number] = [FiscalYear],
            [Fiscal Year] = 'FY ' + CAST ([FiscalYear] AS VARCHAR(4)),
            [Fiscal Quarter Number] = [FiscalQuarter],
            [Fiscal Quarter] = 'Q' + CAST([FiscalQuarter] AS CHAR(1)),
            [Fiscal Year Quarter Number] = [FiscalYear] * 10 + [FiscalQuarter],
            [Fiscal Year Quarter] = 'Q' + CAST([FiscalQuarter] AS CHAR(1)) + '-' + CAST ([FiscalYear] AS VARCHAR(4)),
            [Fiscal Month Number] = [FiscalMonthNumber],
            [Fiscal Month] = [CalendarMonthLabel],
            [Working Day] = [IsWorkDay],
            [Is Holiday] = [IsHoliday],
            [Holiday Name] = [HolidayName],
            [Europe Season] = [EuropeSeason],
            [North America Season] = [NorthAmericaSeason],
            [Asia Season] = [AsiaSeason]
    FROM    fiscalCalendar

GO

