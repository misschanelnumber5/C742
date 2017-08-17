floPop= read.table("lastYearPop.txt", header=FALSE) 
options(scipen=10)
hist(floPop$V1, breaks=1000000, border="blue" ,las=2, xlim=c(0, 30000000), xlab="", main="Histogram of 2016 United State Population Sizes")