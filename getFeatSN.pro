pro getFeatSN, precision

  if NOT keyword_set(precision) then precision = 0.015 ;; 1.5% on the feature
  
;  readcol, 'lickWidth.dat', name, width, f = 'A,F', comment = '#'
  data  = mrdfits('lickdef.fits', 1)
  name  = data.NAME
  width = data.L1 - data.L0
  ctr   = 0.5 * (data.L0 + data.L1)
  nfeat = n_elements(name)

  snperAA = []
  for ii = 0, nfeat - 1 do begin
     snperAA = [snperAA, 1. / (precision * sqrt(width[ii]))]
     print, name[ii], snperAA[ii]
  endfor

  print, mean(snperAA), minmax(snperAA)

  s = sort(ctr)

  plot, ctr[s], snperAA[s], $
        xtitle = textoidl('\AA'), $
        ytitle = "!18S/N!X ["+textoidl("\AA")+'!E-1!N]'
  cgtext, !X.WINDOW[1]-0.025, !Y.WINDOW[1]-0.075, align = 1, $
          strcompress('to reach '+string(precision * 100, f = '(F4.1)')+'% per feature'), $
          /norm
  
end
