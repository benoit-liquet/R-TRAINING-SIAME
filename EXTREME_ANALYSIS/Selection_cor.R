selection.cor<-function(data,seuil){
data$TIME<-as.POSIXlt(data$TIME, format = "%Y%m%d.%H%M")

test<-data[-1,]
test.sel<-test[which(test$HS>seuil),]
tempete<-data.frame(num=numeric(),debut=as.POSIXlt(character()),fin=as.POSIXlt(character()),hs=numeric(),tm02=numeric(),duree=numeric())
tempete[1,2]<-as.POSIXct(test.sel[1,1])
g<-1
tempete[1,4:5]<-0

for (i in 1 : length(test.sel$TIME)){
  tempete[g,1]<-g
  
  dif<-as.numeric(difftime(test.sel[i+1,1],test.sel[i,1],units="hours"))
  
  if(dif <= 48){
    tempete[g,2]<-min(as.POSIXct(tempete[g,2]),as.POSIXct(test.sel[i,1]),as.POSIXct(test.sel[i+1,1]))
    tempete[g,4]<-max(tempete[g,4],test.sel[i,2],test.sel[i+1,2],na.rm = TRUE)
    tempete[g,5]<-max(tempete[g,5],test.sel[i,3],test.sel[i+1,3],na.rm = TRUE)
    if ((i+1)==length(test.sel$TIME)){
      tempete[g,3]<-as.POSIXct(test.sel[i+1,1])
      break
    }
  }else{
    tempete[g,3]<-as.POSIXct(test.sel[i,1])
    
    g<-g+1
    tempete[g,2]<-as.POSIXct(test.sel[i+1,1])
    tempete[g,4]<-test.sel[i+1,2]
    tempete[g,5]<-test.sel[i+1,3]
  }
  
}

for (j in 1:length(tempete[,1])){
  tempete[j,6]<-as.numeric(difftime(tempete[j,3],tempete[j,2],units="hours"))
}
return(tempete)
}

selection.flux<-function(file,quant){
  data<-read.csv2(file,header=TRUE)[,-1]
  data$Date<-as.POSIXlt(data$Date, format="%Y-%m-%d %H:%M:%S")
  
  test<-data[,-c(2,4,5,7)]
  
  test.sel<-test[which(test$Flux>quantile(test$Flux,quant)),]
  tempete<-data.frame(num=numeric(),debut=as.POSIXlt(character()),fin=as.POSIXlt(character()),hs=numeric(),flux=numeric(),tp=numeric(),duree=numeric())
  tempete[1,2]<-as.POSIXct(test.sel[1,1])
  g<-1
  tempete[1,4:7]<-0
  
  for (i in 1 : length(test.sel$HS)){
    tempete[g,1]<-g
    
    dif<-as.numeric(difftime(test.sel[i+1,1],test.sel[i,1],units="hours"))
    
    if(dif <= 48){
      tempete[g,2]<-min(as.POSIXct(tempete[g,2]),as.POSIXct(test.sel[i,1]),as.POSIXct(test.sel[i+1,1]))
      tempete[g,4]<-max(tempete[g,4],test.sel[i,2],test.sel[i+1,2],na.rm = TRUE)
      tempete[g,5]<-max(tempete[g,5],test.sel[i,3],test.sel[i+1,3],na.rm = TRUE)
      tempete[g,6]<-max(tempete[g,6],test.sel[i,4],test.sel[i+1,4],na.rm = TRUE)
      if ((i+1)==length(test.sel$Date)){
        tempete[g,3]<-as.POSIXct(test.sel[i+1,1])
        break
      }
    }else{
      tempete[g,3]<-as.POSIXct(test.sel[i,1])
      
      g<-g+1
      tempete[g,2]<-as.POSIXct(test.sel[i+1,1])
      tempete[g,4]<-test.sel[i+1,2]
      tempete[g,5]<-test.sel[i+1,3]
      tempete[g,6]<-test.sel[i+1,4]
    }
    
  }
  
  for (j in 1:length(tempete$num)){
    tempete[j,7]<-as.numeric(difftime(tempete[j,3],tempete[j,2],units="hours"))
  }
  return(tempete)
}
