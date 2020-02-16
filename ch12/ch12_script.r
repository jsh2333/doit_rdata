##################################################
# ch12 인터랙티브 그래프
##################################################

# 인터랙티브 그래프 (interactive graph): 
# 마우스 움직임에 반응해 실시간으로 형태가 변하는 그래프
# 장점:  자유롭게 조작하면서 관심 부분을 자세히 살펴볼 수 있습니다. 
#  html 포맷으로 저장하면 웹브라우저에서도 같은 동작을 제공하게 됩니다. 

# 12.1  plotly 패키지로 인터랙티브 그래프 만들기
# 12.2  dygraphs 패키지로 인터랙티브 시계열 그래프 만들기

# 보다 많은 인터랙티브 그래프 예제: 
# https://plot.ly/ggplot2 에 접속해보세요.

#================================
# 12.1  plotly 패키지로 인터랙티브 그래프 만들기
#================================
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


#--------------------------------
# 4. html 저장하기
#--------------------------------
# 뷰어-> export-> save as... web page

# html 저장하고 브라우저로 열어보세요

#--------------------------------
# 5. 인터랙티브 막대 그래프 만들기
#--------------------------------

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


# ggplot2내장된 economics 데이터를 사용해서 그래프를 작성합니다. 


? economics
# 실업자, 저축률 등 1967~2015년 미국의 우러별 경제 지표를 담은 데이터입니다. 
# This dataset was produced from US economic time series data available from http://research.stlouisfed.org/fred2. economics is in "wide" format, economics_long is in "long" format.

# A data frame with 478 rows and 6 variables

# date   
#    Month of data collection
# psavert   
#    personal savings rate, http://research.stlouisfed.org/fred2/series/PSAVERT/
# pce   
#    personal consumption expenditures, in billions of dollars, http://research.stlouisfed.org/fred2/series/PCE
# unemploy   
#    number of unemployed in thousands, http://research.stlouisfed.org/fred2/series/UNEMPLOY
# uempmed   
#    median duration of unemployment, in weeks, http://research.stlouisfed.org/fred2/series/UEMPMED
# pop   
#    total population, in thousands, http://research.stlouisfed.org/fred2/series/POP

# 최근 업데이트된 정보를 다운로드 받아서 적용해보세요
# https://fred.stlouisfed.org/

#--------------------------------
# 1. dygraphs 패키지 설치
#--------------------------------
install.packages("dygraphs")
library(dygraphs)


#--------------------------------
# 2. economics 데이터
#--------------------------------
economics <-  ggplot2::economics

head(economics)
summary(economics)


#--------------------------------
# 3. economics 데이터
#--------------------------------
#  시간 순서 속성을 갖는 xts 데이터 타입
#  xts() 를 사용해서 unemploy(실업자수)를 변경할 수 있습니다. 

library(xts)
rm(eco)
eco<- xts(economics$unemploy, order.by = economics$date)

head(eco)
# [,1]
# 1967-07-01 2944
# 1967-08-01 2945
# 1967-09-01 2958
# 1967-10-01 3143
# 1967-11-01 3066
# 1967-12-01 3018
View(eco)
str(eco)
# An ‘xts’ object on 1967-07-01/2015-04-01 containing:
#   Data: num [1:574, 1] 2944 2945 2958 3143 3066 ...
# Indexed by objects of class: [Date] TZ: UTC
# xts Attributes:  
#   NULL



#--------------------------------
# 4. 인터랙티브 시계열 그래프 만들기 
#--------------------------------
# dygraphs 패키지에 있는 dygraph() 를 사용합니다. 
dygraph(eco)
# 그래프의 오른쪽 상단에 날자, V1(실업자수) 표시됩니다. 
# 마우스 포인트 지점에 따라 표시 정보가 바뀝니다. 

# 마우스 드래그를 하여 범위를 설정해보세요


#--------------------------------
# 5. 인터랙티브 시계열 그래프 만들기 
#--------------------------------

dygraph(eco) %>% 
  dyRangeSelector()

# 마우스로 기간 번위를 조정할 수 있습니다. 


#--------------------------------
# 6. 여러 값 표현하기
#--------------------------------
# 동시에 여러 값을 시계열 그래프에 표시할 수 있습니다. 


# unemploy(실업자수), psavert(저축률) 을 표시해보겠습니다. 

# 먼저, 시계열 표시를 하기 위해 unemploy, psavert변수를 xts 타입으로 변환합니다. 
# rm(eco)
# psavert(저축률)
eco_a <- xts (economics$psavert, order.by =  economics$date)

# psavert 와 비교해 보기 쉽도록 1000으로 나누어 100만명 단위로 수정합니다. 
# unemploy(실업자수), 
eco_b <- xts (economics$unemploy/1000, order.by = economics$date)


#--------------------------------
# 7. 여러 값 표현하기
#--------------------------------
# 하나의 변수로 변수를 결합합니다. 
eco2 <-cbind(eco_a, eco_b)
str(eco2)

# 데이터처리를 위해 알아보기 쉽도록 변수명을 바꾸어 놓습니다. 
# eco2는 데이터프레임이 아니라 xts타입이므로 rename()을 적용할 수 없습니다. 
# colnames() 를 사용해서 변수명을 변경할 수 있습니다. 
colnames(eco2) <-c("psavert", "unemploy")
head(eco2)



#--------------------------------
# 8. 여러 값을 표현하는 시계열 그래프 그리기
#--------------------------------

dygraph(eco2) %>% 
  dyRangeSelector()


# 참고
# plotly ggplot2 library
#   https://plot.ly/ggplot2
# dygraphs for R
#   http://rstudio.github.io/dygraphs























