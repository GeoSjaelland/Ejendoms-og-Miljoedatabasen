Select
cast(ROW_NUMBER() OVER(ORDER BY (Select '')) as int) AS OBJECTID,
convert(date, convert(varchar,left(F.dimtid,4)) + '-' + convert(varchar,left(right(F.dimtid,4),2)) + '-' + convert(varchar,right(F.dimtid,2))) as Tidspunkt,
case when F.DimtidStartDatoAfForløb = -1 Then convert(date,('00010101'))
     else convert(date, convert(varchar,left(F.DimtidStartDatoAfForløb,4)) + '-' + convert(varchar,left(right(F.DimtidStartDatoAfForløb,4),2)) + '-' + convert(varchar,right(F.DimtidStartDatoAfForløb,2)))
    End as DatoStartForlob,
case when F.DimTidSlutDatoAfForløb = -1 Then convert(date,('99991231'))
     else convert(date, convert(varchar,left(F.DimTidSlutDatoAfForløb,4)) + '-' + convert(varchar,left(right(F.DimTidSlutDatoAfForløb,4),2)) + '-' + convert(varchar,right(F.DimTidSlutDatoAfForløb,2)))
    End as DatoSlutForlob,
F.DimBorger,
F.DimForanstaltningsmodtagerUBU,
DB.Personnummer,
DB.Navn,
convert(date,DB.Fødselsdato) as Foedselsdato,
F.AlderIÅr as Alder,
F.AlderVedStartAfForanstaltningIÅr as AlderVedStartAfForanstaltning,
DB.Køn as Koen,
DL.Landenummer,
DL.Landenavn,
F.DimForanstaltningUBU,
F.ForløbIDage as ForlobIDageForanstaltning,
F.ForløbIMåneder as ForlobIMaanederForanstaltning,
isnull(DF.FørstegangsbevillingTekst,'') as ForstegangsBevilling,
isnull(DF.FørstegangsanbringelseTekst,'') as ForstegangsAnbringelse,
isnull(DF.LovType,'') as LovType,
isnull(DF.LovBeskrivelse,'') as LovTitel,
isnull(DF.ParagrafBeskrivelse,'') as ParagrafBeskrivelse,
isnull(DF.ParagrafNummer,'') as ParagrafNummer,
isnull(DF.ParagrafNummerNøgle,'') as ParagrafNummerNogle,
isnull(DF.ParagrafStkNummer,'') as ParagrafStkNummer,
isnull(DF.ParagrafStkNummerNøgle,'') as ParagrafStkNummerNogle,
isnull(DF.ParagrafStk,'') as ParagrafStk,
isnull(DF.ParagrafStkNøgle,'') as ParagrafStkNogle,
isnull(DF.FlisParagrafKode,'') as FlisParagrafKode,
isnull(DF.FlisParagrafGrupperingKode,'') as FlisParagrafGrupperingKode,
isnull(DF.FlisParagrafGrupperingTekst,'') as FlisParagrafGruppering,
isnull(DF.FlisForanstaltningstypeKode,'') as FlisForanstaltningstypeKode,
isnull(DF.FlisForanstaltningstypeTekst,'') as FlisForanstaltningstype,
isnull(DF.FlisForanstaltningstypeGrupperingKode,'') as FlisForanstaltningTypeKode,
isnull(DF.FlisForanstaltningstypeGrupperingTekst,'') as FlisForanstaltningType,
isnull(DF.Hovedkonto,'') as Hovedkonto,
isnull(DF.Hovedfunktion,'') as Hovedfunktion,
isnull(DF.Funktion,'') as Funktion,
isnull(DF.Gruppering,'') as Gruppering,
isnull(DF.ErMånedsafslutningTekst,'') as ErMånedsafslutning,
isnull(DF.ErNyForanstaltningTekst,'') as ErNyForanstaltning,
isnull(DF.ErAfsluttetForanstaltningTekst,'') as ErAfsluttetForanstaltning,
isnull(DF.FørsteForebyggendeForanstaltningTekst,'') as FørsteForebyggendeForanstalt,
isnull(DF.FlisOverordnetForanstaltningstypeKode,'') as FlisTopForanstaltningstypeKode,
isnull(DF.FlisOverordnetForanstaltningstypeTekst,'') as FlisTopForanstaltningstype,
DAS.CVR as CVRNummerLeverandor,
isnull(DAS.LeverandørNavn,'') as LeverandorNavn,
DAS.PrivatLeverandørTekst as PrivatLeverandor,
DAS.Kommunenummer as KommuneNummerLeverandor,
DAS.KommuneNavn as KommuneNavnLeverandor,
DAS.Kategorikode as KategoriKodeLeverandor,
DAS.KategoriTekst as KategoriLeverandor,
F.KommunenummerBetalingskommune,
F.KommunenummerHandleKommune,
DG.KommuneNummer,
DG.Vejnummer as Vejkode,
DG.Husnummer as Hus_Nr,
convert(smallint,left(DG.Husnummer,3)) as HusNummer,
case when isnumeric(right(DG.Husnummer,1)) = 0 then Upper(right(DG.Husnummer,1))
     else ''
     end as HusBogstav,
isnull(Right('000' + convert(varchar,DG.KOmmunenummer),3) + Right('0000' + convert(varchar,DG.vejnummer),4) + DG.Husnummer,'0') as KVH_ADR_KEY,
isnull(DG.Etage,'') as Etage,
isnull(DG.Sidedørnummer,'') as Side_DoerNr,
isnull(Right('000' + convert(varchar,DG.KOmmunenummer),3) + Right('0000' + convert(varchar,DG.vejnummer),4) + rtrim(DG.Husnummer) + isnull(Right('00' + DG.ETAGE,2),'00') + isnull(Right('0000' + DG.Sidedørnummer,4),'0000'),'0') as KVHX_ADR_KEY,
DG.Vejnavn as Vejnavn,
isnull(DG.CONavn,'') as CONavn,
case when etage is null and sidedørnummer is null
        then DG.vejnavn + ' ' + convert(varchar,convert(int,left(DG.husnummer,3))) + rtrim(Right(DG.husnummer,1))
     when isnumeric(Etage)= 1 and sidedørnummer is null
        then DG.vejnavn + ' ' + convert(varchar,convert(int,left(DG.husnummer,3))) + rtrim(Right(DG.husnummer,1)) + ', ' + convert(varchar,convert(int,dg.Etage)) + '. '
     when isnumeric(Etage)= 0 and sidedørnummer is null and etage is not null
        then DG.vejnavn + ' ' + convert(varchar,convert(int,left(DG.husnummer,3))) + rtrim(Right(DG.husnummer,1)) + ', ' + isnull(dg.Etage,'')
     when etage is null and isnumeric(Sidedørnummer+ 'e0') = 1
        then DG.vejnavn + ' ' + convert(varchar,convert(int,left(DG.husnummer,3))) + rtrim(Right(DG.husnummer,1)) + ', nr. ' + convert(varchar,convert(int,Sidedørnummer))
     when etage is null and isnumeric(Sidedørnummer+ 'e0') = 0 and sidedørnummer is not null
        then DG.vejnavn + ' ' + convert(varchar,convert(int,left(DG.husnummer,3))) + rtrim(Right(DG.husnummer,1)) + ', ' + Sidedørnummer
     when isnumeric(Etage)= 1 and isnumeric(Sidedørnummer+ 'e0') = 1
        then DG.vejnavn + ' ' + convert(varchar,convert(int,left(DG.husnummer,3))) + rtrim(Right(DG.husnummer,1)) + ', ' + convert(varchar,convert(int,dg.Etage)) + '. ' + 'nr. ' + convert(varchar,convert(int,Sidedørnummer))
     when isnumeric(Etage)= 1 and isnumeric(Sidedørnummer+ 'e0') = 0 and sidedørnummer is not null
         then DG.vejnavn + ' ' + convert(varchar,convert(int,left(DG.husnummer,3))) + rtrim(Right(DG.husnummer,1)) + ', ' + convert(varchar,convert(int,dg.Etage)) + '. ' + Sidedørnummer
     when isnumeric(Etage)= 0 and isnumeric(Sidedørnummer+ 'e0') = 1 and etage is not null
         then DG.vejnavn + ' ' + convert(varchar,convert(int,left(DG.husnummer,3))) + rtrim(Right(DG.husnummer,1)) + ', ' + isnull(dg.Etage,'') + ' nr. ' + convert(varchar,convert(int,Sidedørnummer))
     when isnumeric(Etage)= 0 and isnumeric(Sidedørnummer+ 'e0') = 0 and sidedørnummer is not null and etage is not null
         then DG.vejnavn + ' ' + convert(varchar,convert(int,left(DG.husnummer,3))) + rtrim(Right(DG.husnummer,1)) + ', ' + isnull(dg.Etage,'') + ' ' + Sidedørnummer
    end as Adresse,
Case when DG.Bynavn = 'Ukendt' then ''
     else DG.Bynavn
    end as ByNavn,
DG.Postnummer,
DG.Postdistrikt,
DG.Byfornyelsesdistriktsnummer,
DG.Byfornyelsesdistriktsnavn,
DG.BefolkningsDistriktsKode,
DG.BefolkningsDistriktsNavn,
DG.SkoleDistriktsNummer,
DG.SkoleDistriktsNavn,
DG.Socialdistriktsnummer,
DG.Socialdistriktsnavn,
DG.Valgdistriktsnummer,
Dg.Valgdistriktsnavn,
isnull(APU.DDKNcelle100m,0) as DDKNcelle100m,
isnull(APU.DDKNcelle1km,0) as DDKNcelle1km,
isnull(APU.DDKNcelle10km,0) as DDKNcelle10km,
isnull(APU.KoorOest,0) as KoorOest,
isnull(APU.KoorNord,0) as KoorNord,
APU.GEOMETRI,
cast(ROW_NUMBER() OVER(ORDER BY (Select '')) as int) AS MI_PRINX,
cast('Pen (1, 2, 255) Brush (1, 0, 16777215)' as varchar(254)) as MI_STYLE
FROM FactForanstaltningUBU as F
inner join DimGeografi as DG on
        DG.DimGeografiID = F.DimGeografiBopæl
inner join DimAlder as DA on
        DA.DimAlderID = F.DimAlder
inner join DimBorgerStatus as DBS on
        DBS.DimBorgerStatusID = F.DimBorgerStatus
inner join DimLand as DL on
        DL.DimLandID = F.DimLandStatsborgerskab
inner join DimBorger as DB on
        DB.DimBorgerID = F.DimBorger
inner join DimForanstaltningUBU as DF on
        DF.DimForanstaltningUBUID = F.DimForanstaltningUBU
inner join DimAnbringelsesstedUBU as DAS on
        DAS.DimAnbringelsesstedUBUID = F.DimAnbringelsesstedUBU
inner join DimForanstaltningsmodtagerUBU as DFM on
        DFM.DimForanstaltningsmodtagerUBUID = F.DimForanstaltningsmodtagerUBU
left join Land_AdressePunkt as APU on
        APU.Kommunenummer = DG.Kommunenummer
    and APU.Vejkode = DG.Vejnummer
    and APU.HUS_NR = DG.Husnummer