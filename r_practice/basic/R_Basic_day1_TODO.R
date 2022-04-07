#################################
## 1. R 설치 및 기본설정     ####
#################################
## 스크립트 창에 있는 프로그램 실행하기 ##
# 한줄만 실행 : "Run" 혹은 ctrl + enter
# 여러줄 실행 : 마우스로 여러줄 선택후 "Run" 혹은 ctrl + enter
# 전체 실행 : "source"-"source with Echo" 혹은 ctrl + shift + enter
str(cars)
plot(cars)
cars

## 작업 디렉토리 지정 ##
# 지정한 디렉토리(폴더)에 데이터 파일을 저장하는 방법
# getwd : 현재 작업 디렉토리를 보여줌
# setwd : 자신이 원하는 곳으로 지정 가능
getwd()
setwd('c:/r')

## 라이브러리 설치 및 사용
install.packages("ggplot2") # 라이브러리 설치는 라이브러리 파일을 하드디스크에 저장
library(ggplot2) # 라이브러리 부착은 하드 디스크에서 주기억 장치로 적재
search() # 부착된 라이브러리 목록 확인

 

#################################
## 2. 데이터형과 연산 ##
#################################


# 변수
x <- 1  # x에 1을 할당
y <- 2  # y에 1을 할당
x
y
z <- x+y # z에 x+y 결과값을 할당
z

# 해당 변수의 값을 일정한 값만큼 증가
x <- 1
x
x <- x + 1
x
x <- x + 3
x

# 변수이름 규칙
a <- 1
a
A

a@ <- 2

initial_value <- 1
initial_value

blood.type = c("A", "B", "O", "AB")
blood.type

1a <- 1
_a1 <- 1
a_1 <- 1
a_1
b2 <- 2
b2

if <- 1
for <- 2


# 데이터형
x <- 5
y <- 2
x/y
xi <- 1 + 2i
yi <- 1 - 2i
xi+yi
str <- "Hello, World!"
str

blood.type <- factor(c('A', 'B', 'O', 'AB'))
blood.type
T
F
xinf <- Inf
yinf <- -Inf
xinf/yinf

# 데이터형 확인 함수들
is.integer(1)  #정수
is.numeric(1)  #숫자
is.integer(1L)
is.numeric(1L)

#데이터형 변환 함수들
# x에 단순히 1을 넣은 경우 x는 숫자형
x <- 1 	 
x
is.integer(x)

# x에 1L을 입력한 경우 x는 정수형 
x <- 1L 		
x
is.integer(x)

# x에 1을 as.integer 함수로 변환하여 입력한 경우 x는 정수형
x <- as.integer(1) 	 
x
is.integer(x)

# 벡터 생성
1:7 		# 1~7까지 1씩 증가
7:1 		# 7~1까지 1씩 감소

#TODO 	 	# 1~5 벡터 생성. 1:5와 동일
c(1, 2, 3, c(4:6)) 	# 1~3, 4~6 결합
#TODO	# 1~3을 x에 저장
x 		         # x 출력
y <- c() 		     # y를 빈 벡터로 생성
y <- c(y, c(1:3))	# y 에 c(1:3) 추가
y 		         # y 출력 
#TODO 	# 1~10, 2씩 증가
#TODO		# 1~10, 2씩 증가 
seq(0, 1, by = 0.1) 		  # 0~1, 0.1씩 증가
seq(0, 1, length.out = 11)# 0~1, 11개인 벡터 
#TODO# (1, 2, 3) 2번 반복
rep(c(1:3), each = 2)	# (1, 2, 3) 개별 2번 반복

#벡터 연산
x <- c(2, 4, 6, 8, 10)
#TODO		# 길이(크기) 
#TODO		      # x의 1번 요소
x[1, 2, 3] 		# 요소 구할때 -> 에러
#TODO	# 요소 구할때 -> c함수
x[-c(1, 2, 3)] 	# 요소 제외
x[c(1:3)] 		# 1~3 요소 출력

#벡터끼리 연산수행
x <- c(1, 2, 3, 4)
y <- c(5, 6, 7, 8)
z <- c(3, 4)
w <- c(5, 6, 7)
#TODO		# x 개별요소에 2를 각각 더함
#TODO		# x와 y 크기가 동일 -> 각요소 더함
x + z 		# x와 y 크기가 정수배 -> 작은쪽 순환 더함
x + w 		# x와 y 크기가 정수배 아님 -> 에러


# 벡터 연산에 유용한 함수
x=1:10
x >5 		# x 요소값이 5보다 큰가?

#all any함수 : 벡터 내 모든 일부 요소의 조건 검토
all(x>5) 		# x 요소값이 모두 5보다 큰가?
any(x>5) 		# x 요소값이 일부 5보다 큰가?

#head tail : 데이터의 앞 뒤 일부 요소 추출
#TODO		# 기본 6개 데이터 추출
tail(x) 		# 기본 6개 데이터 추출
head(x, 3) 	# 3개 데이터 추출
tail(x, 3) 	# 3개 데이터 추출

# union intersect setdiff setequal : 벡터 간 집합 연산
x <- c(1, 2, 3)
y <- c(3, 4, 5)
z <- c(3, 1, 2)
#TODO	# 합집합
intersect(x, y) 	# 교집합
setdiff(x, y) 	# 차집합(x기준 동일요소 제외)
setdiff(y, x) 	# 차집합(y기준 동일요소 제외)
setequal(x, y) 	# x와 y가 동일한지 비교
setequal(x, z) 	# x와 z가 동일한지 비교


#배열 : 열과 행으로 구성된 데이터
#arrary 함수 : N차원 배열 생성
x <- array(1:5, c(2, 4)) # 1~5   값으로  2X4 행렬에 할당
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
#TODO(v1, v2, v3) # 열 단위로 묶어 배열 생성
rbind(v1, v2, v3) # 행 단위로 묶어 배열 생성


# 배열 연산
# 2x2 행렬 2개를 각각 x, y에 저장
x <- #TODO
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
#TODO # 함수를 행으로 적용
apply(x, 2, mean) # 함수를 열로 적용

#dim 함수: 배열 크기
dim(x)

#sample 함수 : 샘플 추출
sample(x) # 임의로 추출
#TODO # 10개 추출
sample(10) #샘플 만들기

#데이터프레임
name <- c("하나", "두나", "세나")
age <- c(22, 20, 25)
gender <- factor(c("M", "F", "M"))
blood <- factor(c("A", "O", "B"))
patients <- #TODO(name, age, gender, blood)
patients

# edit함수 이용해 데이터프레임 생성
test<-data.frame()
test<-edit(test)
test


# 데이터 프레임 요소에 접근 : $, [,]
patients
#TODO # name 속성값 출력
patients#TODO # 1행 값
patients#TODO # 2열 값
patients[3, 1] # 3행 1열 값
patients[#TODO ] #하나에 대한 정보 추출
patients[patients$name=="하나", c("name", "age")] #하나의 이름과 나이 추출
 

