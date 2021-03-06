---
title: "Analyse des extremes"
author: "Aurelien Callens et Benoit Liquet"
date: "October 31, 2017"
output: html_document
---




# Houle

## Analyse descriptive



- Rose des houles: How to do with R ?


```r
source("Rose_houles.r")
library(data.table)
load("DATASET/Data_wind_Anglet.RData")
a <- seq(from=0,to=round(max(data.wind.anglet$HS)),length=round(max(data.wind.anglet$HS)+1))
plot.swellrose(spd = data.wind.anglet$HS,dir = data.wind.anglet$PEAKD ,spdseq = a)
```

![Rose des houles présentant l'occurence des vagues selon leur hauteur significative et leur direction.  Données du site d'Anglet de 1949 à 2014. \label{fig:rose_vague}](figure/rose_vague-1.png)

- Representation bivariee

![Graphique bivarié de la hauteur significative en fonction de la période. Les couleurs indiquent l'occurence des vagues en pourcentage.  \label{fig:bivar_vague}](figure/bivar_vague-1.png)


## Analyse serie temporelle




```r
recons <- as.data.frame(test1$Tend)
par(new=T)
plot(test1$Data.vec,type="l",ylab="Hs(m)",xlab="Year",axes=F,main="")
axis(2)
axis(1,at=seq(1,792,12),labels=as.character(1949:2014))
lines(recons,col="red",lwd=2)
legend("topleft",legend=c("Série temporelle originale","Tendance"),col=c("black","red"),lty=1,cex=0.8)
```

<img src="figure/tsfin -1.png" title="Série temporelle des moyennes mensuelles de la hauteur significative pour la période 1949-2014 (Site d'Anglet). La tendance est représentée en rouge et les données originales en noir.\label{fig:tsfin}" alt="Série temporelle des moyennes mensuelles de la hauteur significative pour la période 1949-2014 (Site d'Anglet). La tendance est représentée en rouge et les données originales en noir.\label{fig:tsfin}" style="display: block; margin: auto;" />



```r
boxplot(test1$Sais.matrix,pch=1,xlab="Mois",ylab="Hs(m)",main="",ylim=range(test1$Sais.matrix),names=as.character(c("J","F","M","A","M","J","J","A","S","O","N","D")))
abline(h=1,lty=2)
monthplot(x.ts,type="h",ylab="Hs(m)")
```

<img src="figure/indsaivague -1.png" title="(a) Indices saisonniers représentant les différences à la moyenne des hauteurs significatives des vagues selon les mois. (b) Monthplot représentant les séries temporelles de chaque mois durant les 65 années étudiées (1949-2014) pour le site d'Anglet. Dans le graphique des indices saisonniers, la droite y=1 correspond à la moyenne annuelle. Le monthplot représente les séries temporelles au sein de chaque mois, il permet de voir une éventuelle évolution dans le temps.\label{fig:indsaivague}" alt="(a) Indices saisonniers représentant les différences à la moyenne des hauteurs significatives des vagues selon les mois. (b) Monthplot représentant les séries temporelles de chaque mois durant les 65 années étudiées (1949-2014) pour le site d'Anglet. Dans le graphique des indices saisonniers, la droite y=1 correspond à la moyenne annuelle. Le monthplot représente les séries temporelles au sein de chaque mois, il permet de voir une éventuelle évolution dans le temps.\label{fig:indsaivague}" width="50%" /><img src="figure/indsaivague -2.png" title="(a) Indices saisonniers représentant les différences à la moyenne des hauteurs significatives des vagues selon les mois. (b) Monthplot représentant les séries temporelles de chaque mois durant les 65 années étudiées (1949-2014) pour le site d'Anglet. Dans le graphique des indices saisonniers, la droite y=1 correspond à la moyenne annuelle. Le monthplot représente les séries temporelles au sein de chaque mois, il permet de voir une éventuelle évolution dans le temps.\label{fig:indsaivague}" alt="(a) Indices saisonniers représentant les différences à la moyenne des hauteurs significatives des vagues selon les mois. (b) Monthplot représentant les séries temporelles de chaque mois durant les 65 années étudiées (1949-2014) pour le site d'Anglet. Dans le graphique des indices saisonniers, la droite y=1 correspond à la moyenne annuelle. Le monthplot représente les séries temporelles au sein de chaque mois, il permet de voir une éventuelle évolution dans le temps.\label{fig:indsaivague}" width="50%" />

## Etude des extrêmes


```r
source("Selection_cor.R")
library(fExtremes)
library(ismev)
library(QRM)
source("gumrlvalue_maxi.R")
source("gum_rl_ic.R")
library(scales)
maxim<-maxi(data.wind.anglet)
gum.rl.ic(maxim$mle,maxim$cov,maxim$data,.7)
invisible(ks.test(maxim$data,"pGumbel",maxim$mle[1],maxim$mle[2]))
u <- 4.5
data.t <- selection.cor(data.wind.anglet,u)
bootp <- read.csv("DATASET/bootpAnglet_1949_2014.site")[,-1]
k <- (mean(data.t$hs-u)^2/var(data.t$hs-u)-1)/2

o <- mean(data.t$hs-u)*(mean(data.t$hs-u)^2/var(data.t$hs-u)+1)/2
lambdat<-length(data.t$hs)/65
  
t <- c(round(seq(from=0.1,to=9,length=10),1),ceiling(seq(from=10,to=150,length=22)))
xmv <- u+(o/k)*((t*lambdat)^k-1)
  
biais <- apply(bootp,2,mean)-xmv
  
qp <- data.frame((apply(bootp,2,quantile,(1-0.7)/2)-biais),xmv,(apply(bootp,2,quantile,1-(1-0.7)/2)-biais))
t <- c(round(seq(from=0.1,to=9,length=10),1),ceiling(seq(from=10,to=150,length=22)))
plot(t,qp$xmv,log="x",type="n", xlab = "Période de retour (annees)", ylab = "Hauteur significative (metres)", 
       main = "")
lines(t,qp$xmv)
lines(t,qp[,1])
lines(t,qp[,3])
n <- length(data.wind.anglet$HS)
lambdat <-length(data.t$hs)/65
points((1/(1 - (1:n)/(n + 1))/lambdat)[match(data.t$hs,data.wind.anglet$HS)],sort(data.t$hs),pch=16,cex=0.7,col="blue")
abline(v=c(1,5,10,50,100),lty=2,col=alpha("grey",0.9))
invisible(ks.test(data.t$hs,"pgpd",k,u,o))
```

<img src="figure/rlpgpd-1.png" title="(a) Graphiques des périodes de retour calculées avec la méthode des maxima annuels. (b) Graphiques des périodes de retour calculées avec la méthode à seuil pour le site d'Anglet. Les intervalles de confiance sont à 70 pourcents. \label{fig:rlpgpd}" alt="(a) Graphiques des périodes de retour calculées avec la méthode des maxima annuels. (b) Graphiques des périodes de retour calculées avec la méthode à seuil pour le site d'Anglet. Les intervalles de confiance sont à 70 pourcents. \label{fig:rlpgpd}" width="50%" /><img src="figure/rlpgpd-2.png" title="(a) Graphiques des périodes de retour calculées avec la méthode des maxima annuels. (b) Graphiques des périodes de retour calculées avec la méthode à seuil pour le site d'Anglet. Les intervalles de confiance sont à 70 pourcents. \label{fig:rlpgpd}" alt="(a) Graphiques des périodes de retour calculées avec la méthode des maxima annuels. (b) Graphiques des périodes de retour calculées avec la méthode à seuil pour le site d'Anglet. Les intervalles de confiance sont à 70 pourcents. \label{fig:rlpgpd}" width="50%" />




