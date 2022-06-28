SELECT        dbo.GS_BORGER_FLYTNING.Fraflytningskommunenr, dbo.GS_BORGER_FLYTNING.Fraflytningskommune, dbo.GS_BORGER_FLYTNING.Bopælskommunenr, dbo.GS_BORGER_FLYTNING.Bopælskommune,
                         dbo.GS_BORGER_FLYTNING.PERSONNUMMER, dbo.GS_BORGER_FLYTNING.CPR, dbo.GS_BORGER_FLYTNING.Fødselsdato, dbo.GS_BORGER_FLYTNING.Alder, dbo.GS_BORGER_FLYTNING.Navn,
                         dbo.GS_BORGER_FLYTNING.CO_NAVN, dbo.GS_BORGER_FLYTNING.Adresse, dbo.GS_BORGER_FLYTNING.Supplerende_bynavn, dbo.GS_BORGER_FLYTNING.Postnummer, dbo.GS_BORGER_FLYTNING.Bynavn,
                         dbo.GS_BORGER_FLYTNING.Postdistrikt, dbo.GS_BORGER_FLYTNING.Tilflytningsdato, dbo.GS_BORGER_FLYTNING.Fraflytningsdato, dbo.GS_BORGER_FLYTNING.Borgerstatus,
                         dbo.GS_BORGER_FLYTNING.Borgerstatuskode, dbo.GS_BORGER_FLYTNING.Landekode, dbo.GS_BORGER_FLYTNING.Land, dbo.GS_BORGER_FLYTNING.ADRESSELINK_ID, dbo.GS_BORGER_FLYTNING.ADRESSE_ID,
                         dbo.GS_BORGER_FLYTNING.UDVadresseID, dbo.GS_BORGER_FLYTNING.PERSONNUMMER_MOR, dbo.GS_BORGER_FLYTNING.PERSONNUMMER_FAR, dbo.GS_BORGER_FLYTNING.Borgerstatusdato
FROM            dbo.GS_BORGER_FLYTNING INNER JOIN
                             (SELECT        CPR, MAX(Tilflytningsdato) AS Tilflytningsdato
                               FROM            dbo.GS_BORGER_FLYTNING AS GS_BORGER_FLYTNING_1
                               WHERE        YEAR(Tilflytningsdato) < 2021
                               GROUP BY CPR) AS maxdato ON dbo.GS_BORGER_FLYTNING.CPR = maxdato.CPR AND dbo.GS_BORGER_FLYTNING.Tilflytningsdato = maxdato.Tilflytningsdato INNER JOIN
                         dbo.JN67100T ON dbo.GS_BORGER_FLYTNING.Bopælskommunenr = dbo.JN67100T.KOMMUNENUMMER
WHERE        (YEAR(dbo.GS_BORGER_FLYTNING.Borgerstatusdato) = YEAR(GETDATE())) AND (dbo.GS_BORGER_FLYTNING.Borgerstatuskode IN (70, 80, 90)) OR
                         (dbo.GS_BORGER_FLYTNING.Borgerstatuskode < 30)