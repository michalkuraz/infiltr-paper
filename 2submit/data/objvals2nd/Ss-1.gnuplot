








# bod 4 -------------------------------
xbod=8.6393e-05
ymax=2.5
ymin=0.01
xtext=0.000001
ytext=3.5

set yrange[0:25]
set xrange[1e-8:0.1]
set xlabel "S_s [cm^{-1}]"
set ylabel "{/Symbol Y}({S_s) [cm^{-1}]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top left
set arrow from xbod,ymax to xbod,ymin lw 1 lt rgb "#B88A00"
set label 1 at xtext, ytext
set label 1 "identified S_s=8.6393e-05  cm^{-1}"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid
set output
set xtics 1e-2
set logscale x


set terminal postscript enhanced colour "Helvetica" 23 lw 3
# set terminal latex
set output "Ss-1.eps"
plot "coarse/Ss-1-par.val" smooth unique w l lw 3 title "r_f=1" , "fine/Ss-1-par.val" smooth unique w l lw 3 title "r_f=2"

#-----------------------------------


