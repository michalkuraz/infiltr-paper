








# bod 5 -------------------------------
ylow=0.0
yhigh=0.16

xlow=0.4
xhigh=0.8




xscale=1.0/(0.0044-0.0032)*(xhigh-xlow)
yscale=1.0/(0.07-0.02)*(yhigh-ylow)

set yrange[ylow:yhigh]
set xrange[xlow:xhigh]


set xlabel "{/Symbol q} [-]"
set ylabel "{/Symbol Y}_1({/Symbol q}) [cm]"








xtext=(0.00357-0.0032)*xscale + xlow
ytext=(0.066 - 0.02)*yscale + ylow

set label 1 at xtext, ytext
set label 1 "identified {/Symbol q}=0.594 for r_f=0"
set grid


x6=(0.00357-0.0032)*xscale +xlow
y6=(0.056-0.02)*yscale + ylow

set label 6 at x6,y6
set label 6 "identified {/Symbol q}=0.621 for r_f=1"

set style rect back fs empty border lc rgb '#008800'
xpos1=(0.00356-0.0032)*xscale + xlow
ypos1=(0.068-0.02)*yscale + ylow
xpos11=(0.00406-0.0032)*xscale + xlow
ypos11=(0.064-0.02)*yscale + ylow
set object 1 rect from xpos1,ypos1 to xpos11,ypos11 lw 5

xpos2=(0.00356-0.0032)*xscale + xlow
ypos2=(0.058-0.02)*yscale + ylow
xpos22=(0.00406-0.0032)*xscale + xlow
ypos22=(0.054-0.02)*yscale + ylow
set object 2 rect from xpos2,ypos2 to xpos22,ypos22 lw 5 fs empty border lc rgb '#880080'

xpos3=(0.00406-0.0032)*xscale + xlow
ypos3=(0.07-0.02)*yscale + ylow

xpos33=(0.0044-0.0032)*xscale + xlow
ypos33=(0.062-0.02)*yscale + ylow

set object 5 rect from xpos3,ypos3 to xpos33,ypos33 lw 5 fs empty border lc rgb '#008800'

xpos4=xpos3
ypos4=(0.060-0.02)*yscale + ylow

xpos44=(0.0044-0.0032)*xscale + xlow
ypos44=(0.052-0.02)*yscale + ylow

set object 6 rect from xpos4,ypos4 to xpos44,ypos44 lw 5 fs empty border lc rgb '#880080'




set size ratio 0.5
set terminal postscript enhanced colour "Helvetica" 16 lw 3
# set terminal latex
set output "ths-5.eps"
# 
# plot "../../objvals/results-0-0/n-4-par.val" smooth unique w l lw 3 lt -1 title "r_f=0, 1^{st} iter." ,  "../../objvals/results-1-1/n-5-par.val" smooth unique w l lw 3 lt 1 title "r_f=1,  1^{st} iter. " , "n-1-par.val" smooth unique w l lw 3 title "r_f=1 2^{nd} iter. " ,  "rf2/n-1-par.val" smooth unique w l lw 3 title "r_f=2 2^{nd} iter. "

plot "../../objvals/results-0-0/ths-4-par.val" smooth unique w l lw 3 dt 2 linecolor rgb "red"  title "r_f=0, 1^{st} iter." ,  "../../objvals/results-1-1/ths-5-par.val"  smooth unique w l lw 3  dt 2 linecolor rgb "blue" title "r_f=1, 1^{st} iter." , "+" u 1:(NaN) title " " w dots linecolor rgb "white"  ,  "+" u 1:(NaN) title " " w dots linecolor rgb "white" , "ths-1-par.val" smooth unique w l lw 3   linecolor rgb "red"  title   "r_f=1, 2^{nd} iter." ,"rf2/ths-1-par.val" smooth unique w l lw 3   linecolor rgb "blue"  title "r_f=2, 2^{nd} iter.", "ths-0.ext" pt 1 ps 5  lc rgb '#008800'  lw 2 notitle , "ths-1.ext" pt 2 ps 5  lc rgb '#880080' lw 2 notitle 


#----------------------------------------------------------------------------------


