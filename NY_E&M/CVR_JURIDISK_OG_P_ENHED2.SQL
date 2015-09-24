SELECT
				JUR.beliggenhedsadresse_kommune_kode AS Kommunenummer,
				JUR.cvrnr AS CVR_nummer,
				P.PNR AS P_NUMMER,
				JUR.navn_tekst AS JUR_Navn,
				P.navn_tekst AS PNR_Navn,
				JUR.beliggenhedsadresse_coNavn AS JUR_CO_Navn,
				(RTRIM(JUR.beliggenhedsadresse_vejnavn) + ' ' + CONVERT(VARCHAR,JUR.beliggenhedsadresse_husnummerFra)+LTRIM(JUR.beliggenhedsadresse_bogstavFra)+
				CASE
					WHEN JUR.beliggenhedsadresse_etage <> '' Then ', '
					WHEN JUR.beliggenhedsadresse_etage ='' AND  JUR.beliggenhedsadresse_sidedoer <> '' Then ', '
					ELSE ''
				END
				+ RTRIM(JUR.beliggenhedsadresse_etage)+
				CASE
					WHEN JUR.beliggenhedsadresse_etage <> '' Then '.'
					ELSE ''
				END
				+ JUR.beliggenhedsadresse_sidedoer) AS JUR_Adresse,
					JUR.beliggenhedsadresse_bynavn AS JUR_Bynavn,
				JUR.beliggenhedsadresse_postnr AS JUR_Postnummer,
				JUR.beliggenhedsadresse_postdistrikt AS JUR_Postdistrikt,
				JUR.livsforloeb_startdato AS Startdato_CVR_nummer,
				JUR.hovedbranche_kode AS JUR_Hovedbranchekode,
				JUR.hovedbranche_tekst AS JUR_Hovedbranche,
				JUR.bibranche1_kode AS JUR_bibranchekode_1,
				JUR.bibranche1_tekst AS JUR_Bibranche_1,
				JUR.bibranche2_kode AS JUR_Bibranchekode_2,
				JUR.bibranche2_tekst AS JUR_Bibranche_2,
				JUR.bibranche3_kode AS JUR_Bibranchekode_3,
				JUR.bibranche3_tekst AS JUR_Bibranche_3,
				JUR.VIRKSOMHEDSFORM_KODE AS Virksomhedsformkode,
				JUR.virksomhedsform_tekst AS Virksomhedsform,
				CASE
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '0' then 'B'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '1' then 'C'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '2 - 4' then 'D'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '5 - 9' then 'E'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '10 - 19' then 'F'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '20 - 49' then 'G'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '50 - 99' then 'H'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '100 - 199' then 'I'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '200 - 499' then 'J'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '500 - 999' then 'K'
				  WHEN JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '1000+' then 'L'
				  else 'M'
				END AS JUR_Stoerrelseskode,
				JUR.aarsbeskaeftigelse_antalAnsatteInterval AS JUR_Virksomhedsstoerrelse,
				JUR.aarsbeskaeftigelse_antalAnsatte AS JUR_Antal_ansatte,
				JUR.telefonnummer_kontaktoplysning AS JUR_Telefonnummer,
				JUR.telefax_kontaktoplysning AS JUR_Telefax,
				JUR.email_kontaktoplysning AS JUR_Email,
				JUR.kreditoplysninger_tekst AS JUR_Kreditoplysning,
				0 AS Kreditstatus,
				JUR.ajourfoeringsdato AS Ajourf_dato_CVR_P_nummer,
				JUR.livsforloeb_ophoersdato AS Ophoersdato,
				P.beliggenhedsadresse_coNavn AS PNR_CO_Navn,
				RTRIM(LTRIM(RTRIM(P.beliggenhedsadresse_vejnavn) + ' '
					+ CONVERT(VARCHAR, P.beliggenhedsadresse_husnummerFra)
					+ RTRIM(LTRIM(P.beliggenhedsadresse_bogstavFra))  + ' '
					+ RTRIM(LTRIM(P.beliggenhedsadresse_etage)) + ' '
					+ RTRIM(LTRIM(P.beliggenhedsadresse_sidedoer))))
					AS PNR_adresse,
				P.beliggenhedsadresse_postnr AS PNR_Postnummer,
				P.beliggenhedsadresse_postdistrikt AS PNR_Postdistrikt,
				P.hovedbranche_kode AS PNR_Hovedbranchekode,
				P.hovedbranche_tekst AS PNR_Hovedbranche,
				P.bibranche1_kode AS PNR_Bibranchekode_1,
				P.bibranche1_tekst AS PNR_Bibranche_1,
				P.bibranche2_kode AS PNR_Bibranchekode_2,
				P.bibranche2_tekst AS PNR_Bibranche_2,
				P.bibranche3_kode AS PNR_Bibranchekode_3,
				P.bibranche3_tekst AS PNR_Bibranche_3,
				ADG.ESREjdNr,
				CONVERT(varchar, ADG.LANDSEJERLAVKODE) + CONVERT(varchar, ADG.MATRNR) AS MATRIKELID,
				CONVERT(varchar, P.beliggenhedsadresse_kommune_kode) +
					RIGHT('0000' + CONVERT(VARCHAR, P.beliggenhedsadresse_vejkode), 4) +
					RIGHT('000' + CONVERT(VARCHAR, P.beliggenhedsadresse_husnummerFra), 3) +
					RTRIM(P.beliggenhedsadresse_bogstavFra)
					AS ADRESSELINK_ID,
				CONVERT(varchar, P.beliggenhedsadresse_kommune_kode) +
					CONVERT(varchar, P.beliggenhedsadresse_vejkode) +
					RIGHT('000' + CONVERT(VARCHAR, P.beliggenhedsadresse_husnummerFra), 3) +
					RTRIM(P.beliggenhedsadresse_bogstavFra)
					AS ADRESSE_ID,
				ADG.ADG_ID
FROM
				CV00100T AS JUR
				Right Join CV00200T AS P on
				JUR.cvrnr = P.virksomhed_cvrnr
				Left Join dbo.JY72000V AS ADG on
				P.beliggenhedsadresse_kommune_kode = ADG.KomKode
				and P.beliggenhedsadresse_vejkode = ADG.VejKode
				and RIGHT('000' + CONVERT(VARCHAR, P.beliggenhedsadresse_husnummerFra), 3) +
				RTRIM(P.beliggenhedsadresse_bogstavFra) = ADG.HUS_NR
WHERE
				P.beliggenhedsadresse_kommune_kode=336
