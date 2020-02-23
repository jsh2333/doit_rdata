#################################################
# crawling examples
#################################################
#  
#------------------------------------------------------------------------
# EX1 scrapping .....
#------------------------------------------------------------------------
install.packages("XML")
install.packages("plyr")
library(XML)
library(plyr)

URL <- 'https://ko.wikipedia.org/wiki/위키백과'

# URL <- 'https://ko.wikipedia.org/wiki/%EC%9C%84%ED%82%A4%EB%B0%B1%EA%B3%BC'


get0 <- httr::GET(URL)

html0 <- XML::htmlParse(get0,encoding='UTF-8')
html0

#html DOM구조에서 html -> body -> div1, div2, div3
#->div3번째에 있는 div1, div2, div3, div4
#->div4에 속해 있는 div
#->div에 속해있는 p태그의 첫번째, 두번째
#->p태그의 두번째 를 xpath1로 잡고 xml파싱해서 값을 가져온다. 
xpath1 <- '/html/body/div[3]/div[3]/div[4]/div/p[2]'

data1<-xpathSApply(html0,xpath1,xmlValue)
View(data1)
#xmlValue


xpath2 <- '/html/body/div[3]/div[3]/div[4]/div[1]/table/tbody/tr[9]'
xpathSApply(html0,xpath2,xmlValue)


#------------------------------------------------------------------------
##
# 실행결과
#
# > xpath1 <- '/html/body/div[3]/div[3]/div[4]/div/p[2]'
# > xpathSApply(html0,xpath1,xmlValue)
# [1] "위키백과는 자유 저작물을 보유하고 상업적인 광고가 없으며 주로 기부금을 통해 지원을 받는 비영리 단체인 위키미디어 재단에 의해 소유되고 지원을 받고 있다.[4][5][6][7] 2020년 기준으로 영어판 600만여 개, 한국어판 484,345개를 비롯하여 300여 언어판을 합하면 4천만 개 이상의 글이 수록되어 꾸준히 성장하고 있으며 앞으로 더 성장할 예정이다.[8] 위키백과의 저작권은 크리에이티브 커먼즈 라이선스(CCL)와 GNU 자유 문서(GFDL)의 2중 라이선스를 따른다. 두 라이선스 모두 자유 콘텐츠를 위한 것으로 일정한 요건을 갖추면 사용에 제약을 받지 않는다.\n"


#------------------------------------------------------------------------
# EX2 scrapping .....
#------------------------------------------------------------------------

# 셀레니움을 이용한 javascript로 만들어진 동적 웹페이지 크롤링
# http://henryquant.blogspot.com/search?updated-max=2019-11-15T14:29:0%2B09:00&max-results=1&pgno=1

# 설치
# 1) selenium: https://www.seleniumhq.org/download/
# https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd
# download:   selenium-server-standalone-3.141.59.jar
# 2) geckodriver: https://github.com/mozilla/geckodriver/releases/tag/v0.17.0
# download:   geckodriver-v0.17.0-win64.zip
# 3) chromeDriver: https://sites.google.com/a/chromium.org/chromedriver/downloads
# download:   chromedriver.exe
# 

# C:\Rselecnium  폴더를 만들고 위 3개의 파일을 넣어두고 다음 java 명령어를 실행합니다. 
# C:\Rselenium>java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.141.59.jar -port 4445

# 05:03:04.214 INFO [GridLauncherV3.parse] - Selenium server version: 3.141.59, revision: e82be7d358
# 05:03:04.315 INFO [GridLauncherV3.lambda$buildLaunchers$3] - Launching a standalone Selenium Server on port 4445
# 2020-02-23 05:03:04.375:INFO::main: Logging initialized @588ms to org.seleniumhq.jetty9.util.log.StdErrLog
# 05:03:04.636 INFO [WebDriverServlet.<init>] - Initialising WebDriverServlet
# 05:03:05.211 INFO [SeleniumServer.boot] - Selenium Server is up and running on port 4445

# 실행창은 열어두고 있으세요.

# 셀레니움 관련 패키지인 RSelenium와 seleniumPipes를 인스톨 한 후, 
# 관련 패키지들을 열어줍니다.
install.packages('RSelenium')
install.packages('seleniumPipes')
library(RSelenium)
library(seleniumPipes)
library(rvest)
library(httr)


# remoteDriver() 함수를 통해 4445번 포트와 크롬을 연결
remDr = remoteDriver(
  remoteServerAddr="localhost",
  port=4445L,
  browserName="chrome")

# 브라우저 오픈
remDr$open()

?remoteDriver

# # remDr$navigate("url") - 크롤링하고자 하는 사이트 주소를 입력하면 해당 주소로 이동합니다.
remDr$navigate('https://finance.naver.com/item/coinfo.nhn?code=005930&target=finsum_more')
#"자동화된 테스트 소프트웨어에 의해 제어되고 있습니다 " 라는 문구가 보입니다.

# 수집할 데이터를 찾습니다.
#Financial Summary에 해당하는 부분을 찾아나갑니다.

# 해당 페이지는 iframe 내부에서 javascript를 통해 타 페이지의 데이터가 들어와있는 형태이므로, 
# 해당 iframe 내부로 접근해야 합니다.
# ID 찾아내기
?remDr$findElement
frames = remDr$findElements(using = "id",
                            value = 'coinfo_cp')

# 이 외에도 xpath, css selector 등 다양한 html 태그를 통해 원하는 html 정보를 검색


print(frames)



# Frame 안으로 접근
remDr$switchToFrame(frames[[1]])


# remDr$findElements() 함수는 원하는 요소로 접근이 가능합니다. 

# 연간 재무제표 이므로, [연간]에 해당하는 탭의 위치를 찾은 후 Xpath를 복사합니다. 
# 해당 위치는 다음과 같습니다.

# //*[@id="cns_Tab21"]

# 연간 클릭
remDr$findElement(using = 'xpath',
                  value ='//*[@id="cns_Tab21"]')$clickElement()

# # 분기 클릭
# remDr$findElement(using = 'xpath',
#                   value ='//*[@id="cns_Tab21"]')$clickElement()


# 페이지 소스를 읽어오기
page_parse = remDr$getPageSource()[[1]]
# HTML 정보만을 읽어옵니다.
page_html = page_parse %>% read_html()

# 재무제표 데이터가 들어있는 테이블 추출
# 로케일 언어를 English로 변경
Sys.setlocale('LC_ALL', 'English')
# html_table() 함수를 통해 테이블 데이터만 추출
table = page_html %>% html_table(fill = TRUE)
View(table) # -- 재무제표값은 [14] 번에 들어가 있습니다.
Sys.getlocale()
# 다시 로케일 언어를 Korean으로 변경
Sys.setlocale('LC_ALL', 'Korean')


df = table[[14]]
View(df)
head(df)
# -------------- 찾으려는 데이터 선택이 되고 데이터를 읽어왔나요? ------------------------
library(stringr)
library(magrittr)

rownames(df) = df[, 1]

df = df[, -1]

colnames(df) = df[1, ]
df = df[-1, ]

colnames(df) = str_sub(colnames(df), 1, 7)

df = sapply(df, function(x) {
  str_replace_all(x, ',', '') %>%
    as.numeric()
}) %>%
  data.frame(., row.names = rownames(df))

View(df)
head(df)

#-----------------
# (단계별로 변수 이름을 만들고 변경사항을 비교해보겠습니다.)

library(stringr)
library(magrittr)
? magrittr


# 첫번째 열을 행이름으로 설정한 후, 해당 열을 삭제합니다.
rownames(df) = df[, 1]
df_1 = df[, -1]
View(df_1)
# 첫번재 행을 열이름으로 설정한 후, 해당 행을 삭제합니다.
colnames(df_1) = df_1[1, ]
df_2 = df_1[-1, ]
View(df_2)
# 열이름에서 str_sub() 함수를 이용해 1~7번째 글자만 선택합니다. (YYYY/MM)
colnames(df_2) = str_sub(colnames(df_2), 1, 7)


# sapply() 함수 내에서 str_replace_all() 함수를 이용해 모든 콤마(,)를 없앤 후 숫자 형태로 변경합니다.
?sapply
df_3 = sapply(df_2, function(x) {
  str_replace_all(x, ',', '') %>%
    as.numeric()
}) %>%
  data.frame(., row.names = rownames(df_2))

head(df_3)
View(df_3)



# R을 이용한 데이터로 투자하기 - (1) 거래소 데이터 크롤링
# http://henryquant.blogspot.com/2019/01/r-1.html
# R을 이용한 데이터로 투자하기 - (2) 데이터 정리 및 변형하기
# http://henryquant.blogspot.com/2019/01/r-2_25.html


#---------------------------------------------

##
# scrapping music information from wikipedia
# Blog : http://apple-rbox.tistory.com
# R을 이용해서 
# 위키피디아에 있는 빌보드 상위 100곡(year-end hot-100)의 정보와 
# 하이퍼링크를 가져오는 예제

#-----------------------------------------------------
install.packages("XML")
install.packages("dplyr")
install.packages("rvest")



sapply(c('dplyr', 'XML', 'rvest'), require, character.only=T)

# https://rpubs.com/SungHwan/564034


#------------------------------------------------------------------------
# EX2 scrapping ....네이버뉴스
#------------------------------------------------------------------------
# 1) 네이버뉴스페이지URL
# 2) 네이버뉴스페이지에서 기사 링크 URL 수집
# 3) 기사 페이지별로 기사 내용 크롤링

# 1) 네이버뉴스페이지URL
https://news.naver.com/main/list.nhn?mode=LS2D&mid=shm&sid1=105&sid2=230


# 2) 네이버뉴스페이지에서 기사 링크 URL 수집
# 3) 기사 페이지별로 기사 내용 크롤링




#------------------------------------------------------------------------
# EX2 scrapping .....
#------------------------------------------------------------------------
install.packages("httr")
install.packages("stringr")
library(httr)
library(stringr)

#front <- 'https://news.joins.com/article/' # 중앙일보 
front <- "https://news.joins.com/article/23712907?cloc=joongang-home-newslistleft"
startPoint <- 22248999
endPoint <- 22249100
times <- 0
fileDir <- 'c:\\temp\\r_crawl\\'
fileNumber <- 1

while(startPoint != endPoint){
  tryCatch({
    URL <- paste(front,as.character(startPoint),sep='')
    get <- GET(URL)
    html <- htmlParse(get, encoding= 'UTF-8')
    head_xpath <- '//*[@id="article_title"]'
    body_xpath <- '//*[@id="article_body"]'
    
    #입력일
    # date_xpath <- '/html/body/div[2]/div[2]/div[11]/div[1]/div[2]/div[1]/em[2]'
    date_xpath <- '/html/body/div[3]/div[3]/div[1]/div[8]/div[1]/div[2]/div[1]/em[2]'
    
    
    article_title <- trimws(gsub(',',' ',gsub('\n','',xpathSApply(html,head_xpath,xmlValue))))
    article_date <- trimws(gsub(',',' ',xpathSApply(html,date_xpath,xmlValue)))
    article_body <- trimws(gsub(',',' ',gsub('\n','',xpathSApply(html,body_xpath,xmlValue))))
  }
  ,
  error = function(e){
    print('Not Found')
    article_title <<- 'NULL_TITLE'
    article_date <<- 'NULL_DATE'
    article_body <<- 'NULL_BODY'
    
  }
  )
  cat(startPoint,',',
      article_title,",",
      article_date,',',
      article_body,'\n',
      file=paste(fileDir,fileNumber,'.txt',sep=''),
      append=T)
  
  if(times %% 100 == 1){
    Sys.sleep(10)
  }
  else{}
  
  if(file.info(paste(fileDir,fileNumber,'.txt',sep=''))$size>1024000000){
    fileNumber <- fileNumber + 1
  }
  else{}
  
  startPoint <- startPoint +1
  times <- times + 1
}

##-------------------
# http://datamining.dongguk.ac.kr/lectures/bigdata/_book/웹스크래핑.html


library(rvest)
url = 'https://movie.naver.com/movie/board/review/list.nhn?&page=1'

a1 = read_html(url) %>% html_nodes(xpath = '//*[@id="old_content"]/table/tbody/tr')
a1 %>% html_nodes(xpath='//*[@class="movie"]')
html_node("a") %>% html_attr("href")
?? html_nodes
a = read_html(url) %>% html_table(fill = TRUE) %>% .[[1]]
a[,3] = stringr::str_replace_all(a[,3], "[\n\r\t]", "")
a

a2 = read_html(url) %>% html_nodes(//*[@id="wrap"]/table/tbody/tr/td[2]) %>% html_nodes("td")
a2[2] %>% html_nodes("li")
a2 = read_html(url) %>% html_nodes(xpath='//*[@id="section_body"]') #%>% html_attr("attr1")




