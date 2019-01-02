a1=0.019
n1=1.31
m1=1-1/n1
a2=0.145
n2=2.68
m2=1-1/n2
f(x) = 1/(1+(-a1*x)**n1)**m1
g(x) = 1/(1+(-a2*x)**n2)**m2
set xrange [-100:0]
thr1=0.095
ths1=0.41
thr2=0.045
ths2=0.43
f(x) = (ths1-thr1)/(1+(-a1*x)**n1)**m1 + thr1
g(x) = (ths2-thr2)/(1+(-a2*x)**n2)**m2 + thr2
set grid
set xlabel "h [cm]"
set ylabel "{/Symbol q}(h) [-]"
set terminal postscript enhanced lw 4 "Helvetica" 23 colour dashed
set key right bottom
set output "retc-bench.eps"
plot f(x) title "clay loam", g(x) title "sand" 
