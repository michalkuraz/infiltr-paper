set xlabel "time [hrs]"

set ylabel "{/Symbol D} I(t) [cm]"

set terminal postscript enhanced colour "Helvetica" 23 lw 3

set yrange [-1.5e-3:2.5e-3]
set output "mesh-diff.eps"

set grid

set key box width 0.8 height .8 opaque

plot "abq" u 1:5 w l lc rgb "red" title "offset 2.0cm - offset 1.0cm", "acq" u 1:5 w l  lc rgb "blue" title "offset 2.0cm - offset 0.2cm"
