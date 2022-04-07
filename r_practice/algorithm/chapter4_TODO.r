### chapter 4 
PSDS_PATH <- file.path('.', 'source')

### chapter 4.1 단순선형회귀
lung <- read.csv(file.path(PSDS_PATH, 'data', 'LungDisease.csv'))
plot(lung$Exposure, lung$PEFR, xlab="Exposure", ylab="PEFR")

# 단순선형회귀모델 
model <- lm(PEFR ~ Exposure, data=lung)
model
 
fitted <- predict(model)
fitted
resid <- residuals(model)
resid


### chapter 4.2 다중선형회귀
PSDS_PATH <- file.path('.', 'source')
house <- read.csv(file.path(PSDS_PATH, 'data', 'house_sales.csv'), sep='\t')
head(house[, c("AdjSalePrice", "SqFtTotLiving", "SqFtLot", "Bathrooms", 
               "Bedrooms", "BldgGrade")])

# 다중선형회귀모델 
house_lm <- lm( AdjSalePrice ~ SqFtTotLiving + SqFtLot + Bathrooms + 
                 Bedrooms + BldgGrade,  
               data=house, na.action=na.omit)

house_lm


summary(house_lm)


# stepAIC() 함수를 이용한 단계적 회귀 예 
house_full <- lm(AdjSalePrice ~ SqFtTotLiving + SqFtLot + Bathrooms + 
                   Bedrooms + BldgGrade + PropertyType + NbrLivingUnits + 
                   SqFtFinBasement + YrBuilt + YrRenovated + NewConstruction,
                 data=house, na.action=na.omit)

# install.packages('MASS')
library(MASS)
step_lm <- stepAIC(house_full, direction="both")
step_lm



### chapter 4.4 
# "다수의 유형을 갖는 범주형 변수들" 
# 너무 많은 종류의 범주형 변수는 원-핫인코딩으로 데이터를 변형하면 
# 많은 양의 이진 더미를 생성할 수 있음. 
# 이 경우, 유형을 일부를 통합하는 것이 좋을 지, 
# 그대로 유지하는 것이 좋을 지 결정해야 함.

# house 데이터의 zipcode는 우편번호를 나타내는 범주형변수입니다.
# zipcode의 경우  원-핫인코딩으로 변형 시 너무 많은 이진 더미를 생성할 수 있읍니다. 
# 아래와 같이 우편번호를 5개의 그룹으로 통합 ZipGroup 변수에 저장합니다. (책 173 페이지 참고) 

# (아래 코드는 ppt에는 없으나 코드를 실행하여 ZipGroup 변수를 house 데이터에 생성해두어야 
#  chapter 4.6과 chapter 4.7 실습을 실행할 수 있습니다. )
library(dplyr)
zip_groups <- house %>%
  mutate(resid = residuals(house_lm)) %>%
  group_by(ZipCode) %>%
  summarize(med_resid = median(resid),
            cnt = n()) %>%
  # sort the zip codes by the median residual
  arrange(med_resid) %>%
  mutate(cum_cnt = cumsum(cnt),
         ZipGroup = factor(ntile(cum_cnt, 5)))

house <- house %>%
  left_join(dplyr::select(zip_groups, ZipCode, ZipGroup), by='ZipCode')

house$ZipGroup



### chapter 4.6 교란변수
# 중요한 변수인 ZipGroup 을 포함시키지 않았을 때 
lm(AdjSalePrice ~ SqFtTotLiving + SqFtLot + Bathrooms + Bedrooms + BldgGrade , data=house, na.action=na.omit)

# 중요한 변수인 ZipGroup 을 포함시켰을 때  
lm(AdjSalePrice ~ SqFtTotLiving + SqFtLot + Bathrooms + Bedrooms + BldgGrade + PropertyType + ZipGroup, data=house, na.action=na.omit)



### chapter 4.7 상호작용효과
lm  (AdjSalePrice ~  SqFtTotLiving *  ZipGroup + SqFtLot + 
       Bathrooms + Bedrooms +  BldgGrade + PropertyType,
     data=house, na.action=na.omit)

##########################################################

