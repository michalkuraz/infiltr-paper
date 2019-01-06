






# bod 3 -------------------------------
xbod=0.362
ymax=0.05
ymin=0.01
xtext=xbod+xbod/150.0
ytext=ymin+ymin/150.0

set yrange[0:0.11]
set xlabel "{/Symbol q} [-]"
set ylabel "{/Symbol Y}_1({/Symbol q}) [cm]"

# set xlabel "$\ths$ [-]"
# set ylabel "$\Psi$ [cm]"


set key top center
set arrow from xbod,ymax to xbod,0 lw 1 lt rgb "#B88A00"
set label 1 at xtext, ymin
set label 1 "identified {/Symbol q}=0.362 "
# set label 1 "identified $\ths$=00258 cm$^{-1}$"
set grid
set output

set terminal postscript enhanced colour "Helvetica" 26 lw 3
# set terminal latex
set output "ths-6.eps"
plot "rf1/ths-1-par.val" smooth unique w l lw 3 title "r_f=1", "ths-1-par.val" smooth unique w l lw 3 title "r_f=0" 
#----------------------------------------------------------------------------------




