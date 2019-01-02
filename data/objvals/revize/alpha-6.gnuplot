



# bod 6 -------------------------------
xbod=0.002775
ymax=0.065
ymin=0.01
xtext=0.00243
ytext=0.07

xrf1=0.0025
yrf1=0.07

xrf0=0.00328
yrf0=0.065

# set yrange[0:0.22]
set xlabel "{/Symbol a} [cm^{-1}]"
set ylabel "{/Symbol Y}_1({/Symbol a}) [cm]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"


 set key top left
# unset key
set arrow from xbod,ymax to xbod,ymin lw 1 lt rgb "#B88A00" 
set label 1 at xtext, ytext
set label 1 "identified {/Symbol a}=0.002775 cm^{-1}"

# set label 2 at xrf0, yrf0
# set label 3 at xrf1, yrf1
# 
# set label 2 "r_f=0"
# set label 3 "r_f=1"
# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid
set output

set terminal postscript enhanced colour "Helvetica" 26 lw 3
# set terminal latex
set output "alpha-6.eps"
plot "alpha-1-par.val" smooth unique w l lw 3 title "r_f=1" , "rf1/alpha-1-par.val" smooth unique w l lw 3 title "r_f=0"
#----------------------------------------------------------------------------------


