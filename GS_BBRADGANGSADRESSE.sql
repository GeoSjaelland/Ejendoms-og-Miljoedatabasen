SELECT
				(RTRIM(dbo.JY72000V.VEJADRNAVN) + ' ' + REPLACE(LTRIM(REPLACE(dbo.JY72000V.HUS_NR, '0', ' ')), ' ', '0')) AS Adresse,
				JY72000V.VEJADRNAVN AS Vejadresseringsnavn,
				JY72000V.HUS_NR AS Husnummer,
				JY72000V.SUPBYNAVN AS Bynavn,
				JY72000V.POSTNR AS Postnummer,
				JY72000V.POSTBYNAVN AS Postdistriktnavn,
				JY72000V.BYGNAVN AS Lokalitet,
				CAST(dbo.JY72000V.KOMMUNENUMMER AS VarChar(3)) + CAST(dbo.JY72000V.VEJKODE AS VarChar(4)) + JY72000V.HUS_NR AS ADRESSE_ID,
				JY72000V.KOMMUNENUMMER AS Kommunenummer,
				JY72000V.VEJKODE AS Vejkode,
				JY72000V.ADG_ID AS Id_Adgangsadresse,
				JY72000V.ADRPKTKILDE AS Kilde_til_adressekode,
				QL29400V.TEKST AS Kilde_til_adgangsadressen,
				JY72000V.OPRETTELSESDATO AS Oprettelsesdato,
				JY72000V.IKRAFTTRAEDDATO AS Ikrafttrædelsesdato,
				JY72000V.SENESTEAENDRDATO AS Seneste_ændringsdato,
				JY72000V.NEDLAEGDATO AS Dato_for_nedlæggelse,
				JY72000V.APU_ID AS Adressepunkt_Id,
				JY72000V.ADRPKTNOEJAGTIGKLS AS Nøjagtighedsklassekode,
				QL29500V.TEKST AS Nøjagtighedsklasse,
				JY72000V.ADG_KOMFELT1 AS Kommunalt_felt_1,
				JY72000V.ADG_KOMFELT2 AS Kommunalt_felt_2,
				JY72000V.ADG_KOMFELT3 AS Kommunalt_felt_3,
				JY72000V.KOMFELT4 AS Kommunalt_felt_4,
				JY72000V.KOMFELT5 AS Kommunalt_felt_5,
				JY72000V.KOMFELT6 AS Kommunalt_felt_6,
				JY72000V.JOURNR AS Journalnummer,
				JY72000V.ESDH_REF AS ESDH_Reference,
				JY72000V.OPRET_TS AS Opret_timestamp,
				JY72000V.AENDR_TS AS Ændret_timestamp,
				JY72000V.OPHOERT_TS AS Ophørt_timestamp,
				JY72000V.VEJ_NAVN AS Vejnavn,
				JY72000V.ENTYDIGVEJ AS Entydig_vejnavn,
				JY72000V.BEREGN AS Beregn,
				JY72000V.KOMKODE AS Kommunenr_KMS,
				JY72000V.EREF AS Feltreference,
				JY72000V.LANDSEJERLAVKODE AS Landsejerlav,
				JY72000V.KOMEJERLAVKODE AS Kommunal_ejerlavskode,
				JY72000V.MATRNR AS KMS_Matrikelnummer,
				JY72000V.ESREJDNR AS Ejendomsnummer_ESR,
				JY72000V.MATR_ART_KODE AS Matrikel_artskode,
				JY72000V.DELNR AS Delnummer,
				JY72000V.OPDELINGSNR AS Opdelingsnummer,
				JY72000V.MATRIKELNR AS Matrikelnummer,
				JY72000V.MATRIKELBOGSTAV AS Matrikelbogstav,
				JY73200V.KOOROEST,
				JY73200V.KOORNORD,
				JY73200V.TXTRETN
FROM
				JY72000V LEFT OUTER JOIN
				JY73200V ON
				JY72000V.APU_ID = JY73200V.APU_ID LEFT OUTER JOIN
				QL29500V ON
				JY72000V.ADRPKTNOEJAGTIGKLS = QL29500V.KODE LEFT OUTER JOIN
				QL29400V ON
				JY72000V.ADRPKTKILDE = QL29400V.KODE