nightlife_crime <- read.csv('C:/Users/user/Desktop/수업 내용/R/문제/lab02/nightlife_crime.csv', header=TRUE, sep=",")
str(nightlife_crime)

#평균
mean(nightlife_crime[["violence"]])
mean(nightlife_crime[["thef"]])

#중앙값
median(nightlife_crime[["violence"]])
median(nightlife_crime[["thef"]])

#분산
var(nightlife_crime[["violence"]])
var(nightlife_crime[["thef"]])

#표준편차
sd(nightlife_crime[["violence"]])
sd(nightlife_crime[["thef"]])

#사분위수
quantile(nightlife_crime[["violence"]], p=c(.05, .25, .5, .75, .95))
quantile(nightlife_crime[["thef"]], p=c(.05, .25, .5, .75, .95))

#boxplot
boxplot(nightlife_crime[["violence"]], ylab="violence(count)")
boxplot(nightlife_crime[["thef"]], ylab="thef(count)")


str(nightlife_crime)
for(i in 1:25){
  if(nightlife_crime$pub[i] > 50 && nightlife_crime$karaoke[i] > 50){
    print(paste(nightlife_crime$region[i], nightlife_crime$pub[i], nightlife_crime$karaoke[i]))
  }
}


for(i in 1:25){
  if(nightlife_crime$pub[i] > 50 && nightlife_crime$karaoke[i] > 50){
    # print(nightlife_crime$region[i])
    a <- paste(nightlife_crime$pub[i])
    b <- paste(nightlife_crime$karaoke[i])
  }
}