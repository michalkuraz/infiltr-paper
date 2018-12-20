








# bod 5 -------------------------------
xbod=1.279
ymax=0.03
xmax=1.26
ymin=0.02
xtext=1.2
ytext=0.0

# set yrange[0.02:0.07]
set xlabel "n [-]"
set ylabel "{/Symbol Y}_1(n) [cm]"

set xrange [1.2:1.4]

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"

xbod2=1.305

set arrow from 1.3,0.09 to xbod2,ymin lw 1 lt rgb "#B88A00" 



# unset key
set arrow from 1.24,0.005 to xbod,ymin lw 1 lt rgb "#B88A00" 
set label 1 at xtext, ytext
set label 1 "identified n=1.279 for r_f=0"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid

# x2=1.205
# y2=0.06
# 
# set label 2 at x2, y2
# set label 2 "r_f=0, 1^{st} iter."
# 
# x3=0.0034
# y3=0.067
# set label 3 at x3, y3
# set label 3 "r_f=1,  1^{st} iter. "
# 
# x4=0.00418
# y4=0.025
# set label 4 at x4, y4
# set label 4 "r_f=1, 2^{nd} iter. "
# 
# x5=0.00418
# y5=0.035
# set label 5 at x5, y5
# set label 5 "r_f=2, 2^{nd} iter. "
# 
x6=1.255
y6=0.092
set label 6 at x6,y6
set label 6 "identified n=1.305 for r_f=1"


set size ratio 0.5
set terminal postscript enhanced colour "Helvetica" 18 lw 3
# set terminal latex
set output "n-7.eps"

plot "../../objvals/results-0-0/n-4-par.val" smooth unique w l lw 3 lt -1 title "r_f=0, 1^{st} iter." ,  "../../objvals/results-1-1/n-5-par.val" smooth unique w l lw 3 lt 1 title "r_f=1,  1^{st} iter. " , "n-1-par.val" smooth unique w l lw 3 title "r_f=1 2^{nd} iter. " ,  "rf2/n-1-par.val" smooth unique w l lw 3 title "r_f=2 2^{nd} iter. "
#----------------------------------------------------------------------------------


