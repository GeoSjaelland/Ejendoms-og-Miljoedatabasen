SELECT
				A.PNR,
				A.CVRNR AS CVR_nummer,
				A.NAVN_1,
				A.NAVN_2,
				A.NAVN_3,
				A.NAVN,
				A.CO_NAVN_OFF,
				RTRIM(LTRIM(RTRIM(A.VEJNAVN_OFF) + ' ' + CONVERT(VARCHAR, A.HUSNR_FRA_OFF) + RTRIM(LTRIM(A.BOGST_FRA_OFF))  + ' ' + RTRIM(LTRIM(A.ETAGE_OFF)) + ' ' + RTRIM(LTRIM(A.SIDE_DOER_OFF)))) AS Officiel_adresse,
				A.POSTNR_OFF AS Postnummer,
				A.POSTDIST_OFF AS Postdistrikt,
				A.ENH_STARTDATO AS Startdato_CVR_P_nummer,
				A.BRANCHE AS Hovedbranchekode,
				QL57200V.TEKST AS Hovedbranche,
				A.BIBRANCHE_1 AS Bibranchekode_1,
				QL57200V_1.TEKST AS Bibranche_1,
				A.BIBRANCHE_2 AS Bibranchekode_2,
				QL57200V_2.TEKST AS Bibranche_2,
				A.BIBRANCHE_3 AS Bibranchekode_3,
				QL57200V_3.TEKST AS Bibranche_3,
				A.STR_KODE AS St�rrelseskode,
				QL57100V.TEKST AS Virksomhedsst�rrelse,
				A.ANT_ANS AS Antal_ansatte,
				A.TELEFONNUMMER,
				A.TELEFAX,
				A.E_MAIL AS Email,
				A.ENH_AJDATO AS Ajourf_dato_CVR_P_nummer,
				A.ENH_OPHOER_DATO AS Oph�rsdato,
				A.KMD_AJOURFOER_TS AS Ajourf�ringdato_CVR_EogM,
				CONVERT(char(1), A.ARC)  AS Opdateringskode_CVR,
				A.KOM_ID_OFF AS Kommunenummer,
				A.VEJKODE_OFF AS Vejkode,
				A.HUSNR_FRA_OFF AS Husnummer,
				A.BOGST_FRA_OFF AS Husbogstav,
				A.ETAGE_OFF AS Etage,
				A.SIDE_DOER_OFF AS Side_d�rnr,
				JY72000V.ESREJDNR,
				CONVERT(varchar, JY72000V.LANDSEJERLAVKODE) + CONVERT(varchar, JY72000V.MATRNR) AS MATRIKELID,
				CONVERT(varchar, A.KOM_ID_OFF)  + RIGHT('0000' + CONVERT(VARCHAR, A.VEJKODE_OFF), 4) + RIGHT('000' + CONVERT(VARCHAR, A.HUSNR_FRA_OFF), 3) + RTRIM(A.BOGST_FRA_OFF)  AS ADRESSELINK_ID,
				CONVERT(varchar, A.KOM_ID_OFF) + CONVERT(varchar, A.VEJKODE_OFF) + RIGHT('000' + CONVERT(VARCHAR, A.HUSNR_FRA_OFF), 3) + RTRIM(A.BOGST_FRA_OFF) AS ADRESSE_ID,
				JY72000V.ADG_ID
FROM
				AG01100T AS A INNER JOIN
				AG01000T AS B ON A.CVRNR = B.CVRNR LEFT OUTER JOIN
				QL57200V ON A.BRANCHE = QL57200V.KODE LEFT OUTER JOIN
				QL57200V AS QL57200V_1 ON A.BIBRANCHE_1 = QL57200V_1.KODE LEFT OUTER JOIN
				QL57200V AS QL57200V_2 ON A.BIBRANCHE_2 = QL57200V_2.KODE LEFT OUTER JOIN
				QL57200V AS QL57200V_3 ON A.BIBRANCHE_3 = QL57200V_3.KODE LEFT OUTER JOIN
				QL57100V ON A.STR_KODE = QL57100V.KODE LEFT OUTER JOIN
				JY72000V ON CONVERT(varchar, A.KOM_ID_OFF) + CONVERT(varchar, A.VEJKODE_OFF) + RIGHT('000' + CONVERT(VARCHAR, A.HUSNR_FRA_OFF), 3)  + RTRIM(A.BOGST_FRA_OFF) = CONVERT(varchar, JY72000V.KOMMUNENUMMER) + CONVERT(varchar, JY72000V.VEJKODE)  + RTRIM(JY72000V.HUS_NR)
WHERE
				(A.KOM_ID_OFF = 336) AND (A.ENH_OPHOER_DATO > { fn NOW() }) AND (B.ENH_OPHOER_DATO > { fn NOW() }) AND (A.KMD_GYLDIG_TIL > { fn NOW() }) AND  (B.KMD_GYLDIG_TIL > { fn NOW() })