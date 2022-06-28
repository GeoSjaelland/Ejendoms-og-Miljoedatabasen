SELECT
				Bosaettelse.FRAFLYT_KOMMUNENR AS Fraflytningskommunenr,
				QL60000V.TEKST AS Fraflytningskommune,
				Bosaettelse.KOMMUNENUMMER AS Bopælskommunenr,
				QL60000V_1.TEKST AS Bopælskommune,
				Bosaettelse.PERSONNUMMER,
				CASE
 					WHEN Bosaettelse.PERSONNUMMER > 1000000000
					THEN CAST(LEFT(CONVERT(VARCHAR, Bosaettelse.PERSONNUMMER), 6)+ '-' + RIGHT(CONVERT(VARCHAR, Bosaettelse.PERSONNUMMER), 4) AS VARCHAR(11))
					ELSE CAST('0' + LEFT(CONVERT(VARCHAR, Bosaettelse.PERSONNUMMER), 5) + '-' + RIGHT(CONVERT(VARCHAR, Bosaettelse.PERSONNUMMER), 4) AS VARCHAR(11))
				END AS CPR,
				Borger.FØDSEL_DATO AS Fødselsdato,
CASE
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 0 AND 2
 THEN '0 - 2 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 3 AND 5
 THEN '03 - 05 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) = 6
 THEN '06 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 07 AND 16
 THEN '07 - 16 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 17 AND 25
 THEN '17 - 25 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 26 AND 42
 THEN '26 - 42 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 43 AND 59
 THEN '43 - 59 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 60 AND 64
 THEN '60 - 64 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 65 AND 79
 THEN '65 - 79 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) > 79 THEN 'Over 79 år'
END AS Aldersklasse,
CASE
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 0 AND 5
 THEN '0 - 5 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 6 AND 16
 THEN '06 - 16 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 17 AND 24
 THEN '17 - 24 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 25 AND 44
 THEN '25 - 44 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 45 AND 64
 THEN '45 - 64 år'
 WHEN ((0 + CONVERT(Char(8), 20140107, 112) - CONVERT(Char(8), REPLACE(Borger.FØDSEL_DATO, '-', ''), 112)) / 10000) > 64
 THEN 'Over 64 år'
END AS Aldersklasse2,
				CONVERT(INT, DATEDIFF(d, Borger.FØDSEL_DATO, '20140107') / 365.25) AS Alder,
				CONVERT(INT, DATEDIFF(d,Borger.FØDSEL_DATO, CONVERT(datetime, LEFT(Bosaettelse.ADR_TILFLYT_TS, 10))) / 365.25)  AS Alder_ved_flytning,
				CAST(RTRIM(REVERSE(REPLACE(SUBSTRING(REVERSE(Borger.ADRESSERINGSNAVN), 1, CHARINDEX(',', REVERSE(Borger.ADRESSERINGSNAVN))), ',', '')))+ ' ' + REPLACE(SUBSTRING(Borger.ADRESSERINGSNAVN, 1, CHARINDEX(',', Borger.ADRESSERINGSNAVN)), ',', '') AS VARCHAR(50)) AS Navn,
				Bosaettelse.CO_NAVN, CAST(RTRIM(APU.VejNavn + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(APU.HUS_NR), '0', ' ')), ' ', '0') + ' ' + RTRIM(LTRIM(Bosaettelse.ETAGE))+ ' ' + RTRIM(LTRIM(Bosaettelse.SIDE_DØRNR))) AS VARCHAR(50)) AS Adresse,
				APU.SupByNavn AS Supplerende_bynavn,
				APU.Postnummer,
				APU.PostDistrikt AS Bynavn,
				CAST(APU.Postnummer AS VARCHAR(5)) + ' ' + APU.PostDistrikt AS Postdistrikt,
				CASE
 					WHEN Bosaettelse.ADR_TILFLYT_TS < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(Bosaettelse.ADR_TILFLYT_TS, 10) AS datetime)
				END AS Tilflytningsdato,
				CASE
 					WHEN Bosaettelse.ADR_FRAFLYT_TS > '4713-12-31'
					THEN CAST('4713-12-31' AS datetime)
					ELSE CAST(LEFT(Bosaettelse.ADR_FRAFLYT_TS, 10) AS datetime)
				END AS Fraflytningsdato,
				CASE
 					WHEN Bosaettelse.KOM_TILFLYTDATO < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(Bosaettelse.KOM_TILFLYTDATO, 10) AS datetime)
				END AS Kommunetilflytningsdato,
				CASE
 					WHEN Bosaettelse.KOM_FRAFLYTDATO < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(Bosaettelse.KOM_FRAFLYTDATO, 10) AS datetime)
				END AS Kommunefraflytningsdato,
				CASE
 					WHEN Bosaettelse.CPR_BOSÆT_TS < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime) ELSE CAST(LEFT(Bosaettelse.CPR_BOSÆT_TS, 10) AS datetime)
				END AS CPR_Bosætningsdato,
				Borger.BORGERSTATUS_KODE AS Borgerstatuskode,
				QL58900V.TEKST AS Borgerstatus,
				CASE
 					WHEN Borger.BORGERSTATUS_TS < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(Borger.BORGERSTATUS_TS, 10) AS datetime)
				END AS Borgerstatusdato,
				Borger.LAND_KODE AS Landekode, QL59400V.TEKST AS Land,
				CASE
 					WHEN Borger.STATSB_RET_TS < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(Borger.STATSB_RET_TS, 10) AS datetime)
				END AS Statsborgerret_ændring,
				CASE
 					WHEN Borger.STATBORG_OPHØR_TS > '4713-12-31'
					THEN CAST('4713-12-31' AS datetime)
					ELSE CAST(LEFT(Borger.STATBORG_OPHØR_TS, 10) AS datetime)
				END AS Statsborgerret_Ophør,
				CAST(Bosaettelse.KOMMUNENUMMER AS VARCHAR(3)) + RIGHT('0000' + CONVERT(VARCHAR, Bosaettelse.VEJ_KODE), 4) + RTRIM(Bosaettelse.HUS_NUMMER) AS ADRESSELINK_ID,
				CAST(Bosaettelse.KOMMUNENUMMER AS VARCHAR(3)) + CAST(Bosaettelse.VEJ_KODE AS VARCHAR(4)) + RTRIM(Bosaettelse.HUS_NUMMER) AS ADRESSE_ID,
				CAST(Bosaettelse.KOMMUNENUMMER AS VARCHAR(3)) + CAST(Bosaettelse.VEJ_KODE AS VARCHAR(4)) + RTRIM(Bosaettelse.HUS_NUMMER) + LTRIM(Bosaettelse.ETAGE) + LTRIM(Bosaettelse.SIDE_DØRNR) AS UDVadresseID,
				Borger.PERSONNUMMER_MOR,
				Borger.PERSONNUMMER_FAR
FROM
				QL60000V AS QL60000V_1 RIGHT OUTER JOIN
				AA70100T AS Bosaettelse LEFT OUTER JOIN
				LAND_ADRESSEPUNKT AS APU ON Bosaettelse.HUS_NUMMER = APU.HUS_NR AND Bosaettelse.VEJ_KODE = APU.VejKode AND
				Bosaettelse.KOMMUNENUMMER = APU.KommuneNummer ON QL60000V_1.KODE = Bosaettelse.KOMMUNENUMMER LEFT OUTER JOIN
				QL60000V ON Bosaettelse.FRAFLYT_KOMMUNENR = QL60000V.KODE LEFT OUTER JOIN
				QL59400V RIGHT OUTER JOIN
				AA70000T AS Borger ON QL59400V.KODE = Borger.LAND_KODE LEFT OUTER JOIN
				QL58900V ON Borger.BORGERSTATUS_KODE = QL58900V.KODE ON Bosaettelse.PERSONNUMMER = Borger.PERSONNUMMER INNER JOIN JN67100T ON Bosaettelse.KOMMUNENUMMER = JN67100T.KOMMUNENUMMER

WHERE
				CONVERT(datetime, LEFT(Bosaettelse.ADR_TILFLYT_TS, 10))  <=  '20140107' and CONVERT(datetime, LEFT(Bosaettelse.ADR_FRAFLYT_TS, 10)) > '20140107'