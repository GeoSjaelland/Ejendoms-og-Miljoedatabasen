Declare  @StartDate DATE = '20190102'

SELECT
				GS_BORGER_FLYTNING.*,
				DATEDIFF(d, GS_BORGER_FLYTNING.Fødselsdato, @StartDate) / 365.25 AS Alder_v_udtræk
FROM
				GS_BORGER_FLYTNING INNER JOIN
				JN67100T ON GS_BORGER_FLYTNING.Bopælskommunenr = JN67100T.KOMMUNENUMMER

WHERE
				Tilflytningsdato< @StartDate and Fraflytningsdato>@StartDate
