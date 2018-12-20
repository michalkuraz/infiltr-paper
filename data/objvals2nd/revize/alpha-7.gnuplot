








# bod 5 -------------------------------
xbod=0.00380
ymax=0.024
xmax=0.00362
ymin=0.02
xtext=0.00325
ytext=0.025

set yrange[0.02:0.07]
set xlabel "{/Symbol a} [cm^{-1}]"
set ylabel "{/Symbol Y}_1({/Symbol a}) [cm]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"

xbod2=0.003959044

set arrow from 0.0041,0.055 to xbod2,ymin lw 1 lt rgb "#B88A00" 



unset key
set arrow from xmax,ymax to xbod,ymin lw 1 lt rgb "#B88A00" 
set label 1 at xtext, ytext
set label 1 "identified {/Symbol a}=0.00380 cm^{-1} for r_f=0"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid

x2=0.00322
y2=0.039

set label 2 at x2, y2
set label 2 "r_f=0, 1^{st} iter."

x3=0.0034
y3=0.067
set label 3 at x3, y3
set label 3 "r_f=1,  1^{st} iter. "

x4=0.00418
y4=0.025
set label 4 at x4, y4
set label 4 "r_f=1, 2^{nd} iter. "

x5=0.00418
y5=0.035
set label 5 at x5, y5
set label 5 "r_f=2, 2^{nd} iter. "

x6=0.00378
y6=0.0555
set label 6 at x6,y6
set label 6 "identified {/Symbol a}=0.00395 cm^{-1} for r_f=1"


set size ratio 0.5
set terminal postscript enhanced colour "Helvetica" 18 lw 3
# set terminal latex
set output "alpha-5.eps"
f(x) = 43301.1685333345*(x-0.0002)**2 - 328.182481513453*(x-0.0002) + 0.656148123558243
plot "../../objvals/results-0-0/alpha-4-par.val" smooth unique w l lw 3 title "r_f=0, 1^{st} iter." ,  "../../objvals/results-1-1/alpha-5-par.val" smooth unique w l lw 3 title "r_f=1,  1^{st} iter. " , "alpha-1-par.val" smooth unique w l lw 3 title "r_f=1 2^{nd} iter. " , f(x)   lw 3 title "r_f=2 2^{nd} iter. "
#----------------------------------------------------------------------------------


