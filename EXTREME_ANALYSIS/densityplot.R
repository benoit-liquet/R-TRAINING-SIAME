
density.plot<-function(xdat,ydat,xlabe,ylabe){
  
  library(MASS)
  f1 <- kde2d(xdat, ydat, n = 40, lims = c(range(xdat), range(ydat)))
  f1$z<-(f1$z)*100
  
  palette<-rev(rainbow(20,s=0.95,start=0.956,end=0.65))
  
  filled.contour(f1$x,f1$y,f1$z,col=palette,levels  = seq(from=min(f1$z)+0.0004*100,to=max(f1$z),length=20),xlim = c(2,18),
                 ylim = c(0,7),xlab=xlabe,ylab=ylabe)
  
}
