*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' The Biodiversity Intactness Index (BII) is calculated at the level of 71 biomes.

 q44_bii(biome44)$(sum(j2, f44_biome(j2,biome44)) > 0) .. v44_bii(biome44)
 					=e=
 					(sum((j2,potnatveg,landcover44), vm_bv(j2,landcover44,potnatveg) * f44_biome(j2,biome44)) / sum((j2,land), pcm_land(j2,land) * f44_biome(j2,biome44)));

*' For each of the 71 biomes, the BII has to meet a minium level based on `s44_bii_lower_bound`.
*' `v44_bii_missing` is a technical variable to maintain feasibility in case `v44_bii` cannot be increased.
 					
 q44_bii_target(biome44)$(sum(j2, f44_biome(j2,biome44)) > 0) .. 					
 					v44_bii(biome44) =g= sum(ct, p44_bii_lower_bound(ct,biome44));

