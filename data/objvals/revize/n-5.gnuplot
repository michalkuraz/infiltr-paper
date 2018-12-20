




# bod 6 -------------------------------
xbod=2.138
ymax=0.022
ymin=0.012
xtext=2.05
ytext=0.0225

# set yrange[0:0.22]
set xlabel "n [-]"
set ylabel "{/Symbol Y}_1(n) [cm]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top left
set arrow from xbod,ymax to xbod,ymin lw 1 lt rgb "#B88A00"
set label 1 at xtext, ytext
set label 1 "identified n= 2.138"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid
set output

set terminal postscript enhanced colour "Helvetica" 23 lw 3
# set terminal latex
set output "n-5.eps"
plot "n-1-par.val" smooth unique w l lw 3 title "r_f=1" ,"rf1/n-1-par.val" smooth unique w l lw 3 title "r_f=0"
#----------------------------------------------------------------------------------

