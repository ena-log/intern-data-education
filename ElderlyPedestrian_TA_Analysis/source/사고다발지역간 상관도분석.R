library(corrplot)

data1 <- read.csv("C:\\Users\\user\\Desktop\\0813\\사고다발지역 분석데이터 7개구.csv")

str(data1)

a <- data.frame(data1) # 데이터 프레임으로 변환


cor(a)

corrplot(cor(a), method = "number", col='black') # 상관도 시각화
