SELECT
				TOP (100) PERCENT GS_BORGER_FLYTNING.Fraflytningskommunenr,
				GS_BORGER_FLYTNING.Fraflytningskommune,
				GS_BORGER_FLYTNING.Bopælskommunenr,
				GS_BORGER_FLYTNING.Bopælskommune,
				GS_BORGER_FLYTNING.PERSONNUMMER,
				GS_BORGER_FLYTNING.CPR,
				GS_BORGER_FLYTNING.Fødselsdato,
				GS_BORGER_FLYTNING.Alder,
				GS_BORGER_FLYTNING.Alder_ved_flytning,
				GS_BORGER_FLYTNING.Aldersklasse,
				GS_BORGER_FLYTNING.Navn,
				TMP_SIDSTEADRESSE.CO_NAVN,
				TMP_SIDSTEADRESSE.Adresse,
				TMP_SIDSTEADRESSE.Supplerende_bynavn,
				TMP_SIDSTEADRESSE.Postnummer,
				TMP_SIDSTEADRESSE.Bynavn,
				TMP_SIDSTEADRESSE.Postdistrikt,
				TMP_SIDSTEADRESSE.Borgerstatuskode,
				TMP_SIDSTEADRESSE.Borgerstatus,
				TMP_SIDSTEADRESSE.Tilflytningsdato,
				TMP_SIDSTEADRESSE.Fraflytningsdato,
				TMP_SIDSTEADRESSE.Kommunetilflytningsdato,
				TMP_SIDSTEADRESSE.Kommunefraflytningsdato,
				TMP_SIDSTEADRESSE.Borgerstatusdato,
				TMP_SIDSTEADRESSE.Landekode,
				TMP_SIDSTEADRESSE.Land,
				GS_BORGER_FLYTNING.CPR_Bosætningsdato,
				GS_BORGER_FLYTNING.PERSONNUMMER_MOR,
				GS_BORGER_FLYTNING.PERSONNUMMER_FAR,
				TMP_SIDSTEADRESSE.ADRESSE_ID,
				TMP_SIDSTEADRESSE.UDVadresseID,
				GS_BORGER_FLYTNING.CO_NAVN AS CO_NAVN_tilflytning,
				GS_BORGER_FLYTNING.Adresse AS Adresse_tilflytning,
				GS_BORGER_FLYTNING.Supplerende_bynavn AS Supplerende_bynavn_tilflytning,
				GS_BORGER_FLYTNING.Postdistrikt AS Postdistrikt_tilflytning
FROM
				GS_BORGER_FLYTNING INNER JOIN
					(SELECT
						GS_BORGER_FLYTNING_2.PERSONNUMMER,
						GS_BORGER_FLYTNING_2.CO_NAVN,
						CASE WHEN LEFT(GS_BORGER_FLYTNING_2.ADRESSE_ID,5) = '33699'
						 THEN 'Rådhuset'
						 ELSE GS_BORGER_FLYTNING_2.Adresse
						END AS Adresse,
						GS_BORGER_FLYTNING_2.Supplerende_bynavn,
						GS_BORGER_FLYTNING_2.Postnummer,
						GS_BORGER_FLYTNING_2.Bynavn,
						GS_BORGER_FLYTNING_2.Postdistrikt,
						GS_BORGER_FLYTNING_2.Borgerstatuskode,
						GS_BORGER_FLYTNING_2.Borgerstatus,
						GS_BORGER_FLYTNING_2.Tilflytningsdato,
						GS_BORGER_FLYTNING_2.Fraflytningsdato,
						GS_BORGER_FLYTNING_2.Kommunetilflytningsdato,
						GS_BORGER_FLYTNING_2.Kommunefraflytningsdato,
						GS_BORGER_FLYTNING_2.Borgerstatusdato,
						GS_BORGER_FLYTNING_2.Landekode,
						GS_BORGER_FLYTNING_2.Land,
						GS_BORGER_FLYTNING_2.ADRESSE_ID,
						GS_BORGER_FLYTNING_2.UDVadresseID
					FROM
						GS_BORGER_FLYTNING AS GS_BORGER_FLYTNING_2 INNER JOIN
         	(SELECT
         		MAX(Fraflytningsdato) AS Fraflytningsdato,
         		PERSONNUMMER
           FROM
           	GS_BORGER_FLYTNING AS GS_BORGER_FLYTNING_1
           WHERE
           	(YEAR(Fraflytningsdato) = 2016) AND (Bopælskommunenr = 336)
           GROUP BY PERSONNUMMER) AS Maxdato
          ON GS_BORGER_FLYTNING_2.PERSONNUMMER = Maxdato.PERSONNUMMER
          AND GS_BORGER_FLYTNING_2.Fraflytningsdato = Maxdato.Fraflytningsdato) AS TMP_SIDSTEADRESSE
				ON GS_BORGER_FLYTNING.PERSONNUMMER = TMP_SIDSTEADRESSE.PERSONNUMMER
				AND GS_BORGER_FLYTNING.PERSONNUMMER = TMP_SIDSTEADRESSE.PERSONNUMMER
WHERE
				(GS_BORGER_FLYTNING.Bopælskommunenr <> 336)
				AND (GS_BORGER_FLYTNING.Tilflytningsdato = TMP_SIDSTEADRESSE.Fraflytningsdato)
				OR (GS_BORGER_FLYTNING.Fraflytningsdato = TMP_SIDSTEADRESSE.Fraflytningsdato)
				AND (GS_BORGER_FLYTNING.Borgerstatusdato = TMP_SIDSTEADRESSE.Fraflytningsdato)
				AND (TMP_SIDSTEADRESSE.Borgerstatuskode IN (70, 80))