# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MESSAGE-MAgPIE Emulator
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

today <- format(Sys.Date(),format="%y%m%d")
identifier_flag = "MM"

cfg$force_replace <- TRUE

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                               "./patch_inputdata"=NULL),
                           getOption("magpie_repos"))


cfg$gms$c_timesteps <- "12" #12: 1995, 2000, then 10-year steps; 5year: 5-year steps; MAgPIE default: coup2100


res_v <- c("c2") #c2, c4; cluster resolution, default: c2=200 clusters


### Bioenergy
cfg$gms$bioenergy <- "MMemu_jan22"
cfg$gms$c60_1stgen_biodem <- "off"
cfg$gms$c60_2ndgen_biodem <- "off"
cfg$gms$c60_res_2ndgenBE_dem <- "off"
BE_v <- c(15) #0,3,5,8,13,30,60

US00_05 <- 1.1197 #src: https://data.worldbank.org/indicator/NY.GDP.DEFL.ZS?end=2005&locations=US&start=2000

for (res in res_v) {
   for (BE in BE_v) {


     cfg$input <-
      if(res == "c4"){
        c(regional    = "rev4.65_3fbaa84a_magpie.tgz",
          validation  = "rev4.65_3fbaa84a_validation.tgz",
          cellular = "rev4.65_3fbaa84a_d4868716_cellularmagpie_c400_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
          additional  = "additional_data_rev4.07.tgz",
          calibration = "c4_calib.tgz")
        } else {
          c(regional    = "rev4.65_3fbaa84a_magpie.tgz",
            validation  = "rev4.65_3fbaa84a_validation.tgz",
            cellular = "rev4.65_3fbaa84a_1998ea10_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
            additional  = "additional_data_rev4.07.tgz",
            calibration = "c2_calib.tgz",
            "c2_patch_BE.tgz")
          }


    #Title

    title <- paste0(today,"BE",str_pad(BE, 2, pad = "0"),"_",res)
    cfg$title <- title

    cfg$results_folder = "output/:title:"



    ### Start run

    timeStart <- Sys.time()
    print(paste0(timeStart, ": Start ", title))
    start_run(cfg,codeCheck=FALSE)

    print(paste0(Sys.time(), ": Finished ", title, "; Started at: ",timeStart, "; Runtime: ", round(difftime(Sys.time(), timeStart, units = "mins"),digits = 0)," minutes"))
   } # close BE
} # close Res

