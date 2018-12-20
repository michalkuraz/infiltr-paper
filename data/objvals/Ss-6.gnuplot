



# bod 6 -------------------------------
xbod=1.922e-4
ymax=0.2
ymin=0.0
xtext=xbod/2
ytext=0.21

# set yrange[0:25]
set xlabel "S_s [cm^{-1}]"
set ylabel "{/Symbol Y}_1({S_s) [cm]"
set xrange[0:5e-4]

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top left
set arrow from xbod,ymax to xbod,ymin lw 1 lt rgb "#B88A00"
set label 1 at xtext, ytext
set label 1 "identified S_s=1.922x10^{-4} cm^{-1}"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid
set output
# set logscale x
# set format x "10^{%L}"

set terminal postscript enhanced colour "Helvetica" 23 lw 3
# set terminal latex
set output "Ss-6.eps"
plot "results-0-0/Ss-5-par.val" smooth unique w l lw 3 title "r_f=0" ,  "results-1-1/Ss-6-par.val" smooth unique w l lw 3 title "r_f=1"
#----------------------------------------------------------------------------------


