a5=0.0016337
n5=1.3481
a6=0.00258
n6=1.8
a7=0.0032285
n7=1.4421
a8=0.002276
n8=1.5189

f5(x)=1/(1+(-a5*x)**n5)**(1-1/n5)

f6(x)=1/(1+(-a6*x)**n6)**(1-1/n6)

f7(x)=1/(1+(-a7*x)**n7)**(1-1/n7)

f8(x)=1/(1+(-a8*x)**n8)**(1-1/n8)

set xrange [-280:0]

set yrange [0:1]

set xlabel "pressure head [cm]"

set ylabel "{/Symbol q}_E [-]"

set terminal postscript enhanced lw 3 "Helvetica" 25 colour

set grid

set key bottom right

set output "retc.eps"

plot f5(x)  title "5", f6(x) title "6", f7(x) title "7", f8(x) title "8"

