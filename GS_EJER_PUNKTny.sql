SELECT DISTINCT
				JY67300V_T.EKOMNR AS Kommunenummer,
				CO11800T.BFE_NUMMER,
				JY67300V_T.EEJDNR AS Ejendomsnummer,
				CASE
				 WHEN JY67700V_T.LANDSEJERLAVSTEKST <> ''
				 THEN RTRIM(CONVERT(VARCHAR, JY67300V_T.AMATBOG)) + ', ' + JY67700V_T.LANDSEJERLAVSTEKST
				 ELSE RTRIM(CONVERT(VARCHAR, JY67300V_T.AMATBOG)) + ', ' + JY63500V_T.CELAVLATXT
				END AS Matrikelnummer,
				JY67500V_T.ABELIG AS Ejendomsbeliggenhed,
				RTRIM(RTRIM(JY67700V_T.VEJ_ADRESSENAVN) + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(JY67700V_T.HUS_NUMMER),'0', ' ')), ' ', '0')) AS Matrikeladresse,
				JY64900V_T.ANAVN AS Ejers_navn,
				JY64900V_T.ACONAVN AS Ejers_CO_navn,
				JY64900V_T.AADRESS AS Ejers_adresse,
				JY64900V_T.AUDVADR AS Ejers_udvidede_adresse,
				JY64900V_T.APOST AS Postdistrikt,
				JY67500V_T.CBENYT AS Benyttelseskode,
				CAST(QL61500V_T.TEKST AS VARCHAR(70)) AS Benyttelse,
				JY64900V_T.CMSTAT AS Ejers_statuskode,
				CAST(QL63200V_T.TEKST AS VARCHAR(75)) AS Ejerstatus,
				JY64900V_T.CPENS AS Pensionistkode,
				CAST(QL63400V_T.TEKST AS VARCHAR(75)) AS Pensioniststatus,
				JY64900V_T.CLEJE AS Lejeværdikode,
				CAST(QL63500V_T.TEKST AS VARCHAR(75)) AS Lejeværdi,
				JY64900V_T.CBSKADR AS Kode_for_adressebeskyttelse,
				CAST(QL63600V_T.TEKST AS VARCHAR(75)) AS Adressebeskyttelse,
				JY64900V_T.DSLUTS AS Slutseddeldato,
				JY64900V_T.DSKOED AS Skødedato,
				JY64900V_T.DOVTG AS Overtagelsesdato,
				CAST(QL63700V_T.TEKST AS VARCHAR(75)) AS Overdragelsesmåde,
				JY64900V_T.BKOEBS AS Købesum,
				CAST(CAST(JY64900V_T.GKOETAEL AS varchar(6)) + '/' + CAST(JY64900V_T.GKOENAEV AS varchar(6)) AS varchar(12)) AS Køberandel,
				CAST(CAST(JY64900V_T.GEJTAEL AS varchar(6)) + '/' + CAST(JY64900V_T.GEJNAEV AS varchar(6)) AS varchar(12)) AS Ejerandel,
				JY64900V_T.DCPRCIR AS Ejer_CPR_CVR,
				JN60500T.VEJ_KODE AS Vejkode,
				JN60500T.HUS_NUMMER AS Husnummer_bogstav,
				JY67300V_T.CELAV AS Ejerlavskode,
				RTRIM(JY67300V_T.AMATBOG) AS MATNR,
				CASE
				 WHEN JY67700V_T.LANDSEJERLAVSTEKST <> ''
				 THEN JY67700V_T.LANDSEJERLAVSTEKST
				 ELSE JY63500V_T.CELAVLATXT
				END AS LANDSEJERLAVSTEKST,
				JY67300V_T.EPCEL AS Parcelnummer,
				CAST(QL61000V_T.TEKST AS VARCHAR(75)) AS Artskode,
				JY67300V_T.FMATAR AS Matrikulært_areal,
				JY67300V_T.FVEJ AS Matrikulært_vejareal,
				JY67500V_T.FTOTAR AS Ejendomsareal,
				JY67500V_T.FTOTVEJ AS Heraf_vejareal,
				JY67500V_T.FARVUR AS Vurderet_areal,
				JY67500V_T.FVEJVUR AS Heraf_vurderet_vejareal,
				JY67500V_T.CEJFORH AS Ejerforholdskode,
				CAST(QL50000V_T.TEKST AS VARCHAR(133)) AS Ejerforhold,
				JY67500V_T.FEJER AS Antal_ejere,
				JY67500V_T.FLEJL AS Antal_lejligheder,
				JY67500V_T.EMODER AS Moderejendomsnummer,
				JY67500V_T.COFVEJ AS Adgang_til_offentlig_vej,
				JY67500V_T.CBSKADRA AS Admin_adressebeskyttelse,
				JY67500V_T.AANAVN AS Administrators_navn,
				JY67500V_T.AACONAVN AS Administrators_CO_navn,
				JY67500V_T.AAADRESS AS Administrators_adresse,
				JY67500V_T.AAUDVADR AS Administrators_udv_adresse,
				JY67500V_T.AAPOST AS Administrators_postdistrikt,
				JY67500V_T.EADMNR AS Administratornummer,
				JY67500V_T.DCPRADM AS Administrators_CPR_CVR,
				JY67500V_T.CADM AS Administratorkode,
				QL65000V_T.TEKST AS Administratorstatus,
				JY67300V_T.EJERLEJLIGHEDSNR,
				CASE
				 WHEN CONVERT(VARCHAR, JN60500T.KOMMUNENUMMER) <> ''
				 THEN CONVERT(VARCHAR, JN60500T.KOMMUNENUMMER) + RIGHT('0000' + CONVERT(VARCHAR,JN60500T.VEJ_KODE), 4) + RTRIM(JN60500T.HUS_NUMMER)
				 ELSE CONVERT(VARCHAR, JY67500V_T.EKOMNR) + RIGHT('0000' + CONVERT(VARCHAR, JY67500V_T.VEJ_KODE), 4) + RTRIM(JY67500V_T.HUS_NUMMER)
				END AS ADRESSELINK_ID,
				CASE
				 WHEN CONVERT(VARCHAR, JN60500T.KOMMUNENUMMER) <> ''
				 THEN CONVERT(VARCHAR, JN60500T.KOMMUNENUMMER) + CONVERT(VARCHAR, JN60500T.VEJ_KODE) + CONVERT(VARCHAR, JN60500T.HUS_NUMMER)
				 ELSE CONVERT(VARCHAR, JY67500V_T.EKOMNR) + CONVERT(VARCHAR, JY67500V_T.VEJ_KODE) + RTRIM(JY67500V_T.HUS_NUMMER)
				END AS ADRESSE_ID,
				CASE
				 WHEN CONVERT(VARCHAR, JN60500T.KOMMUNENUMMER) <> ''
				 THEN CONVERT(VARCHAR, CONVERT(VARCHAR,  JN60500T.KOMMUNENUMMER) + CONVERT(VARCHAR, JN60500T.VEJ_KODE) + CONVERT(VARCHAR,  JN60500T.HUS_NUMMER) + LTRIM(RTRIM(REPLACE(JN60500T.ETAGE, ' ', ''))) + LTRIM(RTRIM(REPLACE(JN60500T.SIDE_DOERNR, ' ', ''))))
				 ELSE CONVERT(VARCHAR, JY67500V_T.EKOMNR) + CONVERT(VARCHAR, JY67500V_T.VEJ_KODE) + RTRIM(JY67500V_T.HUS_NUMMER)
				END AS UDVADRESSEID,
				CASE
				 WHEN CONVERT(VARCHAR, JY67300V_T.AMATBOG) <> ''
				 THEN CONVERT(VARCHAR, JY67300V_T.CLELAV) + '' + CONVERT(VARCHAR, JY67300V_T.AMATBOG)
				 ELSE CONVERT(VARCHAR, JY63500V_T.CELAVLA) + '' + RTRIM(JY67500V_T.AMATBOG)
				END AS MatrikelID
FROM
				QL63200V_T RIGHT OUTER JOIN
				QL63400V_T LEFT OUTER JOIN
				QL63700V_T RIGHT OUTER JOIN
				JY64900V_T LEFT OUTER JOIN
				QL65000V_T LEFT OUTER JOIN
				JY67700V_T RIGHT OUTER JOIN
				JY67300V_T INNER JOIN
				CO11800T ON JY67300V_T.EEJDNR = CO11800T.EJD_NR AND JY67300V_T.CELAV = CO11800T.EJERLAV_KODE AND JY67300V_T.EMATNR = CO11800T.MATR_NR AND
				JY67300V_T.ABGSTM = CO11800T.MATR_BOGSTAV INNER JOIN
				JN60500T ON JY67300V_T.EEJDNR = JN60500T.EJENDOMSNR LEFT OUTER JOIN
				JY63500V_T ON JY67300V_T.CLELAV = JY63500V_T.CELAVLA ON JY67700V_T.EJENDOMSNR = JY67300V_T.EEJDNR AND JY67700V_T.MATRIKELBOGSTAV = JY67300V_T.ABGSTM AND
				JY67700V_T.MATRIKELNR = JY67300V_T.EMATNR AND JY67700V_T.LANDSEJERLAVSKODE = JY67300V_T.CLELAV LEFT OUTER JOIN
				JY67500V_T ON JY67300V_T.EEJDNR = JY67500V_T.EEJDNR ON QL65000V_T.KODE = JY67500V_T.CADM RIGHT OUTER JOIN
				QL61000V_T ON JY67500V_T.CARTK = QL61000V_T.KODE RIGHT OUTER JOIN
				QL61500V_T ON JY67500V_T.CBENYT = QL61500V_T.KODE ON JY64900V_T.EEJDNR = JY67300V_T.EEJDNR ON QL63700V_T.KODE = JY64900V_T.COVMD ON
				QL63400V_T.KODE = JY64900V_T.CPENS ON QL63200V_T.KODE = JY64900V_T.CMSTAT LEFT OUTER JOIN
				QL63500V_T ON JY64900V_T.CLEJE = QL63500V_T.KODE LEFT OUTER JOIN
				QL50000V_T ON JY64900V_T.CEJFORH = QL50000V_T.KODE LEFT OUTER JOIN
				QL63600V_T ON JY64900V_T.CBSKADR = QL63600V_T.KODE
WHERE
				(JY67300V_T.CARTK = 2) OR
				(JY67300V_T.CARTK = 3)