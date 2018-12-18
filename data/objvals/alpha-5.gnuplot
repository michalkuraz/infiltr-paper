








# bod 5 -------------------------------
xbod=0.00380
ymax=0.05
ymin=0.01
xtext=xbod+xbod/150.0
ytext=ymin+ymin/150.0

set yrange[0.02:0.08]
set xlabel "{/Symbol a} [cm^{-1}]"
set ylabel "{/Symbol Y}_1({/Symbol a}) [cm]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


set key top left
set arrow from xbod,ymax to xbod,0 lw 1 lt rgb "#B88A00" 
set label 1 at xtext, ymin
set label 1 "identified {/Symbol a}=0.00380 cm^{-1} for r_f=0"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid
set output

set terminal postscript enhanced colour "Helvetica" 18 lw 3
# set terminal latex
set output "alpha-5.eps"
f(x) = 43301.1685333345*(x-0.0002)**2 - 328.182481513453*(x-0.0002) + 0.656148123558243
plot "results-0-0/alpha-4-par.val" smooth unique w l lw 3 title "r_f=0, 1^{st} iter." ,  "results-1-1/alpha-5-par.val" smooth unique w l lw 3 title "r_f=1,  1^{st} iter. " , "../objvals2nd/revize/alpha-1-par.val" smooth unique w l lw 3 title "r_f=1 2^{nd} iter. " ,  f(x) lw 3 title "r_f=2 2^{nd} iter. "
#----------------------------------------------------------------------------------


