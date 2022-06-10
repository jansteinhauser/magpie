# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source the default config and then over-write it before starting the run.
source("config/default.cfg")

cfg$sequential <- FALSE

cfg$gms$tc <- "endo_apr22"
#tc_factor <- c(1e-5,1e-4,1e-3,1e-2,5e-5,5e-4,5e-3,5e-2)
tc_factor <- c(0.02)#c(1e-5,5e-5,1e-4,5e-4,1e-3,5e-3)
tc_exp <- c(2)#,2,3)
tc_min <- c(0.01)

#cfg$gms$c13_tccost <- "high"

cfg$gms$c13_capacity_cost <- 1

cfg$gms$bioenergy <- "2ndgen_linear_may22"
BE <- c(10,60)

polution <- c("R21M42-SSP2-PkBudg1300") #, "R21M42-SSP2-PkBudg900")

for(af in tc_factor){
  for(e in tc_exp){
    for (c in tc_min){
      for (be in BE){
        for (pol in polution){

      cfg$gms$s13_adj_factor <- af
      cfg$gms$s13_adj_exp <- e
      cfg$gms$s13_tech_cost_min <- c

      cfg$gms$c60_2ndgen_bioenergy_subsidy <- be

      if(pol == "R21M42-SSP2-PkBudg1300") pol_flag="B13"
      if(pol == "R21M42-SSP2-PkBudg900") pol_flag="B09"

      cfg$gms$c56_pollutant_prices <- pol

      # Update title
      cfg$title <- paste0("BE",be,"af",af,"-",e)
#      cfg$title <- paste0("BE",be,"af",af,"-",e,pol_flag)
#      cfg$title <- paste0("af",af,"p",e)

      # Start the run
      start_run(cfg=cfg,codeCheck=FALSE)

        } # Closing pol loop
      } # Closing BE Loop
    }# Closing tc_min loop
  }# Closing exp loop
}# Closing af loop
