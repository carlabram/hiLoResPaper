function getlick, lambda, spec, $
                  line = line, $
                  getall = getall, $
                  printname = printname

  if NOT keyword_set(line) then line = 'Hdelta_A'

  defs = mrdfits('lickDef.fits', 1, /sil)

  if NOT keyword_set(PRINTNAME) then begin

     if NOT keyword_set(getall) then begin
        name = strcompress(defs.NAME, /rem)
        nlines = n_elements(line)
;        rd = fltarr(nlines)
        ew = fltarr(nlines)
        nc = intarr(nlines)
        dl = lambda[1] - lambda[0]
        for ii = 0, nlines - 1 do begin
           ind = where(name eq line[ii])
           bc = where(lambda ge defs[ind].B0 and lambda le defs[ind].B1)
           rc = where(lambda ge defs[ind].R0 and lambda le defs[ind].R1)
           lc = where(lambda ge defs[ind].L0 and lambda le defs[ind].L1, ncont)
           slp = (mean(spec[bc]) - mean(spec[rc])) / (mean(lambda[bc]) - mean(lambda[rc]))
           cont = findgen(ncont) * slp + mean(spec[bc])
;           rd[ii] = total(spec[lc]/cont) * (lambda[1]-lambda[0])
           ew[ii] = total(1-spec[lc]/cont) * dl
           nc[ii] = ncont           
        endfor
     endif else begin
        ew = fltarr(n_elements(defs))
        for ii = 0, n_elements(defs) - 1 do begin
           bc = where(lambda ge defs[ii].B0 and lambda le defs[ii].B1)
           rc = where(lambda ge defs[ii].R0 and lambda le defs[ii].R1)
           lc = where(lambda ge defs[ii].L0 and lambda le defs[ii].L1, ncont)
           slp = (mean(spec[bc]) - mean(spec[rc])) / (mean(lambda[bc]) - mean(lambda[rc]))
           cont = findgen(ncont) * slp + mean(spec[bc])
;           rd[ii] = total(spec[lc]/cont) * (lambda[1]-lambda[0])
           ew[ii] = total(1-spec[lc]/cont) * dl
           nc[ii] = ncont
        endfor
     endelse

     output = {LINES: line, EW: ew, NPIX: nc}
     
     RETURN, output

  endif else $
     print, defs.NAME
  
end

;;
;;
;;

pro makelickdb
  readcol, 'lickdef.dat', $
           l0, l1, b0, b1, r0, r1, unit, name, $
           f = 'X,F,F,F,F,F,F,I,A', /sil, /quick, comment = '#'
  n = n_elements(name)
  savedata = {L0:    0., $
              L1:    0., $
              B0:    0., $
              B1:    0., $
              R0:    0., $
              R1:    0., $
              NAME: '0' $
             }
  savedata = replicate(savedata, n)
  for ii = 0, n - 1 do begin
     savedata[ii].L0   = l0[ii]
     savedata[ii].L1   = l1[ii]
     savedata[ii].B0   = b0[ii]
     savedata[ii].B1   = b1[ii]
     savedata[ii].R0   = r0[ii]
     savedata[ii].R1   = r1[ii]
     savedata[ii].NAME = name[ii]
  endfor
  mwrfits, savedata, 'lickDef.fits', /create
end
