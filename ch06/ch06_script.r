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

#-----------------------------------------
# 06-5 파생변수 추가하기 :  mutate()
exam %>% 
  mutate(total = math + english + science) %>% 
  head()

exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science)/3) %>% 
  head()

exam %>% 
  mutate(test = ifelse(science >=60, "pass", "fail")) %>% 
  head()

exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science)/3,
         test = ifelse(mean >=60, "pass", "fail")) %>% 
  head()

exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science)/3,
         test = ifelse(mean >=60, "pass", "fail")) %>% 
  arrange(desc(total)) %>% 
  head()

#-----------------------------------------
# 06-6 집단별로 요약하기 : group_by(), summarise()

exam %>% summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            sd_math = sd(math),
            n = n()
            )
mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head()

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=="suv") %>% 
  mutate(tot=(cty+hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)
  

#-----------------------------------------
# quiz 06-7
mpg<-as.data.frame(ggplot2::mpg)
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) 

mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy=mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)
  
mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

#-----------------------------------------
# 06-7 데이터합치기: left_join(), bind_rows()
test1<-data.frame(id=c(1,2,3,4,5), 
                  midterm=c(60, 80, 70, 90, 85))

test2<-data.frame(id=c(1,2,3,4,5), 
                  final=c(70, 83, 65, 95, 80))

test1
test2

# dplyr 패키지의 left_join()을 사용해서 데이터 합치기
total <- left_join(test1, test2, by="id")
total

name <- data.frame(class=c(1, 2, 3, 4, 5),
                   teacher=c("kim", "lee", "park", "choi", "jung"))
name
exam
exam_teacher<-left_join(exam, name, by="class")
exam_teacher

#세로 합치기
group_a <-data.frame(id=c(1,2,3,4,5),
                     test=c(60, 80, 70, 90, 85))

group_b <-data.frame(id=c(6,7,8,9,10),
                     test=c(70, 83, 65, 95, 80))

group_ab <- bind_rows(group_a, group_b)
group_ab

#-----------------------------------------
# quiz, p157
fuel <- data.frame(fl=c("c", "d", "e", "p", "r"),
                      price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22), 
                      stringsAsFactors = F)
mpg<-as.data.frame(ggplot2::mpg)
head(mpg)
mpg<-left_join(mpg, fuel, by="fl")
head(mpg)

mpg %>% 
  select(model, fl, price_fl) %>% 
  head(5)


