#a5=0.0016337
#n5=1.3481
a6=2.775e-3
n6=2.138
a7=3.8e-3
n7=1.30
a8=3.06e-3
n8=1.364
Ks6=1.06
Ks7=1.008
Ks8=1.067

m6 = 1-1/n6

m7 = 1-1/n7

m8 = 1-1/n8


#f5(x)=1/(1+(-a5*x)**n5)**(1-1/n5)

f6(x)=Ks6*(1 - (-(a6*x))**(m6*n6)/(1 + (-(a6*x))**n6)**m6)**2/(1 + (-(a6*x))**n6)**(m6/2.0)

f7(x)=Ks7*(1 - (-(a7*x))**(m7*n7)/(1 + (-(a7*x))**n7)**m7)**2/(1 + (-(a7*x))**n7)**(m7/2.0)

f8(x)=Ks8*(1 - (-(a8*x))**(m8*n8)/(1 + (-(a8*x))**n8)**m8)**2/(1 + (-(a8*x))**n8)**(m8/2.0)

set xrange [-280:0]

 set yrange [0.:1.1]

set xlabel "pressure head [cm]"

set ylabel "K_s [cm.hrs^{-1}]"

set terminal postscript enhanced lw 3 "Helvetica" 26 colour

set grid

set key top left

set output "Ks.eps"

plot  f6(x) title "extreme 6" lc rgb "red" lw 3, f7(x) title "extreme 7" lc rgb "blue" lw 3, f8(x) title "extreme 8" lc rgb "green" lw 3

