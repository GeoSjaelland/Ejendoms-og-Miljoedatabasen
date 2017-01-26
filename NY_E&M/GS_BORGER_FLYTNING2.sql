SELECT
				A.FRAFLYT_KOMMUNENR AS Fraflytningskommunenr, dbo.QL60000V.TEKST AS Fraflytningskommune,
				A.KOMMUNENUMMER AS Bopælskommunenr,
				QL60000V_1.TEKST AS Bopælskommune, A.PERSONNUMMER,
				dbo.udf_FormatCPR(A.PERSONNUMMER) AS CPR,
				B.FØDSEL_DATO AS Fødselsdato, CONVERT(INT, DATEDIFF(d, B.FØDSEL_DATO, GETDATE()) / 365.25) AS Alder,
				CAST(RTRIM(REVERSE(REPLACE(SUBSTRING(REVERSE(B.ADRESSERINGSNAVN), 1, CHARINDEX(',', REVERSE(B.ADRESSERINGSNAVN))), ',', ''))) + ' ' + REPLACE(SUBSTRING(B.ADRESSERINGSNAVN, 1, CHARINDEX(',', B.ADRESSERINGSNAVN)), ',', '') AS VARCHAR(50)) AS Navn,
				A.CO_NAVN, CAST(RTRIM(dbo.JY72000V.VEJADRNAVN + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(dbo.JY72000V.HUS_NR), '0', ' ')), ' ', '0') + ' ' + RTRIM(LTRIM(A.ETAGE)) + ' ' + RTRIM(LTRIM(A.SIDE_DØRNR))) AS VARCHAR(50)) AS Adresse,
				dbo.JY72000V.SUPBYNAVN AS Supplerende_bynavn,
				dbo.JY72000V.POSTNR AS Postnummer,
				dbo.JY72000V.POSTBYNAVN AS Bynavn,
				CAST(dbo.JY72000V.POSTNR AS VARCHAR(5)) + ' ' + dbo.JY72000V.POSTBYNAVN AS Postdistrikt,
				dbo.JY72000V.BYGNAVN AS Bygningsnavn,
				CASE
					WHEN A.ADR_TILFLYT_TS < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(A.ADR_TILFLYT_TS, 10) AS datetime)
				END AS Tilflytningsdato,
				CASE
					WHEN A.ADR_FRAFLYT_TS > '4713-12-31'
					THEN CAST('4713-12-31' AS datetime)
					ELSE CAST(LEFT(A.ADR_FRAFLYT_TS, 10) AS datetime)
				END AS Fraflytningsdato,
				CASE
					WHEN A.KOM_TILFLYTDATO < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(A.KOM_TILFLYTDATO, 10) AS datetime)
				END AS Kommunetilflytningsdato,
				CASE
					WHEN A.KOM_FRAFLYTDATO < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(A.KOM_FRAFLYTDATO, 10) AS datetime)
				END AS Kommunefraflytningsdato,
				CASE
					WHEN A.CPR_BOSÆT_TS < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(A.CPR_BOSÆT_TS, 10) AS datetime)
				END AS CPR_Bosætningsdato,
				B.BORGERSTATUS_KODE AS Borgerstatuskode,
				dbo.QL58900V.TEKST AS Borgerstatus,
				CASE
					WHEN B.BORGERSTATUS_TS < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(B.BORGERSTATUS_TS, 10) AS datetime)
				END AS Borgerstatusdato,
				B.LAND_KODE AS Landekode,
				dbo.QL59400V.TEKST AS Land,
				CASE
					WHEN B.STATSB_RET_TS < '1753-01-01'
					THEN CAST('1753-01-01' AS datetime)
					ELSE CAST(LEFT(B.STATSB_RET_TS, 10) AS datetime)
				END AS Statsborgerret_ændring,
				CASE
					WHEN B.STATBORG_OPHØR_TS > '4713-12-31'
					THEN CAST('4713-12-31' AS datetime)
					ELSE CAST(LEFT(B.STATBORG_OPHØR_TS, 10) AS datetime)
				END AS Statsborgerret_Ophør,
				CAST(A.KOMMUNENUMMER AS VARCHAR(3)) + RIGHT('0000' + CONVERT(VARCHAR, A.VEJ_KODE), 4) + RTRIM(A.HUS_NUMMER) AS ADRESSELINK_ID,
				CAST(A.KOMMUNENUMMER AS VARCHAR(3)) + CAST(A.VEJ_KODE AS VARCHAR(4)) + RTRIM(A.HUS_NUMMER) AS ADRESSE_ID,
				CAST(A.KOMMUNENUMMER AS VARCHAR(3)) + CAST(A.VEJ_KODE AS VARCHAR(4)) + RTRIM(A.HUS_NUMMER) + LTRIM(A.ETAGE) + LTRIM(A.SIDE_DØRNR) AS UDVadresseID,
				 B.PERSONNUMMER_MOR,
				 B.PERSONNUMMER_FAR

FROM
				dbo.QL60000V RIGHT OUTER JOIN
        dbo.AA70100T AS A LEFT OUTER JOIN
        dbo.QL60000V AS QL60000V_1 ON A.KOMMUNENUMMER = QL60000V_1.KODE LEFT OUTER JOIN
        dbo.JY72000V ON A.VEJ_KODE = dbo.JY72000V.VEJKODE AND A.KOMMUNENUMMER = dbo.JY72000V.KOMMUNENUMMER AND
        A.HUS_NUMMER = dbo.JY72000V.HUS_NR ON dbo.QL60000V.KODE = A.FRAFLYT_KOMMUNENR LEFT OUTER JOIN
        dbo.QL59400V RIGHT OUTER JOIN
        dbo.AA70000T AS B ON dbo.QL59400V.KODE = B.LAND_KODE LEFT OUTER JOIN
        dbo.QL58900V ON B.BORGERSTATUS_KODE = dbo.QL58900V.KODE ON A.PERSONNUMMER = B.PERSONNUMMER
