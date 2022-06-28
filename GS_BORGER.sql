﻿SELECT
CASE
 WHEN LEN(CPR.PERSONNUMMER) = 9
 THEN '0' + CONVERT(varchar, LEFT(CPR.PERSONNUMMER, 5)) + '-' + CONVERT(varchar, RIGHT(CPR.PERSONNUMMER, 4))
 WHEN LEN(CPR.PERSONNUMMER) = 10
 THEN CONVERT(varchar, LEFT(CPR.personnummer, 6)) + '-' + CONVERT(varchar, RIGHT(CPR.personnummer, 4))
END AS CPR, CPR.KOMMUNENUMMER,
CPR.FØDSEL_DATO AS Fødselsdato,
(0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(CPR.FØDSEL_DATO, '-', ''), 112)) / 10000 AS Alder,
CASE
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 0 AND 2
 THEN '0 - 2 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 3 AND 5
 THEN '03 - 05 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) = 6
 THEN '06 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 07 AND 16
 THEN '07 - 16 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 17 AND 25
 THEN '17 - 25 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 26 AND 42
 THEN '26 - 42 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 43 AND 59
 THEN '43 - 59 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 60 AND 64
 THEN '60 - 64 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 65 AND 79
 THEN '65 - 79 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(cpr.FØDSEL_DATO, '-', ''), 112)) / 10000) > 79 THEN 'Over 79 år'
END AS Aldersklasse,
CASE
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(CPR.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 0 AND 5
 THEN '0 - 5 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(CPR.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 6 AND 16
 THEN '06 - 16 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(CPR.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 17 AND 24
 THEN '17 - 24 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(CPR.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 25 AND 44
 THEN '25 - 44 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(CPR.FØDSEL_DATO, '-', ''), 112)) / 10000) BETWEEN 45 AND 64
 THEN '45 - 64 år'
 WHEN ((0 + CONVERT(Char(8), GETDATE(), 112) - CONVERT(Char(8), REPLACE(CPR.FØDSEL_DATO, '-', ''), 112)) / 10000) > 64
 THEN 'Over 64 år'
END AS Aldersklasse2,
CPR.KØN AS Køn,
CPR.STILLING,
CASE
 WHEN CPR.STILLING_DATO < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 ELSE CONVERT(datetime,
 CPR.STILLING_DATO, 120)
END AS Stillingsdato,
CAST(RTRIM(REVERSE(REPLACE(SUBSTRING(REVERSE(CPR.ADRESSERINGSNAVN), 1, CHARINDEX(',', REVERSE(CPR.ADRESSERINGSNAVN))), ',', ''))) + ' ' + REPLACE(SUBSTRING(CPR.ADRESSERINGSNAVN, 1, CHARINDEX(',', CPR.ADRESSERINGSNAVN)), ',', '') AS VARCHAR(60)) AS Navn,
CPR.CO_NAVN,
CAST(RTRIM(APU.VEJNAVN + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(APU.HUS_NR), '0', ' ')), ' ', '0') + ' ' + RTRIM(LTRIM(CPR.ETAGE)) + ' ' + RTRIM(LTRIM(CPR.SIDE_DØRNR))) AS VARCHAR(50)) AS Adresse,
				APU.SUPBYNAVN AS Supplerende_bynavn,
				APU.POSTNUMMER,
				APU.Postdistrikt AS POSTBYNAVN,
				CAST(APU.POSTNUMMER AS VARCHAR(5)) + ' ' + APU.Postdistrikt AS Postdistrikt,
CASE
 WHEN CPR.ADRNAVN_DATO < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 ELSE CONVERT(datetime, CPR.ADRNAVN_DATO, 120)
END AS Dato_for_adresseringsnavn, CPR.FOLKEKIRK_TILH_MRK AS Folkekirkemarkering,
CASE
 WHEN CPR.FOLKEKIRK_MRK_DATO < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 ELSE CONVERT(datetime, CPR.FOLKEKIRK_MRK_DATO, 120)
END AS Dato_for_folkekirkemarkering,
CAST(dbo.QL58900V.TEKST AS VARCHAR(75)) AS Borgerstatus,
CASE
 WHEN CPR.BORGERSTATUS_TS < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 ELSE CONVERT(datetime, substring(CPR.BORGERSTATUS_TS, 1, 10) + ' ' + substring(CPR.BORGERSTATUS_TS, 12, 2) + ':' + substring(CPR.BORGERSTATUS_TS, 15, 2) + ':' + substring(CPR.BORGERSTATUS_TS, 18, 6), 120)
END AS Tidsstempling_borgerstatus,
CPR.ANTAL_BØRN AS Antal_børn,
CASE
 WHEN CPR.ADR_TILFLYT_TS < '1753-01-01'
 THEN CONVERT(datetime, '4713-12-31', 120)
 WHEN CPR.ADR_TILFLYT_TS = '9999-12-31-00.00.00.000000'
 THEN CONVERT(datetime, '4713-12-31', 120)
 ELSE CONVERT(datetime, substring(CPR.ADR_TILFLYT_TS, 1, 10) + ' ' + substring(CPR.ADR_TILFLYT_TS, 12, 2) + ':' + substring(CPR.ADR_TILFLYT_TS, 15, 2) + ':' + substring(CPR.ADR_TILFLYT_TS, 18, 6), 120)
END AS Tidsstempling_tilflytning,
CPR.VEJ_KODE AS Vejkode,
CPR.HUS_NUMMER AS Husnummer_bogstav,
CPR.ETAGE, CPR.SIDE_DØRNR AS Side,
CPR.BYGNING_NUMMER AS Bygningsnummer,
CASE
 WHEN CPR.ADR_FRAFLYT_TS < CPR.ADR_TILFLYT_TS
 THEN CONVERT(datetime, '4713-12-31', 120)
 WHEN CPR.ADR_FRAFLYT_TS < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 WHEN CPR.ADR_FRAFLYT_TS = '9999-12-31-00.00.00.000000'
 THEN CONVERT(datetime, '4713-12-31', 120)
 ELSE CONVERT(datetime, substring(CPR.ADR_FRAFLYT_TS, 1, 10) + ' ' + substring(CPR.ADR_FRAFLYT_TS, 12, 2) + ':' + substring(CPR.ADR_FRAFLYT_TS, 15, 2) + ':' + substring(CPR.ADR_FRAFLYT_TS, 18, 6), 120)
END AS Tidsstempling_fraflytning,
CPR.CO_NAVN,
CASE
 WHEN CPR.KOM_TILFLYTDATO < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 ELSE CONVERT(datetime, CPR.KOM_TILFLYTDATO, 120)
END AS Kommune_tilflytningsdato,
 CPR.FRAFLYT_KOMMUNENR AS Fraflytningskommunenummer, dbo.QL60000V.TEKST AS Fraflytningskommune,
CASE
 WHEN CPR.ADRESSE_BESKYTT ELSE = 'B'
 THEN 'Adressen er beskyttet i CPR'
 WHEN CPR.ADRESSE_BESKYTT
 ELSE = 'L'
 THEN 'Adressen må ikke optages i vejvisere'
 ELSE 'Adressen er ikke beskyttet'
END AS Adressebeskyttelse,
CASE
 WHEN CPR.ADRESSEBESKYT_DATO < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 ELSE CONVERT(datetime, CPR.ADRESSEBESKYT_DATO, 120)
END AS Dato_for_adressebeskytt
 ELSE,
CASE
 WHEN CPR.ADR_BESKYT_SLTDATO < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 ELSE CONVERT(datetime, CPR.ADR_BESKYT_SLTDATO, 120)
END AS Dato_sletning_adressebeskyt,
CASE
 WHEN CPR.CIVILSTAND_TS < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 ELSE CONVERT(datetime, substring(CPR.CIVILSTAND_TS, 1, 10) + ' ' + substring(CPR.CIVILSTAND_TS, 12, 2)
 + ':' + substring(CPR.CIVILSTAND_TS, 15, 2) + ':' + substring(CPR.CIVILSTAND_TS, 18, 6), 120)
END AS Tid_for_civilstand, CAST(dbo.QL58800V.TEKST AS VARCHAR(75)) AS Civilstand,
CASE
 WHEN CPR.CIVILST_OPHØR_TS < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 WHEN CPR.CIVILST_OPHØR_TS = '9999-12-31-00.00.00.000000'
 THEN CONVERT(datetime, '4713-12-31', 120)

 ELSE CONVERT(datetime, substring(CPR.CIVILST_OPHØR_TS, 1, 10) + ' ' + substring(CPR.CIVILST_OPHØR_TS, 12, 2) + ':' + substring(CPR.CIVILST_OPHØR_TS, 15, 2) + ':' + substring(CPR.CIVILST_OPHØR_TS, 18, 6), 120)

END AS Tid_for_civilstandsophør, CPR.PERSONNR_ÆGTEFÆLLE AS Personnummer_ægtefælle, CPR.ÆGTEFÆLLE_FLAG AS Flag_for_ægtefælle,
CASE
 WHEN CPR.EJ_UMYNDIGGØR_FLAG <> 1
 THEN 'Ja'
 ELSE 'Nej'
END AS Umyndiggjort, CPR.LAND_KODE AS Landekode, CAST(dbo.QL59400V.TEKST AS VARCHAR(75)) AS Land,
CASE
 WHEN CPR.STATSB_RET_TS < '1753-01-01'
 THEN CONVERT(datetime, '1753-01-01', 120)
 ELSE CONVERT(datetime, substring(CPR.STATSB_RET_TS, 1, 10) + ' ' + substring(CPR.STATSB_RET_TS, 12, 2)
 + ':' + substring(CPR.STATSB_RET_TS, 15, 2) + ':' + substring(CPR.STATSB_RET_TS, 18, 6), 120)
END AS Tid_for_ændr_statsborgerskab,
CASE
 WHEN CPR.STATBORG_OPHØR_TS < '1753-01-01'
 THEN CONVERT(datetime,
 '1753-01-01', 120)
 WHEN CPR.STATBORG_OPHØR_TS = '9999-12-31-00.00.00.000000'
 THEN CONVERT(datetime, '4713-12-31', 120)
 ELSE CONVERT(datetime, substring(CPR.STATBORG_OPHØR_TS, 1, 10)
 + ' ' + substring(CPR.STATBORG_OPHØR_TS, 12, 2) + ':' + substring(CPR.STATBORG_OPHØR_TS, 15, 2) + ':' + substring(CPR.STATBORG_OPHØR_TS, 18, 6), 120)
END AS Tid_for_ophør_statsborgersk,
 CPR.PERSONNUMMER_MOR, CPR.PERSONNUMMER_FAR, CPR.MOR_DOK, CPR.FAR_DOK, CPR.BORGERSTATUS_UM AS Usik_tidstempel_borgerstatus, CAST(CPR.KOMMUNENUMMER AS VARCHAR(3))
 + RIGHT('0000' + CONVERT(VARCHAR, CPR.VEJ_KODE), 4) + RTRIM(CPR.HUS_NUMMER) AS ADRESSELINK_ID, CAST(CPR.KOMMUNENUMMER AS VARCHAR(3)) + CAST(CPR.VEJ_KODE AS VARCHAR(4))
 + RTRIM(CPR.HUS_NUMMER) AS ADRESSE_ID, CAST(CPR.KOMMUNENUMMER AS VARCHAR(3)) + CAST(CPR.VEJ_KODE AS VARCHAR(4)) + RTRIM(CPR.HUS_NUMMER) + LTRIM(CPR.ETAGE) + LTRIM(CPR.SIDE_DØRNR)
 AS UDVadresseID, CPR.PERSONNUMMER, APU.KoorOest, APU.KoorNord, APU.DDKNcelle100m, APU.DDKNcelle1km, APU.DDKNcelle10km, APU.MI_PRINX, APU.MI_STYLE,CASE
 WHEN APU.GEOMETRI IS NULL

 THEN geometry::STPointFromText('POINT (714924.23 6134752.1)', 4937)
 ELSE APU.GEOMETRI
END AS GEOMETRI
FROM            dbo.QL60000V RIGHT OUTER JOIN
 dbo.QL59400V RIGHT OUTER JOIN
 dbo.QL58800V RIGHT OUTER JOIN
 dbo.AA70000T AS CPR INNER JOIN
 dbo.JN67100T ON CPR.KOMMUNENUMMER = dbo.JN67100T.KOMMUNENUMMER LEFT OUTER JOIN
 dbo.LAND_ADRESSEPUNKT AS APU ON CPR.VEJ_KODE = APU.VejKode AND CPR.HUS_NUMMER = APU.HUS_NR AND CPR.KOMMUNENUMMER = APU.KommuneNummer LEFT OUTER JOIN
 dbo.QL58900V ON CPR.BORGERSTATUS_KODE = dbo.QL58900V.KODE ON dbo.QL58800V.KODE = CPR.CIVILSTAND ON dbo.QL59400V.KODE = CPR.LAND_KODE ON dbo.QL60000V.KODE = CPR.FRAFLYT_KOMMUNENR
WHERE        (CPR.BORGERSTATUS_KODE < 10)