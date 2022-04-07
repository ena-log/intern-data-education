### chapter 5
PSDS_PATH <- file.path('.', 'source')

### chapter 5.1 나이브베이즈
loan_data <- read.csv(file.path(PSDS_PATH, 'data', 'loan_data.csv'), stringsAsFactors = T)

## Naive Bayes
# install.packages("klaR")
library(klaR)

naive_model <- NaiveBayes(outcome ~ purpose_ + home_ + emp_len_, 
                          data = na.omit(loan_data))



new_loan <- loan_data[147, c('purpose_', 'home_', 'emp_len_')]
row.names(new_loan) <- NULL
new_loan

predict(naive_model, new_loan)



### chapter 5.2 로지스틱회귀

## logistic regresstion
logistic_model <- glm(outcome ~ payment_inc_ratio + purpose_ + 
                        home_ + emp_len_ + borrower_score,
                      data=loan_data, family='binomial')

summary((logistic_model))
#TODO(logistic_model,  type = 'response')

##########################################################

