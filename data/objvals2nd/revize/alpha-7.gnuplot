








# bod 5 -------------------------------
ylow=0.02
yhigh=0.08
xbod=0.00380
ymax=0.0227
xmax=0.0036
ymin=0.02
xlow=0.0032
xhigh=0.0044


set yrange[ylow:yhigh]
set xrange[xlow:xhigh]
set xlabel "{/Symbol a} [cm^{-1}]"
set ylabel "{/Symbol Y}_1({/Symbol a}) [cm]"

# set xlabel "$\alpha$ [cm$^{-1}$]"
# set ylabel "$\Psi$ [cm]"

xbod2=0.003959044

# set arrow from 0.0038,0.04 to xbod2,ymin lw 1 lt rgb "#B88A00" 



set key top right

set key spacing 1.1



set style rect back fs empty border lc rgb '#008800'
xscale=1.0/(0.0044-0.0032)*(xhigh-xlow)
yscale=1.0/(0.07-0.02)*(yhigh-ylow)

xpos1=(0.00356-0.0032)*xscale + xlow
ypos1=(0.068-0.02)*yscale + ylow
xpos11=(0.00406-0.0032)*xscale + xlow
ypos11=(0.064-0.02)*yscale + ylow
set object 1 rect from xpos1,ypos1 to xpos11,ypos11 lw 5

xtext=(0.00357-xlow)*xscale + xlow
ytext=(0.066 - ylow)*yscale + ylow

set label 1 at xtext, ytext
set label 1 "identified {/Symbol a}=0.0038 cm^{-1} for r_f=0"

xpos2=(0.00356-0.0032)*xscale + xlow
ypos2=(0.059-0.02)*yscale + ylow
xpos22=(0.00406-0.0032)*xscale + xlow
ypos22=(0.055-0.02)*yscale + ylow
set object 2 rect from xpos2,ypos2 to xpos22,ypos22 lw 5 fs empty border lc rgb '#880080'

#  set arrow from xbod,0.02 to xbod,0.053 nohead 
# 
#  set arrow from xbod2,0.02 to xbod2,0.035 nohead 

# set label 1 "identified $\alpha$=00258 cm$^{-1}$"
set grid

# set object 3 circle at  0.00380,0.02 size scr 0.02 fc rgb '#008800' lw 4
# 
# set object 4 circle at 0.003959044 ,0.02 size scr 0.02 fc rgb '#880080' lw 4

xpos3=(0.00406-0.0032)*xscale + xlow
ypos3=(0.07-0.02)*yscale + ylow

xpos33=(0.0044-0.0032)*xscale + xlow
ypos33=(0.062-0.02)*yscale + ylow

set object 5 rect from xpos3,ypos3 to xpos33,ypos33 lw 5 fs empty border lc rgb '#008800'


xpos4=xpos3
ypos4=(0.061-0.02)*yscale + ylow

xpos44=(0.0044-0.0032)*xscale + xlow
ypos44=(0.053-0.02)*yscale + ylow

set object 6 rect from xpos4,ypos4 to xpos44,ypos44 lw 5 fs empty border lc rgb '#880080'


# x2=0.00322
# y2=0.039
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

x6=(0.00357-xlow)*xscale +xlow
y6=(0.057-ylow)*yscale + ylow
set label 6 at x6,y6
set label 6 "identified {/Symbol a}=0.0041 cm^{-1} for r_f=1"


set size ratio 0.5
set terminal postscript enhanced colour "Helvetica" 16 lw 3
# set terminal latex
set output "alpha-5.eps"



# f(x) = 43301.1685333345*(x-0.0002)**2 - 328.182481513453*(x-0.0002) + 0.656148123558243
plot "../../objvals/results-0-0/alpha-4-par.val" smooth unique w l lw 3 dt 2 linecolor rgb "red"  title "r_f=0, 1^{st} iter." ,  "../../objvals/results-1-1/alpha-5-par.val"  smooth unique w l lw 3  dt 2 linecolor rgb "blue" title "r_f=1, 1^{st} iter." , "+" u 1:(NaN) title " " w dots linecolor rgb "white",  "alpha-1-par.val" smooth unique w l lw 3   linecolor rgb "red"  title   "r_f=1, 2^{nd} iter." , "rf2/alpha1" smooth unique w l   lw 3   linecolor rgb "blue"  title "r_f=2, 2^{nd} iter.", "alpha-0.ext" pt 1 ps 5  lc rgb '#008800'  lw 5 notitle , "alpha-1.ext" pt 2 ps 5  lc rgb '#880080' lw 5 notitle 
#----------------------------------------------------------------------------------


