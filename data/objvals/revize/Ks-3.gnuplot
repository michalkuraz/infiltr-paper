






# bod 3 -------------------------------
xbod=1.059653
ymax=0.04
ymin=0.01
xtext=0.92
ytext=0.042

# set yrange[0:0.11]
set xlabel "K_s [cm.hrs^{-1}]"
set ylabel "{/Symbol Y}_1(K_s) [cm]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top left
set arrow from xbod,ymax to xbod,ymin lw 1 lt rgb "#B88A00"
set label 1 at xtext, ytext
set label 1 "identified K_s=1.060 cm.hrs^{-1}"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid



set terminal postscript enhanced colour "Helvetica" 26 lw 3
# set terminal latex
set output "Ks-6.eps"
plot  "rf1/Ks-1-par.val" smooth unique w l lw 3 title "r_f=1", "Ks-1-par.val" smooth unique w l lw 3 title "r_f=0" 
#----------------------------------------------------------------------------------




