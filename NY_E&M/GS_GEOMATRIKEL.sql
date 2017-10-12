SELECT
				Jordstykke.MATRNR + ', ' + Jordstykke.ELAVSNAVN AS Søg,
				CAST(RTRIM(Matrikeladresse.VEJ_ADRESSENAVN) + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(Matrikeladresse.HUS_NUMMER), '0', ' ')), ' ', '0') AS VARCHAR(80)) AS Matrikeladresse,
				CASE WHEN DIMatrikel.EEJDNR > 0
				THEN DIMatrikel.EEJDNR
				ELSE CONVERT(INT, RIGHT(CONVERT(VARCHAR,Jordstykke.esr_ejdnr),5))
				END AS Ejendomsnummer,
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
				CAST('Pen (1,2,0) Brush (1,0,16777215)' AS varchar(254)) AS MI_STYLE,
				Jordstykke.OBJECTID,
				Jordstykke.Shape,
				CASE WHEN CONVERT(VARCHAR,
					Jordstykke.MATRNR) <> ''
					THEN CONVERT(VARCHAR, Jordstykke.ELAVSKODE) + '' + CONVERT(VARCHAR,	Jordstykke.MATRNR)
				END AS MatrikelID,
				Matrikeladresse.EJENDOMSNR AS EJD_NR,
				Jordstykke.ELAVSKODE AS Landsejerlavskode,
				DIMatrikel.CARTK AS Artskode,
				QL61000V.TEKST AS Matrikeltype


FROM
				CA_GEO_Jordstykker AS Jordstykke INNER JOIN
				JN67100T AS Kommunetabel ON Jordstykke.KOMKODE = Kommunetabel.KOMMUNENUMMER LEFT OUTER JOIN
        QL60400V RIGHT OUTER JOIN
        QL61000V RIGHT OUTER JOIN
        JY67300V AS DIMatrikel ON QL61000V.KODE = DIMatrikel.CARTK LEFT OUTER JOIN
        JY67700V AS Matrikeladresse ON DIMatrikel.EEJDNR = Matrikeladresse.EJENDOMSNR AND DIMatrikel.CLELAV = Matrikeladresse.LANDSEJERLAVSKODE AND
        DIMatrikel.ABGSTM = Matrikeladresse.MATRIKELBOGSTAV AND DIMatrikel.EMATNR = Matrikeladresse.MATRIKELNR ON
        QL60400V.KODE = DIMatrikel.CZONE ON Jordstykke.MATRNR = DIMatrikel.AMATBOG AND Jordstykke.ELAVSKODE = DIMatrikel.CLELAV
