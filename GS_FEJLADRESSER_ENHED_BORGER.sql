SELECT
				MIN(DISTINCT GS_BORGER.Tidsstempling_tilflytning) AS Tidligste_indflytning,
				CONVERT(VARCHAR, GS_BORGER.Adresse) AS Adresse,
				GS_BORGER.Husnummer_bogstav,
				GS_BORGER.Etage,
				GS_BORGER.Side,
				GS_BORGER.Supplerende_bynavn,
				CONVERT(VARCHAR, GS_BORGER.Postdistrikt) AS Postdistrikt,
				CONVERT(VARCHAR, GS_BORGER.ADRESSELINK_ID) AS ADRESSELINK_ID,
				CONVERT(VARCHAR, GS_BORGER.ADRESSE_ID) AS ADRESSE_ID,
				CONVERT(VARCHAR, GS_BORGER.UDVadresseID) AS UDVadresseID
FROM
				GS_BBREnhed RIGHT OUTER JOIN
				GS_BORGER ON GS_BBREnhed.UDVadresseID = GS_BORGER.UDVadresseID
WHERE
				(GS_BBREnhed.Boligtypekode < '1') OR (GS_BBREnhed.Boligtypekode IS NULL)
GROUP BY
				GS_BORGER.Adresse,
				GS_BORGER.Supplerende_bynavn,
				GS_BORGER.Etage,
				GS_BORGER.Side,
				GS_BORGER.Postdistrikt,
				GS_BORGER.ADRESSELINK_ID,
				GS_BORGER.ADRESSE_ID,
				GS_BORGER.UDVadresseID,
				GS_BORGER.Husnummer_bogstav