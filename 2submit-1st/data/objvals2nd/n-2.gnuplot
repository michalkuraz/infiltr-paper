






# bod 3 -------------------------------
xbod=1.8
ymax=0.05
ymin=0.01
xtext=xbod+xbod/150.0
ytext=ymin+ymin/150.0

set yrange[0:0.11]
set xlabel "n [-]"
set ylabel  "{/Symbol y}_1(n) [cm]"

# set xlabel "$\n$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top right
set arrow from xbod,ymax to xbod,0 lw 1 lt rgb "#B88A00"
set label 1 at xtext, ymin
set label 1 "identified n=1.8 "
# set label 1 "identified $\n$=00258 cm$^{-1}$"
set grid
set output

set terminal postscript enhanced colour "Helvetica" 23 lw 3
# set terminal latex
set output "n-2.eps"
plot "coarse/n-2-par.val" smooth unique w l lw 3 title "r_f=1" , "fine/n-2-par.val" smooth unique w l lw 3 title "r_f=2"
#----------------------------------------------------------------------------------




