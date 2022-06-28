
		select
            isnull(cast(ROW_NUMBER() OVER (ORDER BY (SELECT        '')) AS int), - 1) AS OBJECTID,
			bbr.regareal,
			bbr.vejareal,
			bbr.antal_byg,
			bbr.antal_parc,
			bbr.antal_raekke,
			bbr.antal_etage,
			bbr.antal_sommer,
			bbr.antal_andre,
			bbr.beb_areal,
			bbr.Byg_Bolig_Arl_Saml,
			bbr.erhv_areal,
			bbr.est_bebyggelsespct,
			bbr.est_bebyggelsespct_m_vejareal,
			bbr.etageareal,
			bbr.etageareal_foer_fradrag,
			bbr.fradrag_ialt,
			bbr.byg_arl_saml,
			bbr.byg_bebyg_arl_smaa_byg,
			bbr.TAGETAGEAREAL,
			bbr.KAELDERAREAL,
			bbr.KAELDER_ARL_U_125M,
			bbr.AABENOVERDAEKAREAL,
			bbr.AFFALDSRUM_ARL,
			bbr.GARAGE_INDB_ARL,
			bbr.CARPORT_INDB_ARL,
			bbr.UDHUS_INDB_ARL,
			bbr.Antal_bolig_enheder,
			bbr.sfe_ejendomsnummer,
			bbr.GEO_Matrikel,
			bbr.KommuneNummer,
			bbr.EjendomsNummer,
			bbr.EjerlavsNavn,
			bbr.LandsEjerlavKode,
			bbr.MatrikelIdent,
			bbr.MatrikelNummer,
			bbr.MatrikelBogstav,
			andre_jordstykker_list,
			jordstykker2.geometri

			FROM
					(select
						coalesce(count(BYG_ANVKODE),0) AS antal_byg,
						coalesce(SUM(CASE WHEN BYG_ANVKODE in (120,121) THEN 1 ELSE 0 END),0) as antal_parc,
						coalesce(SUM(CASE WHEN BYG_ANVKODE in (130,131,132) THEN 1 ELSE 0 END),0) as antal_raekke,
						coalesce(SUM(CASE WHEN BYG_ANVKODE=140 THEN 1 ELSE 0 END),0) as antal_etage,
						coalesce(SUM(CASE WHEN BYG_ANVKODE=510 THEN 1 ELSE 0 END),0) as antal_sommer,
						coalesce(SUM(CASE WHEN BYG_ANVKODE NOT IN (120,121,130,131,132,140,510) THEN 1 ELSE 0 END),0) as antal_andre,


						coalesce(SUM(byg_bebyg_arl),0) as beb_areal,
						coalesce(sum(Byg_Bolig_Arl_Saml),0) as Byg_Bolig_Arl_Saml,
						coalesce(sum(erhv_arl_saml),0) as erhv_areal,

						CAST(100*(coalesce(sum(etageareal_foer_fradrag),0)-(CASE WHEN sum(fradragsudgangspunkt) BETWEEN 0 AND (sum(max_fradrag_taet)+sum(max_fradrag_aaben)+sum(max_fradrag_andre)) THEN coalesce(sum(fradragsudgangspunkt),0) ELSE coalesce(sum(max_fradrag_taet),0)+coalesce(sum(max_fradrag_aaben),0)+coalesce(sum(max_fradrag_andre),0) END))/coalesce(regareal,0) AS DECIMAL(16,2)) as est_bebyggelsespct,
						coalesce(CASE WHEN regareal-vejareal > 0 THEN CAST(100*(sum(etageareal_foer_fradrag)-(CASE WHEN sum(fradragsudgangspunkt) BETWEEN 0 AND (sum(max_fradrag_taet)+sum(max_fradrag_aaben)+sum(max_fradrag_andre)) THEN sum(fradragsudgangspunkt) ELSE sum(max_fradrag_taet)+sum(max_fradrag_aaben)+sum(max_fradrag_andre) END))/(regareal-vejareal) AS DECIMAL(16,2)) ELSE 0 END,0) as est_bebyggelsespct_m_vejareal,
						coalesce(sum(etageareal_foer_fradrag),0)-coalesce((CASE WHEN sum(fradragsudgangspunkt) BETWEEN 0 AND (sum(max_fradrag_taet)+sum(max_fradrag_aaben)+sum(max_fradrag_andre)) THEN sum(fradragsudgangspunkt) ELSE sum(max_fradrag_taet)+sum(max_fradrag_aaben)+sum(max_fradrag_andre) END),0) AS etageareal,
						coalesce(sum(etageareal_foer_fradrag),0) AS etageareal_foer_fradrag,
                        coalesce((CASE WHEN sum(fradragsudgangspunkt) BETWEEN 0 AND (sum(max_fradrag_taet)+sum(max_fradrag_aaben)+sum(max_fradrag_andre)) THEN sum(fradragsudgangspunkt) ELSE sum(max_fradrag_taet)+sum(max_fradrag_aaben)+sum(max_fradrag_andre) END),0) AS fradrag_ialt,
                        coalesce(sum(byg_arl_saml),0) AS byg_arl_saml,
						sum(byg_bebyg_arl_smaa_byg) AS byg_bebyg_arl_smaa_byg,
						coalesce(sum(TAGETAGEAREAL),0) AS TAGETAGEAREAL,
						coalesce(sum(KAELDERAREAL),0) AS KAELDERAREAL,
						coalesce(sum(KAELDER_ARL_U_125M),0) AS KAELDER_ARL_U_125M,
						coalesce(sum(AABENOVERDAEKAREAL),0) AS AABENOVERDAEKAREAL,
						coalesce(sum(AFFALDSRUM_ARL),0) AS AFFALDSRUM_ARL,
						coalesce(sum(GARAGE_INDB_ARL),0) as GARAGE_INDB_ARL,
						coalesce(sum(CARPORT_INDB_ARL),0) as CARPORT_INDB_ARL,
						coalesce(sum(UDHUS_INDB_ARL),0) as UDHUS_INDB_ARL,
						coalesce(sum(Antal_bolig_enheder),0) AS Antal_bolig_enheder,
						regareal,
						vejareal,
						sfe_ejendomsnummer,
						GEO_Matrikel,
						KommuneNummer,
						EjendomsNummer,
						EjerlavsNavn,
						LandsEjerlavKode,
						MatrikelIdent,
						MatrikelNummer,
						MatrikelBogstav
					from
						(SELECT
							bygning.BYGANVENDELSEKODE as BYG_ANVKODE,
							CASE WHEN bygning.BYGANVENDELSEKODE BETWEEN 910 AND 5000 THEN bygning.byg_bebyg_arl ELSE 0 END AS byg_bebyg_arl_smaa_byg,
							bygning.byg_arl_saml,
							coalesce(bygning.tagetageareal,0) as TAGETAGEAREAL,
							coalesce(bygning.KAELDERAREAL,0) as KAELDERAREAL,
							coalesce(bygning.KAELDERAREAL_U125M,0) as KAELDER_ARL_U_125M,
							bygning.AABENOVERDAEKAREAL,
							bygning.AFFALDSRUM_ARL,
							bygning.Byg_Bolig_Arl_Saml,
							bygning.GARAGE_INDB_ARL,
							bygning.CARPORT_INDB_ARL,
							bygning.UDHUS_INDB_ARL,
							coalesce(enhed.Antal_bolig_enheder, 0) as Antal_bolig_enheder,
							CASE WHEN coalesce(enhed.Antal_bolig_enheder, 0) = 0 AND bygning.BYGANVENDELSEKODE BETWEEN 0 AND 900 THEN 1 ELSE 0 END AS anden_bebyggelse,
							(CASE WHEN bygning.BYGANVENDELSEKODE = 130 or bygning.BYGANVENDELSEKODE = 131 or bygning.BYGANVENDELSEKODE = 140 or  bygning.BYGANVENDELSEKODE = 150 or  bygning.BYGANVENDELSEKODE = 160  THEN 1 ELSE 0 END)*coalesce(enhed.Antal_bolig_enheder, 0)*20 AS max_fradrag_taet,
							(CASE WHEN bygning.BYGANVENDELSEKODE = 110 OR bygning.BYGANVENDELSEKODE = 120 OR bygning.BYGANVENDELSEKODE = 132  OR bygning.BYGANVENDELSEKODE = 510 THEN 1 ELSE 0 END)*coalesce(enhed.Antal_bolig_enheder, 0)*50 AS max_fradrag_aaben,
							(CASE WHEN coalesce(enhed.Antal_bolig_enheder, 0) = 0 AND bygning.BYGANVENDELSEKODE BETWEEN 0 AND 900 THEN 1 ELSE 0 END)*
							(bygning.byg_arl_saml+coalesce(bygning.tagetageareal,0)+coalesce(bygning.KAELDERAREAL,0)+bygning.AABENOVERDAEKAREAL-coalesce(bygning.KAELDERAREAL_U125M, 0)-bygning.AFFALDSRUM_ARL)*0.25 as max_fradrag_andre,
							BYG_ARL_SAML+(CASE WHEN bygning.BYGANVENDELSEKODE BETWEEN 910 AND 5000 THEN bygning.byg_bebyg_arl ELSE 0 END)+coalesce(bygning.tagetageareal,0)+coalesce(bygning.KAELDERAREAL,0)-coalesce(bygning.KAELDERAREAL_U125M,0)+bygning.AABENOVERDAEKAREAL-bygning.AFFALDSRUM_ARL AS etageareal_foer_fradrag,
							CASE WHEN bygning.BYGANVENDELSEKODE BETWEEN 910 AND 5000 THEN Byg_Bebyg_Arl WHEN bygning.BYGANVENDELSEKODE BETWEEN 0 AND 900 THEN AABENOVERDAEKAREAL ELSE 0 END + coalesce(bygning.GARAGE_INDB_ARL,0) + coalesce(bygning.CARPORT_INDB_ARL,0) + coalesce(bygning.UDHUS_INDB_ARL,0)  AS fradragsudgangspunkt,
							bygning.byg_bebyg_arl,
							bygning.BYG_ERHVERV_ARL_SAML as erhv_arl_saml,
							bygning.ANTLEJMKOEKKEN,
							bygning.ANTLEJUKOEKKEN,

							jordstykker.regareal,
							jordstykker.vejareal,
							jordstykker.sfe_ejendomsnummer,
							jordstykker.GEO_Matrikel,
							jordstykker.KommuneNummer,
							jordstykker.EjendomsNummer,
							jordstykker.EjerlavsNavn,
							jordstykker.LandsEjerlavKode,
							jordstykker.MatrikelIdent,
							jordstykker.MatrikelNummer,
							jordstykker.MatrikelBogstav
						FROM geo_jordstykker_kommune as jordstykker
							LEFT JOIN geo_bbr_bygning bygning
								ON (jordstykker.geo_matrikel = bygning.geo_matrikel)
							LEFT JOIN (
								SELECT
									GEO_Bygning,
									sum(CASE WHEN BOLIGTYPE_KODE BETWEEN '1' AND '5' THEN 1 ELSE 0 END) AS Antal_bolig_enheder
								FROM geo_bbr_enhed
								group by GEO_Bygning) enhed
							on (bygning.GEO_Bygning = enhed.GEO_Bygning)
					) bygningsopdelt
						group by
							bygningsopdelt.sfe_ejendomsnummer,
							bygningsopdelt.GEO_Matrikel,
							bygningsopdelt.KommuneNummer,
							bygningsopdelt.EjendomsNummer,
							bygningsopdelt.EjerlavsNavn,
							bygningsopdelt.LandsEjerlavKode,
							bygningsopdelt.MatrikelIdent,
							bygningsopdelt.MatrikelNummer,
							bygningsopdelt.MatrikelBogstav,
							bygningsopdelt.regareal,
							bygningsopdelt.vejareal) AS bbr
				LEFT JOIN geo_jordstykker_kommune as jordstykker2
				ON bbr.geo_matrikel = jordstykker2.geo_matrikel
								LEFT JOIN
						(select GEO_Matrikel, sfe_ejendomsnummer,
						STUFF((SELECT ';' + ' matr.nr ' + MatrikelIdent + ' ' + EjerlavsNavn FROM geo_jordstykker_kommune
						WHERE (sfe_ejendomsnummer = Results.sfe_ejendomsnummer AND GEO_Matrikel != Results.GEO_Matrikel)
						FOR XML PATH ('')),1,2,'') AS andre_jordstykker_list
						from geo_jordstykker_kommune Results group by GEO_Matrikel, sfe_ejendomsnummer) andre_jordstykker
					ON andre_jordstykker.GEO_Matrikel = bbr.geo_matrikel
