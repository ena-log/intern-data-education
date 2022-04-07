#배열 : 열과 행으로 구성된 데이터
#arrary 함수 : N차원 배열 생성
x <- array(1:5, c(2, 4)) # 1~5 rkqtdmf 2X4 행렬에 할당
x
x[1, ] # 1행 요소 값 출력
x[, 2] # 2열 요소 값 출력

#행과 열 이름 설정
dimnamex = list(c("1st", "2nd"), c("1st", "2nd", "3rd", "4th"))
x <- array(1:5, c(2, 4), dimnames = dimnamex)
x
x["1st", ]
x[, "4th"]

# matrix 함수: 2차원 배열 생성
x <- 1:12
x
matrix(x, nrow = 3)
matrix(x, nrow = 3, byrow = T) #행우선

#벡터를 묶어 배열 생성
v1 <- c(1, 2, 3, 4)
v2 <- c(5, 6, 7, 8)
v3 <- c(9, 10, 11, 12)
cbind(v1, v2, v3) # 열 단위로 묶어 배열 생성
rbind(v1, v2, v3) # 행 단위로 묶어 배열 생성


# 배열 연산
# 2x2 행렬 2개를 각각 x, y에 저장
x <- array(1:4, dim = c(2, 2))
y <- array(5:8, dim = c(2, 2))
x
y
x + y
x - y
x * y # 각 열별 곱셈

#배열함수
x <- array(1:12, c(3, 4))
x
#apply 함수: 행 열로 함수적용
apply(x, 1, mean) # 함수를 행으로 적용
apply(x, 2, mean) # 함수를 열로 적용

#dim 함수: 배열 크기
dim(x)

#sample 함수 : 샘플 추출
sample(x) # 임의로 추출
sample(x, 10) # 10개 추출
sample(10) #샘플 만들기

#데이터프레임
name <- c("하나", "두나", "세나")
age <- c(22, 20, 25)
gender <- factor(c("M", "F", "M"))
blood <- factor(c("A", "O", "B"))
patients <- data.frame(name, age, gender, blood)
patients

# edit함수 이용해 데이터프레임 생성
test<-data.frame()
test<-edit(test)
test


# 데이터 프레임 요소에 접근 : $, [,]
patients
patients$name # name 속성값 출력
patients[1, ] # 1행 값
patients[, 2] # 2열 값
patients[3, 1] # 3행 1열 값
patients[patients$name=="하나", ] #하나에 대한 정보 추출
patients[patients$name=="하나", c("name", "age")] #하나의 이름과 나이 추출

#데이터프레임에 유용한 함수
head(cars) # cars 데이터셋 확인
speed
attach(cars) # attach 속성을 변수로 만듬
speed # speed 변수명 이용 가능
detach(cars) # detach 속성의 변수사용 해제
speed 

#데이터 속성을 이용해 함수 적용
mean(cars$speed)
max(cars$speed)

# subset 일부 데이터만 추출
subset(cars, speed > 20) # 속도가 20초과인 데이터
subset(cars, speed > 20, select = c(dist)) # 속도 20초과, dist 열 추출
subset(cars, speed > 20, select = -c(dist)) # 속도 20초과, dist 열 제외


# 리스트
patients <- data.frame(name = c("하나", "두나", "세나"), 
                       age = c(22, 20, 25), 
                       gender = factor(c("M", "F", "M")), 
                       blood = factor(c("A", "O", "B")))
no.patients <- data.frame(day = c(1:6), 
                          no = c(50, 60, 55, 52, 65, 58))

# 데이터를 단순 추가
listPatients <- list(patients, no.patients) 
listPatients


# 각 데이터에 이름 부여하면서 추가
listPatients <- list(patients=patients, no.patients = no.patients) 
listPatients

listPatients$patients		# 요소명 입력

listPatients[[1]]				# 인덱스 입력

listPatients[["patients"]]			# 요소명을""에 입력

lapply(listPatients$no.patients, mean) # 평균 구하기

sapply(listPatients$no.patients, mean) 


#################################
## 3. 데이터 취득과 정제 ##
#################################

# 01 파일 읽고 쓰기 #

# 파일 마지막 행에서 [Enter]를 누르지 않은 경우
students <- read.table("C:/r/students.txt", header = T) 

# 파일 마지막 행에서 [Enter]를 누른 경우
students <- read.table("C:/r/students.txt",  header = T) 
students

# 읽은 파일의 구조 확인
str(students) 

# 파일을 있는 형태 그대로 읽음
students <- read.table("C:/r/students.txt", header = T, as.is = T) 
str(students)

# 파일을 읽을 때 문장을 요인으로 인식하지 않도록 설정
students <- read.table("C:/r/students.txt", header = T, stringsAsFactors = F) 
str(students)


#read.csv 함수: CSV(Comma-Separated Values) 파일을 읽을 때 사용
# 첫 행이 header이므로 header 옵션을 지정할 필요가 없음
students <- read.csv("C:/r/students.csv") 
students

# 읽은 파일의 구조 확인
str(students) 

# name 속성을 요인에서 문장으로 변경
students$name <- as.character(students$name) 
str(students)

# 파일을 읽을 때 문장을 요인으로 인식하지 않도록 설정함
students <- read.csv("C:/r/students.csv", stringsAsFactors = FALSE) 
str(students)

#?write.table
# 문장에 큰따옴표가 표시됨.
write.table(students, file = "C:/r/output.txt") 

# 문장에 큰따옴표되지 않음.
write.table(students, file = "C:/r/output.txt", quote = F) 


# 02 데이터 정제를 위한 조건문과 반복문 #
# 벡터인 경우
test = c(15, 20, 30, NA, 45)
test[test<40]	# 값이 40 미만인 요소 추출
test[test%%3!= 0]	# 값이 3으로 나누어 떨어지지 않는 요소 추출
test[is.na(test)]	# NA인 요소 추출
test[!is.na(test)]			# NA가 아닌 요소 추출
test[test%%2==0&!is.na(test)]	# 2의 배수면서 NA가 아닌 요소 추출

# 데이터 프레임인 경우
characters <- data.frame(name = c("하나", "두나", "세나"), 
                         age = c(30, 16, 21), 
                         gender = factor(c("M", "F","M")))  
characters
characters[characters$gender =="F",]  # 성별이 여성인 행 추출
characters[characters$age<30&characters$gender =="M",] # 30살 미만의 남성                    

#if문 사용 (if, else if, else)
x <- 5
if(x %% 2 ==0) {
  print('x는 짝수')	# 조건식이 참일 때 수행
}   else {
  print('x는 홀수')	# 조건식이 거짓일 때 수행
}

x <- -1
if(x>0) {
  print('x is a positive value.')	# x가 0보다 크면 출력
} else if(x<0) {
  print('x is a negative value.')	# x가 0보다 작으면 출력
} else {
  print('x is zero.')		# 위 조건을 모두 만족하지 않으면 출력
}

x <- c(-5:5)
options(digits = 3)		# 숫자 표현 시 유효자릿수를 3자리로 설정
sqrt(x)

#ifelse(조건식, 참값,거짓값)
sqrt(ifelse(x>=0, x, NA))	# NaN이 발생하지 않게 음수면 NA로 표시

# 반복문
# repeat 문을 이용해 1부터 10까지 숫자 증가
i <- 1	             # i의 시작값은 1
repeat {
  if(i>10) {         # i가 10을 넘으면 반복을 중단(break)함
    break
  } else {
    print(i)
    i = i+1           # i를 1 증가시킴.
  }
}

# while 문을 이용해 1부터 10까지 숫자 증가
i <- 1 # i의 시작값은 1임.
while(i <= 10){ # i가 10 이하인 동안에 반복함
  print(i)
  i = i+1 # i를 1 증가시킴.
}

# for 문을 이용한 1부터 10까지 숫자 증가시키기
for(i in 1:10) {
  print(i)
}  

# 연습문제
# while 문을 이용해 구구단 2단 만들기
i <- 1
while(i<10) {
  print(paste(2, "X", i, "=", 2*i))
  i = i+1
}

# for 문을 이용해 구구단 2단 만들기
for(i in 1:9) {
  print(paste(2, "X", i, "=", 2*i))
}
# for 문을 이용해 구구단 2~9단 만들기
for(i in 2:9) {
  for(j in 1:9) {
    print(paste(i, "X", j, "=", i*j))
  }
}
# 1부터 10까지의 수 중 짝수만 출력하기
for(i in 1:10) {
  if(i%%2 == 0) {
    print(i)
  }
}


# 03 사용자 정의 함수 : 원하는 기능 묶기 # 
#transMile() 함수 작성
transMile <- function(x) {
  tmile = x*1.6
  result = paste(tmile, "km", sep="")
  return(result)
}
transMile(5)

#계승 구하는 사용자함수
fact <- function(x) {   # 함수의 이름은 fact, 입력은 x
  fa = 1  # 계승값을 저장할 변수
  while(x>1) {  # x가 1보다 큰 동안 반복
    fa = fa*x   # x 값을 fa에 곱한 후 fa에 다시 저장
    x = x-1  # x 값을 1 감소
  }  
  return(fa)   # 최종 계산된 fa 반환
}
fact(5)	  # 5!을 계산한 결과 출력

# 04 데이터 정제 예제 1 : 결측값 처리 # 
# is.na 함수를 이용해 결측값 처리하기
str(airquality)	# airquality 데이터의 구조를 살펴봄.

# airquality 데이터에서 NA는 TRUE, 아니면 FALSE. 
head(is.na(airquality))	
table(is.na(airquality))	# NA가 총 44개 있음.

table(is.na(airquality$Temp))	# Temp에는 NA가 없음을 확인함.

table(is.na(airquality$Ozone))	# Ozone에는 NA가 37개 발견됨.

mean(airquality$Temp)		# NA가 없는 Temp는 평균이 구해짐.

mean(airquality$Ozone)		# NA가 있는 Ozone은 평균이 NA로 나옴.

# Ozone 속성에서 NA가 없는 값만 추출함.
air_narm <- airquality[!is.na(airquality$Ozone), ]  
air_narm
mean(air_narm$Ozone)	# 결측값 제거후 mean 함수 동작

# na.omit 함수를 이용해 결측값 처리하기
air_narm1 <- na.omit(airquality)
mean(air_narm1$Ozone)

# 함수 속성인 na.rm을 이용해 결측값 처리하기
mean(airquality$Ozone, na.rm = T)


# 05 데이터 정제 예제 2 : 이상값 처리 # 

# 이상값이 포함된 환자 데이터
patients <- data.frame(name = c("하나", "두나", "세나", "네나", "다나"), 
                       age = c(22, 20, 25, 30, 27), 
                       gender=factor(c("M", "F", "M", "K", "F")), 
                       blood = factor(c("A", "O", "B", "AB", "C")))
patients

# 성별에서 이상값 제거
patients_outrm <- patients[patients$gender=="M"|patients$gender=="F", ]
patients_outrm	


# 성별과 혈액형에서 이상값 제거
patients_outrm1 <- patients[(patients$gender == "M"|patients$gender == "F") 
                            & (patients$blood == "A"
                               |patients$blood == "B"
                               |patients$blood == "O"
                               |patients$blood == "AB"), ]
patients_outrm1	 

#성별은 남자는 1, 여자는 2로 표시, 혈액형은 A, B, O, AB형을 각각 1, 2, 3, 4로 표현
# 이상값이 포함된 환자 데이터
patients <- data.frame(name = c("하나", "두나", "세나", "네나", "다나"), 
                       age = c(22, 20, 25, 30, 27), 
                       gender = c(1, 2, 1, 3, 2), 
                       blood = c(1, 3, 2, 4, 5))
patients	

# 성별에 있는 이상값을 결측값으로 변경
patients$gender <- ifelse((patients$gender<1|patients$gender>2), 
                          NA, patients$gender)
patients	

# 형액형에 있는 이상값도 결측값으로 변경
patients$blood <- ifelse((patients$blood<1|patients$blood>4), 
                         NA, patients$blood)
patients

# 결측값을 모두 제거
patients[!is.na(patients$gender)&!is.na(patients$blood), ]


#boxplot을 활용하여 정상값과 이상값을 구분
boxplot(airquality[, c(1:4)])    # Ozone, Solar.R, Wind, Temp에 대한 boxplot
boxplot(airquality[, 1])$stats   # Ozone의 boxplot 통계값 계산

air <- airquality                 # 임시 저장 변수로 airquality 데이터 복사
table(is.na(air$Ozone))          # Ozone의 현재 NA 개수 확인

# 이상값을 NA로 변경
air$Ozone <- ifelse(air$Ozone<1|air$Ozone>122, NA, air$Ozone) 
table(is.na(air$Ozone)) # 이상값 처리 후 NA 개수 확인(2개 증가)

# NA 제거
air_narm <- air[!is.na(air$Ozone), ] 
mean(air_narm$Ozone) # 이상값 두 개 제거로 is.na 결과보다 값이 줄어듦
boxplot(air_narm$Ozone)$stats


#################################
## 4. 데이터가공 ##
#################################

R.version
install.packages("installr")
library(installr)
updateR()

#base R을 이용한 데이터 가공 

install.packages("gapminder")
install.packages("dplyr")
library(gapminder) 
library(dplyr)
glimpse(gapminder)

#각 나라country의 기대 수명lifeExp
gapminder[, c("country", "lifeExp")] # 5년 간격으로 동일국가 있음

gapminder[, c("country", "lifeExp", "year")] # 년도를 같이 보기

gapminder[1:15, ] # 1~15 행 추출

gapminder[gapminder$country == "Croatia", ] #Croatia만 추출

gapminder[gapminder$country == "Croatia", "pop"] #Croatia, 인구만 추출

#Croatia, 기대수명, 인구만 추출
gapminder[gapminder$country == "Croatia", c("lifeExp","pop")]

#Croatia의 1990년도 이후의 기대 수명과 인구 추출
gapminder[gapminder$country == "Croatia" & gapminder$year > 1990, c("lifeExp","pop")]


# dplyr 라이브러리를 이용한 데이터 가공 # 
#select 함수
select(gapminder, country, year, lifeExp)

#filter 함수
filter(gapminder, country == "Croatia")

#summarise 함수
summarise(gapminder, pop_avg = mean(pop))

summarise(group_by(gapminder, continent), pop_avg = mean(pop))

# 결과가 동일하게 출력
summarise(group_by(gapminder, continent, country), 
          pop_avg = mean(pop))

gapminder %>% 
  group_by(continent, country) %>%
  summarise(pop_avg = mean(pop))

#한 명령어로 처리한 결과를 다시 다른명령어로 처리시
temp1 <- filter(gapminder, country == "Croatia")      
temp2 <- select(temp1, country, year, lifeExp)  
temp3 <- apply(temp2[ , c("lifeExp")], 2, mean)
temp3

# %>% 연산자를 이용하면
gapminder %>% 
  filter(country == "Croatia") %>% 
  select(country, year, lifeExp) %>% 
  summarise(lifeExp_avg = mean(lifeExp))


# 04 데이터 가공의 실제 # 
#방대한 데이터 요약
#아보카도의 가격폭등이 기록된 캐글 데이터
#캐글은 전 세계 대이터 과학자들이 특정 문제의 해결법을 놓고 경쟁을 벌이는 온라인 플랫폼 
avocado <- read.csv("C:/r/avocado.csv", header=TRUE, sep = ",")

str(avocado)

#총 판매량과 평균 가격 속성을 지역에 따라 구분하여 각각 요약 
#dplyr 라이브러리의 group_by와 summarize 함수 사용
(x_avg <- avocado %>% 
    group_by(region) %>% 
    summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice)))

#지역별 특징을 연도별로 다시 세분화
(x_avg <-avocado %>% 
    group_by(region, year) %>% 
    summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice)))

#유기농 여부(type)를 기준으로 한 번 더 세분화
(x_avg <-avocado %>% 
    group_by(region, year, type) %>% 
    summarize(V_avg = mean(Total.Volume), P_avg = mean(AveragePrice)))

#결과 확인
x_avg
 


#연습문제
#  1부터 100까지의 수 중에서 3의 배수이면서 4의 배수는 아닌 수의 합을 구하라.
total = 0
for(i in c(1:100)) {
  if (i%%3 == 0 & i%%4 != 0) {
    total=total + i
  }
}
total

#  x와 n을 입력하면 1부터 n까지의 수 중에서 x의 배수 합을 구해주는 사용자 정의 함수를 만들어라.
times = function(x, n) {
  total = 0
  for(i in c(1:n)) {
    if (i%%x == 0) {
      total=total + i
    }
  }
  return(total)
}
times(3, 100) # 1부터 100까지 수 중 3의 배수의 합을 구함
