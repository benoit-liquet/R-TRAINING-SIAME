require(segmented)
require(forecast)
require(tseries)
require(stats)

add.segmented <- function(object,order=12,niter=2,setseed=180, start=c(years,mois),end=c(years,mois)){                          
  
  time.frame <- end[1]-start[1]+1
  object2 <- rep(NA,time.frame*order)
  object2[start[2]:(length(object)+start[2]-1)] <- object
  X.serie <- matrix(object2,ncol=order,nrow=length(object2)/order,byrow=TRUE)  
  
  moyen.mobile <- ma(object2,order=order)                                      
  Tend.est.ts <- moyen.mobile                                                
  for(i in 1:niter){
    Sais <- object2 - Tend.est.ts                                                
    Sais.matrix <- matrix(Sais,ncol=order,nrow=length(object2)/order,byrow=TRUE) 
    indice.saison <- apply(Sais.matrix,2,FUN=function(x) mean(x,na.rm=TRUE))    
    moy <- mean(indice.saison)                                                  
    indice.saison.est <- indice.saison-moy                                     
    mat.indice.saison.est <- matrix(indice.saison.est,ncol=order,nrow=length(object2)/order,byrow=TRUE)  
    Tend <- X.serie - mat.indice.saison.est                                     
    ###segmented estimation model for the tendance
    Tend.Y <- na.omit(as.vector(t(Tend)))                                                
    Tend.time <- 1:length(Tend.Y)                                               
    glm.model <- glm(Tend.Y~Tend.time)                                          
    seg.model <- segmented(glm.model,seg.Z=~Tend.time)           
    Tend.est <- fitted(seg.model)                                              
    Tend.est.ts <- ts(Tend.est,start,end,frequency=order) 
    Tend.est.ts2 <- rep(NA,time.frame*order)
    Tend.est.ts2[start[2]:(length(Tend.est.ts)+start[2]-1)] <- Tend.est.ts
    Tend.est.ts <- Tend.est.ts2
  }
  
  Saison.est.ts <- ts(as.vector(t(mat.indice.saison.est)),start,end,frequency=order) 
  resid.ts <- na.omit(object2) - na.omit(Saison.est.ts) - na.omit(Tend.est.ts)                                                         
  resid <- as.vector(t(resid.ts))                                                                         
  signif <- 2*(1-pt(abs(slope(seg.model)[[1]][,3]),df=seg.model$df.residual))
  result <- list(ptend=length(seg.model$coefficients),Signif=signif, Data.ts=object,Data.vec=as.vector(t(X.serie)),MA=moyen.mobile,Tend=Tend.est.ts,Indice.Saison=indice.saison.est,Saison.ts=Saison.est.ts,residual=resid.ts,Sais.matrix=Sais.matrix) 
  return(result)
}

add.lm <- function(object,order=12,niter=2,setseed=180, start=c(years,mois),end=c(years,mois)){                          
  
  time.frame <- end[1]-start[1]+1
  object2 <- rep(NA,time.frame*order)
  object2[start[2]:(length(object)+start[2]-1)] <- object
  X.serie <- matrix(object2,ncol=order,nrow=length(object2)/order,byrow=TRUE)  
  
  moyen.mobile <- ma(object2,order=order)                                      
  Tend.est.ts <- moyen.mobile                                                
  for(i in 1:niter){
    Sais <- object2 - Tend.est.ts                                                
    Sais.matrix <- matrix(Sais,ncol=order,nrow=length(object2)/order,byrow=TRUE) 
    indice.saison <- apply(Sais.matrix,2,FUN=function(x) mean(x,na.rm=TRUE))    
    moy <- mean(indice.saison)                                                  
    indice.saison.est <- indice.saison-moy                                     
    mat.indice.saison.est <- matrix(indice.saison.est,ncol=order,nrow=length(object2)/order,byrow=TRUE)  
    Tend <- X.serie - mat.indice.saison.est                                     
    ###segmented estimation model for the tendance
    Tend.Y <- na.omit(as.vector(t(Tend)))                                                
    Tend.time <- 1:length(Tend.Y)                                               
    lm.model <- lm(Tend.Y~Tend.time)           
    Tend.est <- fitted(lm.model)                                              
    Tend.est.ts <- ts(Tend.est,start,end,frequency=order) 
    Tend.est.ts2 <- rep(NA,time.frame*order)
    Tend.est.ts2[start[2]:(length(Tend.est.ts)+start[2]-1)] <- Tend.est.ts
    Tend.est.ts <- Tend.est.ts2
  }
  
  Saison.est.ts <- ts(as.vector(t(mat.indice.saison.est)),start,end,frequency=order) 
  resid.ts <- na.omit(object2) - na.omit(Saison.est.ts) - na.omit(Tend.est.ts)                                                         
  resid <- as.vector(t(resid.ts))                                                                         
  sum <- summary(lm.model)
  signif <- sum$coefficients[2,4]
  result <- list(ptend=length(lm.model$coefficients), Signif=signif, Summary=sum, Data=object,Data.vec=as.vector(t(X.serie)),MA=moyen.mobile,Tend=Tend.est.ts,Indice.Saison=indice.saison.est,Saison=Saison.est.ts,Residus=resid.ts,Sais.matrix=Sais.matrix) 
  return(result)
}

mul.lm <- function(object,order=12,niter=2,setseed=180, start=c(years,mois),end=c(years,mois)){                          
  
  time.frame <- end[1]-start[1]+1
  object2 <- rep(NA,time.frame*order)
  object2[start[2]:(length(object)+start[2]-1)] <- object
  X.serie <- matrix(object2,ncol=order,nrow=length(object2)/order,byrow=TRUE)  
  
  moyen.mobile <- ma(object2,order=order)                                      
  Tend.est.ts <- moyen.mobile                                                
  for(i in 1:niter){
    Sais <- object2/Tend.est.ts                                             
    Sais.matrix <- matrix(Sais,ncol=order,nrow=length(object2)/order,byrow=TRUE) 
    indice.saison <- apply(Sais.matrix,2,FUN=function(x) mean(x,na.rm=TRUE))    
    sum.s <- sum(indice.saison)                  
    #Estimation season coefficient
    indice.saison.est <- order*indice.saison/sum.s                                                  
    mat.indice.saison.est <- matrix(indice.saison.est,ncol=order,nrow=length(object2)/order,byrow=TRUE)  
    Tend <- X.serie /mat.indice.saison.est    
    
    ###segmented estimation model for the tendance
    Tend.Y <- na.omit(as.vector(t(Tend)))                                                
    Tend.time <- 1:length(Tend.Y)                                               
    lm.model <- lm(Tend.Y~Tend.time)           
    Tend.est <- fitted(lm.model)                                              
    Tend.est.ts <- ts(Tend.est,start,end,frequency=order) 
    Tend.est.ts2 <- rep(NA,time.frame*order)
    Tend.est.ts2[start[2]:(length(Tend.est.ts)+start[2]-1)] <- Tend.est.ts
    Tend.est.ts <- Tend.est.ts2
  }
  
  Saison.est.ts <- ts(as.vector(t(mat.indice.saison.est)),start,end,frequency=order) 
  resid.ts <- na.omit(object2) / (na.omit(Saison.est.ts) * na.omit(Tend.est.ts) )                                                        
  resid <- as.vector(t(resid.ts))                                                                         
  sum <- summary(lm.model)
  signif <- sum$coefficients[2,4]
  result <- list(ptend=length(lm.model$coefficients), Signif=signif, Summary=sum, Data=object,Data.vec=as.vector(t(X.serie)),MA=moyen.mobile,Tend=Tend.est.ts,Indice.Saison=indice.saison.est,Saison=Saison.est.ts,Residus=resid.ts,Sais.matrix=Sais.matrix) 
  return(result)
}

AIC.add <- function(object,p.sais=12){
  n <- length(object$Residus)
  p.tend <- object$ptend
  df <- n-p.sais-p.tend-1
  sd.residual <- sd(object$Residus)*sqrt((n-1)/df)
  log.lik <- sum(log(dnorm(object$Residus,mean=0,sd=sd.residual)))
  aic <- -2*log.lik+2*(p.sais+p.tend+1)
  return(aic)
}
AIC.mult <- function(object,p.sais=12){
  n <- length(object$Residus)
  p.tend <- object$ptend
  df <- n-p.sais-p.tend-1
  sd.residual <- sd(object$Residus)*sqrt((n-1)/df)
  fit.model <- as.matrix(t(object$Tend))*as.vector(t(object$Saison))
  log.lik <- sum(log(dnorm(object$Data.vec,mean=fit.model,sd=fit.model*sd.residual)))
  aic <- -2*log.lik+2*(p.sais+p.tend+1)
  return(aic)
}


