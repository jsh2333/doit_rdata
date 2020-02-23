###########################################################
# R을 이용한 텔레그램봇 만들기 (스케쥴러를 사용하여 자동 정보 전송)
###########################################################

# https://core.telegram.org/bots/api
# http://henryquant.blogspot.com/search?updated-max=2019-03-18T16:53:0%2B09:00&max-results=1&pgno=4




install.packages("telegram.bot")
library(telegram.bot)

#---------------------------------

# telegram
# install.packages('telegram.bot')
library(telegram.bot)

# bot = Bot(token = "YOUR API KEY")
bot = Bot(token = "1088672930:AAEj0KLnfaYZGUHn-KXegFi43mex40Fp5WY")
print(bot$getMe())

$id
[1] 704368869

$is_bot
[1] TRUE

$first_name
[1] "fin_news_bot"

$username
[1] "hqnews_bot"

#---------------------------------


bot = Bot(token = "Your API KEY")
updates = bot$getUpdates()
chat_id = updates[[1]]$message$chat$id