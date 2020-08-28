pro makeDummyPlots

  !X.THICK = 4
  !Y.THICK = 4
  !P.CHARSIZE = 1.25
  !P.CHARTHICK = 4
  
  set_plot, 'PS'
  device, filename = 'context.eps', $
          /decomp, /encap, xsize = 4, ysize = 4, /in
  plot, [-0.5,2.5], [0,2.5], /nodat, $
        xtitle = '!18V-J!X', ytitle = '!18U-V!X', /iso, /xsty
  device, /close

  ;;
  ;;
  ;;
  
  device, filename = 'scheme.eps', $
          /encap, xsize = 6.5, ysize = 3, /in
  x0 = 0.1
  x1 = 0.9
  xw = 0.5 * (x1-x0)
  y2 = 0.95
  y1 = 0.45
  y0 = 0.15
  !p.CHARSIZE = 1.1
  plot, [3000,40000], [0,3], /nodat, $
        pos = [x0,y1+0.1,x0+xw,y2], /xlog, /xsty
  plot, [3000,40000], !Y.CRANGE, /nodat, $
        ytickname = replicate(' ', 60), $
        pos = [x0+xw,!Y.WINDOW[0],x1,y2], /noer, /xlog, /xsty
  plot, [3600,5700], [0,3], /nodat, $
        xtitle = 'rest wavelength ['+textoidl('\AA')+']', $
        pos = [x0,y0,x1,y1], /noer
  cgtext, $
     'flux [10!E-17!N erg s!E-1!N cm!E-2!N '+textoIDl('\AA')+'!E-1!N] ', $
          x0/2, 0.5, align = 0.5, orien = 90, /norm
  device, /close

  ;;
  ;;
  ;;
  
  device, filename = 'metric.eps', $
          /encap, xsize = 4, ysize = 4, /in
  x0 = 0.15
  plot, [5000,5300], [0,3], /nodat, $
        xtickname = replicate(' ', 60), $
        ytitle = '!18f!X!D'+greek('lambda')+$
        '!N [10!E-17!N erg s!E-1!N cm!E-2!N '+textoidl('\AA')+'!E-1!N]', $
        pos = [x0,0.5,0.9,0.9]
  plot, !X.CRANGE, 5 * [-1,1], /nodat, /ysty, $
        xtitle = 'rest wavelength', $
        ytitle = 'residuals [%]', $
        pos = [!X.WINDOW[0],0.15,!X.WINDOW[1],!Y.WINDOW[0]], /noer
  device, /close

  ;;
  ;;
  ;;
  
  device, filename = 'balmer.eps', $
          /decomp, /encap, xsize = 4, ysize = 3, /in
  yw = 0.5 * (y2 - 0.5)
  plot, [3700,5300], [-5,5], /nodat, $
        xtitle = 'wavelength of index', $
        ytitle = 'residuals [%]', $
        /ysty
;        'flux [10!E-17!N erg s!E-!N cm!E-2!N '+textoidl('\AA')+'!E-1!N]'
  device, /close

  ;;
  ;;
  ;;

  device, filename = 'disp.eps', $
          /decomp, /encap, xsize = 4, ysize = 3, /in
  yw = 0.5 * (y2 - 0.5)
  plot, [2,2.5], [10,12], /nodat, $
        xtitle = 'log '+greek('sigma')+' [km s!E-1!N]', $
        ytitle = 'log !18M!X!D*!N [M!D'+sunsymbol()+']!N', $
        /ysty
;        'flux [10!E-17!N erg s!E-!N cm!E-2!N '+textoidl('\AA')+'!E-1!N]'
  device, /close
  
  set_plot, 'X'
  
end
