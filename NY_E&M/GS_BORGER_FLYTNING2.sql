SELECT

				A.KOMMUNENUMMER AS Kommunenummer,
				A.PERSONNUMMER AS Personnummer,
				udf_FormatCPR(A.PERSONNUMMER) AS CPR,
				B.F�DSEL_DATO AS F�dselsdato,
				CONVERT(INT, DATEDIFF(d, B.F�DSEL_DATO, GETDATE()) / 365.25) AS Alder,
				CAST(RTRIM(REVERSE(REPLACE(SUBSTRING(REVERSE(B.ADRESSERINGSNAVN), 1, CHARINDEX(',', REVERSE(B.ADRESSERINGSNAVN))), ',', ''))) + ' ' + REPLACE(SUBSTRING(B.ADRESSERINGSNAVN, 1, CHARINDEX(',', B.ADRESSERINGSNAVN)), ',', '') AS VARCHAR(50)) AS Navn,
				A.CO_NAVN,
				CAST(RTRIM(JY72000V.VEJADRNAVN + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(JY72000V.HUS_NR), '0', ' ')), ' ', '0') + ' ' + RTRIM(LTRIM(A.ETAGE)) + ' ' + RTRIM(LTRIM(A.SIDE_D�RNR))) AS VARCHAR(50)) AS Adresse,
				JY72000V.SUPBYNAVN AS Supplerende_bynavn,
				JY72000V.POSTNR AS Postnummer, JY72000V.POSTBYNAVN AS Bynavn,
				CAST(JY72000V.POSTNR AS VARCHAR(5)) + ' ' + JY72000V.POSTBYNAVN AS Postdistrikt,
				JY72000V.BYGNAVN AS Bygningsnavn,
 				CASE WHEN A.ADR_TILFLYT_TS < '1753-01-01' THEN CAST('1753-01-01' AS date) ELSE CAST(LEFT(A.ADR_TILFLYT_TS,10) AS date) END AS Tilflytningsdato,
 				CASE WHEN A.ADR_FRAFLYT_TS < '1753-01-01' THEN CAST('1753-01-01' AS date) ELSE CAST(LEFT(A.ADR_FRAFLYT_TS,10) AS date) END AS Fraflytningsdato,
				CASE WHEN A.KOM_TILFLYTDATO < '1753-01-01' THEN CAST ('1753-01-01' AS date) ELSE CAST(A.KOM_TILFLYTDATO AS date) END AS Kommunetilflytningsdato,
				CASE WHEN A.KOM_FRAFLYTDATO < '1753-01-01' THEN CAST ('4713-12-31' AS date) ELSE CAST(A.KOM_FRAFLYTDATO AS date) END AS Kommunefraflytningsdato,
				CASE WHEN A.CPR_BOS�T_TS < '1753-01-01' THEN CAST ('1753-01-01' AS date) ELSE CAST(A.CPR_BOS�T_TS AS date) END AS CPR_Bos�tningsdato,
				B.BORGERSTATUS_KODE,
				QL58900V.TEKST AS Borgerstatus,
				A.FRAFLYT_KOMMUNENR,
				QL60000V.TEKST AS Fraflytningskommune,
				B.LAND_KODE,
				QL59400V.TEKST AS Land,
				CASE WHEN B.STATSB_RET_TS < '1753-01-01' THEN CAST ('1753-01-01' AS date) ELSE CAST(LEFT(B.STATSB_RET_TS,10) AS date) END AS Statsborgerret_�ndring,
				CASE WHEN B.STATBORG_OPH�R_TS > '4713-12-31' THEN CAST ('4713-12-31' AS date) ELSE CAST(LEFT(B.STATBORG_OPH�R_TS,10) AS date) END AS Statsborgerret_Oph�r,
				CAST(dbo.A.KOMMUNENUMMER AS VARCHAR(3))+ RIGHT('0000' + CONVERT(VARCHAR, dbo.A.VEJ_KODE), 4) + RTRIM(dbo.A.HUS_NUMMER) AS ADRESSELINK_ID,
	      CAST(dbo.A.KOMMUNENUMMER AS VARCHAR(3)) + CAST(dbo.A.VEJ_KODE AS VARCHAR(4)) + RTRIM(dbo.A.HUS_NUMMER) AS ADRESSE_ID,
	      CAST(dbo.A.KOMMUNENUMMER AS VARCHAR(3)) + CAST(dbo.A.VEJ_KODE AS VARCHAR(4)) + RTRIM(dbo.A.HUS_NUMMER) + LTRIM(dbo.A.ETAGE) + LTRIM(dbo.A.SIDE_D�RNR) AS UDVadresseID
FROM
				QL59400V RIGHT OUTER JOIN
				AA70000T AS B ON QL59400V.KODE = AA70000T.LAND_KODE LEFT OUTER JOIN
				QL58900V ON AA70000T.BORGERSTATUS_KODE = QL58900V.KODE RIGHT OUTER JOIN
				AA70100T AS A LEFT OUTER JOIN
				JY72000V ON AA70100T.VEJ_KODE = JY72000V.VEJKODE AND AA70100T.KOMMUNENUMMER = JY72000V.KOMMUNENUMMER AND AA70100T.HUS_NUMMER = JY72000V.HUS_NR LEFT OUTER JOIN
				QL60000V ON AA70100T.FRAFLYT_KOMMUNENR = QL60000V.KODE ON AA70000T.PERSONNUMMER = AA70100T.PERSONNUMMER