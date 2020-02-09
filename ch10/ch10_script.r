#########################################################
# 10 . 텍스트 마이닝 (Text mining)
#########################################################
#텍스트마이닝: 문자로 된 데이터에서 가치 있는 정보를 얻어내는 분석 기법
#형태소 분석(Morphology analysis) : 어절에 대한 품사를 파악
# 명사, 동사, 형용사 추출하여 품사의 관계와 
# 문장에서 등장 회수를 계산해서 중요도를 산출

# 텍스트 마이닝 준비하기
# 힙합 음악 가사를 이용해서 텍스트 마이닝을 하는 방법에 대해 알아보겠습니다. 

# 1. 패키지 준비하기 
# KoNLP(Korean Natural Language Processing)을 이용해서 한글 데이터에 대한 형태소 분석을 수행합니다. 
# jdk 가 설치되어 있어야 합니다. 
# 
# jdk 설치:  
# download:
# https://www.java.com/ko/download/manual.jsp

# jdk설치한 후에는 
# 시스템 환경변수 등록을 해야 합니다. 
# JAVA_HOME = c:\programs\jdk1.8.11\...
 
 
 sessionInfo()
 
 #KoNLP 사용
 # 패키지 설치
 install.packages("rJava")
 install.packages("memoise")
 # install.packages("KoNLP")
 install.packages("tm")
 
 install.packages("multilinguer")
 install.packages("https://mran.microsoft.com/snapshot/2017-12-11/bin/windows/contrib/3.4/KoNLP_0.80.1.zip", repos=NULL, type = "binary")
 
 
 # 패키지 로드
 library(rJava)
 library(tm)
 library(multilinguer)
 library(KoNLP)
 library(dplyr)
 
 # Package ‘KoNLP’ was removed from the CRAN repository.
 # 
 # Formerly available versions can be obtained from the archive.
 # 
 # Archived on 2020-02-01 as installation issues were not addressed.
 # https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz
 
 install_deps(".")  
 install_deps("/path/to/package",dependencies="logical")
 
 

 
 # https://rstudio-pubs-static.s3.amazonaws.com/390520_0e53f55571474119b82a059e9dc1403d.html
 Sys.getenv("JAVA_HOME") 
 # java 폴더 경로 설정하기 
 # Sys.setenv(JAVA_HOME="C:\Program Files\Java\jdk1.8.0_121")
 
 
 # > install.packages("C:/Users/sh/Downloads/KoNLP_0.80.2.tar.gz", repos = NULL, type = "source")
 # WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
 #         
 #         https://cran.rstudio.com/bin/windows/Rtools/
 #         ERROR: dependencies 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools' are not available for package 'KoNLP'
 # * removing 'C:/programs/R/R-3.6.2/library/KoNLP'
 # Warning in install.packages :
 #         installation of package ‘C:/Users/sh/Downloads/KoNLP_0.80.2.tar.gz’ had non-zero exit status
 # 
 
 
 # java, rJava 설치
 install.packages("multilinguer")
 # 이때 mac 사용자는 데스크탑 비밀번호를 물어봅니다. 입력해줘야 설치가 진행됩니다.
 library(multilinguer)
 install_jdk()
 # 위 함수에서 에러가 발생하면 알려주세요
 # https://github.com/mrchypark/multilinguer/issues
 
 install.packages(c('hash', 'tau', 'Sejong', 'RSQLite', 'devtools')) 
 # 의존성 패키지 설치
 install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
 ? install.packages
 # 아카이브된 버전의 패키지 설치
 install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz", repos=NULL, type="source")
 
 install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz", repos= NULL, typ="source")
 
 #https://r-forge.r-project.org/R/?group_id=1295
 install.packages("KoNLP", repos="http://R-Forge.R-project.org")
 
 
 # https://cran.rstudio.com/
 install.packages("https://cran-archive.r-project.org/bin/windows/contrib/3.1/KoNLP_0.76.9.zip", repos=NULL, type="source")        
 
 
 #download zip from https://mran.microsoft.com/snapshot/2017-12-11/web/packages/KoNLP/index.html
 # https://mran.microsoft.com/snapshot/2017-12-11/bin/windows/contrib/3.4/KoNLP_0.80.1.zip
 
 
 
 install.packages("multilinguer")
 install.packages("https://mran.microsoft.com/snapshot/2017-12-11/bin/windows/contrib/3.4/KoNLP_0.80.1.zip", repos=NULL, type = "binary")
 
 # download rtoos from https://cran.r-project.org/bin/windows/testing/rtools40.html
 
 # https://cran.r-project.org/bin/windows/Rtools/
 # alternative install
 # install.packages("devtools")
 # devtools::install_github('haven-jeon/KoNLP')
 
 
 # 패키지 로드
 library(rJava)
 library(tm)
 library(KoNLP)
 library(dplyr)
 #library(NLP)
 
 # download https://mran.microsoft.com/snapshot/2017-12-11/web/packages/KoNLP/KoNLP.pdf  
 
 #2.사전설정하기 
 useNIADic()
 
 #======================================================
 # https://ark1st.tistory.com/23
 # 1. 명사 추출
 nones <- extractNones(text.txt)
 
 # 2. 사전 선택
 
 #시스템 디폴트 사전을 사용합니다.
 useSystemDic()
 #NIA 사전을 사용합니다.
 useNIADic()
 #세종 사전을 사용합니다.
 useSejongDic
 
 # 3. 사전 제작
 #데이터로 자신의 사전을 만들수도 있습니다.
 buildDictionary()
 
 # 4. 자음 모음 추출
 #자모 추출
 is.jamo()
 #자음 추출
 is.jaeum()
 #모음 추출
 is.moeum()
 #======================================================
 
 
 
 # 4. 사전설정하기
 useNIADic()
 
 # 5. 데이터준비하기 
 # download  hiphop.txt  from  http://bit.ly/doit_rd  paste to ../datas/
 # 멜론 차트 랩/힙합 상위 50곡의 가사
 
 # 데이터 불러오기
 txt<-readLines("../datas/hiphop.txt")
 head(txt)
 
 View(txt)
 
 
 
 install.packages("readxl")
 library(readxl)
 
# 멜론차트 2017년 3월 둘째 주  -랩/힙합
songlist <-read_excel("../datas/SongList.xlsx")
head(songlist)


# 6 .특수문자 제거하기 
# 문자처리 패키지 stringr
# 특수문자를 빈칸으로 수정

.libPaths()
install.packages("stringr")
library(stringr)
#특수문자 제거
txt2 <- str_replace_all(txt, "\\W", " ")
        head(txt2) 
head(txt, 20)
head(txt2, 20)

###############
# 가장 많이 사용된 단어 알아보기
# 힙합 가사에 어떤 단어가 많이 사용되었는지 알아보겠습니다. 

# 1. 명사 추출하기 
sentences1<-"대한민국의 영토는 한반도와 그 부속도서로 한다"
extractNoun(sentences = sentences1,  autoSpacing = T)
extractNoun(sentences1)

# 2. 힙합 가사에서 명사를 추출, 각각의 단어가 몇 번씩 사용되었는지 빈도표 생성

#----------------------------------
# 리스트 참고
# https://dsmoon.tistory.com/entry/R언어4리스트
#----------------------------------
# unlist() 함수는 리스트를 벡터로 변환해준다.
?unlist

j<-list(name="Joe", salary=55000, union=T)
View(j)
str(j)
names(j)

uj <-unlist(j)
View(uj)
str(uj)


l1 <- list(a = "a", b = 2, c = pi+2i)
unlist(l1) # a character vector
l2 <- list(a = "a", b = as.name("b"), c = pi+2i)
unlist(l2) # remains a list


# https://freshrimpsushi.tistory.com/688
# unique() 함수는 배열에서 중복되는 원소를 모두 제거하고 하나씩만 남긴다
x<-list(A=c(3,2,5,3),B=c(2.2,5,3,2.0)); x
unlist(x)
unique(unlist(x))
#----------------------------------

# extractNoun() 출력결과를 리스트 형태로 반환합니다. 
# table()은 빈도테이블로 변환해 줍니다. 
# 리스트 335p

# 가사에서 명사 추출
nouns<- extractNoun(txt)
# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
ul_nouns<-unlist(nouns)
View(ul_nouns)
wordcount <-table(ul_nouns)
str(wordcount)
View(wordcount)

#데이터 프레임으로 변환
df_word<-as.data.frame(wordcount, stringsAsFactors = F)
View(df_word)
head(df_word)
#변수명 수정
df_word<-rename(df_word, word=Var1, freq=Freq)
head(df_word)

# 3. 자주 사용된 단어 빈도표 만들기
# 두 글자 이상에서 단어의미를 찾을 수 있으므로 
# 두 글자 이상으로 된 단어를 추출합니다. 
df_word<-filter(df_word, nchar(word) >=2)
#----------------------
? nchar() # Count the Number of Characters (or Bytes or Width)
# example:
x <- c("asfef", "qwerty", "yuiop[", "b", "stuff.blah.yech")
nchar(x)
#----------------------

# 4. 빈도 순으로 정렬 후 상위 20개 단어 추출
top_20<-df_word %>%
        arrange(desc(freq)) %>% 
        head(20)
top_20

head(top_20)

#--------------------------------
# 워드 클라우드 만들기 p270
#--------------------------------
# 1. 패키지 준비하기 
# 2. 단어 색상 목록 만들기
# 3. 난수 고정하기 
# 4. 워드 클라우드 만들기


# 1. 패키지 준비하기 
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

# 2. 단어 색상 목록 만들기
# Dark2 색상 목록에서 8개 색상 추출(hex color code)
pal<-brewer.pal(8, "Dark2")
pal
# [1] "#1B9E77" "#D95F02" "#7570B3" "#E7298A" "#66A61E" "#E6AB02" "#A6761D"
# [8] "#666666"

# 3. 난수 고정하기 
# 매번 다른 모양의 워드 클라우드를 생성합니다. 
set.seed(1234)

# 4. 워드 클라우드 만들기
# wordclound()의 설정 내용과 뷰어창의 크기에 따라 보여지는 클라우드 모양 결정
wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색깔 목록

# 많이 사용된 단어는 가운데 배치되고 글자 폰트도 크게 적용
top_20<-df_word %>%
        arrange(desc(freq)) %>% 
        head(20)
top_20

head(top_20)


# 5. 단어 색상 바꾸기
# 파란색 계열의 색상목록, 
# 빈도가 높을수록 진한 파란색으로 표현
# Blues 색상에서 9개의 색상코드 추출
pal<-brewer.pal(9, "Blues")
pal
#-----------------------------
?brewer.pal
#-----------------------------
# Creates nice looking color palettes especially for thematic maps
## Usage
# brewer.pal(n, name)
# display.brewer.pal(n, name)
# display.brewer.all(n=NULL, type="all", select=NULL, exact.n=TRUE, 
#                    colorblindFriendly=FALSE)
# brewer.pal.info
#-----------------------------

pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성
pal
set.seed(1234)                     # 난수 고정

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 2,            # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(4, 0.3),       # 단어 크기 범위
          colors = pal)            # 색상 목록


#=================================================
# 10-2 국정원 트윗 텍스트 마이닝 p273
#=================================================
# 텍스트 마이닝은 sns(소셜 네트워크 서비스)에 올라온 글에서
# 사람들의 생각의 흐름을 알아보기 위한 목적으로 활용됩니다. 

# 국정원이 대선에 개입한 사실이 밝혀져서 논란이 되었던 2013년 6월 
# 독립 언론 뉴스타파가 인터넷을 통해 공개한 것입니다. 

# 데이터는 국정원 계정으로 작성된 3744개 트윗으로 구성되었습니다. 
# 무작위로 작성되었을 것 같은 트윗 글에서 
# 의도가 분명한 어떤 경향을 발견할 수 있을까요?

# 원본 다운로드:  http://newstapa.tistory.com/598 
# 실습에 사용된 데이터는 일부 정제한 데이터입니다. 

# 관련사항을 먼저 읽어보겠습니다. 
# https://zarodream.tistory.com/29
# [3차] 국정원 추정 트위터 핵심계정 'gubonsu'의 활약상
# https://zarodream.tistory.com/12?category=709257
# [2차] 국정원 추정 트위터 핵심계정 대선관련 트윗 공개 - shore0987
# https://zarodream.tistory.com/8?category=709257
# [1차] 원세훈의 원장님 지시말씀을 오타까지 똑같이 퍼나른 핵심계정 - taesan4

#-------------------------------------
# 국정원 트윗 텍스트마이닝
#-------------------------------------
# 1. 데이터 준비하기
# 2. 단어 빈도표 만들기
# 3. 두글자 이상의 단어추출, 빈도순 정렬, 상위20개 추출
# 4. 단어 빈도 막대 그래프 만들기
# 5. 워드 클라우드 만들기 
# 6. 색상 변경
#-------------------------------------

# 1. 데이터 준비하기
# download twitter.csv  from http://bit.ly/doit_re   save to ../datas/
# 한글로 되어 있는 변수명을 데이터처리가 쉽도록 영문자로 수정
# 특수문자 제거

#데이터로드
twitter<- read.csv("../datas/twitter.csv",
                   header=T,
                   stringsAsFactors = F,
                   fileEncoding = "UTF-8"
                   )
head(twitter)
str(twitter)


#변수명수정
library(dplyr)
twitter_a<-rename(twitter,
               no=번호,
               id=계정이름,
               date=작성일,
               tw=내용
)
head(twitter_a)
str(twitter_a)
View(twitter_a)
#특수문자 제거
# headtwitter_a # 

install.packages("stringr")
library(stringr)
twitter_a$tw<-str_replace_all(twitter_a$tw, "\\W", " ")

head(twitter_a$tw)
View(twitter_a$tw)
# 2. 단어 빈도표 만들기
# 트윗에서 명사추출 -> 각 단어가 몇 번씩 사용되었는지 빈도표를 생성
library(KoNLP)
nouns <-extractNoun(twitter_a$tw)
head(nouns)
str(head(nouns))
View(nouns)

# 추출한 명사목록(list)를 문자열 벡터로 변환
ul_nouns <-unlist(nouns)
head(ul_nouns)
str(ul_nouns)
View(ul_nouns)

#단어별 빈도표 생성
wordcount<-table(ul_nouns)
head(wordcount)
str(wordcount)
View(wordcount)

#데이터프레임으로 변환
df_word<-as.data.frame(wordcount, stringsAsFactors = F)
head(df_word)
str(df_word)

#변수명 수정
df_word<-rename(df_word,
                word=ul_nouns,
                freq=Freq)
str(df_word)

# 3. 두글자 이상의 단어추출, 빈도순 정렬, 상위20개 추출
df_word <-filter(df_word, nchar(word) >=2)
#상위 20개 추출
top20<-df_word %>% 
        arrange(desc(freq)) %>% 
        head(20)
head(top20)


# 상위에 랭킹된 단어를 반복해서 들으면 어떤 생각이 떠오르게 되나요?


# 4. 단어 빈도 막대 그래프 만들기
# ggplot() 을 이용해서 시각화하기

#install.packages("ggplot2")
library(ggplot2)
order<-arrange(top20, freq)$word
head(order)

ggplot(data=top20, aes(x=word, y=freq)) +
        geom_col()+
        coord_flip()+
        scale_x_discrete(limit=order)

ggplot(data=top20, aes(x=word, y=freq)) +
        geom_col()+
        coord_flip()+
        scale_x_discrete(limit=order)+
        geom_text(aes(label=freq), hjust=-0.3)

ggplot(data=top20, aes(x=word, y=freq)) +
        geom_col()+
        coord_flip()+
        scale_x_discrete(limit=order)+
        geom_text(aes(label=freq), hjust=-0.3)+
        ylim(0, 2500)
# 북한에 대한 언급이 가장 많습니다. 


# 5. 워드 클라우드 만들기 
pal<-brewer.pal(8, "Dark2")
set.seed(1234)
wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록


# 6. 색상 변경
pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                     # 난수 고정

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록


#참고자료
# KoNLLP패키지개발자 전희원
# http://freesearch.pe.kr
# KoNLP: https://github.com/haven_jeon/KoNLP
# 양우성의 국정원 의심 계정 트윗 분석
# http://wsyang.com/2013/07/newstapa-leaks
# 슬로우뉴스,  '종북'을 사랑한 트위터들: 국정원 의심 계정 워드 클라우드 제작자 인터뷰:
# http://slownews.kr/12329
# http://wsyang.com/2013/07/newstapa-leaks




 


