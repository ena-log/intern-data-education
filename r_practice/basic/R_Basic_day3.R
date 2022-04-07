#시각화 : 총판매량을 연도에 따라 관찰
install.packages("ggplot2")
library(ggplot2)

(x_avg %>% 
  filter(region != "TotalUS") %>% 
  ggplot(aes(year, V_avg, col = type)) + geom_line() + facet_wrap(~region))

#데이터 정렬과 검색
#arragne함수이용하여 총판매량 기준으로 순위, 최대값 등
arrange(x_avg, desc(V_avg))

x_avg1 <- x_avg %>% filter(region != "TotalUS")

# TotalUS를 제외하고 나면 통계 함수를 직접 사용하여 처리할 수 있음. 
x_avg1[x_avg1$V_avg == max(x_avg1$V_avg), ]



#Date형 데이터의 활용
# avocado 판매 정보를 월별 평균으로 요약
install.packages("lubridate")
library(lubridate)

(x_avg <- avocado %>% 
    group_by(region, year, month(Date), type) %>% 
    summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice)))

#모델링을 위한 가공
# 데이터 프레임 읽기
wine <- read.table("C:/r/wine.data.txt", header = TRUE, sep = ",")

head(wine)

n <- readLines("C:/r/wine.name.txt")
n
# 문자열 일부를 추출하기 위해 substr 함수 사용 
names(wine)[2:14] <- substr(n, 4, nchar(n))
names(wine)

#데이터 셋 분할하기
train_set <- sample_frac(wine, 0.6)
str(train_set)

test_set <- setdiff(wine, train_set)
str(test_set)

# 데이터 구조 변경
elec_gen <- read.csv("C:/r/electricity_generation_per_person.csv", header = TRUE, sep = ",")
names(elec_gen)

# 년도 앞의 x 제거
names(elec_gen) <- substr(names(elec_gen), 2, nchar(names(elec_gen)))
names(elec_gen)

#총 138개국에 대해 56년 동안(1960~2014) 의 1인당 전기 사용량
elec_use <- read.csv("C:/r/electricity_use_per_person.csv", header = TRUE, sep = ",")
names(elec_use)[2:56] <- substr(names(elec_use)[2:56], 2, nchar(names(elec_use)[2:56]))
names(elec_use)[2:56] 

#두 개의 데이터 프레임을 병합
install.packages("tidyr")
library(tidyr)

elec_gen_df <- gather(elec_gen, -ountry, key = "year", value = "ElectricityGeneration")

# 데이터프레임에 이름 재설정
names(elec_gen) <- c("country", "year", "ElectricityGeneration")
elec_use_df <- gather(elec_use, -country, key = "year", value = "ElectricityUse")

elec_gen_use <- merge(elec_gen_df, elec_use_df)
elec_gen_use


 