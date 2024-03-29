﻿SELECT
				JY64300V.PERSONNUMMER_RED AS CPR,
				JY64300V.KOMMUNENUMMER,
				JY64300V.FODSEL_DATO AS Fødselsdato,
				CONVERT(INT, DATEDIFF(d, JY64300V.FODSEL_DATO, GETDATE()) / 365.25) AS Alder,
				CASE
					WHEN CONVERT(INT, DATEDIFF(d, JY64300V.FODSEL_DATO, GETDATE()) / 365.25) BETWEEN 0AND 5 Then '0 - 5 år'
					WHEN CONVERT(INT, DATEDIFF(d, JY64300V.FODSEL_DATO, GETDATE()) / 365.25) BETWEEN 6 AND 16 Then '6 - 16 år'
					WHEN CONVERT(INT, DATEDIFF(d, JY64300V.FODSEL_DATO, GETDATE()) / 365.25) BETWEEN 17 AND 24 Then '17 - 24 år'
					WHEN CONVERT(INT, DATEDIFF(d, JY64300V.FODSEL_DATO, GETDATE()) / 365.25) BETWEEN 25 AND 44 Then '25 - 44 år'
					WHEN CONVERT(INT, DATEDIFF(d, JY64300V.FODSEL_DATO, GETDATE()) / 365.25) BETWEEN 45 AND 64 Then '45 - 64 år'
					WHEN CONVERT(INT, DATEDIFF(d, JY64300V.FODSEL_DATO, GETDATE()) / 365.25) > 64 Then 'Over 64 år'
				END AS Aldersklasse,
				JY64300V.KON AS Køn,
				JY64300V.STILLING AS Stilling,
				JY64300V.STILLING_DATO AS Stillingsdato,
				CAST(RTRIM(REVERSE(REPLACE(SUBSTRING(REVERSE(JY64300V.ADRESSERINGSNAVN), 1, CHARINDEX(',', REVERSE(JY64300V.ADRESSERINGSNAVN))), ',', ''))) + ' ' + REPLACE(SUBSTRING(JY64300V.ADRESSERINGSNAVN, 1, CHARINDEX(',', JY64300V.ADRESSERINGSNAVN)), ',', '') AS VARCHAR(50)) AS Navn,
				JY64300V.ADRNAVN_DATO AS Dato_for_adresseringsnavn,
				CAST(RTRIM(JY72000V.VEJADRNAVN + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(JY72000V.HUS_NR), '0', ' ')), ' ', '0') + ' ' + RTRIM(LTRIM(JY64300V.ETAGE)) + ' ' + RTRIM(LTRIM(JY64300V.SIDE_DORNR))) AS VARCHAR(50)) AS Adresse,
				JY72000V.SUPBYNAVN AS Supplerende_bynavn,
				JY72000V.POSTNR,
				JY72000V.POSTBYNAVN,
				CAST(JY72000V.POSTNR AS VARCHAR (5))+' '+JY72000V.POSTBYNAVN AS Postdistrikt,
				JY72000V.BYGNAVN,
				JY64300V.FOLKEKIRK_TILH_MRK AS Folkekirkemarkering,
				JY64300V.FOLKEKIRK_MRK_DATO AS Dato_for_folkekirkemarkering,
				CAST(QL58900V.TEKST AS VARCHAR(75)) AS Borgerstatus,
				JY64300V.BORGERSTATUS_TS AS Tidsstempling_borgerstatus,
				JY64300V.ANTAL_BORN AS Antal_børn,
				JY64300V.ADR_TILFLYT_TS AS Tidsstempling_tilflytning,
				JY64300V.VEJ_KODE AS Vejkode,
				JY64300V.HUS_NUMMER AS Husnummer_bogstav,
				JY64300V.ETAGE AS Etage,
				JY64300V.SIDE_DORNR AS Side,
				JY64300V.BYGNING_NUMMER AS Bygningsnummer,
				JY64300V.ADR_FRAFLYT_TS AS Tidsstempling_fraflytning,
				JY64300V.CO_NAVN AS CO_Navn,
				JY64300V.KOM_TILFLYTDATO AS Kommune_tilflytningsdato,
				JY64300V.FRAFLYT_KOMMUNENR AS Fraflytningskommunenummer,
				QL60000V.TEKST As Fraflytningskommune,
				JY64300V.ADRESSEBESKYT_DATO AS Dato_for_adressebeskyttelse,
				JY64300V.ADR_BESKYT_SLTDATO AS Dato_sletning_adressebeskyt,
				JY64300V.CIVILSTAND_TS AS Tid_for_civilstand,
				CAST(QL58800V.TEKST AS VARCHAR(75)) AS Civilstand,
				JY64300V.CIVILST_OPHOR_TS AS Tid_for_civilstandsophør,
				JY64300V.PERSONNR_AGTEFALLE AS Personnummer_ægtefælle,
				JY64300V.AGTEFALLE_FLAG AS Flag_for_ægtefælle,
				JY64300V.LAND_KODE AS Landekode,
				CAST(QL59400V.TEKST AS VARCHAR(75)) AS Land,
				JY64300V.STATSB_RET_TS AS Tid_for_ændr_statsborgerskab,
				JY64300V.STATBORG_OPHOR_TS AS Tid_for_ophør_statsborgersk,
				JY64300V.PERSONNUMMER_MOR,
				JY64300V.PERSONNUMMER_FAR,
				JY64300V.MOR_DOK,
				JY64300V.FAR_DOK,
				JY64300V.BORGERSTATUS_UM AS Usik_tidstempel_borgerstatus,
				CAST(JY64300V.KOMMUNENUMMER AS VARCHAR(3)) + RIGHT('0000' + CONVERT(VARCHAR, JY64300V.VEJ_KODE), 4) + RTRIM(JY64300V.HUS_NUMMER) AS ADRESSELINK_ID,
				CAST(JY64300V.KOMMUNENUMMER AS VARCHAR(3)) + CAST(JY64300V.VEJ_KODE AS VARCHAR(4)) + RTRIM(JY64300V.HUS_NUMMER) AS ADRESSE_ID,
				CAST(JY64300V.KOMMUNENUMMER AS VARCHAR(3)) + CAST(JY64300V.VEJ_KODE AS VARCHAR(4)) + RTRIM(JY64300V.HUS_NUMMER) + LTRIM(JY64300V.ETAGE) + LTRIM(JY64300V.SIDE_DORNR) AS UDVadresseID,
				JY64300V.PERSONNUMMER,
				JY73200V.KOOROEST,
				JY73200V.KOORNORD,
				JY73200V.DDKNCELLE100M,
				JY73200V.DDKNCELLE1KM,
				JY73200V.DDKNCELLE10KM
FROM
		    JY72000V LEFT OUTER JOIN
        JY73200V ON JY72000V.APU_ID = JY73200V.APU_ID RIGHT OUTER JOIN
        JY64300V LEFT OUTER JOIN
        QL58900V ON JY64300V.BORGERSTATUS_KODE = QL58900V.KODE LEFT OUTER JOIN
				QL58800V ON JY64300V.CIVILSTAND = QL58800V.KODE LEFT OUTER JOIN
        QL59400V ON JY64300V.LAND_KODE = QL59400V.KODE LEFT OUTER JOIN
        QL60000V ON JY64300V.FRAFLYT_KOMMUNENR = QL60000V.KODE ON JY72000V.KOMMUNENUMMER = JY64300V.KOMMUNENUMMER AND
        JY72000V.VEJKODE = JY64300V.VEJ_KODE AND JY72000V.HUS_NR = JY64300V.HUS_NUMMER
