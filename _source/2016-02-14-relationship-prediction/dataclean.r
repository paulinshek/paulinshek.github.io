#### Data Tidy ####
### Should probably just all be built into a function
library(foreign)

dataPath = "/home/paulin/Documents/SomeRLovin/Relationship Prediction/data/HCMST"

# How Couples Stay Together data
hcmst =as.data.frame(read.spss(file.path(dataPath, "HCMST.sav"))) # waves 1,2,3
hcmst4 = as.data.frame(read.spss(file.path(dataPath, "HCMSTwave4.sav")))
hcmst5 = as.data.frame(read.spss(file.path(dataPath, "HCMSTwave5.sav")))


orig = hcmst[,1:281]
dim(orig)

# ditch weight2, it's the same as weight1

orig = orig[,-3]

names(orig)[1] = "id"
names(orig)[2] = "weight1"
names(orig)[3] = "age"
names(orig)[4] = "agecat7"
names(orig)[5] = "agecat4"
names(orig)[6] = "education"
names(orig)[7] = "edcat"
names(orig)[8] = "ethnicity"
names(orig)[9] = "gender"
names(orig)[10] = "hhhead"
names(orig)[11] = "hhsize"
names(orig)[12] = "housetype"
names(orig)[13] = "hhincome"
names(orig)[14] = "hhincomeg" #guess at hhincome (median of cat answer)
names(orig)[15] = "maritalstat"
names(orig)[16] = "metro"
names(orig)[17] = "area"
names(orig)[18] = "areasplit"
names(orig)[19] = "ownhome"
names(orig)[20] = "kids2"
names(orig)[21] = "kids1317"
names(orig)[22] = "peopleo18"
names(orig)[23] = "kids25"
names(orig)[24] = "kids612"
names(orig)[25] = "kidsu18"
names(orig)[26] = "employment"
names(orig)[27] = "internet"
orig = orig[,-28]#not asked to 90%
orig = orig[,-c(28:43)]#no need to do into so much race detail?
names(orig)[28] = "lgbfriend"
names(orig)[29] = "politics"
orig = orig[,-30]#no need for evangelical
names(orig)[30] = "religion"
names(orig)[31] = "coredate"
names(orig)[32] = "pudafdate"

###make separate daf for other members of the house
house = orig[,33:74]

orig = orig[,-c(33:74)]
orig = orig[,-c(33:34)]#consent and same as weight1
names(orig)[33] = "weight4"
names(orig)[34] = "weight5"
names(orig)[35] = "weight6"
orig = orig[,-c(36:37)]#another same weight
names(orig)[36] = "intdate"
orig = orig[,-37]# Q duration
names(orig)[37] = "relationship"
names(orig)[38] = "lgb"
orig = orig[,-c(39,40)]#older version of lgb

respondent = orig[,1:38]

### We've cut down all the information about the respondent. Now to do same for their partner

partner = orig[,39:ncol(orig)]
names(partner)[1] = "married"
names(partner)[2] = "lgb2"
names(partner)[3] = "sexpartner"
partner = partner[,-4]
names(partner)[4] = "pgender"
names(partner)[5] = "pgendersame"
names(partner)[6] = "phispanic"
names(partner)[7] = "prace"
partner = partner[,-8]
names(partner)[8] = "preligion"
names(partner)[9] = "preligionchange"
partner = partner[,-10]
names(partner)[10] = "page"
names(partner)[11] = "peducation"
names(partner)[12] = "pmumeducation"
names(partner)[13] = "ppolitics"
partner = partner[,-c(14,15)]
names(partner)[14] = "mumeducation"
names(partner)[15] = "choodcountry"
names(partner)[16] = "relspermonth"
names(partner)[17] = "totmarriagescur"
names(partner)[18] = "totmarriages"
partner = partner[,-c(19,20)]
names(partner)[19] = "attraction"
partner = partner[,-c(20,21,22,23,24,25)]
names(partner)[20] = "livingtog"
names(partner)[21] = "everlivedtog"
names(partner)[22] = "metage"
partner = partner[,-23]
names(partner)[23] = "romanceage"
partner = partner[,-24]
names(partner)[24] = "moveinage"
partner = partner[,-25]
names(partner)[25] = "marriedage"
partner = partner[,-26]
partner = partner[,-c(26,27)]
names(partner)[26] = "timetogether" 
names(partner)[27] = "income"
partner = partner[,-28]
names(partner)[28] = "sameschool"
names(partner)[29] = "sameuni"
names(partner)[30] = "gupsamecity"
names(partner)[31] = "parentsmet"
names(partner)[32] = "parentsalive"
names(partner)[33] = "parentapprove"
names(partner)[34] = "metwork"
names(partner)[35] = "metschool"
names(partner)[36] = "metchurch"
names(partner)[37] = "metdservice"
names(partner)[38] = "metvacation"
names(partner)[39] = "metnightout"
names(partner)[40] = "metsocialclub"
names(partner)[41] = "metprivparty"
names(partner)[42] = "metother"
partner = partner[,-43]
names(partner)[43] ="internetmet"
names(partner)[44] = "introfam"
names(partner)[45] = "introfriend"               
names(partner)[46] = "introcowork"
names(partner)[47] = "introclassmate"
names(partner)[48] = "introneigh"
names(partner)[49] = "introself"
names(partner)[50] = "introother"
partner = partner[,-51]
names(partner)[51] = "relqual"


partner = partner[,1:51]
