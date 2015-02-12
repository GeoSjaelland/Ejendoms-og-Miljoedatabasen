SELECT
				CAST(RTRIM(JY72000V.VEJADRNAVN + ' ' + REPLACE(LTRIM(REPLACE(RTRIM(JY72000V.HUS_NR), '0', ' ')), ' ', '0')) AS VARCHAR(50)) AS Adresse,
				KOMMUNENUMMER AS Kommunenummer,
				EJENDOMSNR AS Ejendomsnummer,
				OPG_ID AS Opgang_Id,
				ADG_ID AS Id_Adgangsadresse,
				BYG_ID AS Bygningsident,
				ELEVATOR AS Elevatorkode,
				QL27000V.TEKST AS Elevator,
				OPG_KOMFELT1 AS Kommunalt_felt_1,
				OPG_KOMFELT2 AS Kommunalt_felt_2,
				OPG_KOMFELT3 AS Kommunalt_felt_3,
				KOMFELT4 AS Kommunalt_felt_4,
				KOMFELT5 AS Kommunalt_felt_5,
				KOMFELT6 AS Kommunalt_felt_6,
				JOURNR AS Journalnummer,
				ESDH_REF AS ESDH_Reference,
				OPRET_TS AS Opret_timestamp,
				AENDR_TS AS Ændret_timestamp,
				OPHOERT_TS AS Ophørt_timestamp,
				GYLDIGHEDSDATO AS Gyldighedsdato,
				VEJ_KODE AS Vejkode,
				HUS_NUMMER AS Husnummer_bogstav,
				CAST(JY70200V.KOMMUNENUMMER AS varchar(3)) + RIGHT('0000'+ CONVERT(VARCHAR,JY70200V.VEJ_KODE),4)+ RTRIM(JY70200V.HUS_NUMMER) AS ADRESSELINK_ID,
				CAST(JY70200V.KOMMUNENUMMER AS varchar(3)) + CAST(JY70200V.VEJ_KODE AS varchar(4)) + RTRIM(JY70200V.HUS_NUMMER) AS ADRESSE_ID
FROM
        QL27000V RIGHT OUTER JOIN
        JY70200V LEFT OUTER JOIN
        JY72000V ON JY70200V.ADG_ID = JY72000V.ADG_ID ON QL27000V.KODE = JY70200V.ELEVATOR