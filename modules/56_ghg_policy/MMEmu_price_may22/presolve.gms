*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


v56_emissions_taxed_reg.up(i) = Inf;
if (((m_year(t) >= s56_ghgprice_start) and (s56_emission_cap = 1)),
    v56_emissions_taxed_reg.up(i) $ (s56_cumulative_cap = 0) = 
        sum(ct, p56_pollutant_cap(ct,i));
    v56_emissions_taxed_reg.up(i) $ (s56_cumulative_cap = 1) = 
        sum(ct, p56_pollutant_cap_cum(ct,i)) - p56_emissions_taxed_cumulative(i);    
    v56_emissions_taxed_reg.l(i) = 0;
);

