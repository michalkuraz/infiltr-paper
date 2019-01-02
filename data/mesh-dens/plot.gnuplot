set grid
set logscale x
set logscale y

set xlabel "r_{min} [cm]"
set ylabel "NDOFs"

set terminal postscript enhanced colour "Helvetica" 23 lw 3

set output "denses.eps"


plot "denses" w l notitle
