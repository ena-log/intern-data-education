# iris 데이터로 다음을 구하세요.
# iris는 붓꽃의 품종을 나타내는 Species변수와 꽃잎과 꽃받침의 폭과 넓이 값을 갖는 변수로 구성
head(iris)
str(iris)


#1. Sepal.Width의 0%, 25%, 50%, 75%,100% 백분위수의 출력  
quantile(iris[["Sepal.Width"]], p=c(.00, .25, .50, .75, 1))

#2.  Sepal.Width 변수 값의 boxplot 그리기 
#          (최소, 1Q, 2Q(중앙값),3Q, 최대값의 시각화) 
boxplot(as.matrix(iris$Sepal.Width), ylab="Sepal.Width")

#3. Sepal.Width 변수 값의 boxplot의 수치를 출력해보자.
#           (최소, 1Q, 2Q(중앙값),3Q, 최대값) 
boxplot(iris$Sepal.Width)$stats

#4.   1의 출력값과 3의 출력값이 다른 이유는? 

 
#5. 히스토그램그리기  (Sepal.Width 변수 값을 5구간으로 나누어 )
breaks <- seq(from=min(iris[["Sepal.Width"]]), to=max(iris[["Sepal.Width"]]), length=6)
hist(iris[["Sepal.Width"]], breaks = breaks)

#6. Sepal.Width 변수 값을 5구간으로 나누어 빈도표 출력 
breaks = seq(from=min(iris$Sepal.Width), to=max(iris$Sepal.Width), length=6)

iris_freq <- cut(iris[["Sepal.Width"]], breaks=breaks, right=TRUE, include.lowest = TRUE)
iris_freq
table(iris_freq)

#7.   동전던지기를하여  앞면이 나오면 1000원을 친구에게 주고, 
#       뒷면이 나오면 2000원을 친구로 부터 받기로 했다. 이때 기대값은 ?  
coin_ev <- 1000*0.5 + 2000*0.5
coin_ev

#8 iris의   Species 변수만 제외하고, 나머지 각변수간 상관계수(피어스)들의 상관행렬을 구하세요. 
cor(iris[1:4])
 

#9.   8번 답의 결과 가장 강한 양의 상관 계수를 갖는 변수들은 무엇인가. 
# Petal.Width와 Petal.Length의  상관계수  0.9628654 


#10.  8번 답의 결과 가장 강한 음의 상관 계수를 갖는 변수들은 무엇인가. 
# Sepal.Width와 Petal.Length의 상관계수 -0.4284401   
# 절대값이 0.8 이상이 되어야 강한 관계라고 할 수 있다. 
# -0.4는 약한 관계 


#11. 8의 상관행렬을 시각화해보세요.  
library(corrplot)
corrplot(cor(iris[1:4]), method = "e") 

#12.   9의 답 변수로 산점도 그래프를 그려보세요. 
plot (iris$Petal.Width, iris$Petal.Length)

#13.   10의 답 변수로  산점도 그래프를 그려보세요. 
plot (iris$Sepal.Width, iris$Petal.Length)
