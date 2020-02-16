###################################################
# ch11 지도 시각화
###################################################

#-----------------------
# *지도에 지역별 특성을 
#  색깔로 표현한 단계 구분도를 만드는 방법을 학습합니다.
#-----------------------
# 순서: 
# 11-1 미국 주별 강력 범죄율 단계 구분도 만들기
# 11-2 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기

# 단계구분도 (choropleth map) - 지역별 통계치를 색깔의 차이로 표현한 지도
# 인구, 소득 특성이 지역별로 구분되는 차이를 쉽게 알아볼 수 있다. 

##
# 11-1 미국 주별 강력 범죄율 단계 구분도 만들기
##
# 미국의 주(State)별 강력 죄율 데이터로부터 단계 구분도를 만들어봅니다.

#------------------------------------
# 1. 패키지 준비하기 
#------------------------------------
#- 단계구분도를 사용하기 위한 패키지 설치
install.packages("ggiraphExtra")
library(ggiraphExtra)

#------------------------------------
# 2. 미국 주별 범죄 데이터 준비하기
#------------------------------------
# R에 내장되어 있는 USArrests 데이터
# 1973년 미국 주(State)별 강력 범죄율 정보

str(USArrests)
# > str(USArrests)
# 'data.frame':	50 obs. of  4 variables:
#   $ Murder  : num  13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
# $ Assault : int  236 263 294 190 276 204 110 238 335 211 ...
# $ UrbanPop: int  58 48 80 50 91 78 77 72 80 60 ...
# $ Rape    : num  21.2 44.5 31 19.5 40.6 38.7 11.1 15.8 31.9 25.8 ...

?USArrests
# This data set contains statistics, in arrests per 100,000 residents for assault, murder, and rape in each of the 50 US states in 1973. Also given is the percent of the population living in urban areas.

# Format
# A data frame with 50 observations on 4 variables.
# 
# [,1]	Murder	numeric	Murder arrests (per 100,000)
# [,2]	Assault	numeric	Assault arrests (per 100,000)
# [,3]	UrbanPop	numeric	Percent urban population
# [,4]	Rape	numeric	Rape arrests (per 100,000)

# Examples
summary(USArrests)

require(graphics)
pairs(USArrests, panel = panel.smooth, main = "USArrests data")

## Difference between 'USArrests' and its correction
USArrests["Maryland", "UrbanPop"] # 67 -- the transcription error

UA.C <- USArrests
UA.C["Maryland", "UrbanPop"] <- 76.6

## also +/- 0.5 to restore the original  <n>.5  percentages
s5u <- c("Colorado", "Florida", "Mississippi", "Wyoming")
s5d <- c("Nebraska", "Pennsylvania")
UA.C[s5u, "UrbanPop"] <- UA.C[s5u, "UrbanPop"] + 0.5
UA.C[s5d, "UrbanPop"] <- UA.C[s5d, "UrbanPop"] - 0.5

## ==> UA.C  is now a *C*orrected version of  USArrests

head(USArrests)

View( USArrests)

#------------------------------------
# 3. 전처리
#------------------------------------
# USArrests 데이터에는 지역명 변수가 없습니다. 
# 각각의 행이름이 지역명(State)으로 되어 있습니다. 
# 변수명을 state 로 정해 놓겠습니다. 
# 이 때 tibble 패키지에 있는 rownames_to_column()을 사용합니다. 
# 뒤에서 지도 데이터 지역명 변수를 소문자로 표시하게 되므로 state의 값을 소문자료 변경합니다.
# tibble 패키지는 dplyr 설치시 함께 설치됩니다. 
# 
library(tibble)
crime<-rownames_to_column(USArrests, var="state")
crime$state<-tolower(crime$state)
head(crime)

# USArrests 데이터가 생긴 모양이 data frame이므로 
crime2<-as.data.frame(USArrests)
head(crime2)
# "dplyr" 파이프라인을 사용해서 변환해도 되겠습니다. 
library(dplyr)
crime2 <- USArrests %>%
  rownames_to_column(var = "state") %>%
  mutate(state = tolower(state))
head(crime2)

str(crime)

#------------------------------------
# 4. 미국의 주 지도 데이터 준비하기
#------------------------------------
# 단계구분도를 만들기 위해서는 
# 지역별 위도, 경도 정보가 있는 지도 데이터가 필요합니다. 
# maps 패키지에 미국의 주별 위경도를 나타낸 state 데이터가 들어 있습니다. 
# map_data() 를 이용해서 데이터프레임 형태로 불러옵니다.
# 이 때 map_data()는 ggplot2패키지에 들어 있습니다. 

library(ggplot2)
states_map<-map_data("state")
# > states_map<-map_data("state")
# 에러: Package `maps` required for `map_data`.
# Please install and try again.

install.packages("maps")
states_map<-map_data("state")

str(states_map)

library(ggplot2)
states_map <- ggplot2::map_data("state")
str(states_map)

#------------------------------------
# 5. 단계 구분도 만들기
#------------------------------------
# 범죄데이터->지도데이터->단계구분도 생성
summary(crime)
str(crime)
summary(states_map)

# ggiraphExtra 패키지에 있는 ggChoropleth()를 사용해서 단계구분도생성합니다.
# fill = Murder 살인범죄 건수를 색상으로 표시
# map_id = state 지역기준을 state로 연결해놓습니다. 
crime$state
crime$Murder
states_map$region

library(ggiraphExtra)

ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map)     # 지도 데이터
# Error in loadNamespace(name) : ‘mapproj’이라고 불리는 패키지가 없습니다

# 공간지도를 그리기 위한 패키지가 필요해서 나오는 오류입니다. 
# mapdata에 대한 패키지를 설치하면 오류가 사라집니다. 

# mapdata패키지 : latitude and longitude
install.packages("mapproj")
library(mapproj)

#------------------------------------
# 6. 인터랙티브 단계 구분도 만들기
#------------------------------------
ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map,     # 지도 데이터
             interactive = T       # 인터랙티브
)
# 지도 위에 마우스 커서를 올려 놓으면 인터랙티브의 의미를 알게됩니다. 

# html포맷으로 저장해서 사용할 수 있습니다. 
# Export -> save as web page...
# USArrests.html 으로 저장해보세요.
# 브라우저로 html파일을 열어보세요
# editor로 html파일을 열어보세요
# 마우스 휠을 움직여서 지도의 특정 영역을 확대, 축소할 수 있습니다. 
# 




# 11-2 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기

# 대한민국 우리나라의 인구통계 데이터를 
# 우리나라 지도위에 단계구분도를 만들겠습니다. 

# 우리나라 지도는 kormaps2014패키지를 사용합니다. 

#------------------------------------
# 1. 패키지 준비하기 
#------------------------------------
#------------------------------------
# 2. 대한민국 시도별 인구 데이터 준비하기
#------------------------------------
#------------------------------------
# 3. 전처리 -  변수명은 영문자로 변경합니다.
#------------------------------------
#------------------------------------
# 4. 대한민국 시도 지도 데이터 준비하기 
#------------------------------------
#------------------------------------
# 5. 단계 구분도 만들기
#------------------------------------

# 1~5단계로 작성하겠습니다. 

#------------------------------------
# 1. 패키지 준비하기 
#------------------------------------
# 패키지 개발자가 github에서 공유한 kormaps2014 패키지를 설치합니다.

install.packages("stringi")
# stringi: Character String Processing Facilities
# https://mran.microsoft.com/snapshot/2017-02-20/web/packages/stringi/index.html

install.packages("devtools")
# devtools: Tools to Make Developing R Packages Easier
# https://cran.r-project.org/web/packages/devtools/index.html

devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)

# github주소를 찾아가서 읽어보겠습니다. 
# https://github.com/cardiomoon/kormaps2014/blob/master/DESCRIPTION
# Package: korPackage: kormaps2014
# Type: Package
# Title: A dataset about Korean Administrative Area(2014) With Korean population census data(2015)

# 대부분의 패키지는 cran에 등록되어 배포됩니다. 
# 일부는 github, git, gitlab을 통해 배포되기도 합니다. 
# github 배포된 패키지를 다운로드 받기 위해서 devtools 패키지를 설치하고
# devtools::install_github() 를 사용해서 주소를 연결해서 설치했습니다. 


#------------------------------------
# 2. 대한민국 시도별 인구 데이터 준비하기
#------------------------------------

# 시도별 인구통계 정보가 담겨있는 korpop1 데이터를 사용해서 
# 시도별 인구 단계구분도를 만들겠습니다.
# korpop1  2015년 센서스 데이터 (시도별)
# korpop2  2015년 센서스 데이터 (시군구별)
# korpop3  2015년 센서스 데이터 (읍면동별)

 

# korpop1데이터의 인코딩이 UTF-8로 되어 있어 한글문자가 깨져 보인다. 
# changeCode()를 사용해서 CP949로 변환
View(korpop1)
View(changeCode(korpop1))
str(changeCode(korpop1))

# > korpop1
# C행정구역별_읍면동                행정구역별_읍면동 <ec>떆<ec>젏 총인구_명
# 5                   '11         <ec>꽌<ec>슱<ed>듅蹂꾩떆         2015   9904312
# 455                 '21       遺\u0080<ec>궛愿묒뿭<ec>떆         2015   3448737
# 681                 '22 <eb><8c>\u0080援ш킅<ec>뿭<ec>떆         2015   2466052
# 832                 '23         <ec>씤泥쒓킅<ec>뿭<ec>떆         2015   2890451
# 995                 '24               愿묒＜愿묒뿭<ec>떆         2015   1502881

# str(korpop1)
# 'data.frame':	17 obs. of  25 variables:
#   $ C행정구역별_읍면동     : chr  "'11" "'21" "'22" "'23" ...
# $ 행정구역별_읍면동      : chr  "서울특별시" "부산광역시" "대구광역시" "인천광역시" ...
# $ 시점                   : chr  "2015" "2015" "2015" "2015" ...
# $ 총인구_명              : chr  "9904312" "3448737" "2466052" "2890451" ...
# $ 남자_명                : chr  "4859535" "1701347" "1228511" "1455017" ...
#------------------------------------
# 3. 전처리 -  변수명은 영문자로 변경합니다.
#------------------------------------
library(dplyr)

# 총인구_명, 행정구역별_읍면동을 pop, name 으로 변경합니다. 
korpop1<-rename(korpop1, 
                pop=총인구_명,
                name=행정구역별_읍면동)
View(changeCode(korpop1))
rm(korpop1)
# "dplyr" 사용하는 방법
library(dplyr)

korpop1 <- korpop1 %>%
  rename(pop  = 총인구_명,
         name = 행정구역별_읍면동)
View(changeCode(korpop1))
korpop1<-changeCode(korpop1)
View(korpop1)
#------------------------------------
# 4. 대한민국 시도 지도 데이터 준비하기 
#------------------------------------

# # kormaps2014 패키지에 내장된 지도데이터
# kormap1  2014년 한국 행정 지도 (시도별)
# kormap2  2014년 한국 행정 지도 (시군구별)
# kormap3  2014년 한국 행정 지도 (읍면동별)

# 시도별 위도, 경도 정보를 담고 있는 kormap1 지도 데이터를 사용합니다. 

# korpop1마찬가지로 인코딩을 CP949로 변환해서 사용합니다. 
str(changeCode(kormap1)) 

#------------------------------------
# 5. 단계 구분도 만들기
#------------------------------------
# 시도별 인구변수 korpop1
# 시도별 위도,경도 데이터 kormap1 을 사용하여 단계 구분도를 작성합니다. 
# 지도 위에 마우스 커서를 올리면 해당 지역인구, 지역명이 표시됩니다. 
library(ggplot2)
library(dplyr)
library(ggiraphExtra)
ggChoropleth(data = korpop1,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code),    # 지역 기준 변수
                 # tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
             interactive = T)        # 인터랙티브

# code로 되어 있어서 지역을 알기 어렵습니다. 
# code대신에 name을 사용해서 지역명을 표시되도록 tooltip에 name을 지정합니다. 
korpop1<-changeCode(korpop1)
View(changeCode(korpop1))

#options(encoding="UTF-8")
#options(encoding="CP949")
View(korpop1)
ggChoropleth(data = korpop1,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
             interactive = T)        # 인터랙티브
# name에 대한 한글이 깨져서 보입니다. 


##
# 다시 정리해서 동작시켜보겠습니다. 
rm(korpop1)

install.packages(c("stringi", "devtools"))
devtools::install_github("cardiomoon/kormaps2014")
library(DT)
library(kormaps2014)
#시도별인구데이터
str(changeCode(korpop1))
# 지도 데이터
str(changeCode(kormap1))
korpop1 <- rename(korpop1,
                  year = 시점,
                  pop  = 총인구_명,
                  name = 행정구역별_읍면동)
View(korpop1)
View(changeCode(korpop1))
ggChoropleth(data = korpop1,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
             interactive = T)        # 인터랙티브

#---------------------------------------------------
# 대한민국 시도별 결핵 환자 수 단계 구분도 만들기
#---------------------------------------------------
# kormaps2014 패키지에서 포함하고 있는 결핵데이터 
# 지역별 결핵 환자 수에 대한 정보 -> tbc 데이터
# 결핵 환자수는 NewPts 변수에서 나타냅니다. 

# 시도별 결핵 환자 수를 단계구분도를 사용해서 표시해보세요

View(tbc)
View(changeCode(tbc))
str(changeCode(tbc))
# 'data.frame':	255 obs. of  5 variables:
#   $ name1 : chr  "강원" "경기" "경남" "경북" ...
# $ code  : chr  "32" "31" "38" "37" ...
# $ name  : chr  "강원도" "경기도" "경상남도" "경상북도" ...
# $ year  : chr  "2001" "2001" "2001" "2001" ...
# $ NewPts: chr  "1396" "4843" "1749" "2075" ...

? tbc
# New patients with tubeculsosis in South Korea
# name1  abbreviation of area
# code  Korean administative area code
# name  Korean administative area, level 1
# year  year
# NewPts  Number of new patients
ggChoropleth(data=tbc,   # 지도에 표현할 데이터
             aes(fill=NewPts, #색깔로 표현할 변수
                 map_id = code, #지역기준 변수
                 tooltip = name # 지도 위에 표시할 지역명
             ),
             map=kormap1, #지도데이터
             interactive = T #인터랙티브 적용
)

tbc_en<-changeCode(tbc)
View(tbc_en)
View(kormap1)
ggChoropleth(data=tbc_en,   # 지도에 표현할 데이터
             aes(fill=NewPts, #색깔로 표현할 변수
              map_id = code, #지역기준 변수
              tooltip = name # 지도 위에 표시할 지역명
                 ),
            map=kormap1, #지도데이터
            interactive = T #인터랙티브 적용
             )

# 참고
# [1] introduction to package ggiraphExtra
#     http://rpubs.com/cardiomoon/231820
# [2] 한국 행정지도(2014)패키지 kormaps2014 안내
#     http://rpubs.com/cardiomoon/222145