*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p30_avl_cropland(t,j)              Total available land for crop cultivation (mio. ha)
 p30_country_snv_weight(i)          SNV policy country weight per region (1)
 p30_snv_shr(t,j)                   Share of semi-natural vegetation in cropland areas (1)
 p30_country_dummy(iso)             Dummy parameter indicating whether country is affected by selected SNV policy (1)
 i30_avl_cropland_iso(iso)          Available land area for cropland at ISO level (mio. ha)
 p30_snv_scenario_fader(t_all)      SNV scenario fader (1)
 p30_rotation_scenario_fader(t_all) Crop rotation scenario fader (1)
 p30_crop_upper                     Maximum crop growth share (1)
 p30_crop_area_glo                  Last time step crop level (mio. Ha)
 p30_crop_area(i)                   Last time step regional crop level (mio. Ha)
;

positive variables
* Fallow land is cropland which is temporarily fallow. Croparea+fallow=cropland
 vm_fallow(j)                       Fallow land (mio. ha)
 vm_area(j,kcr,w)                   Agricultural production area (mio. ha)
 vm_rotation_penalty(i)             Penalty for violating rotational constraints (USD05MER)
 v30_crop_area(i)                   Total regional crop production area (mio. ha)
 v30_crop_area_glo                  Total global crop production area (mio. ha)
;

equations
 q30_cropland(j)                    Total cropland calculation (mio. ha)
 q30_avl_cropland(j)                Available cropland constraint (mio. ha)
 q30_rotation_max(j,crp30,w)        Local maximum rotational constraints (mio. ha)
 q30_rotation_min(j,crp30,w)        Local minimum rotational constraints (mio. ha)
 q30_prod(j,kcr)                    Production of cropped products (mio. tDM)
 q30_carbon(j,ag_pools,stockType)   Cropland above ground carbon content calculation (mio. tC)
 q30_bv_ann(j,potnatveg)            Biodiversity value of annual cropland (mio. ha)
 q30_bv_per(j,potnatveg)            Biodiversity value of perennial cropland (mio. ha)
 q30_land_snv(j)                    Land constraint for the SNV policy in cropland areas (mio. ha)
 q30_crop_reg(i)                  Total regional crop production area (mio. ha)
 q30_crop_glo                     Total global crop production area (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_fallow(t,j,type)                      Fallow land (mio. ha)
 ov_area(t,j,kcr,w,type)                  Agricultural production area (mio. ha)
 ov_rotation_penalty(t,i,type)            Penalty for violating rotational constraints (USD05MER)
 ov30_crop_area(t,i,type)                 Total regional crop production area (mio. ha)
 ov30_crop_area_glo(t,type)               Total global crop production area (mio. ha)
 oq30_cropland(t,j,type)                  Total cropland calculation (mio. ha)
 oq30_avl_cropland(t,j,type)              Available cropland constraint (mio. ha)
 oq30_rotation_max(t,j,crp30,w,type)      Local maximum rotational constraints (mio. ha)
 oq30_rotation_min(t,j,crp30,w,type)      Local minimum rotational constraints (mio. ha)
 oq30_prod(t,j,kcr,type)                  Production of cropped products (mio. tDM)
 oq30_carbon(t,j,ag_pools,stockType,type) Cropland above ground carbon content calculation (mio. tC)
 oq30_bv_ann(t,j,potnatveg,type)          Biodiversity value of annual cropland (mio. ha)
 oq30_bv_per(t,j,potnatveg,type)          Biodiversity value of perennial cropland (mio. ha)
 oq30_land_snv(t,j,type)                  Land constraint for the SNV policy in cropland areas (mio. ha)
 oq30_crop_reg(t,i,type)                  Total regional crop production area (mio. ha)
 oq30_crop_glo(t,type)                    Total global crop production area (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
