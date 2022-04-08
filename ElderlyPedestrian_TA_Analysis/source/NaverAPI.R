#install.packages("httr")
#install.packages("KoNLP")
#install.packages("wordcloud2")
#install.packages("ggplot2")
#install.packages("plyr")
#install.packages("stringr")

library(httr)
library(KoNLP)
library(wordcloud2)
library(ggplot2)
library(plyr)
library(stringr)

#naver api 뉴스 기사 불러오기 
urlStr1 <- "https://openapi.naver.com/v1/search/news.xml?"
#naver api 블로그 불러오기
urlStr <- "https://openapi.naver.com/v1/search/blog.xml?"
#검색할 단어 지정
searchString <- "query=노인보호구역"
searchString <- iconv(searchString, to= "UTF-8")
searchString <- URLencode(searchString)
searchString

#100개 기사/블로그 를 유사도순으로 가져오기
etcString <- "&display=100&start=1&sort=sim"
reqUrl <- paste(urlStr, searchString, etcString, sep="")
reqUrl

#naver api 자신의 id/secret 값 넣기 
clientId <- "[본인 ID 값]"
clientSecret <- "[본인 SECRET 값]"
apiResult <- GET(reqUrl, add_headers("X-Naver-Client-Id"=clientId, "X-Naver-Client-Secret"=clientSecret))
apiResult
str(apiResult)

apiResult$content
str(apiResult$content)

result <- rawToChar(apiResult$content)
result

#encoding 변환
Encoding(result) <- "UTF-8"
result

#기사/블로그 전처리
refinedStr <- result
refinedStr <- gsub("<(\\/?)(\\w ┌+)*([^<>]*)>", " ", refinedStr)
refinedStr <- gsub("[[:punct:]]", " ", refinedStr)
refinedStr <- gsub("[a-z]", " ", refinedStr)
refinedStr <- gsub("[A-Z]", " ", refinedStr)
refinedStr <- gsub("[0-9]", " ", refinedStr)
refinedStr <- gsub(" +", " ", refinedStr)
refinedStr <- gsub("ㅋ", " ", refinedStr)
refinedStr


nouns <- extractNoun(refinedStr)
str(nouns)
nouns[1:1000] #1000개 단어 추출

#한 개인 글자수 제거
nouns <- nouns[nchar(nouns) > 1]
nouns[1:1000]
#특정 단어 제거
excludeNouns <- c("독거노인", "하기", "그렇다보니", "관련","해주","노인","이날","여기","취미","어르신","지원","발생","분야","대상", "취미","민원","해결","교통사고","교통")
excludeNouns <- c("어린이보호구역", "어린이", "보호구역")
excludeNouns <- c("노인보호구역", "노인", "보호구역")
excludeNouns <- c("교통사고","교통")
nouns <- nouns[!nouns %in% excludeNouns]
nouns[1:1000]

wordT <- sort(table(nouns), decreasing=T)[1:300]
wordT


#wordT1 <- sort(table(nouns), decreasing=T)[1:300]
#OldManDF1 <- as.data.frame(wordT1)
#OldManDF1

#막대그래프
#OldManChart <- ggplot(OldManDF1, aes(x=nouns, y=Freq)) + geom_col() + 
#  ggtitle("독거노인 연관단어", subtitle="(빈도기준)")+
#  labs(x="연관단어", y="빈도") + geom_col(aes(fill=Freq))
#OldManChart + theme_classic()

#wordcloud 
wordcloud2(wordT, size=1, shape='circle')

#data frame로 변환
OldManDF <- as.data.frame(wordT)
OldManDF

safeZoneDF <- as.data.frame(wordT)
safeZoneDF

childSafeZoneDF <- as.data.frame(wordT)
childSafeZoneDF
oldSafeZoneDF <- as.data.frame(wordT)

oldSafeZoneDF1 <- as.data.frame(wordT)
oldSafeZoneDF1

#csv로 저장
setwd("C:\\Users\\user")
write.csv(OldManDF, file="OldManDF.csv", row.names = FALSE)
write.csv(safeZoneDF, file="safeZoneDF.csv", row.names = FALSE)
write.csv(childSafeZoneDF, file="childSafeZoneDF2.csv", row.names = FALSE)
write.csv(oldSafeZoneDF, file="oldSafeZoneDF.csv", row.names = FALSE)
write.csv(oldSafeZoneDF1, file="oldSafeZoneDF1.csv", row.names = FALSE)


OldCsv <- read.csv(file = "C:\\Users\\user\\oldSafeZoneDF1.csv", header = TRUE)
OldCsv
View(OldCsv)

############################################################################
#감성분석
setwd("C:\\Users\\user")
posDic = readLines("positive1.txt", encoding = 'UTF-8') #긍정단어 불러오기
negDic = readLines("negative1.txt", encoding = 'UTF-8') #부정단어 불러오기
length(posDic)                                                       
length(negDic)                                                       

posDic.final =c(posDic, 'victor')
negDic.final =c(negDic, 'vanquished')
tail(posDic.final)
tail(negDic.final)


# 감성분석을 위한 함수 정의
sentimental = function(sentences, posDic, negDic){scores = laply(sentences, function(sentence, posDic, negDic) {
  
  sentence = gsub('[[:punct:]]', '', sentence) # 문장부호 제거
  sentence = gsub('[[:cntrl:]]', '', sentence) # 특수문자 제거
  sentence = gsub('\\d+', '', sentence)        # 숫자 제거
  sentence = tolower(sentence)                 # 모두 소문자로 변경(단어가 모두 소문자 임)
  
  word.list = str_split(sentence, '\\s+')      # 공백 기준으로 단어 생성 -> \\s+ : 공백 정규식, +(1개 이상) 
  words = unlist(word.list)                    # unlist() : list를 vector 객체로 구조변경
  
  pos.matches = match(words, posDic)           # words의 단어를 posDic에서 matching
  neg.matches = match(words, negDic)
  
  pos.matches = !is.na(pos.matches)            # NA 제거, 위치(숫자)만 추출
  neg.matches = !is.na(neg.matches)
  
  score = sum(pos.matches) - sum(neg.matches)  # 긍정 - 부정    
  return(score)
}, posDic, negDic)

scores.df = data.frame(score=scores, text=sentences)
return(scores.df)
}

result=sentimental(OldCsv$nouns, posDic.final, negDic.final)
result
names(result)
dim(result)
result$text
result$score

#blue:긍정, green:중립, red:부정
result$color[result$score >=1] = "blue"
result$color[result$score ==0] = "green"
result$color[result$score < 0] = "red"

plot(result$score, col=result$color)
barplot(result$score, col=result$color, main ="감성분석 결과화면")

table(result$color)

result$remark[result$score >=1] = "긍정"
result$remark[result$score ==0] = "중립"
result$remark[result$score < 0] = "부정"

sentiment_result= table(result$remark)
sentiment_result

#파이차트
pie(sentiment_result, main="감성분석 결과", 
    col=c("blue","red","green"), radius=0.8)

