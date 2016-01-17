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
	plot(meanprob, observedprop, xlim = range,ylim = range)
	abline(0,1)
	print(summary(lm(observedprop ~ meanprob - 1)))
	
	# detailed information: plot.lm and anova table
	if (detail)  {
		plot.lm(lm(observedprop ~ meanprob - 1))
		cat("-------------------------------------------------------------\n")
		print(anova(lm(observedprop ~ meanprob - 1)))
	}
}









###### best doubling function ever

Create2v2 = function(daf=formated_data){

	tourn_2v2 = data.frame()

		for(tournamentID in unique(daf$race)){
			#selects the data related to the current tournament
			current_tourn = daf[which(daf$race == tournamentID),]
			
			#repeats the rows in the dataframe as many times as there are players in the tournament (for each row)
			current_tourn_2v2 = current_tourn[rep(seq_along(current_tourn$race), each = nrow(current_tourn)),]
			#renames the columns
			# colnames(current_tourn_2v2) = c("year","p1","position_p1","score_p1","tournament","race","tmpposition","date")
			
			#repeats the dataframe as many times as there are players in the tournament
			#and keeps only the columns we need.
			extracols = current_tourn[rep(seq_along(current_tourn$race), times = nrow(current_tourn)),which(colnames(current_tourn) %in% c("team","team_rank","team_result"))]
			#renames the columns
			colnames(extracols) = c("team2","team_rank2","team_result2")
			
			# binds the two dataframes together
			current_tourn_2v2 = cbind(current_tourn_2v2,extracols)
			rownames(current_tourn_2v2) <- c()
			
			# removes the rows when a player is against itself
			current_tourn_2v2 = current_tourn_2v2[which(!(current_tourn_2v2$team == current_tourn_2v2$team2)),]
			
			# # creates unique match ID:
			
			CreateID = function(index){ 
				matchid = paste(sort(unlist(strsplit(paste(current_tourn_2v2$team[index],current_tourn_2v2$team2[index],current_tourn_2v2$race[index],sep=""),split=""))),collapse="")
				return(matchid)
			}
			
			matchID = sapply(seq_along(current_tourn_2v2$team),CreateID,USE.NAMES=FALSE)
			current_tourn_2v2 = current_tourn_2v2[which(!duplicated(matchID)),]

			print(table(is.na(current_tourn_2v2$team_rank)))
		
			# binds it to the big dataframe with all tournaments
			tourn_2v2 = rbind(tourn_2v2,current_tourn_2v2)
		}
	return(tourn_2v2)
}
