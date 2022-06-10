*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
 s13_ignore_tau_historical	ignore historical tau (1) or use it as lower bound (0) (binary) / 1 /
 s13_max_gdp_shr Maximum tech cost as share of regional GDP (1) / 0.002 /
 s13_adj_factor Adjustment cost factor for TC Cost capacity expansion (1) / 0.02 /
 s13_adj_exp Adjustment cost factor exponent (1) / 2 /
 s13_tech_cost_min Tech cost lower bound (mio. US$2005 per year) / 0.01 /
 c13_capacity_cost Switch to turn additional capacity building cost on (1) or off (0) (binary) / 1 /
;

parameter fm_tau1995(h) Agricultural land use intensity tau in 1995 (1)
/
$ondelim
$include "./modules/13_tc/input/fm_tau1995.cs4"
$offdelim
/;

parameter f13_tcguess(h) Guess for initial annual TC rates (1)
/
$ondelim
$include "./modules/13_tc/input/f13_tcguess.cs4"
$offdelim
/;

$setglobal c13_tccost  medium

table f13_tc_factor(t_all,scen13) Regression factor (USD05PPP per ha)
$ondelim
$include "./modules/13_tc/input/f13_tc_factor.cs3"
$offdelim
;

table f13_tc_exponent(t_all,scen13) Regression exponent (1)
$ondelim
$include "./modules/13_tc/input/f13_tc_exponent.cs3"
$offdelim
;

table f13_tau_historical(t_all,h) historical tau scenario (1)
$ondelim
$include "./modules/13_tc/input/f13_tau_historical.csv"
$offdelim
;

table fm_pastr_tau_hist(t_all,h) Historical managed pasture tau (1)
$ondelim
$include "./modules/13_tc/input/f13_pastr_tau_hist.csv"
$offdelim
;

parameter f13_tc_cost1995(i) Tech change cost in 1995 (mio US$05 PPP)
/
$ondelim
$include "./modules/13_tc/input/f13_tc_cost1995.cs4"
$offdelim
/;
