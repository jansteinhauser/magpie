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
  c60_bioenergy_subsidy first generation bioenergy subsidy (USD05MER per ton) / 300 /
  c60_2ndgen_biosub_startyear start year for implementation of second generation bioenergy subsidy / 2025 / 
  c60_2ndgen_biosub_endyear   end year for implementation of second generation bioenergy subsidy / 2100 /
  c60_2ndgen_biosub_startval  second generation bioenergy subsidy at start (USD05MER per GJ) / 0 /
  c60_2ndgen_biosub_endval    second generation bioenergy subsidy by end year(USD05MER per GJ) / 0 /
  s60_2ndgen_bioenergy_dem_min Minimum dedicated 2nd generation bioenergy demand assumed in each region (mio. GJ per yr) / 1 /
;

$setglobal c60_2ndgen_biodem  R21M42-SSP2-NPi
$setglobal c60_2ndgen_biodem_noselect  R21M42-SSP2-NPi


$if "%c60_2ndgen_biodem%" == "coupling" table f60_bioenergy_dem_coupling(t_all,i) Bioenergy demand (regional) (mio. GJ per yr)
$if "%c60_2ndgen_biodem%" == "coupling" $ondelim
$if "%c60_2ndgen_biodem%" == "coupling" $include "./modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv"
$if "%c60_2ndgen_biodem%" == "coupling" $offdelim
$if "%c60_2ndgen_biodem%" == "coupling" ;

$if "%c60_2ndgen_biodem%" == "emulator" parameter f60_bioenergy_dem_emulator(t_all) Bioenergy demand (global) (mio. GJ per yr)
$if "%c60_2ndgen_biodem%" == "emulator" /
$if "%c60_2ndgen_biodem%" == "emulator" $ondelim
$if "%c60_2ndgen_biodem%" == "emulator" $include "./modules/60_bioenergy/input/glo.2ndgen_bioenergy_demand.csv"
$if "%c60_2ndgen_biodem%" == "emulator" $offdelim
$if "%c60_2ndgen_biodem%" == "emulator" /
$if "%c60_2ndgen_biodem%" == "emulator" ;

table f60_bioenergy_dem(t_all,i,scen2nd60) annual bioenergy demand (regional) (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_bioenergy_dem.cs3"
$offdelim
;

$setglobal c60_res_2ndgenBE_dem  ssp2
*   options:    ssp1,ssp2,ssp3,ssp4,ssp5,off

table f60_res_2ndgenBE_dem(t_all,i,scen2ndres60) annual residue demand for 2nd generation bioenergy(regional) (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_2ndgenBE_residue_dem.cs3"
$offdelim
;


$setglobal c60_1stgen_biodem  const2020
*   options:  "const2020", "const2030", "phaseout2020"

table f60_1stgen_bioenergy_dem(t_all,i,scen1st60,kall) annual 1st generation bioenergy demand (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_1stgen_bioenergy_dem.cs3"
$offdelim
;

parameter f60_2ndgen_bioenergy_subsidy(t_all) 2nd gen subsidy from external run
/
y2020    3.367745525
y2025    6.73549105
y2030    5.746174126
y2035    8.645411192
y2040    12.69879021
y2045    12.46886758
y2050    14.3517124
y2055    15.56808859
y2060    26.51129535
y2065    17.62193604
y2070    8.732576736
y2075    8.128030885
y2080    7.523485033
y2085    7.749851637
y2090    7.976218242
y2095    8.471899013
y2100    8.967579785


/

