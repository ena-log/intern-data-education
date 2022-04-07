## 실습2 - 청소년범죄 영향인자 분석
 
## 책을 보고 전체코드를 완성합니다. 

teenager_crime <- read.csv("C:/BigPublic/data/crime_teenager.csv")
View(teenager_crime)
rownames(teenager_crime) <- teenager_crime[[1]]
 
#스타차트

#나이팅게일차트

#평행좌표계

#평행좌표계(참고자료)
education <- read.csv("http://datasets.flowingdata.com/education.csv", header=TRUE) ##미국 SAT 점수 분석
View(education)
parallelplot(education[,2:7], horizontal.axis=FALSE)

#히트맵


#1. 청소년 강도범죄와 살인범죄간의 상관성 확인


#2. 청소년 절도범죄와 폭력범죄간의 상관성 확인


#범죄간의 상관성 분석-
# 교재의 scatterplot_matrix 대신 pairs 쓰기 
pairs(teenager_crime[,2:6])
 

#상관계수 계산

#corrplot이용(1)

#corrplot이용(2)


#psych패키지 이용
install.packages("psych"  )
library(psych)
#TODO(teenager_crime[ ,2:6])
 
getwd()
nightlife_crime <- #TODO("C:/BigPublic/data/nightlife_crime.csv")
#TODO(nightlife_crime)
#TODO(nightlife_crime)
#TODO(nightlife_crime)

nightlife_crime_cor = nightlife_crime[, -1]
colnames(nightlife_crime_cor)

#상관계수 구하기


#상관계수 시각화


