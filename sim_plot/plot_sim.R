infilt_sim=read.table('infilt_sim.in',head=T)
infilt_meas=read.table('infilt_meas.in',skip=1)
rep_sim=read.table('rep_sim.in',skip=1)


png('infilt_data.png',width=600, height=600,units='px')
for(i in 1:22){
  if(i==1){
    plot(rep_sim$V1,log10(infilt_sim[,i]), type='l', col=gray(0.4),xlim=c(0,4000),ylim=c(-3,-1),ylab='Cumulative infiltration [m]',xlab='Time [s]',yaxt='n')
  }else{
    plot(rep_sim$V1,log10(infilt_sim[,i]), type='l',col=gray(0.4),xlim=c(0,4000),ylim=c(-3,-1),ylab='',xlab='',yaxt='n',xaxt='n')
  }
  par(new=T)
}
plot(infilt_meas$V1,log10(infilt_meas$V3), pch=4, col=gray(0.4),xlim=c(0,4000),ylim=c(-3,-1),ylab='',xlab='',yaxt='n',xaxt='n')
par(new=T)
plot(rep_sim$V1,log10(rep_sim$V2),type='l',col='red',lwd=2,xlim=c(0,4000),ylim=c(-3,-1),yaxt='n',xaxt='n',ylab='',xlab='')
axis(side=2,at=c(-3,-2.5,-2,-1.5,-1),labels=c('1e-3','5e-2','1e-2','5e-1','1e-1'))
par(new=T)    
plot(rep_sim$V1,log10(apply(infilt_sim,1,mean)), type='l',col='green',xlim=c(0,4000),ylim=c(-3,-1),ylab='',xlab='',yaxt='n',xaxt='n',lwd=2)
par(new=T)    
plot(rep_sim$V1,apply(log10(infilt_sim),1,mean), type='l',col='royalblue2',xlim=c(0,4000),ylim=c(-3,-1),ylab='',xlab='',yaxt='n',xaxt='n',lwd=2)
par(new=T)    
plot(rep_sim$V1,log10(apply(infilt_sim,1,median)), type='l',col='darkorange',xlim=c(0,4000),ylim=c(-3,-1),ylab='',xlab='',yaxt='n',xaxt='n',lwd=2)
dev.off()