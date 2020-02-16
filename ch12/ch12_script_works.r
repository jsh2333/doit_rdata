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





