gumrlvalue<-function (a, mat, dat) 
{
  eps <- 1e-06
  a1 <- a
  a2 <- a
  a1[1] <- a[1] + eps
  a2[2] <- a[2] + eps
  f <- c(seq(0.01, 0.09, by = 0.01), 0.1, 0.2, 0.3, 0.4, 0.5, 
         0.6, 0.7, 0.8, 0.9, 0.9666667, 0.98, 0.99, 0.999)
  q <- gevq(a, 1 - f)
  d1 <- (gevq(a1, 1 - f) - q)/eps
  d2 <- (gevq(a2, 1 - f) - q)/eps
  d <- cbind(d1, d2)
  v <- apply(d, 1, q.form, m = mat)
  tab<-data.frame(ceiling(-1/log(f))[17:21],q[17:21],v[17:21])
  return(tab)
}

maxi<-function(data){
  maxi<-tapply(data$HS,format(data$TIME,"%Y"),max)
  maxi<-data.frame(maxi)
  maxi[,2]<-rownames(maxi)
  ac<-gum.fit(as.vector(maxi[,1]),show =F)
  ac$mle <- c(ac$mle, 0)
  return(ac)
}

