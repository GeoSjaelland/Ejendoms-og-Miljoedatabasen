SELECT
				JUR.beliggenhedsadresse_kommune_kode as Kommunenummer,
				JUR.cvrnr as CVR_nummer,
				P.PNR AS P_NUMMER,
				JUR.navn_tekst as Navn,
				P.navn_tekst as PNR_navn,
				JUR.beliggenhedsadresse_coNavn as CO_Navn,
				RTRIM(LTRIM(RTRIM(JUR.beliggenhedsadresse_vejnavn) + ' '
					+ CONVERT(VARCHAR, JUR.beliggenhedsadresse_husnummerFra)
					+ RTRIM(LTRIM(JUR.beliggenhedsadresse_bogstavFra))  + ' '
					+ RTRIM(LTRIM(JUR.beliggenhedsadresse_etage)) + ' '
					+ RTRIM(LTRIM(JUR.beliggenhedsadresse_sidedoer))))
					AS JUR_Adresse,
					JUR.beliggenhedsadresse_bynavn AS Bynavn,
				JUR.beliggenhedsadresse_postnr as Postnummer,
				JUR.beliggenhedsadresse_postdistrikt as Postdistrikt,
				JUR.livsforloeb_startdato as Startdato_CVR_nummer,
				JUR.hovedbranche_kode as JUR_Hovedbranchekode,
				JUR.hovedbranche_tekst as JUR_Hovedbranche,
				JUR.bibranche1_kode as JUR_bibranchekode_1,
				JUR.bibranche1_tekst as JUR_Bibranche_1,
				JUR.bibranche2_kode as JUR_Bibranchekode_2,
				JUR.bibranche2_tekst as JUR_Bibranche_2,
				JUR.bibranche3_kode as JUR_Bibranchekode_3,
				JUR.bibranche3_tekst as JUR_Bibranche_3,
				JUR.VIRKSOMHEDSFORM_KODE as Virksomhedsformkode,
				JUR.virksomhedsform_tekst as Virksomhedsform,
				CASE
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '0' then 'B'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '1' then 'C'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '2 - 4' then 'D'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '5 - 9' then 'E'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '10 - 19' then 'F'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '20 - 49' then 'G'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '50 - 99' then 'H'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '100 - 199' then 'I'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '200 - 499' then 'J'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '500 - 999' then 'K'
				  when JUR.AARSBESKAEFTIGELSE_ANTALANSATTEINTERVAL = '1000+' then 'L'
				  else 'M'
				END as Stoerrelseskode,
				JUR.aarsbeskaeftigelse_antalAnsatteInterval as Virksomhedsstoerrelse,
				JUR.aarsbeskaeftigelse_antalAnsatte AS Antal_ansatte,
				JUR.telefonnummer_kontaktoplysning as Telefonnummer,
				JUR.telefax_kontaktoplysning as Telefax,
				JUR.email_kontaktoplysning as Email,
				JUR.kreditoplysninger_tekst as Kreditoplysning,
				0 as Kreditstatus,
				JUR.ajourfoeringsdato as Ajourf_dato_CVR_P_nummer,
				JUR.livsforloeb_ophoersdato as Ophoersdato,
				P.beliggenhedsadresse_coNavn as PNR_CO_Navn,
				RTRIM(LTRIM(RTRIM(P.beliggenhedsadresse_vejnavn) + ' '
					+ CONVERT(VARCHAR, P.beliggenhedsadresse_husnummerFra)
					+ RTRIM(LTRIM(P.beliggenhedsadresse_bogstavFra))  + ' '
					+ RTRIM(LTRIM(P.beliggenhedsadresse_etage)) + ' '
					+ RTRIM(LTRIM(P.beliggenhedsadresse_sidedoer))))
					AS PNR_adresse,
				P.beliggenhedsadresse_postnr as PNR_Postnummer,
				P.beliggenhedsadresse_postdistrikt as PNR_Postdistrikt,
				P.hovedbranche_kode as PNR_Hovedbranchekode,
				P.hovedbranche_tekst as PNR_Hovedbranche,
				P.bibranche1_kode as PNR_Bibranchekode_1,
				P.bibranche1_tekst as PNR_Bibranche_1,
				P.bibranche2_kode as PNR_Bibranchekode_2,
				P.bibranche2_tekst as PNR_Bibranche_2,
				P.bibranche3_kode as PNR_Bibranchekode_3,
				P.bibranche3_tekst as PNR_Bibranche_3,
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
				CV00100T as JUR
				Right Join CV00200T as P on
				JUR.cvrnr = P.virksomhed_cvrnr
				Left Join dbo.JY72000V as ADG on
				P.beliggenhedsadresse_kommune_kode = ADG.KomKode
				and P.beliggenhedsadresse_vejkode = ADG.VejKode
				and RIGHT('000' + CONVERT(VARCHAR, P.beliggenhedsadresse_husnummerFra), 3) +
				RTRIM(P.beliggenhedsadresse_bogstavFra) = ADG.HUS_NR
WHERE
				P.beliggenhedsadresse_kommune_kode=336
