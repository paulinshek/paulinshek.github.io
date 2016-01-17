names(data)

lm1 = glm(bup1~.,data = data)

logit=function(x){return(exp(x)/(exp(x)+1))}
invlogit = function(x){return(log(x/(1 -x)))}

logit(invlogit(0.5)-(1.04546+1.090909)*0.0554)
