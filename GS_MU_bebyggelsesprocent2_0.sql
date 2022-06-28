 --View hedder KK_MU_JORDSTYKKE_BEByggelseSPROCENT_GEO
SELECT  isnull(cast(ROW_NUMBER() OVER (ORDER BY (
SELECT  ''))                                                                                                                AS int)
       ,- 1)                                                                                                                AS OBJECTID
       ,bbr.EjerlavsNavn
       ,bbr.LandsEjerlavKode
       ,bbr.MatrikelIdent
       ,andre_jordstykker_list                                                                                              AS Tilhoerende_Matrikler
       ,bbr.sfe_ejendomsnummer
       ,bbr.EjendomsNummer
       ,bbr.regareal                                                                                                        AS Matriklens_Registreret_Areal
       ,bbr.vejareal                                                                                                        AS Matriklens_Vejreal
       ,bbr.Antal_bolig_enheder
       ,bbr.antal_byg                                                                                                       AS Antal_Bygninger
       ,bbr.antal_parc                                                                                                      AS Antal_Parcelhuse
       ,bbr.antal_raekke                                                                                                    AS Antal_Raekkehuse
       ,bbr.antal_etage                                                                                                     AS Antal_Etagebyggeri
       ,bbr.antal_sommer                                                                                                    AS Antal_Sommerhuse
       ,bbr.antal_andre                                                                                                     AS Antal_oevrige_bygninger
       ,bbr.beb_areal                                                                                                       AS Bebygget_areal
       ,bbr.Byg_Bolig_Arl_Saml                                                                                              AS Bolig_Areal
       ,bbr.erhv_areal                                                                                                      AS ErhvervsAreal
       ,bbr.etageareal                                                                                                      AS EtageAreal
       ,bbr.etageareal_foer_fradrag
       ,bbr.fradrag_ialt
       ,bbr.byg_arl_saml                                                                                                    AS Samlet_Bygningsareal
       ,bbr.byg_bebyg_arl_smaa_byg                                                                                          AS Samlet_Bygningsareal_smaa_bygninger
       ,bbr.est_bebyggelsespct                                                                                              AS Estimeret_Bebyggelses_procent
       ,bbr.est_bebyggelsespct_m_vejareal                                                                                   AS Estimeret_Bebyggelses_procent_med_Vejareal
       ,CASE WHEN bbr.est_bebyggelsespct BETWEEN 0 AND 99.99 THEN 'Mindre END 100%'
             WHEN bbr.est_bebyggelsespct BETWEEN 100 AND 249.99 THEN '100 - 250%'
             WHEN bbr.est_bebyggelsespct > 250 THEN 'Over 250%' ELSE 'Mulige fejl' END                                      AS Estimeret_Bebyggelses_procent_interval
       ,CASE WHEN (bbr.Byg_Bolig_Arl_Saml > 0 AND bbr.erhv_areal > 0) AND bbr.Byg_Bolig_Arl_Saml > bbr.erhv_areal THEN 'Primært bolig'
             WHEN (bbr.Byg_Bolig_Arl_Saml > 0 AND bbr.erhv_areal > 0) AND bbr.Byg_Bolig_Arl_Saml < bbr.erhv_areal THEN 'Primært erhverv'
             WHEN bbr.Byg_Bolig_Arl_Saml = 0 AND bbr.erhv_areal > 0 THEN 'Erhverv'
             WHEN bbr.Byg_Bolig_Arl_Saml > 0 AND bbr.erhv_areal = 0 THEN 'Bolig' ELSE 'Vejareal eller areal ej angivet' END AS boligtype
       ,jordstykker2.geometri
FROM

---------------------------------
(
	SELECT  COALESCE (COUNT(BYG_ANVKODE),0)                                                                AS antal_byg
	       ,COALESCE (SUM(CASE WHEN BYG_ANVKODE IN (120,121) THEN 1 ELSE 0 END),0)                         AS antal_parc
	       ,COALESCE (SUM(CASE WHEN BYG_ANVKODE IN (130,131,132) THEN 1 ELSE 0 END),0)                     AS antal_raekke
	       ,COALESCE (SUM(CASE WHEN BYG_ANVKODE = 140 THEN 1 ELSE 0 END),0)                                AS antal_etage
	       ,COALESCE (SUM(CASE WHEN BYG_ANVKODE = 510 THEN 1 ELSE 0 END),0)                                AS antal_sommer
	       ,COALESCE (SUM(CASE WHEN BYG_ANVKODE NOT IN (120,121,130,131,132,140,510) THEN 1 ELSE 0 END),0) AS antal_andre
	       ,COALESCE (SUM(byg_bebyg_arl),0)                                                                AS beb_areal
	       ,COALESCE (SUM(Byg_Bolig_Arl_Saml),0)                                                           AS Byg_Bolig_Arl_Saml
	       ,COALESCE (SUM(erhv_arl_saml),0)                                                                AS erhv_areal
	       ,CAST(100 * (COALESCE (SUM(etageareal_foer_fradrag),0) - (CASE WHEN COALESCE(SUM(fradragsudgangspunkt), 0) BETWEEN 0 AND (COALESCE(SUM(max_fradrag_taet), 0) + COALESCE(SUM(max_fradrag_aaben),0) + COALESCE(SUM(max_fradrag_andre),0)) THEN COALESCE (SUM(fradragsudgangspunkt),0) ELSE COALESCE (SUM(max_fradrag_taet),0) + COALESCE (SUM(max_fradrag_aaben),0) + COALESCE (SUM(max_fradrag_andre),0) END)) / COALESCE (regareal,0) AS DECIMAL(16,2)) AS est_bebyggelsespct
	       ,COALESCE (CASE WHEN regareal - vejareal > 0 THEN CAST(100 * (SUM(etageareal_foer_fradrag) - (CASE WHEN COALESCE(SUM(fradragsudgangspunkt), 0) BETWEEN 0 AND (COALESCE(SUM(max_fradrag_taet), 0) + COALESCE(SUM(max_fradrag_aaben), 0) + COALESCE(SUM(max_fradrag_andre),0)) THEN COALESCE(SUM(fradragsudgangspunkt),0) ELSE SUM(COALESCE(max_fradrag_taet, 0)) + SUM(COALESCE(max_fradrag_aaben, 0)) + SUM(COALESCE(max_fradrag_andre, 0)) END)) / (regareal - vejareal) AS DECIMAL(16,2)) ELSE 0 END,0) AS est_bebyggelsespct_m_vejareal
	       ,COALESCE (SUM(etageareal_foer_fradrag),0) - COALESCE ((CASE WHEN SUM(fradragsudgangspunkt) BETWEEN 0 AND (SUM(max_fradrag_taet) + SUM(max_fradrag_aaben) + SUM(max_fradrag_andre)) THEN SUM(fradragsudgangspunkt) ELSE SUM(max_fradrag_taet) + SUM(max_fradrag_aaben) + SUM(max_fradrag_andre) END),0) AS etageareal
	       ,COALESCE (SUM(etageareal_foer_fradrag),0)                                                      AS etageareal_foer_fradrag
	       ,COALESCE ((CASE WHEN COALESCE(SUM(fradragsudgangspunkt), 0) BETWEEN 0 AND (COALESCE(SUM(max_fradrag_taet), 0) + COALESCE(SUM(max_fradrag_aaben), 0) + COALESCE(SUM(max_fradrag_andre),0)) THEN COALESCE(SUM(max_fradrag_taet), 0) + COALESCE(SUM(max_fradrag_aaben), 0) + COALESCE(SUM(max_fradrag_andre),0) END),0) AS fradrag_ialt
	       ,COALESCE (SUM(byg_arl_saml),0)                                                                 AS byg_arl_saml
	       ,SUM(byg_bebyg_arl_smaa_byg)                                                                    AS byg_bebyg_arl_smaa_byg
	       ,COALESCE (SUM(TAGETAGEAREAL),0)                                                                AS TAGETAGEAREAL
	       ,COALESCE (SUM(KAELDERAREAL),0)                                                                 AS KAELDERAREAL
	       ,COALESCE (SUM(KAELDER_ARL_U_125M),0)                                                           AS KAELDER_ARL_U_125M
	       ,COALESCE (SUM(AABENOVERDAEKAREAL),0)                                                           AS AABENOVERDAEKAREAL
	       ,COALESCE (SUM(AFFALDSRUM_ARL),0)                                                               AS AFFALDSRUM_ARL
	       ,COALESCE (SUM(GARAGE_INDB_ARL),0)                                                              AS GARAGE_INDB_ARL
	       ,COALESCE (SUM(CARPORT_INDB_ARL),0)                                                             AS CARPORT_INDB_ARL
	       ,COALESCE (SUM(UDHUS_INDB_ARL),0)                                                               AS UDHUS_INDB_ARL
	       ,COALESCE (SUM(Antal_bolig_enheder),0)                                                          AS Antal_bolig_enheder
	       ,regareal
	       ,vejareal
	       ,sfe_ejendomsnummer
	       ,GEO_Matrikel
	       ,KommuneNummer
	       ,EjendomsNummer
	       ,EjerlavsNavn
	       ,LandsEjerlavKode
	       ,MatrikelIdent
	       ,MatrikelNummer
	       ,MatrikelBogstav
	FROM
	(
		SELECT  bygning.BygningensAnvendelseKode                                                                                              AS BYG_ANVKODE
		       ,CASE WHEN bygning.BygningensAnvENDELSEKode BETWEEN 910 AND 5000 THEN bygning.BebyggetAreal ELSE 0 END                         AS byg_bebyg_arl_smaa_byg
		       ,bygning.SamletBygningsareal                                                                                                   AS byg_arl_saml
		       ,COALESCE (bygning.SamletTagetageAreal_SumBygning,0)                                                                           AS TAGETAGEAREAL
		       ,COALESCE (bygning.SamletArealAfKaelderetager_Sum,0)                                                                           AS KAELDERAREAL
		       ,COALESCE (bygning.Kaelderareal_SumBygning,0)                                                                                  AS KAELDER_ARL_U_125M
		       ,bygning.ArealAabneOverdaekBygSamlet                                                                                           AS AABENOVERDAEKAREAL
		       ,bygning.ArealAffaldsrumITerraenniveau                                                                                         AS AFFALDSRUM_ARL
		       ,bygning.BygningensSamledeBoligAreal                                                                                           AS Byg_Bolig_Arl_Saml
		       ,bygning.ArealIndbyggetGarage                                                                                                  AS GARAGE_INDB_ARL
		       ,bygning.ArealIndbyggetCarport                                                                                                 AS CARPORT_INDB_ARL
		       ,bygning.ArealIndbyggetUdhus                                                                                                   AS UDHUS_INDB_ARL
		       ,COALESCE (enhed.Antal_bolig_enheder,0)                                                                                        AS Antal_bolig_enheder
		       ,CASE WHEN COALESCE (enhed.Antal_bolig_enheder,0) = 0 AND bygning.BygningensAnvENDELSEKode BETWEEN 0 AND 900 THEN 1 ELSE 0 END AS anden_bebyggelse
		       ,(CASE WHEN bygning.BygningensAnvendelseKode = 130 OR bygning.BygningensAnvendelseKode = 131 OR bygning.BygningensAnvendelseKode = 140 OR bygning.BygningensAnvendelseKode = 150 OR bygning.BygningensAnvendelseKode = 160 THEN 1 ELSE 0 END) * COALESCE (enhed.Antal_bolig_enheder,0) * 20 AS max_fradrag_taet
		       ,(CASE WHEN bygning.BygningensAnvendelseKode = 110 OR bygning.BygningensAnvendelseKode = 120 OR bygning.BygningensAnvendelseKode = 132 OR bygning.BygningensAnvendelseKode = 510 THEN 1 ELSE 0 END) * COALESCE (enhed.Antal_bolig_enheder,0) * 50 AS max_fradrag_aaben
		       ,(CASE WHEN COALESCE (enhed.Antal_bolig_enheder,0) = 0 AND bygning.BygningensAnvendelseKode BETWEEN 0 AND 900 THEN 1 ELSE 0 END) * (bygning.SamletBygningsareal + COALESCE (bygning.SamletTagetageAreal_SumBygning,0) + COALESCE (bygning.SamletArealAfKaelderetager_Sum,0) + bygning.ArealAabneOverdaekBygSamlet - COALESCE (bygning.Kaelderareal_SumBygning,0) - bygning.ArealAffaldsrumITerraenniveau) * 0.25 AS max_fradrag_andre
		       ,COALESCE(SamletBygningsareal, 0) + (CASE WHEN bygning.BygningensAnvendelseKode BETWEEN 910 AND 5000 THEN bygning.BebyggetAreal ELSE 0 END) + COALESCE (bygning.SamletTagetageAreal_SumBygning,0) + COALESCE (bygning.SamletArealAfKaelderetager_Sum,0) - COALESCE (bygning.Kaelderareal_SumBygning,0) + COALESCE(bygning.ArealAabneOverdaekBygSamlet, 0) - COALESCE(bygning.ArealAffaldsrumITerraenniveau, 0) AS etageareal_foer_fradrag
		       ,CASE WHEN bygning.BygningensAnvENDELSEKode BETWEEN 910 AND 5000 THEN BebyggetAreal
		             WHEN bygning.BygningensAnvENDELSEKode BETWEEN 0 AND 900 THEN ArealAabneOverdaekBygSamlet ELSE 0 END + COALESCE (bygning.ArealIndbyggetGarage,0) + COALESCE (bygning.ArealIndbyggetCarport,0) + COALESCE (bygning.ArealIndbyggetUdhus,0) AS fradragsudgangspunkt
		       ,bygning.BebyggetAreal                                                                                                         AS byg_bebyg_arl
		       ,bygning.BygningensSamledeErhvervsAreal                                                                                        AS erhv_arl_saml
		       ,bygning.AntalEnhederMedKoekken                                                                                                AS ANTLEJMKOEKKEN
		       ,bygning.AntalEnhederUdenKoekken                                                                                               AS ANTLEJUKOEKKEN
		       ,jordstykker.regareal
		       ,jordstykker.vejareal
		       ,jordstykker.sfe_ejendomsnummer
		       ,jordstykker.GEO_Matrikel
		       ,jordstykker.KommuneNummer
		       ,jordstykker.EjendomsNummer
		       ,jordstykker.EjerlavsNavn
		       ,jordstykker.LandsEjerlavKode
		       ,jordstykker.MatrikelIdent
		       ,jordstykker.MatrikelNummer
		       ,jordstykker.MatrikelBogstav
		FROM geo_jordstykker_kommune AS jordstykker
		LEFT JOIN BBR_Aktiv_Bygning bygning
		ON (jordstykker.feat_ID = bygning.JordstykkeID)
		LEFT JOIN
		(
			SELECT  BygningID
			       ,SUM(CASE WHEN BoligtypeKode BETWEEN '1' AND '5' THEN 1 ELSE 0 END) AS Antal_bolig_enheder
			FROM BBR_Aktiv_Enhed
			GROUP BY  BygningID
		) enhed
		ON (bygning.BygningID = enhed.BygningID)
	) bygningsopdelt

	-----------------------------------------
	GROUP BY  bygningsopdelt.sfe_ejendomsnummer
	         ,bygningsopdelt.GEO_Matrikel
	         ,bygningsopdelt.KommuneNummer
	         ,bygningsopdelt.EjendomsNummer
	         ,bygningsopdelt.EjerlavsNavn
	         ,bygningsopdelt.LandsEjerlavKode
	         ,bygningsopdelt.MatrikelIdent
	         ,bygningsopdelt.MatrikelNummer
	         ,bygningsopdelt.MatrikelBogstav
	         ,bygningsopdelt.regareal
	         ,bygningsopdelt.vejareal
) AS bbr
LEFT JOIN geo_jordstykker_kommune AS jordstykker2
ON bbr.geo_matrikel = jordstykker2.geo_matrikel
LEFT JOIN
(
	SELECT  GEO_Matrikel
	       ,sfe_ejendomsnummer
	       ,STUFF ((
	SELECT  ';' + ' matr.nr ' + MatrikelIdent + ' ' + EjerlavsNavn
	FROM geo_jordstykker_kommune
	WHERE (sfe_ejendomsnummer = Results.sfe_ejendomsnummer AND GEO_Matrikel != Results.GEO_Matrikel) FOR XML PATH('')), 1, 2, '') AS andre_jordstykker_list
	FROM geo_jordstykker_kommune Results
	GROUP BY  GEO_Matrikel
	         ,sfe_ejendomsnummer
) andre_jordstykker
ON andre_jordstykker.GEO_Matrikel = bbr.geo_matrikel
ORDER BY bbr.LandsEjerlavKode, bbr.MatrikelIdent DESC