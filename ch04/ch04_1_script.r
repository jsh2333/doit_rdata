#-------------
# ch04

english<-c(90, 80, 60, 70)
math<-c(50, 60, 100, 20)
class<-c(1, 1, 2, 2)

english
math

df_midterm <- data.frame(english, math)
df_midterm

df_midterm <- data.frame(english, math, class)
df_midterm

mean(df_midterm$english)
mean(df_midterm$math)

# 데이터프레임생성 오류
#df_midterm <- data.frame(
#  english<- c(90, 80, 60, 70)
#  ,math <- c(50, 60, 100, 20)
#  ,class <- c(1, 1, 2, 2)
#)
df_midterm <- data.frame(
  english= c(90, 80, 60, 70)
  ,math = c(50, 60, 100, 20)
  ,class = c(1, 1, 2, 2)
)
df_midterm

# p88 ex
fruit<-c("사과","딸기" ,"수박");
price<-c(1800, 1500, 300);
quant<-c(24, 38, 13);

sales<-data.frame(fruit, price, quant);
mean(sales$price)
mean(sales$quant)
#---------------------------
#04-3 89p

# xlsx
install.packages("readxl");
library(readxl);

df_excel<-read_excel("./datas/excel_exam.xlsx")
df_excel<-read_excel("c:/works/ch04/datas/excel_exam.xlsx")
df_excel;

df_excel_mean_math = mean(df_excel$math)
df_excel_mean_english <- mean(df_excel$english)
df_excel_mean_science <- mean(df_excel$science)
df_excel_mean_math
df_excel_mean_english
df_excel_mean_science

#excel_exam_novar.xlsx
df_excel_novar<-read_excel("./datas/excel_exam_novar.xlsx", col_names = F)
df_excel_novar

# 
df_excel_sheet<-read_excel("./datas/excel_exam_sheet.xlsx", col_names = T, sheet=3)
df_excel_sheet

# csv 읽기
# csv_exam.csv
df_csv_exam <- read.csv("./datas/csv_exam.csv");
df_csv_exam

# csv 읽기
# csv_exam.csv
# 숫자가 아닌 문자가 들어 있는 파일을 읽어올때 옵션이 필요함.
df_csv_exam_string <- read.csv("./datas/csv_exam_string.csv", stringsAsFactors = F);
df_csv_exam_string

df_midterm
write.csv(df_midterm, file="df_midterm.csv")
df_midterm_csv <- read.csv("df_midterm.csv");
df_midterm_csv

# RData 저장하기
save(df_midterm, file="df_midterm.rda")
df_midterm
rm(df_midterm)
df_midterm # 오류발생
# RData 불러오기
load("df_midterm.rda")
df_midterm

# 데이터 대략 파악하기
# p 100

df_csv_exam <- read.csv("./datas/csv_exam.csv");
df_csv_exam
head(df_csv_exam)
dim(df_csv_exam)
summary(df_csv_exam)

tail(df_csv_exam)
str(df_csv_exam)

head(df_csv_exam, 10)
head(df_csv_exam, 3)
tail(df_csv_exam, 3)
View(df_csv_exam)

# boxplot

install.packages("ggplot2");

library(ggplot2);
qplot(data=mpg, x=drv, y=hwy, geom="boxplot", colour=drv)

head(mpg)
tail(mpg)
dim(mpg)
str(mpg)
summary(mpg$hwy)

#-------------------------
rvar1=c(1,2,1)
rvar2=c(2,3,2)
df_raw <-data.frame(rvar1, rvar2)
# rename df's column name
install.packages("dplyr")
library(dplyr)
df_new <-df_raw
df_new <- rename(df_new, v2=rvar2)
df_new
df_raw

library(ggplot2);
mpg_new<-mpg
mpg_new<-rename(mpg_new, highway=hwy)
str(mpg_new)

# 파생변수 만들기
# p113
col1=c(4,3,8)
col2=c(2,6,1)
df<- data.frame(col1, col2)
df_new<-rename(df, var1=col1, var2=col2)
df_new
df_new$var_sum <- df_new$var1 + df_new$var2
df_new$var_mean <- (df_new$var1 + df_new$var2)/2
df_new

str(mpg_new)
mpg_new$total<- (mpg_new$cty+mpg_new$highway)/2
head(mpg_new)
str(mpg_new)

mean(mpg_new$total)
summary(mpg_new$total)
hist(mpg_new$total)
# 조건문을 이용한 파생변수 만들기
mpg_new$test<- ifelse(mpg_new$total >= 20, "pass", "fail");
mpg_new$test<- if(mpg_new$total >= 20) print("pass") else print("fail")
                
head(mpg_new)
str(mpg_new)
View(mpg_new)
# 빈도표 보기
table(mpg_new$test)

library(ggplot2)
qplot(mpg_new$test)

# 2중-중첩 ifelse 사용해서 영역 구분하기
mpg_new$grade <- ifelse( mpg_new$total >=30, "A", 
                         ifelse(mpg_new$total >=20, "B", "C")
                 );

mpg_new$grade
head(mpg_new)
str(mpg_new)
View(mpg_new)

#p123
head(midwest)
str(midwest)
dim(midwest)
summary(midwest)

midwest_new <- midwest
midwest_new<-rename(midwest_new, total=poptotal, asian=popasian)
midwest_new$ratio<- (midwest_new$asian/midwest_new$total)*100 # %표시
qplot(midwest_new$ratio)
asian_mean<-mean(midwest_new$ratio);
midwest_new$group<-ifelse(midwest_new$ratio>asian_mean, "large", "small")
table(midwest_new$group)
library(ggplot2)
qplot(midwest_new$group)

