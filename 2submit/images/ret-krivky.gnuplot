#a5=0.0016337
#n5=1.3481
a6=0.00258
n6=1.95
a7=0.0032285
n7=1.4421
a8=0.002276
n8=1.5189
ths6=0.401
ths7=0.513
ths8=0.236

#f5(x)=1/(1+(-a5*x)**n5)**(1-1/n5)

f6(x)=ths6/(1+(-a6*x)**n6)**(1-1/n6)

f7(x)=ths7/(1+(-a7*x)**n7)**(1-1/n7)

f8(x)=ths8/(1+(-a8*x)**n8)**(1-1/n8)

set xrange [-280:0]

 set yrange [0.:0.6]

set xlabel "pressure head [cm]"

set ylabel "{/Symbol q}_s [-]"

set terminal postscript enhanced lw 3 "Helvetica" 22 colour

set grid

set key top left

set output "retc.eps"

plot  f6(x) title "extreme 6" lc rgb "red" lw 3, f7(x) title "extreme 7" lc rgb "blue" lw 3, f8(x) title "extreme 8" lc rgb "green" lw 3

