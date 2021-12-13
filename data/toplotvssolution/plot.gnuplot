set grid
set xlabel "time [hrs]"
set ylabel "cumulative infiltration [cm]"
unset key
set terminal postscript "Helvetica" 18 lw 3 color
set output "data.eps"
plot "experiment.dat" lc "red" 
