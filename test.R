library (lattice)
library(Cairo)

filename <- "/Users/mkelly/Desktop/NASALCRGIDL2R/testFull.txt"
outputPathPNG = "/Users/mkelly/Desktop/NASALCRGIDL2R/figure.png"
outputPathSVG = "/Users/mkelly/Desktop/NASALCRGIDL2R/figure.svg"
outputPathPDF = "/Users/mkelly/Desktop/NASALCRGIDL2R/figure.pdf"

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

#png(filename=outputPathPNG)#, height=1200, width=1200, bg="white", res=150) 
svg(file=outputPathSVG) 
#pdf(outputPathPDF) 

par(mfrow=c(4,1))

#xal = paste("Date/time (",header_type[1],header_type[2],")",sep=" ")
xal <- "SITE-GMT (fra-dy)"


for(i in as.single(4:7)) {
  timeDecimal <- data[3] - floor(data[3]) #e.g., 280.9197 --> 0.9197
  hour <- timeDecimal * 24 # preliminary, with decimal, e.g., 22.0728
  minutesAsDecimal <- hour - floor(hour) # e.g., 0.0728
  hour <- floor(hour) # Remove decimal from hour, e.g., 22
  minute <- floor(minutesAsDecimal * 60) # 0.0728 --> 4.368 floored to 4
  
  xAxisDateTick <- hour+minutesAsDecimal
  plot(data.frame(x=data[3],y=data[i]),pch=20,col=colores[i-3],lty=0,type="o",xlab=xal,ylab=header_type[i],
	main=paste(header_type[i],header_units[i],header_stat[i],header_range[i],sep=" - "))
  #axis.Date(1, at = seq(as.Date(
  #cat(max(data[3]))
  #cat("\n")
}

dev.off()


singleString <- paste(readLines(outputPathSVG), collapse=" ")
print(singleString)