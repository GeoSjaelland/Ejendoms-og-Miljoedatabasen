SELECT
				Jordstykke.MATRNR + ', ' + Jordstykke.ELAVSNAVN AS Søg,
				RTRIM(Matrikeladresse.VEJ_ADRESSENAVN) + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(Matrikeladresse.HUS_NUMMER), '0', ' ')), ' ', '0') AS Matrikeladresse,
				DIMatrikel.EEJDNR AS Ejendomsnummer,
				Jordstykke.ELAVSNAVN,
				Jordstykke.ELAVSKODE,
				Jordstykke.MATRNR,
				Jordstykke.FEAT_TYPE,
				Jordstykke.KMS_SAGSID,
				Jordstykke.KMS_JOURNR,
				Jordstykke.SKELSAGSID,
				Jordstykke.SUPMSAGSID,
				Jordstykke.KOMNAVN,
				Jordstykke.KOMKODE,
				DIMatrikel.CZONE AS Zonekode,
				QL60400V.TEKST AS Zonestatus,
				Jordstykke.SOGNNAVN,
				Jordstykke.SOGNKODE,
				Jordstykke.REGIONNAVN,
				Jordstykke.REGIONKODE,
				Jordstykke.RETSKRNAVN,
				Jordstykke.RETSKRKODE,
				Jordstykke.MODERJORD,
				Jordstykke.REGAREAL,
				Jordstykke.AREALBEREG,
				Jordstykke.VEJAREAL,
				Jordstykke.VEJAREALBE,
				Jordstykke.VANDAREALB,
				Jordstykke.FAELLESLOD,
				Jordstykke.ESR_EJDNR,
				Jordstykke.SFE_EJDNR,
				Jordstykke.SFE_SAGSID,
				Jordstykke.SFE_DATO,
				Jordstykke.SFE_JOURNR,
				Jordstykke.SFE_NOTE,
				Jordstykke.LAND_NOTE,
				Jordstykke.AREALTYPE,
				Jordstykke.DQ_INDEX,
				Jordstykke.REGISTDATO,
				Jordstykke.GEOMDATO,
				Jordstykke.PUBLIDATO,
				Jordstykke.MI_PRINX,
				Jordstykke.MI_STYLE,
				Jordstykke.OBJECTID,
				Jordstykke.Shape,
				CASE WHEN CONVERT(VARCHAR,
					Jordstykke.MATRNR) <> ''
					THEN CONVERT(VARCHAR,
					Jordstykke.ELAVSKODE) + '' + CONVERT(VARCHAR,	Jordstykke.MATRNR)
				END AS MatrikelID,
				Matrikeladresse.EJENDOMSNR AS EJD_NR

FROM
				QL60400V RIGHT OUTER JOIN
				JY67300V DIMatrikel ON QL60400V.KODE = DIMatrikel.CZONE RIGHT OUTER JOIN
				CA_GEO_Jordstykker Jordstykke INNER JOIN
				JN67100T Kommunetabel ON Jordstykke.KOMKODE = Kommunetabel.KOMMUNENUMMER LEFT OUTER JOIN
				JY67700V Matrikeladresse ON Jordstykke.ELAVSKODE = Matrikeladresse.LANDSEJERLAVSKODE AND Jordstykke.MATRNR = CONVERT(VARCHAR,
				Matrikeladresse.MATRIKELNR) + CONVERT(VARCHAR, Matrikeladresse.MATRIKELBOGSTAV) ON DIMatrikel.AMATBOG = Jordstykke.MATRNR AND
				DIMatrikel.CLELAV = Jordstykke.ELAVSKODE

WHERE
				(DIMatrikel.CARTK < 2)