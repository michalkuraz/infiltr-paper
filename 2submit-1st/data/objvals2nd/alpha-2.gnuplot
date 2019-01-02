






# bod 3 -------------------------------
xbod=0.00258
ymax=0.05
ymin=0.01
xtext=xbod+xbod/150.0
ytext=ymin+ymin/150.0

set yrange[0:0.11]
set xlabel "{/Symbol a} [cm^{-1}]"
set ylabel "{/Symbol Y}({/Symbol a}) [cm]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top left
set arrow from xbod,ymax to xbod,0 lw 1 lt rgb "#B88A00"
set label 1 at xtext, ymin
set label 1 "identified {/Symbol a}=0.00258 cm^{-1}"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid
set output

set terminal postscript enhanced colour "Helvetica" 23 lw 3
# set terminal latex
set output "alpha-2.eps"
plot "coarse/alpha-2-par.val" smooth unique w l lw 3 title "r_f=1" ,  "fine/alpha-2-par.val" smooth unique w l lw 3 title "r_f=2"
#----------------------------------------------------------------------------------




