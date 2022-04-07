#학교폭력 및 청소년 범죄에 영향을  미치는 영향인자분석

################################################################################
#[1단계] 가설수립

#환경이 청소년 범죄발생에 영향을 미치는가
# -> 청소년이 유해업소 등 직접적인 유해환경에 노출된 경우 충동적으로 범죄를 일으킬 수 있지 않을까?


################################################################################
#[2단계] 가설확인

#1. 패키지 설치 및 라이브러리 올리기
install.packages("RColorBrewer") #시각화를 위한 다양한 색 지원
install.packages("lattice") #직교형태의 그래픽을 생성
install.packages("corrplot") #상관관계를 그래픽으로 표현
install.packages("car") #응용 회귀분석
install.packages("lattice") #평행좌표계 표현
install.packages("psych")

library(RColorBrewer)
library(lattice)
library(corrplot)
library(car)
library(lattice)
library(psych)

#2. 데이터로드 -CSV파일 불러오기
teenager_crim <- read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/crime_teenager.csv")
View(teenager_crim) #데이터 확인

#3. 비교시각화 - 스타차트
rownames(teenager_crim) <- teenager_crim[[1]] # 행 이름에 지역이름 넣기
stars(teenager_crim[, 2:6]) #Star Plot 그리기

#4. 비교시각화 - 나이팅게일 차트
stars(teenager_crim[, 2:6], flip.labels = FALSE, draw.segments = TRUE) #나이팅게일 그림 그리기

#5. 비교시각화 -평행좌표계
parallelplot(teenager_crim[,2:6], horizontal.axis = FALSE) #평행좌표계 그리기

education <- read.csv("http://datasets.flowingdata.com/education.csv", header = TRUE) #미국 SAT 점수 자료
View(education) #자료 보기
parallelplot(education[, 2:7], horizontal.axis = FALSE) #평행좌표계 그리기

#6. 비교시각화 - 히트맵
teenager_crim_matrix <- data.matrix(teenager_crim[, 2:6]) #matrix 형태로 반환환
heatmap(teenager_crim_matrix, row = NA, col = brewer.pal(9, "Blues"), scale = "column", margin = c(5,10)) #히트맵

#7. 비교시각화 그래프의 비교
#  비교후 인사이트 발견


################################################################################
#[3단계]: 인자 간 관계확인: 청소년범죄 인자 간 상관성

#1. 관계시각화 - 범죄 간의 상관성 분석
#1) plot함수 이용 2개 변수 이용
plot(teenager_crim$robbery, teenager_crim$murder) #청소년 강도범죄와 살인범죄 간의 상관성 확인
#-> 그래프상 상관성이 확인되지 않음
plot(teenager_crim$thief, teenager_crim$violence) #청소년 절도범죄와 폭력범죄 간의 상관성 확인
#-> 그래프상 상관성 확인됨

#2) scatterplot_matrix 함수 이용
scatterplotMatrix(teenager_crim[, 2:6]) #산점도 그리기

#3) 상관계수 계산
teenager_crim_cor <- teenager_crim[, c(2:6)] #상관분석 변수선별
sum(is.na(teenager_crim_cor)) #결측치 확인
teenager_crim_cor_value <- cor(teenager_crim_cor) #상관계수 계산
teenager_crim_cor_value #상관계수 확인

#4) corrplot 이용
corrplot(teenager_crim_cor_value, method = "circle")
corrplot(teenager_crim_cor_value, method = "circle", addCoef.col = "red") #상관계수 숫자 색

#5) psych 패키지 이용
pairs.panels(teenager_crim[, 2:6])


#2. 관계시각화 - 유흥업소와 범죄 간의 상관성 분석
#1) psych 패키지
getwd()
nightlife_crime <- read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/nightlife_crime.csv")
head(nightlife_crime)
str(nightlife_crime)
colnames(nightlife_crime)

nightlife_crime_cor <- nightlife_crime[, -1]
colnames(nightlife_crime_cor)
View(nightlife_crime_cor)

corteset <- corr.test(nightlife_crime_cor)[1] #상관계수 구하기
cortest

pairs.panels(nightlife_crime_cor[, 1:13]) #상관계수 시각화

cor(nightlife_crime_cor[, 2:13])

round(cor(nightlife_crime_cor[, 1:13]), 2)

