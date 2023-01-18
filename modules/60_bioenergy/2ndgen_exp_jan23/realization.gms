*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/60_bioenergy/2ndgen_linear_dec22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/60_bioenergy/2ndgen_linear_dec22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/60_bioenergy/2ndgen_linear_dec22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/60_bioenergy/2ndgen_linear_dec22/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/60_bioenergy/2ndgen_linear_dec22/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/60_bioenergy/2ndgen_linear_dec22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/60_bioenergy/2ndgen_linear_dec22/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/60_bioenergy/2ndgen_linear_dec22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
