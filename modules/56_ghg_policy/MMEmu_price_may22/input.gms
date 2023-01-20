*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Set-switch for countries affected by regional ghg policy
* Default: all iso countries selected
sets
  policy_countries56(iso) countries to be affected by ghg policy / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
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
  s56_limit_ch4_n2o_price upper limit for CH4 and N2O GHG prices (USD05MER per tC) / 4000 /
  s56_cprice_red_factor reduction factor for CO2 price (-) / 1 /
  s56_ghgprice_target target 2100 ghg price / 559.85 /
  s56_ghgprice_start start year for ghg price phase-in (year) / 2025 /
  s56_ghgprice_phase_in  Switch for phasing-in GHG price over a 20 year period  (1=on 0=off) / 0 /
  s56_ghgprice_devstate_scaling Switch for scaling GHG price with development state (1=on 0=off) / 0 /
  s56_c_price_induced_aff Switch for C price driven afforestation (1=on 0=off) / 1 /
  s56_c_price_exp_aff c price expectation for afforestation (years) / 50 /
  s56_buffer_aff share of carbon credits for afforestation projects pooled in a buffer (1) / 0.2 /
  s56_counter counter for C price interpolation (1) / 0 /
  s56_timesteps number of time steps for C price interpolation (1) / 0 /
  s56_offset helper for C price interpolation (1) / 0 /
  s56_emission_cap switch emission cap on (1) or off (0) / 0 /
  s56_cumulative_cap switch for non-cumulative (0) or cumulative (1) global emissions cap / 0 /
;

$setglobal c56_pollutant_prices  R21M42-SSP2-NPi
$setglobal c56_pollutant_prices_noselect  R21M42-SSP2-NPi
$setglobal c56_emis_policy  redd+natveg_nosoil

$setglobal c56_carbon_stock_pricing  actualNoAcEst
*   options:  actual, actualNoAcEst
$setglobal c56_emis_cap Emu00
$setglobal c56_cap_source G0000

table f56_pollutant_prices(t_all,i,pollutants,ghgscen56) GHG certificate prices for N2O-N CH4 CO2-C (USD05MER per t)
$ondelim
$include "./modules/56_ghg_policy/input/f56_pollutant_prices.cs3"
$offdelim
;

$if "%c56_pollutant_prices%" == "coupling" table f56_pollutant_prices_coupling(t_all,i,pollutants) Regional ghg certificate prices for N2O-N CH4 CO2-C (USD05MER per t)
$if "%c56_pollutant_prices%" == "coupling" $ondelim
$if "%c56_pollutant_prices%" == "coupling" $include "./modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3"
$if "%c56_pollutant_prices%" == "coupling" $offdelim
$if "%c56_pollutant_prices%" == "coupling" ;

$if "%c56_pollutant_prices%" == "emulator" table f56_pollutant_prices_emulator(t_all,i,pollutants) Global ghg certificate prices for N2O-N CH4 CO2-C (USD05MER per t)
$if "%c56_pollutant_prices%" == "emulator" $ondelim
$if "%c56_pollutant_prices%" == "emulator" $include "./modules/56_ghg_policy/input/f56_pollutant_prices_emulator.cs3"
$if "%c56_pollutant_prices%" == "emulator" $offdelim
$if "%c56_pollutant_prices%" == "emulator" ;

* f56_emis_policy contains scenarios determining for each gas and source whether it is priced or not

table f56_emis_policy(scen56,pollutants_all,emis_source) GHG emission policy scenarios (1)
$ondelim
$include "./modules/56_ghg_policy/input/f56_emis_policy.csv"
$offdelim
;

table f56_pollutant_cap(t_all,i,capscen56) Aggregated emission data for N2O CH4 CO2 from previous run (Mt CO2e per t)
$ondelim
$if "%c56_cap_source%" == "G0000" $include "./modules/56_ghg_policy/input/f56_G0000_pollutant_cap.cs3"
$if "%c56_cap_source%" == "G0050" $include "./modules/56_ghg_policy/input/f56_G0050_pollutant_cap.cs3"
$if "%c56_cap_source%" == "G0150" $include "./modules/56_ghg_policy/input/f56_G0150_pollutant_cap.cs3"
$if "%c56_cap_source%" == "G0300" $include "./modules/56_ghg_policy/input/f56_G0300_pollutant_cap.cs3"
$if "%c56_cap_source%" == "G0500" $include "./modules/56_ghg_policy/input/f56_G0500_pollutant_cap.cs3"
$if "%c56_cap_source%" == "G0600" $include "./modules/56_ghg_policy/input/f56_G0600_pollutant_cap.cs3"
$if "%c56_cap_source%" == "G0800" $include "./modules/56_ghg_policy/input/f56_G0800_pollutant_cap.cs3"
$if "%c56_cap_source%" == "G1000" $include "./modules/56_ghg_policy/input/f56_G1000_pollutant_cap.cs3"
$if "%c56_cap_source%" == "G1200" $include "./modules/56_ghg_policy/input/f56_G1200_pollutant_cap.cs3"
$if "%c56_cap_source%" == "G1500" $include "./modules/56_ghg_policy/input/f56_G1500_pollutant_cap.cs3"
$offdelim
;