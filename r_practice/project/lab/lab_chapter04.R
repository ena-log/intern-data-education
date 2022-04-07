# 다음은 지역별 주유소의 휘발류 가격 데이터이다. 
 
oil_price = read.csv("./source/lab/oil_price_ANSI.csv", sep=",")
oil_price


# 고급휘발유 가격을 예측하는 회귀모델을 생성하세요.
# 1. 독립 변수로 휘발유, 경유 등  활용. 

oil_lm <- lm(고급휘발유 ~ 휘발유 + 경유, data = oil_price, na.action = na.omit)


# 1.번 결과 생성된 모델을 해석하고 평가하세요.  
# p-value, 결정 계수, 각 계수 .. 등. 

summary(oil_lm)
# Adjusted R-squared:  0.9214  1에 가까움 -> 유의함
# p-value: < 2.2e-16

oil_lm


#예측
data <- data.frame(휘발유 = c(1688, 1728),
                      경유 = c(1438, 1528))
predict(oil_lm, data)
