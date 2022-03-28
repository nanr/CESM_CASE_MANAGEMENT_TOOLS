;*************************************************
; 
; 24oct2021
; author:  nanr
;************************************************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
;************************************************
begin

   dd = systemfunc("date -u +%y%m%d")

;************************************************
; read in PD Volc file and extend the zeros into the future.
;************************************************

  sname = get_script_name()
ipath = "/glade/p/cesmdata/cseg/inputdata/atm/cam/chem/emis/emissions_ssp370/"

ifiles1 = (/"emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_num_so4_a2_anthro-res_surface_mol_175001-210101_0.9x1.25_c20200924.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_bc_a4_anthro_surface_mol_175001-210101_0.9x1.25_c20190222.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_num_bc_a4_anthro_surface_mol_175001-210101_0.9x1.25_c20190222.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_num_so4_a1_anthro-ag-ship_surface_mol_175001-210101_0.9x1.25_c20200924.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_num_so4_a1_anthro-ag-ship_surface_mol_175001-210101_0.9x1.25_c20200924.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_num_so4_a1_anthro-ene_vertical_mol_175001-210101_0.9x1.25_c20190222.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_so4_a1_anthro-ene_vertical_mol_175001-210101_0.9x1.25_c20190222.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_pom_a4_anthro_surface_mol_175001-210101_0.9x1.25_c20190222.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_num_pom_a4_anthro_surface_mol_175001-210101_0.9x1.25_c20190222.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_SO2_anthro-ag-ship-res_surface_mol_175001-210101_0.9x1.25_c20200924.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_SO2_anthro-ag-ship-res_surface_mol_175001-210101_0.9x1.25_c20200924.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_SO2_anthro-ag-ship-res_surface_mol_175001-210101_0.9x1.25_c20200924.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_SO2_anthro-ene_surface_mol_175001-210101_0.9x1.25_c20190222.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_so4_a1_anthro-ag-ship_surface_mol_175001-210101_0.9x1.25_c20200924.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_so4_a1_anthro-ag-ship_surface_mol_175001-210101_0.9x1.25_c20200924.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_so4_a2_anthro-res_surface_mol_175001-210101_0.9x1.25_c20200924.nc",\
           "emissions-cmip6-ScenarioMIP_IAMC-AIM-ssp370-1-1_SOAGx1.5_anthro_surface_mol_175001-210101_0.9x1.25_c20200403.nc"/)

ifiles3 = (/"emissions-cmip6_num_so4_a2_anthro-res_surface_1920cycling_0.9x1.25_c20211024.nc",\
	    "emissions-cmip6_bc_a4_anthro_surface_1920cycling_0.9x1.25_c20211023.nc",\
	    "emissions-cmip6_num_bc_a4_anthro_surface_1920cycling_0.9x1.25_c20211023.nc",\
	    "emissions-cmip6_num_so4_a1_anthro-ag-ship_surface_1920cycling_0.9x1.25_c20211028.nc",\
	    "emissions-cmip6_num_so4_a1_anthro-ag-ship_surface_1920cycling_0.9x1.25_c20211028.nc",\
	    "emissions-cmip6_num_so4_a1_anthro-ene_vertical_1920cycling_0.9x1.25_c20211023.nc",\
	    "emissions-cmip6_so4_a1_anthro-ene_vertical_1920cycling_0.9x1.25_c20211010.nc",\
            "emissions-cmip6_smoothed_pom_a4_anthro_surface_1920cycling_0.9x1.25_c20211028.nc",\
            "emissions-cmip6_smoothed_num_pom_a4_anthro_surface_1920cycling_0.9x1.25_c20211028.nc",\
            "emissions-cmip6_SO2_anthro-ag-ship-res_surface_c1920cycling_0.9x1.25_c20211029.nc",\
            "emissions-cmip6_SO2_anthro-ag-ship-res_surface_c1920cycling_0.9x1.25_c20211029.nc",\
            "emissions-cmip6_SO2_anthro-ag-ship-res_surface_c1920cycling_0.9x1.25_c20211029.nc",\
            "emissions-cmip6_SO2_anthro-ene_surface_c1920cycling_0.9x1.25_c20211029.nc",\
            "emissions-cmip6_so4_a1_anthro-ag-ship_surface_1920cycling_0.9x1.25_c20211029.nc",\
            "emissions-cmip6_so4_a1_anthro-ag-ship_surface_1920cycling_0.9x1.25_c20211029.nc",\
            "emissions-cmip6_so4_a2_anthro-res_surface_1920cycling_0.9x1.25_c20211029.nc",\
            "emissions-cmip6_SOAGx1.5_anthro_surface_1920cycling_0.9x1.25_c20211030.nc"/)

;ofiles = (/"valid_anthro.ps"/)
ofiles = (/"valid_num_so4_a2_anthro.ps","valid_bc_a4_anthro_surface.ps","valid_num_bc_a4_anthro_surface.ps",\
           "valid_num_so4_a1_anthro-ag-ship_surface.ps","valid_num_so4_a1_anthro-ag-ship_surface_Shipping.ps",\
           "valid_num_so4_a1_anthro-ene_vertical.ps","valid_so4_a1_anthro-ene_vertical.ps",\
           "valid_pom_a4_anthro.ps","valid_num_pom_a4_anthro.ps","valid_emiss_ag_sol_was.ps","valid_emiss_ship.ps","valid_emiss_res_tran.ps","valid_anthro-ene_surface.ps",\
           "valid_anthro-ag-ship_emiss_ag.ps","valid_anthro-ag-ship_emiss_shipping.ps","valid_so4_a2_anthro-res_surface.ps","valid_SOAGx1.5_anthro.ps"/)

names   = (/"emiss_res_tran","emiss_anthro","num_bc_a4_anthro","emiss_ag_sol_was","emiss_shipping",\
            "emiss_ene_ind","emiss_ene_ind","emiss_anthro","num_pom_a4_anthro",\
            "emiss_ag_sol_was","emiss_ship","emiss_res_tran","emiss_ene_ind","emiss_ag_sol_was","emiss_shipping","emiss_res_tran","emiss_anthro"/)



nfiles = dimsizes(ifiles3)
do c = 0, nfiles-1

  ifile1 = ipath + ifiles1(c)
  ifile3 = "emissions_1920_cyclical/" + ifiles3(c)
  ofile  = ofiles(c)

  print(ifile1)
  print(ifile3)


;************************************************
  src_file1    = addfile(ifile1,"r")
  dst_file     = addfile(ifile3,"r")

;************************************************
    if(isfilepresent(ofile)) then
       system("rm "+ofile)
    end if
;************************************************
  wks = gsn_open_wks("ps",ofile)
  fvars = names(c)
  pds =  2028
  src_pde = 3299
  pde = src_pde
  nrecs = pde-pds+1
  nyrs = nrecs / 12.
  print("c = " + c + " ... processing file:  " + ifiles3(c))

    nvars = dimsizes(fvars)
    plot = new(nvars,graphic)
  do v = 0, nvars-1
    usevar = fvars(v)
    print("usevar = " + usevar)
    if (c .eq. 5 .or. c .eq. 6) then
    	ivar1   =    src_file1->$usevar$(pds:pde,0,:,:)
    	ivar3   =    dst_file->$usevar$(0:23,0,:,:)
    else
    	ivar1   =    src_file1->$usevar$(pds:pde,:,:)
    	ivar3   =    dst_file->$usevar$(0:23,:,:)
    end if
    date    =    src_file1->date(pds:pde)
    lat     =    dst_file->lat
    nlat    =    dimsizes(lat)

    indate = floattoint(date * 0.0001)

    fyr = indate(0)
    lyr = indate(dimsizes(indate)-1)
    nyrs2 = floattoint(dimsizes(indate) / 12.)

    ; calculate global weights
    gw   = latGauWgt(nlat, "lat", "gaussian weights", "")

    ; create global weighted areal averages
    avgvar1 = wgt_areaave(ivar1,gw,1.0,0)
    avgvar3 = wgt_areaave(ivar3,gw,1.0,0)

    if (c .eq. 4) then
      printVarSummary(avgvar1)
      printVarSummary(avgvar3)
    end if

    a1 = month_to_annual(avgvar1,1)
    a3 = month_to_annual(avgvar3,1)

    rav1 = a1
    rav3 = a3

    tt   = dimsizes(rav1) 
    iyrs = floattoint(nyrs2)

    newvar  = new((/2,tt/),"double")
    newdate = new((/iyrs/),"integer")

    rec = 0
    do year = 0,iyrs-1
	newdate(year) = indate(rec)
	rec = rec + 12
    end do
    newvar(0,0:dimsizes(rav1)-1) = rav1
    ; newvar(1,:dimsizes(rav3)-1) = rav3
    newvar(1,0) = rav3(0)
    newvar(1,dimsizes(rav1)-1) = rav3(1)

    print(dimsizes(rav1))
    print(dimsizes(rav3))

    res = True
    res@gsnDraw		= False
    res@gsnFrame        = False
    res@tiMainString    = usevar
    res@xyMarkLineMode = "MarkLines"               ; Markers *and* lines
    res@xyLineThicknesses = (/1.0,2.0/)               ; make 2nd lines thicker
    res@xyMarkers      = (/0,16/)
    res@xyMarkerSizeF  = (/0.00125,0.00125/)
    res@xyLineColors      = (/"blue","red"/)          ; change line color
    res@xyMarkerThicknesses = (/8.0,4.0/)               ; make 2nd lines thicker

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .2                  ; move units right
  res@pmLegendOrthogonalPosF = -0.5                ; move units down
  res@pmLegendWidthF         = 0.25                ; Change width and
  res@pmLegendHeightF        = 0.10                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .08                 ; label font height
  res@xyExplicitLegendLabels = (/"CMIP6","1920constant"/)         ; create explicit labels

    res@tiXAxisString = "time"
    plot(v) = gsn_xy(wks, newdate,newvar,res)

    res@tiXAxisString = "time"
    plot(v) = gsn_xy(wks, newdate,newvar,res)
    res@pmLegendDisplayMode    = "Never"            ; turn off legend
    res@xyLineColors      = (/"red","red"/)          ; change line color
    res@xyMarkerColors      = (/"red","red"/)
    res@xyMarkerSizeF  = (/0.00125,0.00125/)
    res@xyMonoDashPattern = True
    res@xyDashPattern      = (/1/)          ; change line color
    plota = gsn_xy(wks, newdate(0::dimsizes(rav1)-1),newvar(1,0::dimsizes(rav1)-1),res)
    overlay(plot(v),plota)

     delete([/res,newdate,newvar,src_file1,dst_file,indate,date,rav1,rav3,newvar,a1,a3,avgvar1,avgvar3,ivar1,ivar3/])

  end do		; fvars loop
  resP                     = True                ; modify the panel plot
  gsn_panel(wks,plot,(/1,1/),resP)
end do		; file loop
;************************************************
; create panel
;************************************************
  resP                     = True                ; modify the panel plot
                                                 ; new resource added in NCL V6.4.0
  ;resP@gsnPanelMainString = names(c)
                                                 ; use this for NCL V6.3.0 and earlier
  resP@lbLabelFontHeightF  = 0.07               ; make labels smaller
    resP@xyExplicitLegendLabels = (/"CMIP6","1920constant"/)         ; create explicit labels
    ; if (c .ne. 2) then
    	; nv = nvars/2 + 1
    	; nv = nvars
    	; gsn_panel(wks,plot,(/nv,2/),resP)
    ; else
    ;gsn_panel(wks,plot,(/3,3/),resP)
    ; end if

    ;delete([/plot/])
end