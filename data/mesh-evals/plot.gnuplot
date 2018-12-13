  
  set grid
  set xlabel "time [hrs]"
  set ylabel "I_s(t) -I_r(t) [cm]"
  plot "ab.dat" u 2:3 w l title "coarse mesh solutions" ,  "cd.dat" u 2:3 w l title "fine mesh solutions"
  set terminal postscript enhanced colour "Helvetica" 23 lw 3
  set output "meshdiff.eps"
  replot 
