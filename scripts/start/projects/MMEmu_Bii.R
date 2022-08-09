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

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                               "./patch_input"=NULL),
                           getOption("magpie_repos"))

cfg$input <- append(cfg$input,c(patch = "patch.tgz"))

cfg$output <- c("output_check", "rds_report")
cfg$sequential <- FALSE
cfg$force_replace <- TRUE

### Identifier
cfg$info$flag <- "2208 - biodiversity tests"

ssp <-  "SSP2"
cfg = setScenario(cfg,c(ssp)) #load config presets

### Bioenergy
cfg$gms$bioenergy <- "2ndgen_linear_may22"
cfg$gms$c60_1stgen_biodem <- "off"
cfg$gms$c60_2ndgen_biodem <- "off"
cfg$gms$c60_res_2ndgenBE_dem <- "off"

### Carbon price
cfg$gms$ghg_policy <- "MMEmu_price_may22"
cfg$gms$s56_ghgprice_start <- 2020
GHG_v <- c(0)

### Biodiversity
#cfg$gms$biodiversity <- "bv_btc_mar21"
cfg$gms$biodiversity <- "bii_target"
#cfg$gms$s44_start_year <- 2020
#cfg$gms$s44_target_year <- 2050
#cfg$gms$s44_start_price <- 0	#def = 0

US00_05 <- 1.1197 #1.1197 #src: https://data.worldbank.org/indicator/NY.GDP.DEFL.ZS?end=2005&locations=US&start=2000

##### Loop settings

### Bioenergy
BE_v <- c(6)
### Biodiversity
BD_v <- c(0,74,76,78)
PA_v <- c('npi')
### TC
TC_v <- c('en','ex')

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

           BII_lo <- BD / 100
           cfg$gms$s44_bii_lower_bound <- BII_lo

           BD_flag <- paste0('BI',str_pad(BD,2,pad='0'))

         for (TC in TC_v){

           TC_flag <- if (TC == 'en') "n" else 'x'

           if (TC == 'ex'){
             cfg$gms$tc < - 'exo'
             #Title and folder

             title <- paste0("E",str_pad(BE, 2, pad = "0"),"G",str_pad(GHG, 4, pad = "0"),BD_flag,PA_flag,TC_flag)
             cfg$title <- title
             cfg$results_folder = "output/:title:"
             ### Start run ###
             start_run(cfg,codeCheck=FALSE)
             }
           else{
             cfg$gms$tc <- "endo_apr22"

              #Title and folder
              title <- paste0("E",str_pad(BE, 2, pad = "0"),"G",str_pad(GHG, 4, pad = "0"),BD_flag,PA_flag,TC_flag)
              cfg$title <- title
              cfg$results_folder = "output/:title:"
              ### Start run ###)
              start_run(cfg,codeCheck=FALSE)

            } # close if/else TC
          } # close TC
        } # close BD
      } # close PA
   } # close GHG
 } # close BE
