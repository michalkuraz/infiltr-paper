






# bod 3 -------------------------------
xbod=1.0582
ymax=0.05
ymin=0.01
xtext=xbod+xbod/150.0
ytext=ymin+ymin/150.0

set yrange[0:0.11]
set xlabel "K_s [cm.hrs^{-1}]"
set ylabel "{/Symbol Y}(K_s) [cm]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top left
set arrow from xbod,ymax to xbod,0 lw 1 lt rgb "#B88A00"
set label 1 at xtext, ymin
set label 1 "identified K_s=1.0582 cm.hrs^{-1}"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid
set output


set terminal postscript enhanced colour "Helvetica" 23 lw 3
# set terminal latex
set output "Ks-1.eps"
plot "coarse/Ks-1-par.val" smooth unique w l lw 3 title "r_f=1" , "fine/Ks-1-par.val" smooth unique w l lw 3 title "r_f=2"
#----------------------------------------------------------------------------------




