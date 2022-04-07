####### chapter 3 
PSDS_PATH <- file.path('.', 'source')

### chapter 3.2
session_times <- read.csv(file.path(PSDS_PATH, 'data', 'web_page_data.csv'))
head(session_times)

t.test(Time ~ Page, data=session_times, alternative='less')
       
       

### chapter 3.7
four_sessions  <- read.csv(file.path(PSDS_PATH, 'data', 'four_sessions.csv'))
head(four_sessions)
summary(aov(Time ~ Page,  data=four_sessions))



### chapter 3.9
click_rate <-  read.csv(file.path(PSDS_PATH, 'data', 'click_rates.csv'))
clicks <- matrix(click_rate$Rate, nrow=3, ncol=2, byrow=TRUE)

head(clicks)
chisq.test(clicks, simulate.p.value=TRUE)

##########################################

