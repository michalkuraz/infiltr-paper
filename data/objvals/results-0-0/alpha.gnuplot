xbod=0.00380
ybod=0.035
xpop=xbod+xbod/10.0
ypop=ybod+ybod/10.0
plot "alpha-3-par.val" smooth unique w l
set xlabel "{/Symbol a} [cm^{-1}]"
set ylabel "{/Symbol Y}_1 [cm]"
set grid
set arrow from xbod,0.0 to xbod,ybod nohead lw 3.5 lc rgb "red"
