gum.rl.ic<-function (a, mat, dat,ic) 
{
  ec<-qnorm((1-(1-ic)/2),mean=0,sd=1)
  eps <- 1e-06
  a1 <- a
  a2 <- a
  a1[1] <- a[1] + eps
  a2[2] <- a[2] + eps
  f <- c(seq(0.01, 0.09, by = 0.01), 0.1, 0.2, 0.3, 0.4, 0.5, 
         0.6, 0.7, 0.8, 0.9, 0.95, 0.99, 0.995, 0.999)
  q <- gevq(a, 1 - f)
  d1 <- (gevq(a1, 1 - f) - q)/eps
  d2 <- (gevq(a2, 1 - f) - q)/eps
  d <- cbind(d1, d2)
  v <- apply(d, 1, q.form, m = mat)
  options(scipen = 999)
  plot(-1/log(f), q, log = "x", type = "n", xlim = c(0.1,150), ylim = c(min(dat, q), max(dat, q)), xlab = "P?riode de retour (ann?es)", ylab = "Hauteur significative (m?tres)", 
       main = "")
  lines(-1/log(f), q)
  lines(-1/log(f), q + ec * sqrt(v))
  lines(-1/log(f), q - ec * sqrt(v))
  points(-1/log((1:length(dat))/(length(dat) + 1)), sort(dat),pch=16,cex=0.7,col="blue")
}
