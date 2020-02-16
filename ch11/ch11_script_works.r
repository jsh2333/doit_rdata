#################################
# ch11 지도 시각화
#################################
#단계구분도 사용시 필요 패키지
#-----------------------
# 1. 패키지 설치
#-----------------------



install.packages("ggiraphExtra")
library(ggiraphExtra)
??ggiraphExtra

library(tibble)
crime <- rownames_to_column(USArrests, var="state")
? rownames_to_column
## rownames 가 붙어 있는 경우?
# has_rownames(crime)
# has_rownames(mtcars)
# head(mtcars)
# has_rownames(iris)

crime$state <- tolower(crime$state)
head( crime)
str(crime)




#----------------------------
# map_data
#----------------------------
install.packages("maps")
library(maps)

library(ggplot2)
states_map<-map_data("state")
ggChoropleth(data=crime, 
             aes(fill = Murder,
                 map_id = state
                 ),
             map = states_map
             )
# 인터렉티브 그래픽 표현
ggChoropleth(data=crime, 
             aes(fill = Murder,
                 map_id = state
             ),
             map = states_map, 
             interactive = T # 인터랙티브 
             )


? map_data
#Examples
if (require("maps")) {
  states <- map_data("state")
  arrests <- USArrests
  names(arrests) <- tolower(names(arrests))
  arrests$region <- tolower(rownames(USArrests))
  
  choro <- merge(states, arrests, sort = FALSE, by = "region")
  choro <- choro[order(choro$order), ]
  ggplot(choro, aes(long, lat)) +
    geom_polygon(aes(group = group, fill = assault)) +
    coord_map("albers",  at0 = 45.5, lat1 = 29.5)
}

if (require("maps")) {
  ggplot(choro, aes(long, lat)) +
    geom_polygon(aes(group = group, fill = assault / murder)) +
    coord_map("albers",  at0 = 45.5, lat1 = 29.5)
}

glimpse(USArrests)

str(USArrests)
apply(USArrests, 2, mean)
apply(USArrests, 2, var)
?apply
colSums(is.na(USArrests))
# corrplot(cor(USArrests), order = "hclust")

? USArrests
? ggChoropleth
#Example
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
head(crimes)
require(ggplot2)
require(ggiraph)
require(maps)
require(mapproj)
require(reshape2)
require(RColorBrewer)
states_map <- map_data("state")
head(states_map)
#Ex1
ggChoropleth(crimes,aes(fill=Murder,map_id=state),map=states_map,interactive=TRUE)
#ex2
ggChoropleth(crimes,aes(fill=c(Murder,Rape),map_id=state),map=states_map,interactive=TRUE)
#ex3
ggChoropleth(crimes,aes(map_id=state),map=states_map,palette="OrRd",interactive=TRUE)
#----------------------------------
# 단계 구분도 만들기
#11-2 대한민국 시도별 인구, 결핵 환자 수 
#----------------------------------
install.packages("stringi")
? stringi

install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)
# 시도별 인구통계 정보가 담겨있는 korpop1 데이터를 사용해서 
# 시도별 인구 단계구분도를 만들겠습니다.
# korpop1  2015년 센서스 데이터 (시도별)
# korpop2  2015년 센서스 데이터 (시군구별)
# korpop3  2015년 센서스 데이터 (읍면동별)

# # kormaps2014 패키지에 내장된 지도데이터
# kormap1  2014년 한국 행정 지도 (시도별)
# kormap2  2014년 한국 행정 지도 (시군구별)
# kormap3  2014년 한국 행정 지도 (읍면동별)

# korpop1데이터의 인코딩이 UTF-8로 되어 있어 한글문자가 깨져 보인다. 
View(korpop1)

# changeCode()를 사용해서 CP949로 변환 
View(changeCode(korpop1))
str(changeCode(korpop1))
head(changeCode(korpop1))

library(dplyr)
korpop1_ren <-rename( korpop1,
                      pop=총인구_명,
                      name=행정구역별_읍면동
             )

head(korpop1_ren)
View(korpop1_ren)
View(changeCode(korpop1_ren))
#-----------------------------------
#4. 대한민국 시도 지도 데이터 준비
#-----------------------------------
kormap1
str(kormap1)
View(kormap1)
View(changeCode(kormap1))

head(korpop1_ren)
ggChoropleth(data=korpop1_ren, 
             aes(fill=pop, map_id=code),
             map=kormap1,
             interactive = T
             )
View(korpop1_ren)
ggChoropleth(data=korpop1_ren, 
             aes(fill=pop, map_id=code, tooltip =  name),
             map=kormap1,
             interactive = T
)

# ggChoropleth() 단계 구분도의 한글이 깨진다면
options(encoding ="UTF-8")
ggChoropleth(data=korpop1_ren, 
             aes(fill=pop, map_id=code, tooltip =  name),
             map=kormap1,
             interactive = T
)
options(encoding ="CP949")
#---------------------------------
# 단계 구분도 작성
# 대한민국 시도별 결핵 환자수 
#---------------------------------
# 결핵자 수 데이타": tbc (kormaps2014 패키지에 포함되어있음)
# 결핵 환자 수:  NewPts
head(kormap1)
head(changeCode(kormap1))
View(tbc)
View(changeCode(tbc))
ggChoropleth( data = tbc, 
              aes(fill=NewPts, map_id = code, tooltip = name),
              map = kormap1, 
              interactive = T
              )


# 참고
# [1] introduction to package ggiraphExtra
#     http://rpubs.com/cardiomoon/231820
# [2] 한국 행정지도(2014)패키지 kormaps2014 안내
#     http://rpubs.com/cardiomoon/222145



