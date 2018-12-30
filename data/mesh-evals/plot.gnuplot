  
  set grid
  set xlabel "time [hrs]"
  set ylabel "I_s(t) -I_r(t) [cm]"
  plot "ab.dat" u 2:3 w l lc rgb "red" title  "coarse mesh solutions" ,  "cd.dat" u 2:3 w l lc rgb "blue"  title "fine mesh solutions"
  
  set key box width 0.8 height .8 opaque
  set terminal postscript enhanced colour "Helvetica" 23 lw 3
  set output "meshdiff.eps"
  replot 
