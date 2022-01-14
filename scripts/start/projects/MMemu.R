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

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source the default config and then over-write it before starting the run.
source("config/default.cfg")

today <- format(Sys.Date(),format="%y%m%d")

cfg$force_replace <- TRUE

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                               "./patch_inputdata"=NULL),
                           getOption("magpie_repos"))


identifier_flag = "MM"

res_v <- c("c4") #c2, c4; cluster resolution, default: c2=200 clusters




for (res in res_v) {


  cfg$input <- c(regional    = "rev4.65_3fbaa84a_magpie.tgz",
                 validation  = "rev4.65_3fbaa84a_validation.tgz",
                 cellular =
                   if(res == "c2"){"rev4.65_3fbaa84a_1998ea10_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"}
                    else if (res == "c4"){"rev4.65_3fbaa84a_d4868716_cellularmagpie_c400_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"}
                    else  {"rev4.65_3fbaa84a_1998ea10_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"},
                 additional  = "additional_data_rev4.07.tgz",
                 calibration =
                   if(res == "c2"){"c2_calib.tgz"}
                    else if (res == "c4"){"c4_calib.tgz"}
                    else  {"c2_calib.tgz"}
                 )

  title <- paste(today,identifier_flag,res,sep="-")
  cfg$title <- title

  cfg$results_folder = "output/:title:"



  ### Start run

  timeStart <- Sys.time()
  print(paste0(timeStart, ": Start ", title))
  start_run(cfg,codeCheck=FALSE)

  print(paste0(Sys.time(), ": Finished ", "TITLE", "; Started at: ",timeStart, "; Runtime: ", round(difftime(Sys.time(), timeStart, units = "mins"),digits = 0)," minutes"))
}
