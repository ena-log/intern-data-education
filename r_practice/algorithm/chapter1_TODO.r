####### chapter 1

PSDS_PATH <- file.path('./source')
state <- read.csv(file.path(PSDS_PATH, 'data', 'state.csv'))


### chapter 1.3 
mean(state[["Population"]])
mean(state[["Population"]], trim=0.1)
median(state[["Population"]])
weighted.mean(state[["Murder.Rate"]], w=state[["Population"]])
  

### chapter 1.4
var(state[["Population"]])
sd(state[["Population"]])
IQR(state[["Population"]])
mad(state[["Population"]])


### chapter 1.5
quantile(state[["Population"]], p=c(.05, .25, .5, .75, .95)) # 백분위수
boxplot(state[["Population"]]/1000000, ylab="Population (millions)")
 

breaks <- seq(from=min(state[["Population"]]), to=max(state[["Population"]]), length=11)
pop_freq <- cut(state[["Population"]], breaks=breaks, right=TRUE, include.lowest = TRUE)
state['PopFreq'] <- pop_freq
table(pop_freq)

hist(state[["Population"]], breaks=breaks) 
hist(state[["Population"]], breaks=breaks, main = "인구분포") #제목달기


### chapter 1.6
#Dallas-Fort Worth 공항의 항공지연 원인 데이터 
dfw <- read.csv(file.path(PSDS_PATH, 'data', 'dfw_airline.csv')) 
dfw
barplot(as.matrix(dfw)/6, cex.axis = 0.8, cex.names = 0.7) 
pie(as.matrix(dfw)/6) #pie chart로 나타내기


### chapter 1.7  
#통신사 주식 수익 데이터 
sp500_px <- read.csv(file.path(PSDS_PATH, 'data', 'sp500_px.csv')) 
sp500_sym <- read.csv(file.path(PSDS_PATH, 'data', 'sp500_sym.csv'), stringsAsFactors = FALSE)

 

telecom <- sp500_px[, sp500_sym[sp500_sym$sector=="telecommunications_services", 'symbol']]
telecom <- telecom[row.names(telecom)>"2012-07-01", ]
# 상관 행렬 
telecom_cor <- cor(telecom)
telecom_cor


etfs <- sp500_px[row.names(sp500_px)>"2012-07-01", 
                 sp500_sym[sp500_sym$sector=="etf", 'symbol']]

install.packages("corrplot")
library(corrplot)  

# 상관행렬 시각화 
corrplot(cor(etfs), method = "ellipse")  # 얇고 진한 색일 수록 강한 상관관계

#산점도 그래프
# telecom <- sp500_px[, sp500_sym[sp500_sym$sector=="telecommunications_services", 'symbol']]
# telecom <- telecom[row.names(telecom)>'2012-07-01',]
plot(telecom$T, telecom$VZ, xlab="T", ylab="VZ")

##########################################


