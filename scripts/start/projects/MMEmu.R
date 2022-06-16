# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MESSAGE-MAgPIE Emulator
# position: 1
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)
library(stringr)


# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source the default config and then over-write it before starting the run.
source("config/default.cfg")

ssp <-  "SSP2"
cfg = setScenario(cfg,c(ssp)) #load config presets

cfg$output <- c("output_check", "rds_report")

today <- format(Sys.Date(),format="%y%m%d")

cfg$sequential <- FALSE

cfg$force_replace <- TRUE

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                               "./patch_input"=NULL),
                           getOption("magpie_repos"))

cfg$input <- c(regional    = "rev4.73_h12_magpie.tgz",
              cellular    = "rev4.73_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
              validation  = "rev4.73_h12_validation.tgz",
              additional  = "additional_data_rev4.22.tgz",
              calibration = "calibration_H12_per_ton_fao_may22_28May22.tgz",
                patch = "patch.tgz")

### TC
#cfg$gms$tc <- "endo_apr22"
#cfg$gms$c13_tccost <- "medium"

#cfg$gms$c13_capacity_cost <- 0
cfg$gms$s13_adj_factor <- 0.01
cfg$gms$s13_adj_exp <- 2
cfg$gms$s13_tech_cost_min <- 0.01
cfg$gms$s13_max_gdp_shr <- 0.002

### Bioenergy
cfg$gms$bioenergy <- "2ndgen_linear_may22"
cfg$gms$c60_1stgen_biodem <- "off"
cfg$gms$c60_2ndgen_biodem <- "off"
cfg$gms$c60_res_2ndgenBE_dem <- "off"

### Carbon price
cfg$gms$ghg_policy <- "MMEmu_price_may22"
cfg$gms$s56_ghgprice_start <- 2020
GHG_v <- c(0)#,50,100,500)

### Rotation
#cfg$gms$crop <- "rotation_apr22"

### Protection

###Biodiversity
#cfg$gms$biodiversity <- "bv_btc_mar21"
cfg$gms$biodiversity <- "bii_target"
#cfg$gms$s44_start_year <- 2020
#cfg$gms$s44_target_year <- 2050
#cfg$gms$s44_start_price <- 0	#def = 0

US00_05 <- 1.1197 #1.1197 #src: https://data.worldbank.org/indicator/NY.GDP.DEFL.ZS?end=2005&locations=US&start=2000

##### Loop settings

### TC
TC_v <- c('en')
TCC_v <-c('medium')
AF_v <-c(1)
### Bioenergy
BE_v <- c(6,7,8,9,10,15,30,60)
### Biodiversity
BD_v <-c(0)#,70,74,76,78)
PA_v <-c('npi')

identifier_flag = "G"

cfg$info$DevelopState <- "2022-06-15"

for (BE in BE_v) {

     cfg$gms$c60_2ndgen_bioenergy_subsidy <-  US00_05 * BE

     for (GHG in GHG_v){

       cfg$gms$s56_ghgprice_target <- US00_05  * GHG

       for (PA in PA_v){

         cfg$gms$c35_ad_policy <- PA
         cfg$gms$c35_aolc_policy <- PA
         cfg$gms$c32_aff_policy <- PA

         PA_flag <- if (PA != 'npi') PA else ""

         for (BD in BD_v){

#           cfg$gms$s44_target_price <- BD * US00_05

           BII_lo <- BD / 100
           cfg$gms$s44_bii_lower_bound <- BII_lo

           BD_flag <- paste0('B',str_pad(BD,2,pad='0'))
#          BD_flag <- if (BD != '0') paste0('B',str_pad(BD,6,pad='0')) else ""

         for (TC in TC_v){

           TC_flag <- if (TC == 'en') "n" else 'x'
           cfg$gms$tc <- if (TC == 'en') "endo_apr22" else 'exo'

           if (TC == 'ex'){
             #Title and folder
             title <- paste0("E",str_pad(BE, 2, pad = "0"),"G",str_pad(GHG, 4, pad = "0"),BD_flag,PA_flag,TC_flag,identifier_flag)
             cfg$title <- title
             cfg$results_folder = "output/:title:"
             ### Start run ###
             timeStart <- Sys.time()
             print(paste0(timeStart, ": Start ", title))
             start_run(cfg,codeCheck=FALSE)
             }
           else{
             for (TCC in TCC_v){

                cfg$gms$c13_tccost <- TCC
                TCC_flag <- substr(TCC,1,1)

               for (AF in AF_v) {
                  cfg$gms$c13_capacity_cost <- AF
                  AF_flag <- if (AF == 1) "A" else ""

                  #Title and folder
                  title <- paste0("E",str_pad(BE, 2, pad = "0"),"G",str_pad(GHG, 4, pad = "0"),BD_flag,PA_flag,TC_flag,TCC_flag,AF_flag,identifier_flag)
                  cfg$title <- title
                  cfg$results_folder = "output/:title:"
                  ### Start run ###
                  timeStart <- Sys.time()
                  print(paste0(timeStart, ": Start ", title))
                  start_run(cfg,codeCheck=FALSE)
               }
             }
           } # close if/else TC


    #             print(paste0(Sys.time(), ": Finished ", title, "; Started at: ",timeStart, "; Runtime: ", round(difftime(Sys.time(), timeStart, units = "mins"),digits = 0)," minutes; CO2: ", US00_05  * GHG, " US$05/t CO2eq; BE: ", US00_05 * BE, " US$05/GJ"))
    #             write(paste(format(timeStart,format="%Y/%m/%d"),format(timeStart,format="%H:%M"),format(Sys.time(),format="%Y/%m/%d"),format(Sys.time(),format="%H:%M"),round(difftime(Sys.time(), timeStart, units = "mins"),digits = 0),BE,GHG,"en",sep = ";"), file="runlog.csv", append = TRUE)
            } # close TC
          } # close BD
        } # close PA
     } # close GHG
   } # close BE
