#-----------------------------------------
# ch07 데이터 정제하기 : 결측치, 이상치 

df<-data.frame(sex=c("M", "F", NA,"M", "F" ), 
              score=c(5, 4, 3, 4, NA))
df

is.na(df)
table(is.na(df))

table(is.na(df$sex))
table(is.na(df$score))

mean(df$score)
sum(df$score)


library(dplyr)
df %>% filter(is.na(score))
df %>% filter(is.na(sex))

df %>% filter(! is.na(score))
df %>% filter(! is.na(sex))

df %>% filter((! is.na(sex)) & (! is.na(score)))

na.omit(df)

mean(df$score, na.rm=T)
sum(df$score, na.rm=T)

exam<- read.csv("../datas/csv_exam.csv")
head(exam)
table(is.na(exam))

exam[c(3, 8, 15), "math"]<-NA
table(is.na(exam))
exam %>% summarise(mean_math=mean(math))

exam %>% summarise(mean_math=mean(math, na.rm=T))

exam %>% summarise(mean_math=mean(math, na.rm=T),
                   sum_math=sum(math, na.rm=T), 
                   median_math=median(math, na.rm = T))

## 평균값으로 결측치를 대체하기

mean_math<-mean(exam$math, na.rm = T)

exam$math<-ifelse(is.na(exam$math), 55, exam$math )
table(is.na(exam))
mean(exam$math)


fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                  price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                    stringsAsFactors = F)
class(fuel$fl)

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = T)
class(fuel$fl)





