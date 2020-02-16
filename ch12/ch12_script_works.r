#############################
# ch12  인터랙티브 그래프
#############################

#mariadb  설치
#다운로드 받은 mariadb.zip을 압축을 풀어 놓습니다. 
#c:\works\mariadb 폴더에다 풀어놓았다고 가정하겠습니다. 
# 
# 설정방법
# 관리자 계정으로 cmd 창을 열어 놓습니다. 
# > cd c:\works\mariadb  이동합니다. 
# > mysql_install_db.exe  --datadir=c:\works\mariadb\data --service="mariadb"  --port=3306  --password=pass

# 계정 권한 설정하기
Mariadb[none]> select mysql
Mariadb[mysql] > grant all privileges on *.* 'rrot'@''
#--------------------------------
# 1. 패키지 준비하기 
#--------------------------------
install.packages("plotly")
library(plotly)


#--------------------------------
# 2. ggplot2 그래프 만들기
#--------------------------------
# 인터랙티브 그래프 생성 순서
# 1) ggplot2에 의해 그래프 생성 
# 2) ggplotly()에서 인터랙티브 그래프로 변환

# mpg 데이터를 사용해서 
# x축에 displ(배기량)
# y축에 hwy(연비) 를 지정해서 산점도를 만들어봅니다. 
# 산점도의 col =drv 는 drv(구동방식: 전륜, 후륜, 4륜)에 따른 색상구분을 위해 사용
# static 그래프
library(ggplot2)
ggplot(data=mpg,
       aes(x=displ, y=hwy, col=drv)
) + geom_point()

#인터랙티브 그래프만들기  
p<-ggplot(data=mpg,
          aes(x=displ, y=hwy, col=drv)
) + geom_point()

#--------------------------------
# 3. ggplotly 적용, 인터랙티브 그래프 만들기
#--------------------------------
ggplotly(p)


# 생성된 그래프에 마우스를 올려보세요

# 영역 확대 -> 마우스 드래그 휠 조절
# 더블클릭 -> 원래 사이즈로 리턴
#------------------------------------------


? diamonds
# A dataset containing the prices and other attributes of almost 54,000 diamonds. The variables are as follows:
# A data frame with 53940 rows and 10 variables:
# 다이아몬드의 특성에 따른 가격 정보
# price  price in US dollars (\$326–\$18,823)



ggplot(data =  diamonds, 
       aes(x = cut, fill=clarity)) +
  geom_bar(position="dodge")

p<- ggplot(data =  diamonds, 
           aes(x = cut, fill=clarity)) +
  geom_bar(position="dodge")


ggplotly(p)

#================================
# 12.2  dygraphs 패키지로 인터랙티브 시계열 그래프 만들기
#================================
# 시간에 따른 데이터의 변화를 표현하는 인터랙티브 
# 시계열 그래프
# 마우스로 시간축을 움직이면서 변화되는 데이터를 관찰 할 수 있습니다. 


install.packages("dygraphs")
library(dygraphs)

? economics
View(economics)

economics <- ggplot2::economics

head(economics)
str(economics)

# xts 타입  -> 시간순서속성의 데이터 타입
# xts()

library(xts)
str(economics$unemploy)
eco <- xts(economics$unemploy, 
           order.by = economics$date)

str(eco)
View(eco)

# 시계열 그래프 만들기
dygraph(eco)

# 날짜 범위 선택
dygraph(eco) %>% 
  dyRangeSelector()

# 저축률 psavert
eco_a <- xts(economics$psavert, order.by = economics$date)
# 실업자수  unemploy
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

eco2 <- cbind(eco_a, eco_b)
colnames(eco2)  <- c("psavert", 'unemploy')
head(eco2)

dygraph(eco2) %>% 
  dyRangeSelector()

#----------------------------------------------
# Examples
# https://plot.ly/ggplot2/stat_smooth/#trend-lines
# Ex1
library(plotly)

p <- ggplot(mpg, aes(displ, hwy))
p <- p + 
  geom_point() + 
  stat_smooth()
p
p <- ggplotly(p)

p
#--------------------------------------
#Ex2
library(plotly)

x <- 1:10
y <- jitter(x^2)

DF <- data.frame(x, y)
View(DF)
ggplot(DF, aes(x = x, y = y)) + geom_point()
#-------
p <- ggplot(DF, aes(x = x, y = y)) + 
     geom_point() +
     stat_smooth(method = 'lm', aes(colour = 'linear'), se = FALSE) +
  stat_smooth(method = 'lm', formula = y ~ poly(x,2), aes(colour = 'polynomial'), se= FALSE) +
  stat_smooth(method = 'nls', formula = y ~ a * log(x) +b, aes(colour = 'logarithmic'), se = FALSE, start = list(a=1,b=1)) +
  stat_smooth(method = 'nls', formula = y ~ a*exp(b *x), aes(colour = 'Exponential'), se = FALSE, start = list(a=1,b=1))

p <- ggplotly(p)

p

#---------------------------------
# Ex3
library(plotly)

x <- rnorm(100)
y <-  + .7*x + rnorm(100)

f1 <- as.factor(c(rep("A",50),rep("B",50)))
f2 <- as.factor(rep(c(rep("C",25),rep("D",25)),2))
View(f2)

df <- data.frame(cbind(x,y))
View(df)
df$f1 <- f1
df$f2 <- f2

p <- ggplot(df,aes(x=x,y=y)) +
  geom_point() +
  facet_grid(f1~f2) +
  stat_smooth(method="lm")

p <- ggplotly(p)

p
#-----------------------
# EX4, 
x <- rnorm(1000)
y1 <- 2*x + rnorm(1000)
y2 <- x^2 + rnorm(1000)
? rnorm
ds <- data.frame(data = x, 
                 Linear = y1, 
                 Quadratic = y2)


cols1 <- c("#ff8080", "#66b3ff")
cols2 <- c("#ff4d4d", "#3399ff")

p <- ggplot(ds, aes(x = data)) + 
  geom_point(aes(y = Linear, color = "Linear"), size = 2, alpha = 0.5) + 
  
  geom_point(aes(y = Quadratic, color = "Non Linear"), size = 2, alpha = 0.5) + 
  stat_smooth(aes(x = data, y = Linear, linetype = "Linear Fit"), method = "lm", formula = y ~ x, se = F, size = 0.25, color = cols2[1]) + 
  stat_smooth(aes(x = data, y = Quadratic, linetype = "Quadratic Fit"), method = "lm", formula = y ~ poly(x,2), se = F, size = 0.25, color = cols2[2]) + 
  scale_color_manual(name = "Relationship", values = c(cols1[1], cols1[2])) + 
  scale_linetype_manual(name = "Fit Type", values = c(2, 2)) + 
  ggtitle("Manual Legend for Stat Smooth")

p <- ggplotly(p)

p



#-------------------------------
#mariadb  연결하기 

install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")

library(DBI)
library(rJava)
library(RJDBC)

drv<-JDBC(driverClass = "com.mysql.jdbc.Driver",
          classPath="c:\\works\\mariadb\\mysql-connector-java\\mysql-connector-java-5.1.48-bin.jar" )

conn<-dbConnect(drv, "jdbc:mysql://localhost:3306/mysql", "root", "pass")


query<- "select host, user, password from user"
dbGetQuery(conn, query)












