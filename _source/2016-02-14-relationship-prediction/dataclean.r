#### Data Tidy ####
### Should probably just all be built into a function
library(foreign)

dataPath = "C:/Users/user/Dropbox/Paulin and Joe/HCMST"

# How Couples Stay Together data
hcmst =as.data.frame(read.spss(file.path(dataPath, "HCMST.sav"))) # waves 1,2,3
hcmst4 = as.data.frame(read.spss(file.path(dataPath, "HCMSTwave4.sav")))
hcmst5 = as.data.frame(read.spss(file.path(dataPath, "HCMSTwave5.sav")))


orig = hcmst[,1:281]
dim(orig)

# ditch weight2, its the same as weight1

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
orig = orig[,-39]#older version of lgb
orig = orig[,-40]# No idea what this means

orig = orig[,1:38]
