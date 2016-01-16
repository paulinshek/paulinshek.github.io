---
layout: post
title: "Relationship Analysis"
author: "Paulin"
date: "2016-02-14"
output: md_document
categories: R
quote: "We could be the anti-valentines day, and predict the end of our relationship, instead!"
image: 
  url : /media/2016-02-14-relationship-anaylsis/cover.jpg
  source: /assets/images/bbt1.jpg
video: false
comments: true
---


```
## Loading required package: methods
```



Joe and I are both data fanatics, and we have been thinking of working on a project together for a long time. When we first started out, I used to always joke that we should do some analysis on other peoples relationships and use it to try and predict how long we'd last. Now we are over two years into our relationship, and we've finally deemed it stable enough to withhold the conclusions that we might find from the data! So here we go...

THE DATA:
We used the HCMST dataset, which is a comprehensive dataset of survey data, featuring over 4000 people. It features 5 "waves" of surveys, spread over 5 years. For each person in the survey, their partner may not necessarily be also included in the survey, but there are ... many couples in the survey. We deemed this a sufficiently high number to only look at complete couples interviewed in the survey. 



![Grey denotes the repondents who declined to answer a follow-up survey, or where not in a relationship in wave 1, in the first place](/figure/source/2015-12-25-relationship-prediction/unnamed-chunk-4-1.png) 
