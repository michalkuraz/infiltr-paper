



# bod 6 -------------------------------
xbod=0.254
ymax=0.05
ymin=0.01
xtext=xbod+xbod/150.0
ytext=ymin+ymin/150.0

set yrange[0:0.22]
set xlabel "{/Symbol q} [-]"
set ylabel "{/Symbol Y}({/Symbol q} [cm]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top right
set arrow from xbod,ymax to xbod,0 lw 1 lt rgb "#B88A00"
set label 1 at xtext, ymin
set label 1 "identified {/Symbol q}=0.254 "
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid
set output

set terminal postscript enhanced colour "Helvetica" 23 lw 3
# set terminal latex
set output "ths-6.eps"
plot "results-0-0/ths-5-par.val" smooth unique w l lw 3 title "r_f=0" ,  "results-1-1/ths-6-par.val" smooth unique w l lw 3 title "r_f=1"
#----------------------------------------------------------------------------------


