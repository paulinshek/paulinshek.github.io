PATH = "C:/Users/user/Documents/Stats/Blog/"
PATH = "~/Documents/paulinshek.github.io/"

source(paste0(PATH,"_source/2016-02-14-relationship-prediction/dataclean.R"))


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
lm1 = glm(bup1~relstat+
            #I((age+page)/2)+
            #I(pmin(age,page)/pmax(age,page))+
            I(age-romanceage)+
            I(romanceage-metage)+
            income+
            samepolitics+
            samereligion+
            howmet+
            hhincomeg+
            I(kidsu18==0)+
            relqual+
            livingtog,
            data = data[which(!is.na(bup1)),],
            family = binomial(link = logit))
          
logit=function(x){return(exp(x)/(exp(x)+1))}
invlogit = function(x){return(log(x/(1 -x)))}
          
probs = logit(predict(lm1,data))
CalibrationPlot(probs,bup1,bins = 20)

summary(lm1)

lm2 = step(lm1)
