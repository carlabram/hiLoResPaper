pro makeSomeTab

  data = mrdfits('lickDef.fits', 1)
  feat = data.NAME  
  bw   = data.L1 - data.L0
  ctr  = 0.5 * (data.L0 + data.L1)

  for ii = 0, n_elements(feat) - 1 do $
     print, f = '(%"%s & %i & %i")', $
            feat[ii], ctr[ii], bw[ii]

end
