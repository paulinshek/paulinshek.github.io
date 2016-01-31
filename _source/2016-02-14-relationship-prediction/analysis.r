PATH = "/Users/Joe/Documents/Blog/"
PATH = "~/Documents/paulinshek.github.io/"
library(dplyr)

source(paste0(PATH,"_source/2016-02-14-relationship-prediction/dataclean.r"))
source(paste0(PATH,"_source/2016-02-14-relationship-prediction/calibrationPlotModelFitting.r"))

outcome1 = as.vector(hcmst$w2_broke_up)

bup1 = rep(0,nrow(partner))
bup1[which(outcome1=="broke up")] = 1
bup1[which(outcome1=="partner passed away")] = NA
bup1[which(is.na(outcome1))]=NA

data = cbind(partner,respondent)

levels(data$income)[c(2,4)] = "more"
levels(data$income)[c(3)] = "same"

data$politics = as.vector(data$politics)
data$ppolitics = as.vector(data$ppolitics)
data$ppolitics[which(data$ppolitics%in%c("nopreference","independent","another party, please specify"))]="other"

data$samepolitics = "no"
data$samepolitics[which(data$politics=="republican"&data$ppolitics=="republican")]="samecon"
data$samepolitics[which(data$politics=="democrat"&data$ppolitics=="democrat")]="samelib"

data$samereligion = 0
data$religion=as.vector(data$religion)
data$preligion=as.vector(data$preligion)

data$samereligion[which(data$religion==data$preligion)] = 1

data$howmet = "other"
data$howmet[which(data$metschool=="yes")]="school"
data$howmet[which(data$metwork=="yes")]="work"
data$howmet[which(data$metchurch=="yes")]="church"
data$howmet[which(data$metdservice=="yes")]="dservice"
data$howmet[which(data$metvacation=="yes")]="vacation"
data$howmet[which(data$metnightout=="yes")]="nightout"
data$howmet[which(data$metsocialclub=="yes")]="socialclub"
data$howmet[which(data$metprivparty=="yes")]="privparty"

data$relstat = NA
data$relstat[which(data$married=="yes, i am married")]="married"
data$relstat[which(data$sexpartner=="yes, i have a sexual partner (boyfriend or girlfriend)")]="sexpartner"
data$relstat[which(data$sexpartner=="i have a romantic partner who is not yet a sexual partner")]="nonsexpartner"

data$livingtog=as.vector(data$livingtog)
data$livingtog[which(data$livingtog=="refused")]=NA

data$bup1=bup1
rm(bup1)

datatouse = data %>% filter(!is.na(page),!is.na(bup1))

lm1 = glm(bup1~relstat+
            I((age+page)/2)+
            I(pmin(age,page)/pmax(age,page))+
            I(age-romanceage)+
            I(log(age-romanceage+1))+
            I(log(log(age-romanceage+1)+1))+
            #I(romanceage-metage)+
            income+
            #samepolitics+
            samereligion+
            howmet+
            hhincomeg+
            I(kidsu18==0)+
            relqual+
            livingtog,
            data = datatouse,
            family = binomial(link = logit))
          
logit=function(x){return(exp(x)/(exp(x)+1))}
invlogit = function(x){return(log(x/(1 -x)))}
          
probs = logit(predict(lm1,datatouse))
CalibrationPlot(probs,datatouse$bup1,bins = 20)

summary(lm1)

lm2 = step(lm1) # bup1 ~ relstat + I(log(age - romanceage + 1)) + relqual + livingtog

levels(data$education)=c(NA,NA,rep("school",8),"hs","collnodeg",rep("degree",2),"masters","doc")
levels(data$peducation)=c(NA,rep("school",8),"hs","collnodeg",rep("degree",2),"masters","doc")

data$education = as.numeric(data$education)
data$peducation = as.numeric(data$peducation)

data$edudiff = abs(data$education-data$peducation)

levels(data$mumeducation)=c(NA,rep("school",8),"hs","collnodeg",rep("degree",2),"masters","doc")
levels(data$pmumeducation)=c(NA,rep("school",8),"hs","collnodeg",rep("degree",2),"masters","doc")

data$mumeducation = as.numeric(data$mumeducation)
data$pmumeducation = as.numeric(data$pmumeducation)

data$mumedudiff = abs(data$mumeducation-data$pmumeducation)

data$parentapprove=as.vector(data$parentapprove)
data$parentapprove[which(data$parentapprove=="refused")]=NA

datapaste = apply(data,MARGIN = 1,FUN = paste,collapse="~")

datatouse = data %>% filter(!is.na(page), 
                            !is.na(bup1), 
                            !is.na(edudiff), 
                            !is.na(mumedudiff),
                            !is.na(relspermonth),
                            !grepl("refused", datapaste))


lm3 = glm(bup1~relstat+
            I((age+page)/2)+
            I(pmin(age,page)/pmax(age,page))+
            I(age-romanceage)+
            I(log(age-romanceage+1))+
            I(log(log(age-romanceage+1)+1))+
            #I(romanceage-metage)+
            income+
            #samepolitics+
            samereligion+
            metwork+
            metschool+
            metchurch+
            metdservice+
            metvacation+
            metnightout+
            metsocialclub+
            metprivparty+
            metother+
            hhincomeg+
            kidsu18+
            relqual+
            livingtog + 
            mumedudiff + 
            #parentapprove +
            edudiff+
            I(education+peducation)+
            I(log(relspermonth+1)),
            data = datatouse,
            family = binomial(link = logit))

lm4 = step(lm3)

probs = logit(predict(lm4,datatouse))
CalibrationPlot(probs,datatouse$bup1,bins = 20)
