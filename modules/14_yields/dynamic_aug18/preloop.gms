*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

i14_yields(t,j,kve,w) = f14_yields(t,j,kve,w);

***YIELD CORRECTION FOR 2ND GENERATION BIOENERGY CROPS*************************************
i14_yields(t,j,"begr",w) = i14_yields(t,j,"begr",w)*sum(cell(i,j),fm_tau1995(i))/fm_tau1995("EUR");
i14_yields(t,j,"betr",w) = i14_yields(t,j,"betr",w)*sum(cell(i,j),fm_tau1995(i))/fm_tau1995("EUR");

***MANAGEMENT CORRECTION FACTOR FOR PASTURE ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***
p14_yields_LPJ_reg(t,i) = (sum(cell(i,j),i14_yields(t,j,"pasture","rainfed")*pm_land_start(j,"past"))/sum(cell(i,j),pm_land_start(j,"past")) );

p14_pyield_corr(t,i) = (f14_pyld_hist(t,i)/p14_yields_LPJ_reg(t,i))$(sum(sameas(t_past,t),1) = 1)
			+ sum(t_past$(card(t_past)),(f14_pyld_hist(t_past,i)/(p14_yields_LPJ_reg(t_past,i)+0.000001)))$(sum(sameas(t_past,t),1) <> 1);


***YIELD CALIBRATION***********************************************************************
i14_yields(t,j,kcr,w)       = i14_yields(t,j,kcr,w)      *sum(cell(i,j),f14_yld_calib(i,"crop"));
i14_yields(t,j,"pasture",w) = i14_yields(t,j,"pasture",w)*sum(cell(i,j),f14_yld_calib(i,"past"));


***INITIALIZATION OF PARAMETERS FOR THE INITIAL TIME STEP**********************************
v14_incr_graz_ani.l(i) = 1;

pc14_graz_ani(i) = 1;
pc14_beef_cattle(i) = 1;

pc14_past_mngmnt_factor(i) = 1; 



