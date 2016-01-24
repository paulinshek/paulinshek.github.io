######### Calibration Plot function

CalibrationPlot = function(prob, result,bins=100, detail = FALSE,range = c(0,1)) {

	# creates breaks and sets up the vectors
	breaks = quantile(prob,seq(0,1,1/bins),na.rm=T)#seq(0,1-1/bins,1/bins)
	prediction = rep(NA,length(breaks))
	observedprop = rep(NA,length(breaks))
	meanprob = rep(NA,length(breaks))
	
	prob = ifelse(prob == 1, 0.99999999999,prob)

	# fills in the vectors position by position
	for (i in seq_along(breaks)) {
		prediction[i] = length(which(prob >= breaks[i] & prob < breaks[i+1]))
		observedprop[i] = length(which(prob >= breaks[i] & prob < breaks[i+1] & result ==1))/prediction[i]
		meanprob[i] = mean(prob[which(prob >= breaks[i] & prob < breaks[i+1])])
	}
	
	# plot observed against predicted probabilities
	plot(meanprob, observedprop, xlim = range,ylim = range,pch="")
	text(meanprob, observedprop,labels = prediction,cex=0.5)
	abline(0,1)
	print(summary(lm(observedprop ~ meanprob - 1)))
	
	# detailed information: plot.lm and anova table
	if (detail)  {
		plot.lm(lm(observedprop ~ meanprob - 1))
		cat("-------------------------------------------------------------\n")
		print(anova(lm(observedprop ~ meanprob - 1)))
	}
}