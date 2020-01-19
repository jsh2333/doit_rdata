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











