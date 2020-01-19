#------------------------------------
# ch06- 조건에 맞는 데이터 추출하기


intall.packages("dplyr")
library(dplyr)

exam<-read.csv("../datas/csv_exam.csv")
exam

# dplyer 패키지의 데이터 전처리에 사용되는 기능
# filter() 행추출
# select() 열(변수) 추출
# arrange() 정렬(default 오름차순, 내림차순 desc() 사용 )
# mutate() 변수 추가
# sumarise() 요약 통계량 산출
# group_by() 집단별로 나누기
# left_join() 데이터 합치기(열)
# bind_rows() 데이터 합치기(행)

exam %>%filter(class==1 | class==2)
View(exam)

exam %>%filter(class!=1)
exam %>%filter(class>=3)
exam %>%filter(class>3)
exam %>%filter(class<3)
exam %>%filter(class<=3)
exam %>%filter(english>80 & math<60 & class==2)
exam %>%filter(english>95 | math>95) # & class==3)
exam %>%filter((english>95 | math>95) & class==3)


class1 <-exam %>%filter(class %in% c(1)  )
class2 <-exam %>%filter(class ==2  )

mean(class1$math)
mean(class2$math)

#-------------------------------------
# p133
# mpg 데이터를 이용한 분석 연습
# Q1
mpg <- as.data.frame(ggplot2::mpg)
#displ 4이하
mpg_a<-mpg %>%  filter(displ <=4)
max(mpg_a$displ)
#displ 5이상
mpg_b<-mpg %>%  filter(displ >=5)
head(mpg_b)
min(mpg_b$displ)
mean(mpg_a$hwy)
mean(mpg_b$hwy)
# Q2
mpg_audi<-mpg %>%  filter(manufacturer =="audi")
mpg_toyota<-mpg %>%  filter(manufacturer =="toyota")
mean(mpg_audi$cty)
mean(mpg_toyota$cty)
# Q3
mpg_q3<-mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda") )
head(mpg_q3)
mean(mpg_q3$hwy)


# 06-3
head(exam)
select1<- exam %>% select(class, math, english)
head(select1)
select2<- exam %>% select(class, math, -english)
select3<- exam %>% select(-math, -english)
head(select3)

exam %>% filter(class==1) %>% select(english)


exam %>% 
  filter(class==1) %>% 
  select(english) %>% 
  head(2)

exam %>% 
  select(id, math) %>%
  head(10)

# 06-4 

exam %>% 
  select(id, math) %>%
  head(10) %>% 
  arrange(math)

exam %>% 
  select(id, math) %>%
  head(10) %>% 
  arrange(desc(math)) %>% 
  head(3)

head(exam)
exam %>% 
  arrange(desc(math), desc(english), class)

  
