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
cfg$input <- append(cfg$input, c(patch = "patch.tgz"))

cfg$output <- c("output_check", "rds_report")
cfg$force_replace <- TRUE

cfg$qos <- "standby"

ssp <-  "SSP2"
cfg = setScenario(cfg,c(ssp)) #load config presets

### Identifier and folder
identifier_flag <- "Emis_Align"
#identifier_flag <- "Emulator_22-10-05_reg_no-price"
cfg$info$flag <- identifier_flag
cfg$results_folder <- paste0("output/",identifier_flag,"/:title:")

### Bioenergy
cfg$gms$bioenergy <- "2ndgen_linear_may22"
cfg$gms$c60_1stgen_biodem <- "off"
cfg$gms$c60_2ndgen_biodem <- "off"
cfg$gms$c60_res_2ndgenBE_dem <- "off"
cfg$gms$c60_biodem_level <- 1

BE_v <- c(60)
#BE_v <- c(0, 3, 5, 8, 15, 30, 60) 


### Biodiversity
cfg$gmx$biodiversity <- "bii_target"
cfg$gms$c44_bii_decrease <- 0
cfg$gms$s44_bii_lower_bound <- 0.76

PA <- 'npi'
cfg$gms$c35_ad_policy <- PA
cfg$gms$c35_aolc_policy <- PA
cfg$gms$c32_aff_policy <- PA


### Carbon price
cfg$gms$ghg_policy <- "MMEmu_priceExp_sep22"
cfg$gms$s56_ghgprice_start <- 2020
#GHG_v <- c(10, 100, 600, 1500, 3000)
GHG_v <- c(0,3000)

### TC / yields
cfg$gms$tc <- "exo"
#cfg$gms$c14_yields_scenario <- 'nocc' 


### Land
cfg$gms$crop    <- "endo_aug22"
cfg$gms$c30_growth_reg <- 1
cfg$gms$c30_annual_max_growth <- 0.02

 
US00_05 <- 1.1197 #src: https://data.worldbank.org/indicator/NY.GDP.DEFL.ZS?end=2005&locations=US&start=2000

for (BE in BE_v){

	cfg$gms$c60_2ndgen_bioenergy_subsidy <-  US00_05 * BE

	for (GHG in GHG_v){

		#remove BE incentive if BE demand is activated
		if (GHG > 0) {
			cfg$gms$c60_2ndgen_bioenergy_subsidy <-  0
			cfg$gms$c60_2ndgen_biodem <-  paste0('Emu', str_pad(BE,2,pad='0')) 		
		} 

		cfg$gms$s56_ghgprice_target <- US00_05  * GHG

		### Title and Folder
		title <- paste0("E",str_pad(BE, 2, pad = "0"),"G",str_pad(GHG, 4, pad = "0"))

		cfg$title <- title

		### Start run 
		start_run(cfg,codeCheck=FALSE)
				
	} #GHG
} #BE



### Default run for comparison
# Source the default config and then over-write it before starting the run.
source("config/default.cfg")

cfg$output <- c("output_check", "rds_report")

cfg$info$flag <-  identifier_flag
cfg$results_folder <- paste0("output/",identifier_flag,"/:title:")
cfg$force_replace <- TRUE

cfg = setScenario(cfg,c(ssp)) #load config presets

cfg$gms$c35_ad_policy <- PA
cfg$gms$c35_aolc_policy <- PA
cfg$gms$c32_aff_policy <- PA

cfg$title <- paste0("Default_",ssp,PA)

start_run(cfg,codeCheck=FALSE)
