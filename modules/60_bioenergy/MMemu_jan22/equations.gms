*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations


*' @code
*' For the MAgPIE-MESSAGE emulator, bioenergy potentials should be intially calculated without
*' fixed demands, based purely on the price signal for 1st and 2nd gen BE, excluding
*' ressidues. 

q60_bioenergy_incentive(i2).. vm_bioenergy_utility(i2)
          =e= sum((ksub60,ct), vm_dem_bioen(i2,ksub60)* fm_attributes("ge",ksub60) * (-i60_bioenergy_subsidy(ct)));

*' For the initial runs, demand is "off", i.e. 0 or nearly 0. It is then set for following
*' runs (at higher carbon prices per BE price category) to the initial calculated demand, fixing this demand as 
*' minimum. In those cases, total demand for bioenergy comes from different origins.
*' 1st generation bioenergy demand is a fixed trajectory of minimum production
*' requirements, where 1st gen sources are substitutable based on their energy
*' content. Second generation bioenergy splits into a Demand for dedicated
*' bioenergy crops, which are fully substitutable based on their energy content,
*' and residues, which are also fully substitutable based on their energy content.

q60_bioenergy(i2,kall) ..
      vm_dem_bioen(i2,kall) * fm_attributes("ge",kall) =g=
      v60_1stgen_bioenergy_dem(i2,kall) +
      v60_2ndgen_bioenergy_dem_dedicated(i2,kall) +
      v60_2ndgen_bioenergy_dem_residues(i2,kall)
      ;

*' By default, no demand is set up. When it is used, 1st gen 
*' sources, i.e. oils and ethanol, can be substituted. Demand is then
*' the output from earlier MAgPIE and/or MESSAGE runs.

q60_bioenergy_1st(i2).. sum(k1st60,v60_1stgen_bioenergy_dem(i2,k1st60))
                        =g= sum((ct),i60_1stgen_bioenergy_dem_acc(ct,i2));

*' For second generation bioenergy from dedicated bioenergy crops
*' (`kbe60` = bioenergy grasses and bioenergy trees), input is
*' given either on regional or global level (defined via switch 
*' $c60\_biodem\_level$). 
*'
*' The bioenergy demand calculation for second generation bioenergy is based on
*' the following two equations from which always only one is active:
*' If $c60\_biodem\_level$ is 1 (regional) the right hand side of the first equation
*' is set to 0, if it is 0 (global) the right hand side of the second equation
*' is set to 0.

q60_bioenergy_glo.. sum((kbe60,i2), v60_2ndgen_bioenergy_dem_dedicated(i2,kbe60))
                    =g= sum((ct,i2),i60_bioenergy_dem(ct,i2))*(1-c60_biodem_level);

q60_bioenergy_reg(i2).. sum(kbe60, v60_2ndgen_bioenergy_dem_dedicated(i2,kbe60))
                    =g= sum(ct,i60_bioenergy_dem(ct,i2))*c60_biodem_level;

*' Except the implementation of the switches and the fact that in the first
*' equation the bioenergy demand is summed up to a global demand both equations
*' act the same way: In both cases the equation just makes sure that the sum
*' over all second generation energy crop of the bioenergy demand is greater or
*' equal to the demand actually given by the input file $i60\_bioenergy\_dem$.

*' There is additionally some demand of residues for second generation bioenergy
*' $i60\_res\_2ndgenBE\_dem$, which is exogenously provided by the estimation that
*' roughly 33% of available residues for recycling on cropland can be used for 2nd
*' generation bioenergy depending on the SSP scenario, since residue stock and use
*' is mainly driven by population and GDP.

q60_res_2ndgenBE(i2) ..
  sum(kres, v60_2ndgen_bioenergy_dem_residues(i2,kres))
  =g=
  sum(ct,i60_res_2ndgenBE_dem(ct,i2));