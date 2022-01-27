*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  scen_countries60(iso) countries to be affected by 2nd generation bionergy demand scenario / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
                          ASM,ATA,ATF,ATG,AUS,AUT,AZE,BDI,BEL,BEN,
                          BES,BFA,BGD,BGR,BHR,BHS,BIH,BLM,BLR,BLZ,
                          BMU,BOL,BRA,BRB,BRN,BTN,BVT,BWA,CAF,CAN,
                          CCK,CHN,CHE,CHL,CIV,CMR,COD,COG,COK,COL,
                          COM,CPV,CRI,CUB,CUW,CXR,CYM,CYP,CZE,DEU,
                          DJI,DMA,DNK,DOM,DZA,ECU,EGY,ERI,ESH,ESP,
                          EST,ETH,FIN,FJI,FLK,FRA,FRO,FSM,GAB,GBR,
                          GEO,GGY,GHA,GIB,GIN,GLP,GMB,GNB,GNQ,GRC,
                          GRD,GRL,GTM,GUF,GUM,GUY,HKG,HMD,HND,HRV,
                          HTI,HUN,IDN,IMN,IND,IOT,IRL,IRN,IRQ,ISL,
                          ISR,ITA,JAM,JEY,JOR,JPN,KAZ,KEN,KGZ,KHM,
                          KIR,KNA,KOR,KWT,LAO,LBN,LBR,LBY,LCA,LIE,
                          LKA,LSO,LTU,LUX,LVA,MAC,MAF,MAR,MCO,MDA,
                          MDG,MDV,MEX,MHL,MKD,MLI,MLT,MMR,MNE,MNG,
                          MNP,MOZ,MRT,MSR,MTQ,MUS,MWI,MYS,MYT,NAM,
                          NCL,NER,NFK,NGA,NIC,NIU,NLD,NOR,NPL,NRU,
                          NZL,OMN,PAK,PAN,PCN,PER,PHL,PLW,PNG,POL,
                          PRI,PRK,PRT,PRY,PSE,PYF,QAT,REU,ROU,RUS,
                          RWA,SAU,SDN,SEN,SGP,SGS,SHN,SJM,SLB,SLE,
                          SLV,SMR,SOM,SPM,SRB,SSD,STP,SUR,SVK,SVN,
                          SWE,SWZ,SXM,SYC,SYR,TCA,TCD,TGO,THA,TJK,
                          TKL,TKM,TLS,TON,TTO,TUN,TUR,TUV,TWN,TZA,
                          UGA,UKR,UMI,URY,USA,UZB,VAT,VCT,VEN,VGB,
                          VIR,VNM,VUT,WLF,WSM,YEM,ZAF,ZMB,ZWE /
;

scalars
  c60_biodem_level  bioenergy demand level indicator 1 for regional and 0 for global demand   (1)   / 1 /
  c60_bioenergy_subsidy first generation bioenergy subsidy (USD05MER per GJ) / 50.3865 /
;

$setglobal c60_2ndgen_biodem  off
$setglobal c60_2ndgen_biodem_noselect  R21M42-SSP2-NPi

table f60_bioenergy_dem(t_all,i,scen2nd60) annual bioenergy demand (regional) (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_bioenergy_dem.cs3"
$offdelim
;

$setglobal c60_res_2ndgenBE_dem  off
*   options:    ssp1,ssp2,ssp3,ssp4,ssp5,off

table f60_res_2ndgenBE_dem(t_all,i,scen2ndres60) annual residue demand for 2nd generation bioenergy(regional) (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_2ndgenBE_residue_dem.cs3"
$offdelim
;


$setglobal c60_1stgen_biodem  off
*   options:  "off"

table f60_1stgen_bioenergy_dem_acc(t_all,i,scen1st60) annual 1st generation bioenergy demand accumulated (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/MMemu_jan22/input/f60_1stgen_bioenergy_dem_acc.cs3"
$offdelim
;
