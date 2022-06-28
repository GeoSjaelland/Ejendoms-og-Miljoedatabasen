SELECT        TOP (100) PERCENT dbo.GS_EJER.Kommunenummer, CAST(Jordstykke.SFE_EJDNR AS int) AS BFE_NUMMER, dbo.GS_EJER.Ejendomsnummer, dbo.GS_EJER.Matrikelnummer, dbo.GS_EJER.Ejendomsbeliggenhed,
                         dbo.GS_EJER.Matrikeladresse, dbo.GS_EJER.Ejers_navn, dbo.GS_EJER.Ejers_CO_navn, dbo.GS_EJER.Ejers_adresse, dbo.GS_EJER.Ejers_udvidede_adresse, dbo.GS_EJER.Postdistrikt, dbo.GS_EJER.Benyttelseskode,
                         dbo.GS_EJER.Benyttelse, dbo.GS_EJER.Ejers_statuskode, dbo.GS_EJER.Ejerstatus, dbo.GS_EJER.Pensionistkode, dbo.GS_EJER.Pensioniststatus, dbo.GS_EJER.Lejeværdikode, dbo.GS_EJER.Lejeværdi,
                         dbo.GS_EJER.Kode_for_adressebeskyttelse, dbo.GS_EJER.Adressebeskyttelse, dbo.GS_EJER.Slutseddeldato, dbo.GS_EJER.Skødedato, dbo.GS_EJER.Overtagelsesdato, dbo.GS_EJER.Overdragelsesmåde,
                         dbo.GS_EJER.Købesum, dbo.GS_EJER.Køberandel, dbo.GS_EJER.Ejerandel, dbo.GS_EJER.Ejer_CPR_CVR, dbo.GS_EJER.Vejkode, dbo.GS_EJER.Husnummer_bogstav, dbo.GS_EJER.Ejerlavskode, dbo.GS_EJER.MATNR,
                         dbo.GS_EJER.LANDSEJERLAVSTEKST, dbo.GS_EJER.Parcelnummer, DIMatrikel.CARTK, dbo.GS_EJER.Artskode, dbo.GS_EJER.Matrikulært_areal, dbo.GS_EJER.Matrikulært_vejareal, dbo.GS_EJER.Ejendomsareal,
                         dbo.GS_EJER.Heraf_vejareal, dbo.GS_EJER.Vurderet_areal, dbo.GS_EJER.Heraf_vurderet_vejareal, dbo.GS_EJER.Ejerforholdskode, dbo.GS_EJER.Ejerforhold, dbo.GS_EJER.Antal_ejere, dbo.GS_EJER.Antal_lejligheder,
                         dbo.GS_EJER.Moderejendomsnummer, dbo.GS_EJER.Adgang_til_offentlig_vej, dbo.GS_EJER.Admin_adressebeskyttelse, dbo.GS_EJER.Administrators_navn, dbo.GS_EJER.Administrators_CO_navn,
                         dbo.GS_EJER.Administrators_adresse, dbo.GS_EJER.Administrators_udv_adresse, dbo.GS_EJER.Administrators_postdistrikt, dbo.GS_EJER.Administratornummer, dbo.GS_EJER.Administrators_CPR_CVR,
                         dbo.GS_EJER.Administratorkode, dbo.GS_EJER.Administratorstatus, dbo.GS_EJER.EJERLEJLIGHEDSNR, dbo.GS_EJER.ADRESSELINK_ID, dbo.GS_EJER.ADRESSE_ID, dbo.GS_EJER.UDVADRESSEID, dbo.GS_EJER.MatrikelID,
                         CAST('Pen (1,2,0) Brush (1,0,16777215)' AS varchar(254)) AS MI_STYLE, Jordstykke.MI_PRINX, Jordstykke.Shape
FROM            dbo.JY67300V_T AS DIMatrikel INNER JOIN
                         dbo.QL61000V ON DIMatrikel.CARTK = dbo.QL61000V.KODE RIGHT OUTER JOIN
                         dbo.JN67100T INNER JOIN
                         dbo.GEO_JORDSTYKKER AS Jordstykke ON dbo.JN67100T.KOMMUNENUMMER = Jordstykke.KOMKODE ON DIMatrikel.AMATBOG = Jordstykke.MATRNR AND DIMatrikel.CLELAV = Jordstykke.ELAVSKODE LEFT OUTER JOIN
                         dbo.GS_EJER ON dbo.GS_EJER.MATNR = Jordstykke.MATRNR AND dbo.GS_EJER.LANDSEJERLAVSTEKST = Jordstykke.ELAVSNAVN
WHERE        (NOT (dbo.GS_EJER.Kommunenummer IS NULL)) AND (NOT (dbo.GS_EJER.Ejers_CO_navn LIKE 'Ophørt%')) AND (dbo.GS_EJER.Ejerforholdskode <> '')