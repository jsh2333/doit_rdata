#--------------------------------------------

# ref.
# https://tariat.tistory.com/650

install.packages("readr")
library(readr)

#
# Ÿ��Ÿ�� �����ͼ��� �ҷ�����, ggplot2����� �ҷ��´�. na���� �־� na.omit�Լ��� �̿��ؼ� na�� �������ش�. �������� �����Ͱ� numeric���� �Ǿ� �־� character�� �������־���.

df <- read_csv("https://raw.githubusercontent.com/agconti/kaggle-titanic/master/data/train.csv")
library(ggplot2)
df <- na.omit(df)
# 1) �ϳ� �׸���
qplot(data=df, x="age", y=Age, geom="boxplot")
# 2) �׷����� �׸���
qplot(data=df, x=Survived, y=Age, geom="boxplot")

summary(df)
str(df$Survived)
df$Survived <-  as.character(df$Survived)

# 1) �ϳ� ���� �׸���
hist(df$Age)

# 2) �ϳ� qplot���� �׸���
qplot(data = df, Age, geom = "histogram")
# 3) �׷캰 �׸���
qplot(data = df, Age, fill=Survived, geom="histogram")
# 4) �׷캰 ������ �׸���
qplot(data = df, Age, fill=Survived, alpha=0.5, geom="densit