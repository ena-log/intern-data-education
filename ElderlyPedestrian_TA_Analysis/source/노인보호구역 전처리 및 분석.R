# 공공체육시설 구별 개수
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리")
data <- read.csv("서울시 공공체육시설 현황(2019).csv")
gu <- unique(data$자치구)

n <- 0
for(i in 1:28) {
  n <- c(n,nrow(data[data$자치구==gu[i],]))
 }

length(gu)
length(n)
fac_n <- data.frame(gu,n[c(2:29)])
colnames(fac_n) <- c("구","체육시설 수")

# gid 결합하기
# 법정동으로 분리하기
library(dplyr)
library(stringr)
gu_gid <- read.csv("동별 공공체육시설 수.csv")
seoul_gid <- read.csv("법정동코드.csv")
seoul_gid <- seoul_gid %>% rename("gid"="법정동코드")
seoul_gid$gid <- str_sub(seoul_gid$gid,1,8)
str(gu_gid)
str(seoul_gid)
seoul_gid <- as.matrix(seoul_gid)
transform(gu_gid,gid=as.numeric(gid))
seoul_gid <- transform(seoul_gid,gid=as.numeric(gid))
join_gid <- inner_join(gu_gid,seoul_gid,by='gid')
head(join_gid)
dong <- strsplit(join_gid$법정동명," ")

d <- 0
for (i in 1:467){
  d <- c(d,dong[[i]][3])
}
join_gid$dong <- d[2:468]
write.csv(join_gid,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\동별 체육시설 전처리.csv")


# 동별로 체육기관 수 세기
gu_fac <- data.frame(join_gid$gid,join_gid$dong,join_gid$NUMPOINTS)
colnames(gu_fac) <- c("gid","동","체육시설 수")
write.csv(gu_fac,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\동별 체육시설 수 dataframe.csv")
sum(gu_fac$`체육시설 수`)


## 데이터 전처리 (동)
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리\\공공체육시설")
data <- read.csv("공공체육시설.csv")
data_dong <- strsplit(data$주소," ")
d <- 0
for (i in 1:751){
  d <- c(d,data_dong[[i]][2])
}
data$법정동 <- d[2:752]
write.csv(data,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\공공체육시설\\공공체육시설_전처리.csv")


### 확인
data1 <- read.csv("법정동 체육시설 수.csv")
sum(data1$NUMPOINTS)


## 데이터 전처리 - 노인 사망사고 (동)
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리")
data <- read.csv("서울특별시 노인사고 _ 동_19.csv")
data_dong <- strsplit(data$시군구," ")
d <- 0
for (i in 1:5911){
  d <- c(d,data_dong[[i]][3])
}
data$법정동 <- d[2:5912]
write.csv(data,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\서울특별시 노인사고_전처리.csv")


# 법정동 이름 전처리 (사용x)
data$법정동 <- str_replace_all(data$법정동,'로[0-9]가',"로동")
data$법정동 <- str_replace_all(data$법정동,'동[0-9]가',"동")
data$법정동 <- str_replace_all(data$법정동,'도[0-9]동',"도동")
data$법정동 <- str_replace_all(data$법정동,'륜[0-9]가',"륜동")
data$법정동 <- str_replace_all(data$법정동,'$로',"로동")
unique(data$법정동) # 동 확인
write.csv(data,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\서울특별시 노인사고_전처리.csv")


# 위 코드 유용성 test
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리\\서울 법정동 shp")
data2 <- read.csv("서울특별시 동.csv")
unique(data2$emd_kor_nm)
data2$emd_kor_nm <- str_replace_all(data2$emd_kor_nm,'로[0-9]가',"로동")
data2$emd_kor_nm <- str_replace_all(data2$emd_kor_nm,'동[0-9]가',"동")
data2$emd_kor_nm <- str_replace_all(data2$emd_kor_nm,'도[0-9]동',"도동")
data2$emd_kor_nm <- str_replace_all(data2$emd_kor_nm,'륜[0-9]가',"륜동")
data2$emd_kor_nm <- str_replace_all(data2$emd_kor_nm,'$로',"로동")
unique(data2$emd_kor_nm)
length(unique(data2$emd_kor_nm))


# 법정동별 노인 사고 수
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리\\공공체육시설")
f <- read.csv("체육시설.csv")
plot(f)
f %>% dim
df <- as.matrix(f)
barplot(f$emd_kor_nm,f$NUMPOINTS)
str(f)
library(ggplot2) # 의미 없어!
ggplot(f,aes(x=NUMPOINTS,y=emd_kor_nm)) + geom_point()


# treemap - 지역별 체육시설 수 
install.packages("treemap")
library(treemap)
colnames(f)
head(f)
library(plyr)
f_order <- arrange(f,desc(NUMPOINTS)) 
f_top <- f_order[1:50,]
treemap(f_top,
        index="emd_kor_nm",
        vSize = "NUMPOINTS",
        vColor = "NUMPOINTS",
        type="value",
        bg.labels = "red",
        title="지역별 체육시설 수"
        )
ggplot(f_top, aes(x=reorder(emd_kor_nm, NUMPOINTS), y=NUMPOINTS, fill=emd_kor_nm)) + geom_bar(stat="identity") + coord_flip()


data$법정동 <- str_replace_all(data$법정동,'로[0-9]가',"로동")
data$법정동 <- str_replace_all(data$법정동,'동[0-9]가',"동")
data$법정동 <- str_replace_all(data$법정동,'도[0-9]동',"도동")
data$법정동 <- str_replace_all(data$법정동,'륜[0-9]가',"륜동")
data$법정동 <- str_replace_all(data$법정동,'$로',"로동")
unique(data$법정동) # 동 확인
write.csv(data,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\서울특별시 노인사고_전처리.csv")


# 교통사고 - 체육시설 수 상관관계 파악하기
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리\\분석 데이터")
data <- read.csv("노인 분석 데이터.csv")
use_data <- data[,c(3,8,9,10,16,17)]
use_data$노인수대비교통사고 <- use_data$노인.교통사고 / use_data$총.노인인구수
head(use_data)


# 행정구역별 노인교통사고 수 (체육시설로 색)
use_data <- arrange(use_data,desc(노인수대비교통사고))
use_data1 <- use_data[1:10,]
fillPalette <- c("#FFFFFF", "#FFCC00", "#FF9900", "#FF6600", "#FF3300") # scale_fill_manual
# brewer(palette="Pastel1")
ggplot(use_data1,aes(x=reorder(행정구역명,노인수대비교통사고),y=노인수대비교통사고,fill=as.factor(공공.체육시설)))+
         geom_bar(stat="identity",colour="black") + geom_text(aes(label=노인수대비교통사고),vjust=-.25)+ scale_fill_manual(values = fillPalette)+
  ggtitle("행정동별 노인교통사고 (공공 체육시설 수)") + xlab("행정동")+ylab("노인 교통사고 수") + theme_bw()+
  theme(axis.text.x=element_text(angle=45,hjust=1))


# 상관관계 : 공공 체육시설 - 노인 교통사고 수 
# 기대결과 : 체육시설이 많을수록 교통사고가 증가한다. (기각)
summary(use_data)
head(use_data)
use_data$독거노인 <- as.numeric(str_replace_all(use_data$독거노인,",",""))
cor_data <- use_data[,c(2,3,4,6)]
cor(cor_data)
plot(cor_data)
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(cor_data,histogram = TRUE,pch=19)
cor_data_c <- cor(cor_data)
library(corrplot)
corrplot(cor_data_c,method="ellipse")
corrplot.mixed(cor_data_c)
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(cor_data_c, method="shade", shade.col=NA, tl.col="black", tl.srt=45,col=col(200), addCoef.col="black", addcolorlabel="no", order="AOE")

cor.test(cor_data$노인보호구역,cor_data$공공.체육시설) # -0.02



# 행정동별 셍활인구 수 전처리
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리")
peo <- read.csv("행정동별 생활인구수.csv")
peo_use <- peo[,c(3,4)]
length(unique(peo_use$행정동코드))
colnames(peo_use)
peo_a <- aggregate(총생활인구수~행정동코드,peo_use,mean)
write.csv(peo_a,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\행정동별 생활인구수_전처리.csv")
colnames(peo_a) <- c("행정구역코드","총생활인구수") 
colnames(data)

df <- merge(data,peo_a,by="행정구역코드",all=TRUE)
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리")
mapp <- read.csv("행정동코드_매핑정보_2018.csv",header=T)
mapp_use <- mapp[,c(2,5)]
head(mapp_use)
colnames(mapp_use) <- c("행정구역코드","행정구역명")
peo_mapp <- merge(peo_a,mapp_use,'행정구역코드')
write.csv(peo_mapp,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\행정동별 생활인구수_전처리.csv")


# 저출산 고령화 추세 파악 (사용 x)
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리\\분석 데이터")
a_2008 <- read.csv("2008 연령별인구현황.csv")
a_2020 <- read.csv("2020 연령별인구현황.csv")
all_2008 <- a_2008[,c(1,4:14)]
all_2020 <- a_2020[,c(1,4:14)]
colnames(all_2008) <- c("행정구역","0-9세","10-19세","20-29세","30-39세","40-49세","50-59세","60-69세","70-79세","80-89세","90-99세","100세이상")
all_2008$행정구역 <- str_replace_all(all_2008$행정구역,'([0-9])',"")
all_2008$행정구역 <- str_replace_all(all_2008$행정구역,'\\W',"")
t_2008 <- t(all_2008[1,c(2:12)])
colnames(t_2008) <- "전국 인구 수"
all_2020[1,]
전국인구수_2008 <- c("5160630" ,"6829651", "7258980", "8559686", "8625285", "5989150", "3920128", "2285007",  "703548",   "81860",  "2237")
전국인구수_2020 <- c("4062274" ,"4850566", "6801367", "6956361", "8338271", "8653176", "6549914", "3671175",  "1691397",   "244100",  "21251")
연령대 <- c("0-9","10-19","20-29","30-39","40-49","50-59","60-69","70-79","80-89","90-99","100-")
df <- data.frame(연령대,전국인구수_2008,전국인구수_2020)
write.csv(df,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\지히부탁해.csv")

str(tt_2008)
nrow(tt_2008)
ggplot(df, aes(x=연령대, y=c(전국인구수_2008, group=1))) + 
     geom_line(linetype="dotted", size=1, colour="blue") + 
     geom_point(size=3, shape=19, colour="blue") +
     ggtitle("Time Series Graph, Temp from May.01 to May.31, with dotted line, dot")
ggplot(df,aes(x=연령대,y=reorder(전국인구수_2008))) + geom_bar(stat="identity")


# 스쿨좉내 어린이 교통사고 - 노인보행자교통사고 (사용 x) => 유의미 x
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리\\분석 데이터\\스쿨존")
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리")
data <- read.csv("스쿨존내 어린이(만 13세 미만) 교통사고 (2).csv")
data1 <- read.csv("노인보행자 교통사고.csv")
colnames(data) <- data[2,]
colnames(data1) <- data1[2,]
colnames(data) <-  c("년도","사고건수","사망자수","부상자수")
colnames(data1) <- c("년도","사고건수","사망자수","부상자수")
data <- data[c(3:7),]
data1 <- data1[c(3:7),]
colnames(data1)

library(ggplot2)
d <- data.frame(data$년도,data$사고건수,data1$사고건수)
colnames(d) <- c("년도","스쿨존교통사고","노인보행자교통사고")
str(d)
ggplot(d,aes(년도,스쿨존교통사고))+geom_line(arrow=arrow())
library(reshape2)
d1 <- melt(d,"년도",c("스쿨존교통사고","노인보행자교통사고"))
write.csv(d1,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\스쿨존노인.csv")
d2 <- read.csv("스쿨존노인.csv")
d2 <- d2[,c(2,3,4)]
ggplot(d,aes(년도,스쿨존교통사고))+geom_bar()  


# 연도별 인구수 - e-나라지표 => 저출산 고령화 결과 도출 
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리\\분석데이터")
data <- read.csv("연도별 인구수csv.csv")
colnames(data) <- data[2,]
data <- data[c(3,5),c(2:ncol(data))]
data <- t(data)
write.csv(data,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\연도별인구수전처리.csv")

setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리")
data1 <-read.csv("연도별인구수전처리.csv") 
colnames(data1) <- c("연도","어린이","노인")
head(data1)
ggplot(data1,aes(x=연도))+geom_line(aes(x=연도,y=노인),color="#CC6600",size=2)+
  geom_line(aes(x=연도,y=어린이),color="#333399",size=2)+
  ylab("인구 수") + theme_bw()


# 연도별 노인,어린이 보호구역 비교교
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리\\분석 데이터")
safezone<- read.csv("경찰청_보호구역_2012-2019.csv")
safezone_use <- t(safezone)
write.csv(safezone_use,"C:\\Users\\user\\Desktop\\project\\노인 전처리\\경찰청_보호구역_2012-2019_전처리.csv")
setwd("C:\\Users\\user\\Desktop\\project\\노인 전처리")
safezone_use <- read.csv("경찰청_보호구역_2012-2019_전처리.csv")
colnames(safezone_use)
ggplot(safezone_use,aes(x=연도))+geom_bar(aes(x=연도,y=어린이보호구역),stat="identity",fill="#FF6666",position=position_dodge())+
  geom_bar(aes(x=연도,y=노인보호구역),stat="identity",fill="#330099",position=position_dodge())

str(safezone_use)


# 보호구역 변화량 파악 => 신규 노인 보호구역 증가, 어린이 보호구역 감소 
kids_diff <- 0 
for (i in 2:8){
  kids_diff <- c(kids_diff,safezone_use[i,2] - safezone_use[i-1,2])
}

older_diff <- 0 
for (j in 2:8){
  older_diff <- c(older_diff,safezone_use[j,3] - safezone_use[j-1,3])
}

safezone_use_diff <- data.frame(safezone_use$연도,kids_diff,older_diff)
colnames(safezone_use_diff) <- c("연도","kids_diff","older_diff")
ggplot(safezone_use_diff,aes(x=연도))+geom_line(aes(x=연도,y=kids_diff,col="#0033FF"))+ geom_point(aes(x=연도,y=kids_diff,col="#0033FF"))+
  geom_line(aes(x=연도,y=older_diff,col="#FF3300"))+geom_point(aes(x=연도,y=older_diff,col="#FF3300")) + ylab("보호구역 증감율") + theme_bw()


# 노인교통사고 법규위반 종류에 따른 사고 발생 수 
setwd("C:\\Users\\user\\Desktop\\project\\노인 분석과정\\rawdata")
acc <- read.csv("교통사고_14년_19년.csv")
str(acc)
library(stringr)
acc$피해운전자.연령 <- as.numeric(str_replace_all(acc$피해운전자.연령,"세",""))
acc_older <- acc[acc$피해운전자.연령 >= 65,] #노인
older_illegal <- as.data.frame(table(acc_older$법규위반))
colnames(older_illegal) <- c("법규위반","사고발생수")
#install.packages("plotrix v3.7-8")
#library(plotrix)
#radial.pie(older_illegal$사고발생수,labels=older_illegal$법규위반)
older_illegal <- as.data.frame(older_illegal)
ggplot(older_illegal,aes(x=reorder(법규위반,사고발생수,sum),y=사고발생수,fill=rainbow(11)))+geom_bar(stat="identity") + 
  theme(axis.text.x = element_text(angle = 30, hjust = 1),panel.background = element_blank())+
  geom_text(aes(label=사고발생수),vjust=-.25)+
  labs(title="노인 교통사고 법규위반 종류")+xlab("법규위반 종류")

# 안전운전불이행의 경우 사고유형 파악 => 횡단중이 가장 많음. (횡단보도관련)
nonsafe <- acc_older[acc_older$법규위반=="안전운전불이행",]
nonsafe <- nonsafe[nonsafe$사고유형 != "차대사람 - 기타",]
nonsafe <- nonsafe[!is.na(nonsafe$사고유형),]
unique(nonsafe$사고유형)
nonsafe$사고유형 <- str_replace_all(nonsafe$사고유형,"차대사람 - ","")
nonsafe_use <- as.data.frame(table(nonsafe$사고유형))
colnames(nonsafe_use) <- c("사고유형","사고발생 수")

total <- sum(nonsafe_use$`사고발생 수`)
백분율 <- 0
for (i in 1:4){
  백분율 <- c(백분율,nonsafe_use[i,2]/total)
}
per <- as.data.frame(백분율 * 100)
nonsafe_use$백분율 <- per[c(2:5),]
ggplot(nonsafe_use,aes(x=reorder(사고유형,백분율,sum),y=백분율,fill=사고유형))+ geom_bar(width=1,stat="identity") + theme_classic()  + labs(title="안전운전불이행 경우의 사고유형")+xlab("사고유형")+
  geom_text(aes(label=round(백분율,2)),vjust=-.25)

