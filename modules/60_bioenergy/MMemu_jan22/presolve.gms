*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_dem_bioen.fx(i,kap) = 0;
v60_1stgen_bioenergy_dem.fx(i,kall) = 0;
v60_1stgen_bioenergy_dem.up(i,k1st60) = Inf;
v60_2ndgen_bioenergy_dem_dedicated.fx(i,kall) = 0;
v60_2ndgen_bioenergy_dem_dedicated.up(i,kbe60) = Inf;
v60_2ndgen_bioenergy_dem_residues.fx(i,kall) = 0;
v60_2ndgen_bioenergy_dem_residues.up(i,kres) = Inf;



if(m_year(t) <= sm_fix_SSP2,
 i60_1stgen_bioenergy_dem_acc(t,i) = 0;
 i60_bioenergy_dem(t,i) = 0;
 i60_res_2ndgenBE_dem(t,i) = 0;
else
 i60_1stgen_bioenergy_dem_acc(t,i) =
             f60_1stgen_bioenergy_dem_acc(t,i,"%c60_1stgen_biodem%");
 i60_res_2ndgenBE_dem(t,i) =
             f60_res_2ndgenBE_dem(t,i,"%c60_res_2ndgenBE_dem%");
);

* Add minimal bioenergy demand in case of zero demand or very small demand to avoid zero prices
i60_bioenergy_dem(t,i)$(i60_bioenergy_dem(t,i) < 0.01) = 0.01;

* Linearly implement the bioenergy subsidy between 2020 and 2100
if(m_year(t) <= 2020,
    i60_bioenergy_subsidy(t) = 0;
    
elseif (m_year(t) > 2020) and (m_year(t) < 2100),
    i60_bioenergy_subsidy(t) = c60_bioenergy_subsidy/(2100-2020) * (m_year(t) - 2020)
    
else i60_bioenergy_subsidy(t) = c60_bioenergy_subsidy
);