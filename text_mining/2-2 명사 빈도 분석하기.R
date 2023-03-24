word_noun <- word_noun %>%
  count(word, sort = T) %>% # 단어 빈도 구해 내림차순 정렬
  filter(str_count(word) > 1) # 두 글자 이상만 남기기기

word_noun

# 상위 20개 단어 추출
top20 <- word_noun %>%
  head(20)

# 막대 그래프 만들기
library(ggplot2)
ggplot(top20, aes(x = reorder(word,n), y = n)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) +
  labs(x = NULL) +
  theme(text = element_text(family = 'nanumgothic'))

# 폰트 설정
library(showtext)
font_add_google(name = 'Black Han Sans', family = 'blackhansans')
showtext_auto()

library(ggwordcloud)
ggplot(word_noun, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = 'blackhansans') +
  scale_radius(limits = c(3, NA),
               range = c(3,15)) +
  scale_color_gradient(low = '#66aaf2', high = '#004EA1') + 
  theme_minimal()
