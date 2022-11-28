*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


v56_emissions_taxed.up = Inf
if ((m_year(t) > 1990) and (s56_emission_cap = 1),
    v56_emissions_taxed.up = sum((ct,i), p56_pollutant_cap(t_all,i));
);

