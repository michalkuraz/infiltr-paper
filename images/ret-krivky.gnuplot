#a5=0.0016337
#n5=1.3481
a6=2.775e-3
n6=2.138
a7=3.8e-3
n7=1.30
a8=3.06e-3
n8=1.364
ths6=0.362
ths7=0.621
ths8=0.243

#f5(x)=1/(1+(-a5*x)**n5)**(1-1/n5)

f6(x)=ths6/(1+(-a6*x)**n6)**(1-1/n6)

f7(x)=ths7/(1+(-a7*x)**n7)**(1-1/n7)

f8(x)=ths8/(1+(-a8*x)**n8)**(1-1/n8)

set xrange [-280:0]

 set yrange [0.:0.6]

set xlabel "pressure head [cm]"

set ylabel "{/Symbol q}_s [-]"

set terminal postscript enhanced lw 3 "Helvetica" 26 colour

set grid

set key bottom right

set output "retc.eps"

plot  f6(x) title "extreme 6" lc rgb "red" lw 3, f7(x) title "extreme 7" lc rgb "blue" lw 3, f8(x) title "extreme 8" lc rgb "green" lw 3

