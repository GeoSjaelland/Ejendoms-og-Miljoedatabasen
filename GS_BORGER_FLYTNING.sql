SELECT
				AA70100V.KOMMUNENUMMER AS Kommunenummer,
				AA70100V.PERSONNUMMER AS Personnummer,
				CASE
					WHEN LEN(CONVERT(VARCHAR,A.PERSONNUMMER))=10
					THEN CAST(LEFT(CONVERT(VARCHAR,A.PERSONNUMMER),6)+'-'+RIGHT(CONVERT(VARCHAR,A.PERSONNUMMER),4) AS VARCHAR(11))
					ELSE CAST('0'+LEFT(CONVERT(VARCHAR,A.PERSONNUMMER),5)+'-'+RIGHT(CONVERT(VARCHAR,A.PERSONNUMMER),4) AS VARCHAR(11))
				END AS CPR,
				CAST(AA70000V.FODSEL_DATO AS datetime) AS F�dselsdato,
				CONVERT(INT, DATEDIFF(d, AA70000V.FODSEL_DATO, GETDATE()) / 365.25) AS Alder,
				CAST(RTRIM(REVERSE(REPLACE(SUBSTRING(REVERSE(AA70000V.ADRESSERINGSNAVN), 1, CHARINDEX(',', REVERSE(AA70000V.ADRESSERINGSNAVN))), ',', ''))) + ' ' + REPLACE(SUBSTRING(AA70000V.ADRESSERINGSNAVN, 1, CHARINDEX(',', AA70000V.ADRESSERINGSNAVN)), ',', '') AS VARCHAR(50)) AS Navn,
				AA70100V.CO_NAVN,
				CAST(RTRIM(JY72000V.VEJADRNAVN + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(JY72000V.HUS_NR), '0', ' ')), ' ', '0') + ' ' + RTRIM(LTRIM(AA70100V.ETAGE)) + ' ' + RTRIM(LTRIM(AA70100V.SIDE_DORNR))) AS VARCHAR(50)) AS Adresse,
				JY72000V.SUPBYNAVN AS Supplerende_bynavn,
				JY72000V.POSTNR AS Postnummer, JY72000V.POSTBYNAVN AS Bynavn,
				CAST(JY72000V.POSTNR AS VARCHAR(5)) + ' ' + JY72000V.POSTBYNAVN AS Postdistrikt,
				JY72000V.BYGNAVN AS Bygningsnavn,
				CAST(AA70100V.ADR_TILFLYT_TS AS datetime) AS Tilflytningsdato,
				CAST(AA70100V.ADR_FRAFLYT_TS AS datetime) AS Fraflytningsdato,
				CAST(AA70100V.KOM_TILFLYTDATO AS datetime) AS Kommunetilflytningsdato,
				CAST(AA70100V.KOM_FRAFLYTDATO AS datetime) AS Kommunefraflytningsdato,
				AA70000V.BORGERSTATUS_KODE, QL58900V.TEKST AS Borgerstatus,
				AA70100V.FRAFLYT_KOMMUNENR,
				QL60000V.TEKST AS Fraflytningskommune,
				AA70000V.LAND_KODE,
				QL59400V.TEKST AS Land,
				CAST(AA70000V.STATSB_RET_TS AS datetime) AS Statsborgerret_�ndring,
				CAST(AA70000V.STATBORG_OPHOR_TS AS datetime) AS Statsborgerret_Oph�r,
				CAST(dbo.AA70100V.KOMMUNENUMMER AS VARCHAR(3))+ RIGHT('0000' + CONVERT(VARCHAR, dbo.AA70100V.VEJ_KODE), 4) + RTRIM(dbo.AA70100V.HUS_NUMMER) AS ADRESSELINK_ID,
				CAST(dbo.AA70100V.KOMMUNENUMMER AS VARCHAR(3)) + CAST(dbo.AA70100V.VEJ_KODE AS VARCHAR(4)) + RTRIM(dbo.AA70100V.HUS_NUMMER) AS ADRESSE_ID,
				CAST(dbo.AA70100V.KOMMUNENUMMER AS VARCHAR(3)) + CAST(dbo.AA70100V.VEJ_KODE AS VARCHAR(4)) + RTRIM(dbo.AA70100V.HUS_NUMMER) + LTRIM(dbo.AA70100V.ETAGE) + LTRIM(dbo.AA70100V.SIDE_DORNR) AS UDVadresseID
FROM
				QL59400V RIGHT OUTER JOIN
				AA70000V ON QL59400V.KODE = AA70000V.LAND_KODE LEFT OUTER JOIN
				QL58900V ON AA70000V.BORGERSTATUS_KODE = QL58900V.KODE RIGHT OUTER JOIN
				AA70100V LEFT OUTER JOIN
				JY72000V ON AA70100V.VEJ_KODE = JY72000V.VEJKODE AND AA70100V.KOMMUNENUMMER = JY72000V.KOMMUNENUMMER AND AA70100V.HUS_NUMMER = JY72000V.HUS_NR LEFT OUTER JOIN
				QL60000V ON AA70100V.FRAFLYT_KOMMUNENR = QL60000V.KODE ON AA70000V.PERSONNUMMER = AA70100V.PERSONNUMMER