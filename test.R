library (lattice)

filename <- "testFull.txt"
outputPath = "/Users/mkelly/Desktop/figure.png"
colores = c("purple","red","blue","orange")

header_type <- scan(filename, nlines = 1, what = character())
header_units <- scan(filename, skip=1, nlines = 1, what = character())
header_stat <- scan(filename, nlines = 1, skip=2, what = character())
header_range <- scan(filename, nlines = 1, skip=3, what = character())

headers <- paste(header_type,header_units,header_stat,header_range,sep=" ")
dataPreFiltered <- read.table(filename, skip=6, header=FALSE)

row_sub = apply(dataPreFiltered, 1, function(row) all(row >=0 ))
data = dataPreFiltered[row_sub,] # This assumes data like -99 is noise 

names(data) <- header_type
names(data) <- headers

png(filename=outputPath, height=1200, width=1200, bg="white", res=150) 
par(mfrow=c(4,1))

xal = paste("Date/time (",header_type[1],header_type[2],")",sep=" ")

for(i in as.single(3:6)) {
  plot(data.frame(x=data[2],y=data[i]),pch=20,col=colores[i-2],lty=0,type="o",xlab=xal,ylab=header_type[i],
	main=paste(header_type[i],header_units[i],header_stat[i],header_range[i],sep=" - "))
}



dev.off()