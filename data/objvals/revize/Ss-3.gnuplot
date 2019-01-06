






# bod 3 -------------------------------
xbod=5e-5
ymax=0.03
ymin=0.01
xtext=4e-5
ytext=0.032

# set yrange[0:25]
set xlabel "S_s [cm^{-1}]"
set ylabel "{/Symbol Y}_1(S_s) [cm]"
set xrange[0:1e-4]

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top left
set arrow from xbod,ymax to 0,ymin lw 1 lt rgb "#B88A00"
set label 1 at xtext, ytext
set label 1 "identified S_s = 0 cm^{-1}"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid
set output
# set logscale x

set terminal postscript enhanced colour "Helvetica" 26 lw 3
# set terminal latex
set output "Ss-6.eps"
plot  "rf1/Ss-1-par.val" smooth unique w l lw 3 title "r_f=1" , "Ss-1-par.val" smooth unique w l lw 3 title "r_f=0" 
#----------------------------------------------------------------------------------




