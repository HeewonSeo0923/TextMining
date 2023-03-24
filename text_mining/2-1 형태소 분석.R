install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite',
                   'devtools'), type = 'binary')

library(KoNLP)

install.packages('remotes')
remotes::install_github('haven-jeon/KoNLP',
                        upgrade = 'never',
                        INSTALL_opts = c('--no-multiarch'))
useNIADic()

library(KoNLP)
library(dplyr)
text <- tibble(
  value = c('대한민국은 민주공화국이다.',
            '대한민국의 주권은 국민에게 있고, 모든 권력은 국민으로부터 나온다.'))

text

extractNoun(text$value)

library(tidytext)
text %>%
  unnest_tokens(input = value, # 분석 대상
                output = word, # 출력 변수명
                token = extractNoun) # 토큰화 함수


# 문재인 대통령 연설문 불러오기
raw_moon <- readLines('speech_moon.csv', encoding = 'UTF-8')

# 기본적 전처리
library(stringr)

moon <- raw_moon %>%
  str_replace_all('[^가-힣]', ' ') %>% 
  str_squish() %>%
  as_tibble()

# 명사 기준 토큰화
word_noun <- moon %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)

word_noun
