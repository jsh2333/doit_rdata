#--------------------------------------------

# ref.
# https://tariat.tistory.com/650

install.packages("readr")
library(readr)

#
# 타이타닉 데이터셋을 불러오고, ggplot2모듈을 불러온다. na값이 있어 na.omit함수를 이용해서 na를 삭제해준다. 생존여부 데이터가 numeric으로 되어 있어 character로 변경해주었다.

df <- read_csv("https://raw.githubusercontent.com/agconti/kaggle-titanic/master/data/train.csv")
library(ggplot2)
df <- na.omit(df)
# 1) 하나 그리기
qplot(data=df, x="age", y=Age, geom="boxplot")
# 2) 그룹으로 그리기
qplot(data=df, x=Survived, y=Age, geom="boxplot")

summary(df)
str(df$Survived)
df$Survived <-  as.character(df$Survived)

# 1) 하나 쉽게 그리기
hist(df$Age)

# 2) 하나 qplot으로 그리기
qplot(data = df, Age, geom = "histogram")
# 3) 그룹별 그리기
qplot(data = df, Age, fill=Survived, geom="histogram")
# 4) 그룹별 분포로 그리기
qplot(data = df, Age, fill=Survived, alpha=0.5, geom="densit