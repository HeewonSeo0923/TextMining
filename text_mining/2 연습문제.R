# q1
raw_park <- readLines('speech_park.csv', encoding = 'UTF-8')
head(raw_park)

park <- raw_park %>%
  str_replace_all('[^가-힣]', ' ') %>% # 한글만 남기기
  str_squish() %>% # 연속된 공백 제거
  as_tibble() # tibble로 변환

word_noun <- park %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)

word_noun

word_noun <- word_noun %>%
  count(word, sort =T) %>%
  filter(str_count(word) > 1)

word_noun

top20 <- word_noun %>%
  head(20)


library(ggplot2)
ggplot(top20, aes(x = reorder(word,n), y = n)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) +
  labs(x = NULL) +
  theme(text = element_text(family = 'nanumgothic'))

sentences_park  <- raw_park %>%
  as_tibble() %>%
  unnest_tokens(input = value,
                output = sentence,
                token = 'sentences')
sentences_park


sentences_park %>%
  filter(str_detect(sentence, '경제'))
