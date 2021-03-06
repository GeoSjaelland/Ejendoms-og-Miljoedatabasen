SELECT
				JY67300V.EKOMNR AS Kommunenummer,
				JY67300V.EEJDNR AS Ejendomsnummer,
				CASE
					WHEN CONVERT(VARCHAR, JY67300V.AMATBOG)<>''
						THEN RTRIM(CONVERT(VARCHAR, JY67300V.AMATBOG)) + ', ' + JY67700V.LANDSEJERLAVSTEKST
				END AS Matrikelnummer,
				JY67500V.ABELIG AS Ejendomsbeliggenhed,
				RTRIM(RTRIM(JY67700V.VEJ_ADRESSENAVN) + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(JY67700V.HUS_NUMMER), '0', ' ')), ' ', '0')) AS Matrikeladresse,
				JY64900V.ANAVN AS Ejers_navn,
				JY64900V.ACONAVN AS Ejers_CO_navn,
				JY64900V.AADRESS AS Ejers_adresse,
				JY64900V.AUDVADR AS Ejers_udvidede_adresse,
				JY64900V.APOST AS Postdistrikt,
				JY67500V.CBENYT AS Benyttelseskode,
				CAST(QL61500V.TEKST AS VARCHAR(70)) AS Benyttelse,
				JY64900V.CMSTAT AS Ejers_statuskode,
				CAST(QL63200V.TEKST AS VARCHAR(75)) AS Ejerstatus,
				JY64900V.CPENS AS Pensionistkode,
				CAST(QL63400V.TEKST AS VARCHAR(75)) AS Pensioniststatus,
				JY64900V.CLEJE AS Lejeværdikode,
				CAST(QL63500V.TEKST AS VARCHAR(75)) AS Lejeværdi,
				JY64900V.CBSKADR AS Kode_for_adressebeskyttelse,
				CAST(QL63600V.TEKST AS VARCHAR(75)) AS Adressebeskyttelse,
				JY64900V.DSLUTS AS Slutseddeldato,
				JY64900V.DSKOED AS Skødedato,
				JY64900V.DOVTG AS Overtagelsesdato,
				CAST(QL63700V.TEKST AS VARCHAR(75)) AS Overdragelsesmåde,
				JY64900V.BKOEBS AS Købesum,
				CAST(CAST(JY64900V.GKOETAEL AS varchar(6)) + '/' + CAST(JY64900V.GKOENAEV AS varchar(6)) AS varchar(12)) AS Køberandel,
				CAST(CAST(JY64900V.GEJTAEL AS varchar(6)) + '/' + CAST(JY64900V.GEJNAEV AS varchar(6)) AS varchar(12)) AS Ejerandel,
				JY64900V.DCPRCIR AS Ejer_CPR_CVR,
				JY67700V.VEJ_KODE AS Vejkode,
				JY67700V.HUS_NUMMER AS Husnummer_bogstav,
				JY67300V.CELAV AS Ejerlavskode,
				CASE
					WHEN RTRIM(CONVERT(VARCHAR,  JY67700V.MATRIKELNR) + JY67700V.MATRIKELBOGSTAV)<>''
					THEN RTRIM(CONVERT(VARCHAR,  JY67700V.MATRIKELNR) + JY67700V.MATRIKELBOGSTAV)
					ELSE RTRIM(JY67300V.AMATBOG)
				END AS MATNR,
				CASE
					WHEN JY67700V.LANDSEJERLAVSTEKST<>''
					THEN JY67700V.LANDSEJERLAVSTEKST
					ELSE JY63500V.CELAVLATXT
				END AS LANDSEJERLAVSTEKST,
				JY67300V.EPCEL AS Parcelnummer,
				CAST(QL61000V.TEKST AS VARCHAR(75)) AS Artskode,
				JY67300V.FMATAR AS Matrikulært_areal,
				JY67300V.FVEJ AS Matrikulært_vejareal,
				JY67500V.FTOTAR AS Ejendomsareal,
				JY67500V.FTOTVEJ AS Heraf_vejareal,
				JY67500V.FARVUR AS Vurderet_areal,
				JY67500V.FVEJVUR AS Heraf_vurderet_vejareal,
				JY67500V.CEJFORH AS Ejerforholdskode,
				CAST(QL50000V.TEKST AS VARCHAR(133)) AS Ejerforhold,
				JY67500V.FEJER AS Antal_ejere,
				JY67500V.FLEJL AS Antal_lejligheder,
				JY67500V.EMODER AS Moderejendomsnummer,
				JY67500V.COFVEJ AS Adgang_til_offentlig_vej,
				JY67500V.CBSKADRA AS Admin_adressebeskyttelse,
				JY67500V.AANAVN AS Administrators_navn,
				JY67500V.AACONAVN AS Administrators_CO_navn,
				JY67500V.AAADRESS AS Administrators_adresse,
				JY67500V.AAUDVADR AS Administrators_udv_adresse,
				JY67500V.AAPOST AS Administrators_postdistrikt,
				JY67500V.EADMNR AS Administratornummer,
				JY67500V.DCPRADM AS Administrators_CPR_CVR,
				JY67500V.CADM AS Administratorkode,
				QL65000V.TEKST AS Administratorstatus,
				JY67300V.EJERLEJLIGHEDSNR,
				CASE
					WHEN CONVERT(VARCHAR, JY67700V.KOMMUNENUMMER)<>''
						THEN CONVERT(VARCHAR, JY67700V.KOMMUNENUMMER) + RIGHT('0000' + CONVERT(VARCHAR,  JY67700V.VEJ_KODE), 4) + RTRIM(JY67700V.HUS_NUMMER)
						ELSE CONVERT(VARCHAR, JY67500V.EKOMNR) + RIGHT('0000' + CONVERT(VARCHAR,  JY67500V.VEJ_KODE), 4) + RTRIM(JY67500V.HUS_NUMMER)
				END AS ADRESSELINK_ID,
				CASE
					WHEN CONVERT(VARCHAR, JY67700V.KOMMUNENUMMER)<>''
						THEN CONVERT(VARCHAR, JY67700V.KOMMUNENUMMER) + CONVERT(VARCHAR, JY67700V.VEJ_KODE) + CONVERT(VARCHAR, JY67700V.HUS_NUMMER)
						ELSE CONVERT(VARCHAR, JY67500V.EKOMNR) + CONVERT(VARCHAR,  JY67500V.VEJ_KODE) + RTRIM(JY67500V.HUS_NUMMER)
				END AS ADRESSE_ID,
				CASE
					WHEN CONVERT(VARCHAR, JY67700V.KOMMUNENUMMER)<>''
						THEN CONVERT(VARCHAR, CONVERT(VARCHAR, JY67700V.KOMMUNENUMMER) + CONVERT(VARCHAR, JY67700V.VEJ_KODE) + CONVERT(VARCHAR, JY67700V.HUS_NUMMER) + LTRIM(RTRIM(REPLACE(JY67700V.ETAGE, ' ', '')))+ LTRIM(RTRIM(REPLACE(JY67700V.SIDE_DOERNR, ' ', ''))))
						ELSE CONVERT(VARCHAR, JY67500V.EKOMNR) + CONVERT(VARCHAR,  JY67500V.VEJ_KODE) + RTRIM(JY67500V.HUS_NUMMER)
				END AS UDVADRESSEID,
				CASE
					WHEN CONVERT (VARCHAR, JY67300V.AMATBOG)<>''
						THEN CONVERT(VARCHAR, JY67300V.CLELAV) + '' + CONVERT (VARCHAR, JY67300V.AMATBOG)
						ELSE CONVERT(VARCHAR, JY63500V.CELAVLA) + '' +  RTRIM(JY67500V.AMATBOG)
				END AS MatrikelID
FROM
				QL63600V LEFT OUTER JOIN
				QL50000V RIGHT OUTER JOIN
				QL63500V RIGHT OUTER JOIN
				QL63200V RIGHT OUTER JOIN
				JY64900V RIGHT OUTER JOIN
				QL61000V RIGHT OUTER JOIN
				JY67300V LEFT OUTER JOIN
				JY67700V ON JY67300V.EEJDNR = JY67700V.EJENDOMSNR
				AND JY67300V.ABGSTM = JY67700V.MATRIKELBOGSTAV
				AND JY67300V.EMATNR = JY67700V.MATRIKELNR
				AND JY67300V.CLELAV = JY67700V.LANDSEJERLAVSKODE LEFT OUTER JOIN
				JY67500V ON JY67300V.EEJDNR = JY67500V.EEJDNR LEFT OUTER JOIN
				JY63500V ON JY67500V.CELAV = JY63500V.CELAV LEFT OUTER JOIN
				QL65000V ON JY67500V.CADM = QL65000V.KODE ON QL61000V.KODE = JY67500V.CARTK LEFT OUTER JOIN
				QL61500V ON JY67500V.CBENYT = QL61500V.KODE ON JY64900V.EEJDNR = JY67300V.EEJDNR LEFT OUTER JOIN
				QL63700V ON JY64900V.COVMD = QL63700V.KODE LEFT OUTER JOIN
				QL63400V ON JY64900V.CPENS = QL63400V.KODE ON QL63200V.KODE = JY64900V.CMSTAT ON
				QL63500V.KODE = JY64900V.CLEJE ON QL50000V.KODE = JY64900V.CEJFORH ON QL63600V.KODE = JY64900V.CBSKADR

WHERE
				(JY67500V.CARTK IN (2, 3, 8, 9, 20, 32, 33, 38, 39, 40)) AND (JY67500V.CBENYT <> '16')
        -- CBENYT <>16: Alle ejendomme, som ikke er udgåede
        -- Der er benyttet CAST til alle tekster fra kodetabeller, selvom det ikke måtte være nødvendigt. Jeg gør det af hensyn til MapInfo, som ellers vil tildele felterne 254 karakterer.
        -- Oktober 2016: Viewet er ændret til at bruge JY67300V - DIMatrikel - som grundlæggende tabel. Hermed får man en entydig MatrikelID. Der er dog stadig nogle fejlregistreringer, som gør, at vi har syv matrikler, som ikke kan joines på MatrikelID. Der er simpelthen ikke overensstemmelse mellem reigstreringen i matriklen og i ESR.
