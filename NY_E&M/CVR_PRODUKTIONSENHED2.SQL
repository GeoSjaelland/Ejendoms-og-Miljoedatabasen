SELECT
				A.pnr AS P_NUMMER,
				A.virksomhed_cvrnr AS CVR_Nummer,
				A.navn_tekst AS Navn,
				A.beliggenhedsadresse_coNavn AS CO_Navn,
				(RTRIM(A.beliggenhedsadresse_vejnavn) + ' ' + CONVERT(VARCHAR,A.beliggenhedsadresse_husnummerFra)+LTRIM(A.beliggenhedsadresse_bogstavFra)+
				CASE
					WHEN A.beliggenhedsadresse_etage <> '' Then ', '
					WHEN A.beliggenhedsadresse_etage ='' AND  A.beliggenhedsadresse_sidedoer <> '' Then ', '
					ELSE ''
				END
				+ RTRIM(A.beliggenhedsadresse_etage)+
				CASE
					WHEN A.beliggenhedsadresse_etage <> '' Then '.'
					ELSE ''
				END
				+ A.beliggenhedsadresse_sidedoer) AS Adresse,
				A.beliggenhedsadresse_bynavn,
				A.beliggenhedsadresse_postnr AS Postnummer,
				A.beliggenhedsadresse_postdistrikt AS Postdistrikt,
				A.livsforloeb_startdato AS Startdato_CVR_P_Nummer,
				A.hovedbranche_kode AS Hovedbranchekode,
				A.hovedbranche_tekst AS Hovedbranche,
				A.bibranche1_kode AS Bibranchekode_1,
				A.bibranche1_tekst AS Bibranche_1,
				A.bibranche2_kode AS Bibranchekode_2,
				A.bibranche2_tekst AS Bibranche_2,
				A.bibranche3_kode AS Bibranchekode_3,
				A.bibranche3_tekst AS Bibranche_3,
				CASE
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '0' Then 'B'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '1' Then 'C'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '2 - 4' Then 'D'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '5 - 9' Then 'E'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '10 - 19' Then 'F'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '20 - 49' Then 'G'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '50 - 99' Then 'H'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '100 - 199' Then 'I'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '200 - 499' Then 'J'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '500 - 999' Then 'K'
				  WHEN A.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '1000+' Then 'L'
				  else 'M'
				END AS Stoerrelseskode,
				A.aarsbeskaeftigelse_antalAnsatteInterval AS Virksomhedsstoerrelse,
				A.aarsbeskaeftigelse_antalAnsatte AS Antal_ansatte,
				A.telefonnummer_kontaktoplysning AS Telefonnummer,
				A.telefax_kontaktoplysning AS Telefax,
				A.email_kontaktoplysning AS Email,
				A.ajourfoeringsdato AS Ajourf_dato_CVR_P_nummer,
				A.livsforloeb_ophoersdato AS Ophoersdato,
				A.beliggenhedsadresse_kommune_kode AS Kommunenummer,
				ADG.ESREJDNR AS ESREjdnr,
				A.beliggenhedsadresse_vejkode AS Vejkode,
				A.beliggenhedsadresse_husnummerFra AS Husnr_Fra,
				A.beliggenhedsadresse_husnummerTil AS Husnr_Til,
				A.beliggenhedsadresse_bogstavFra AS Husbogstav_Fra,
				A.beliggenhedsadresse_bogstavTil AS Husbogstav_Til,
				A.beliggenhedsadresse_etage AS Etage,
				A.beliggenhedsadresse_sidedoer AS Side_dørnr,
				CONVERT(varchar, ADG.LANDSEJERLAVKODE) + CONVERT(varchar, ADG.MATRNR) AS Matrikel_ID,
				CONVERT(varchar, A.beliggenhedsadresse_kommune_kode)  + RIGHT('0000' + CONVERT(VARCHAR, A.beliggenhedsadresse_vejkode), 4) + RIGHT('000' + CONVERT(VARCHAR, A.beliggenhedsadresse_husnummerFra), 3) + RTRIM(A.beliggenhedsadresse_bogstavFra)  AS AdresseLink_ID,
				CONVERT(varchar, A.beliggenhedsadresse_kommune_kode) + CONVERT(varchar, A.beliggenhedsadresse_vejkode) + RIGHT('000' + CONVERT(VARCHAR, A.beliggenhedsadresse_husnummerFra), 3) + RTRIM(A.beliggenhedsadresse_bogstavFra) AS Adresse_ID,
				ADG.ADG_ID
FROM
				CV00200T AS A LEFT OUTER JOIN
				CV00100T AS B ON A.virksomhed_cvrnr = B.cvrnr LEFT OUTER JOIN
				JY72000V AS ADG ON
				A.beliggenhedsadresse_kommune_kode = ADG.KomKode
				AND A.beliggenhedsadresse_vejkode = ADG.VejKode
				AND RIGHT('000' + CONVERT(VARCHAR, A.beliggenhedsadresse_husnummerFra), 3)  + RTRIM(A.beliggenhedsadresse_bogstavFra) = ADG.HUS_NR
WHERE	A.beliggenhedsadresse_kommune_kode = 336
	AND (A.livsforloeb_ophoersdato = '' or A.livsforloeb_ophoersdato > GetDate())

	-- livsforloeb_ophoersdato er ikke oprettet som date i tabellen, så sidste betingelse er lidt meningsløs...