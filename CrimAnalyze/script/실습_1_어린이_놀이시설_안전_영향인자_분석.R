## 실습1 - 어린이 놀이시설 안전 영향인자 분석


## 책을 보고 #TODO 부분을 채워가며 코드를 완성합니다.  


######## 비교시각화 #######
####################
#### 시간대별 장소
accident_time_location<-read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/child/1_1_accident_time_location.csv", stringsAsFactors = FALSE)
View(accident_time_location)
accident_time_location
str(accident_time_location)
accident_time_location$time <- as.character(accident_time_location$time)

# star plot
stars(accident_time_location[,2-9], labels = accident_time_location[[1]])
# 나이팅게일
stars(accident_time_location[,2-9],flip.labels = F, draw.segments = T)

# heatmap
accident_time_location_matrix <- as.matrix((accident_time_location[,2:9]))
rownames(accident_time_location_matrix) <- accident_time_location[[1]]
heatmap(accident_time_location_matrix,row =NA, col=brewer.pal(9,"Blues"), scale="column", margin=c(5,10))


######## 비교시각화 #######
####################
### 놀이시설 장소별 안전사고
# 데이터셋 업로드
accident_location_time <-read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/child/1_2_accident_location_time.csv")
View(accident_location_time)
str(accident_location_time)
accident_location_time$time <- as.character(accident_location_time$time)
#accident_location_time = accident_location_time[-1]

# star chart
str(accident_location_time)
stars(accident_location_time[,2:12], labels = accident_location_time[[1]])

# 나이팅게일
stars(accident_location_time[,2:13], labels = accident_location_time[[1]], flip.labels = T, draw.segments = T)


######## 비교시각화 #######
#놀이기구별 어린이 안전사고 발생 현황 분석(Bar chart)
Rides_accident <- read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/child/2_Rids_accident.csv", stringsAsFactors = F)
View(Rides_accident)
str(Rides_accident) #놀이기구명이 factor형
Rides_accident$rids <- as.character(Rides_accident$rids)
barplot(Rides_accident$injured_count, names.arg = Rides_accident$rids) 


######## 비교시각화 #######
####################
# 연령대별, 놀이기구별
# 데이터셋 업로드
age_rides_accident <-read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/child/3_age_rides_accident.csv")
View(age_rides_accident)
str(age_rides_accident)
rownames(age_rides_accident) <- age_rides_accident[[1]]

# star plot
stars(age_rides_accident[2-9])

# 나이팅게일
stars(age_rides_accident[,2-9], labels = age_rides_accident[[1]], flip.labels = F, draw.segments = T)


# heatmap
age_rides_accident_matrix <- data.matrix(age_rides_accident[,2-9])
##heatmap(age_rides_accident_matrix.row=NA, col=brewer.pal(7,"Greens"), scale="column", margin=c(5,10)) error
heatmap(age_rides_accident_matrix,row=NA, col=brewer.pal(9,"Blues"), scale="column", margin=c(5,10))



######## 관계시각화 #######
# 지역별 놀이시설 수
region_accident <- read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/child/5_region_accident.csv")
View(region_accident)
region_accident

rownames(region_accident) <- region_accident[[1]]
str(region_accident)
region_accident

region_accident_matrix <-data.matrix(region_accident[,2:3]) 
barplot(region_accident$playgrounds_count,  names.arg = region_accident$region)



######## 관계시각화 #######
#놀이시설 장소와 부상자
location_accident <- read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/child/6_location_accident.csv")
View(location_accident)
str(location_accident)

# bubble chart
symbols(location_accident$count, location_accident$injured, circles = location_accident$injured_rate ,
        inches=0.3, fg="white", bg="red", xlab="놀이시설수", ylab="부상자수", main="놀이시설수와 부상자수 관계")
        
accident_rate = location_accident$injured/location_accident$count


# bubble chart2
library(ggplot2)
ggplot(location_accident, aes(x=count, y=injured)) + 
  geom_point(aes(size=accident_rate), shape=21, colour="grey90", fill="blue", alpha=0.5) +
  scale_size_area(max_size = 15) + # 범례 없애려면 guide=FALSE
  geom_text(aes(y=as.numeric(injured)-sqrt(accident_rate)/10, label=location), 
            vjust=1, colour="grey40", size=3) + 
  ggtitle("놀이시설수와 부상자수 관계")


#----------- 놀이시설 수와 부상자 발생 관계
# 데이터셋 업로드
region_accident <- read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/child/5_region_accident.csv")

# 데이터 확인
View(region_accident)
str(region_accident)

# 형변환
region_accident$region <- as.character(region_accident$region) 
region_accident$playgrounds_count <- as.integer(region_accident$playgrounds_count) 

#scatter plot
scatterplot.matrix(region_accident[,2:3])
scatterplotMatrix(region_accident[,2:3])


#----------- 놀이시설 위험도와 사고 관계
# 데이터셋 업로드
child_playground <- read.csv("C:/Users/user/Desktop/수업 내용/04 빅데이터분석시각화/R/r_workspace/CrimAnalyze/data/child/child_playgroud.csv")

# 데이터 확인
View(child_playground)

# 선형회귀분석
lm_out <- lm(accident ~ Ride_risk, data=child_playground)

# 선형회귀식 요약 출력
summary(lm_out)

# 산점도1
plot(accident ~ Ride_risk, data=child_playground)

# 회귀선 그리기
abline(lm_out, col = "red")

# 산점도2
scatterplot(accident~Ride_risk, reg.line=FALSE, smooth=FALSE, spread=FALSE, 
            boxplots=FALSE, span=0.5, ellipse=FALSE, levels=c(.5, .9), 
            data=child_playground)

# 회귀선 그리기
abline(lm_out,col="red")


