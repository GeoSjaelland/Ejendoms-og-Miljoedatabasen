SELECT
				MIN(DISTINCT GS_BORGER2.Tidsstempling_tilflytning) AS Tidligste_indflytning,
				CONVERT(VARCHAR, GS_BORGER2.Adresse) AS Adresse,
				GS_BORGER2.Husnummer_bogstav,
				GS_BORGER2.Etage,
				GS_BORGER2.Side,
				GS_BORGER2.Supplerende_bynavn,
				CONVERT(VARCHAR, GS_BORGER2.Postdistrikt) AS Postdistrikt,
				CONVERT(VARCHAR, GS_BORGER2.ADRESSELINK_ID) AS ADRESSELINK_ID,
				CONVERT(VARCHAR, GS_BORGER2.ADRESSE_ID) AS ADRESSE_ID,
				CONVERT(VARCHAR, GS_BORGER2.UDVadresseID) AS UDVadresseID,
				GS_BBRENHED.Boligtypekode,
				GS_BBRENHED.Boligtype,
				GS_BBRENHED.Anvendelseskode,
				GS_BBRENHED.Anvendelse

FROM
				GS_BBREnhed RIGHT OUTER JOIN
				GS_BORGER2 ON GS_BBREnhed.UDVadresseID = GS_BORGER2.UDVadresseID
WHERE
				GS_BBREnhed.Boligtypekode NOT IN ('1', '2', '3', '4', '5')
				AND GS_BORGER2.UDVadresseID NOT IN
				 (SELECT UDVadresseID
         FROM GS_BBRENHED
         WHERE Boligtypekode IN ('1', '2', '3', '4', '5') AND Anvendelseskode BETWEEN 100 AND 200)
GROUP BY
				GS_BORGER2.Adresse,
				GS_BORGER2.Supplerende_bynavn,
				GS_BORGER2.Etage,
				GS_BORGER2.Side,
				GS_BORGER2.Postdistrikt,
				GS_BORGER2.ADRESSELINK_ID,
				GS_BORGER2.ADRESSE_ID,
				GS_BORGER2.UDVadresseID,
				GS_BORGER2.Husnummer_bogstav,
				GS_BBRENHED.Boligtypekode,
				GS_BBRENHED.Boligtype,
				GS_BBRENHED.Anvendelseskode,
				GS_BBRENHED.Anvendelse