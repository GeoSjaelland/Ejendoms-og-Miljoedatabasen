-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-------------						Beregner antal borgere								-------------
-------------						Dag, måned eller år								-------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

-- sæt kommunenummer
Declare @komkode int = 336


-- sæt startdato og Tidsantal og tidsenhed
Declare  @StartDate DATE = '20210101'
		,@TidAntal INT = 365
		,@TidEnhed varchar(5) = 'DAY' -- DAY, MONTH eller YEAR


-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------


declare @Table table (
		Datofra varchar(26)
		,DatoTil varchar(26)
		,Dato date
		,Antal int
		)

DECLARE @CutoffDate DATE
Set @CutoffDate = CASE @TidEnhed
					when 'DAY' then DATEADD(DAY, @TidAntal, @StartDate)
					when 'MONTH' then DATEADD(MONTH, @TidAntal, @StartDate)
					when 'YEAR' then DATEADD(YEAR, @TidAntal, @StartDate)
					END

IF @TidEnhed = 'DAY'
INSERT into @Table
SELECT null,null,d,null
FROM
(
  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
  FROM
  (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate))
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    ORDER BY s1.[object_id]
  ) AS x
) AS y;

ELSE IF @TidEnhed = 'MONTH'
INSERT into @Table
SELECT null,null,d,null
FROM
(
  SELECT d = DATEADD(MONTH, rn - 1, @StartDate)
  FROM
  (
    SELECT TOP (DATEDIFF(MONTH, @StartDate, @CutoffDate))
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    ORDER BY s1.[object_id]
  ) AS x
) AS y;

ELSE IF @TidEnhed = 'YEAR'
INSERT into @Table
SELECT null,null,d,null
FROM
(
  SELECT d = DATEADD(YEAR, rn - 1, @StartDate)
  FROM
  (
    SELECT TOP (DATEDIFF(YEAR, @StartDate, @CutoffDate))
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    ORDER BY s1.[object_id]
  ) AS x
) AS y;

update @Table
Set Datofra = convert(varchar,Dato) + '-00.00.00.000000'
	,DatoTil = convert(varchar,dateadd(DAY,1,Dato)) + '-00.00.00.000000'


Update h
set Antal = (Select count(*) from AA70100T where KOMMUNENUMMER = @komkode and ADR_TILFLYT_TS <= h.Datofra and ADR_FRAFLYT_TS > h.DatoTil )
from @Table h
where Dato <= getdate()


Select Dato, Antal from @Table