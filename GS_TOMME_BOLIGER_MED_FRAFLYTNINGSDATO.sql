SELECT
				TMP_Senest_beboet.Fraflytningsdato,
				GS_TOMME_BOLIGER.*
FROM
				GS_TOMME_BOLIGER LEFT OUTER JOIN
				 (SELECT MAX(Fraflytningsdato) AS Fraflytningsdato, UDVadresseID
				  FROM
				  GS_BORGER_FLYTNING
				  GROUP BY UDVadresseID, Bopælskommunenr
				  HAVING (Bopælskommunenr = 336) AND (MAX(Fraflytningsdato) < GETDATE())) AS TMP_Senest_beboet ON GS_TOMME_BOLIGER.UDVadresseID = TMP_Senest_beboet.UDVadresseID