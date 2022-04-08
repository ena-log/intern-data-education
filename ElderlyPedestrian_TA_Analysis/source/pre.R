file = "C:\\Users\\user\\Desktop\\사고시설데이터_최종.csv"
accident_all <- read.csv(file,head=TRUE, encoding="cp949")
str(accident_all)

accident_1 <- accident_all[,c(2,18,21)]
str(accident_1)

accident_cor <- cor(accident_1)

########################################################################

setwd("C:\\Users\\user\\Desktop")

file = "C:\\Users\\user\\Desktop\\동별 노인사고 횟수.csv"
old_accident <- read.csv(file,head=TRUE, encoding="UTF-8")

library(stringr)

#동으로 변환
old_accident$동 <- str_replace_all(old_accident$동,'로[0-9]가',"로동")
old_accident$동 <- str_replace_all(old_accident$동,'동[0-9]가',"동")
#data$법정동 <- str_replace_all(data$법정동,'도[0-9]동',"도동")
old_accident$동 <- str_replace_all(old_accident$동,'륜[0-9]가',"륜동")
#data$법정동 <- str_replace_all(data$법정동,'$로',"로동")
unique(old_accident$동) # 동 확인

setwd("C:\\Users\\user")
write.csv(old_accident, file="accident_dong.csv", row.names = FALSE)


setwd("C:\\Users\\user\\Desktop")
file = "보행노인 사고다발지역정보 데이터셋_동_2017.csv"
accident_2017 <- read.csv(file, header = T)

accident_2017$동 <- strsplit(accident_2017$시도, " ")
accident_2017$동[1]

dong <- strsplit(accident_2017$시도, " ")
dong <- unlist(dong)
dong <- str_replace_all(dong, "서울특별시", '')
dong

a <- list()
for(i in range(0:length(dong))){
  if(i %% 2 == 0){
    a <- c(a, dong[i])
  }
  print(a)
}
##################################################################################
#동별 과속방지턱과 사고횟수 관계 나타내보기
setwd("C:\\Users\\user\\Desktop")

file = "C:\\Users\\user\\Desktop\\project\\과속방지턱\\과속방지턱 동별 갯수2.csv"
speedDump <- read.csv(file,head=TRUE, encoding="UTF-8")
str(speedDump)

file2 <- "C:\\Users\\user\\Desktop\\노인 전처리\\보행노인 사고다발지역정보_동_2013-2020.csv"
accident_all <- read.csv(file2,head=TRUE)
str(accident_all)

file = "C:\\Users\\user\\Desktop\\노인 분석 데이터.csv"
old <- read.csv(file,head=TRUE, encoding="cp949")
str(old)

file = "C:\\Users\\user\\Desktop\\노인 전처리\\전국과속방지턱표준데이터_위경도_19_20.csv"
speedDump_all <- read.csv(file,head=TRUE, encoding="cp949")
str(speedDump_all)

speedDump_accident <- cor(old$노인.교통사고, old$과속방지턱)

speedDump_all$보차분리여부 <- str_replace_all(speedDump_all$보차분리여부,"N","0")
speedDump_all$보차분리여부 <- str_replace_all(speedDump_all$보차분리여부,'Y',"1")
speedDump_all$보차분리여부 <- as.integer(speedDump_all$보차분리여부)
cor(old$노인.교통사고, speedDump_all$보차분리여부)

#막대그래프 그리기
library(ggplot2)
old$노인.교통사고 <- as.character(old$노인.교통사고)

ggplot(data= old,  aes(x=행정구역명, y=노인.교통사고)) +
  geom_bar(stat = "identity", fill="white", colour = "black") +
  ggtitle("행정동별 노인교통사고수")

ggplot(old, aes(x=행정구역명, y=과속방지턱)) +
  geom_bar(stat='identity', position="dodge", colour="black") +
  scale_fill_brewer(palette=1) +
  ggtitle("행정동별 노인교통사고와 과속방지턱수")

sort(old$노인.교통사고, decreasing = TRUE)
order(old$노인.교통사고)

ggplot(old, aes(x=행정구역명, y=과속방지턱,fill=group)) +
  geom_bar(stat = 'identity', position='dodge')


###################################################################################

