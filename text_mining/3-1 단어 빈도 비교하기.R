library(dplyr)

raw_moon <- readLines('speech_moon.csv', encoding = 'UTF-8')
moon <- raw_moon %>%
  as_tibble()%>%
  mutate(president = 'moon')

raw_park <- readLines('speech_park.csv', encoding = 'UTF-8')
park <- raw_park %>%
  as_tibble() %>%
  mutate(president = 'park')

bind_speeches <- bind_rows(moon, park) %>%
  select(president, value)

head(bind_speeches)

tail(bind_speeches)

library(stringr)
speeches <- bind_speeches %>%
  mutate(value = str_replace_all(value, '[^가-힣]', ' '),
         value = str_squish(value))

speeches

library(tidytext)
library(KoNLP)

speeches <- speeches %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)

speeches

df <- tibble(class = c('a', 'a', 'a', 'b','b','b'),
             sex = c('female', 'male','female', 'male', 'male','female'))

df

df %>% count(class, sex)

frequency <- speeches %>%
  count(president, word) %>% # 연설문 및 단어별 빈도
  filter(str_count(word) > 1) # 두 글자 이상 추출

head(frequency)

df <- tibble(x = c(1:100))

df

df %>% slice_max(x, n = 3)

top10 <- frequency %>%
  group_by(president) %>% # president 별로 분리
  slice_max(n, n =10) # 상위 10개 추출

top10

top10 %>%
  filter(president == 'park')

df <- tibble(x = c('A', 'B', 'C', 'D'), y = c(4,3,2,2))

df %>% slice_max(y, n=3)

df %>% slice_max(y, n=3, with_ties = F)

top10 <- frequency %>%
  group_by(president) %>%
  slice_max(n, n = 10, with_ties = F)

top10

library(ggplot2)
ggplot(top10, aes(x = reorder(word, n),
                  y = n,
                  fill = president)) +
  geom_col()+
  coord_flip()+
  facet_wrap(~ president)

ggplot(top10, aes(x = reorder(word, n),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president,
             scales = 'free_y')

top10 <- frequency %>%
  filter(word != '국민') %>%
  group_by(president) %>%
  slice_max(n, n = 10, with_ties = F)

top10

ggplot(top10, aes(x = reorder(word, n),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president,
             scales = 'free_y')

ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president,
             scales = 'free_y')


ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president,
             scales = 'free_y') + 
  scale_x_reordered() +
  labs(x = NULL) +
  theme(text = element_text(family = 'nanumgothic'))


