raw_park <- readLines('speech_park.csv', encoding='UTF-8')

head(raw_park)

library(dplyr)

## Q1

# 전처리
park <- raw_park %>%
  str_replace_all('[^가-힣]', ' ') %>%
  str_squish() %>%
  as_tibble()

park  

# 토큰화
word_space <- park%>%
  unnest_tokens(input = value,
                output = word,
                token = 'words')

word_space

## Q2
word_space <- word_space %>%
  count(word, sort = T) %>%
  filter(str_count(word) >1)

word_space

top20 <- word_space %>%
  head(20)

top20

## Q3

ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust=-0.3) +
  
  labs(title = '박근혜 대통령 출마 선언문 단어 빈도',
       x = NULL, y = NULL) +
  
  theme(title = element_text(size = 12),
        text = element_text(family = 'nanumgothic'))

## Cloud

