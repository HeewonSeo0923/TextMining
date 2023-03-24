## 단어 빈도 구하기 : count()
word_space <- word_space %>%
  count(word, sort = T)

library(dplyr)

word_space

# 한 글자로 된 단어 제거하기 : filter(str_count())
str_count('배')

str_count('사과')

# 두 글자 이상만 남기기

word_space <- word_space %>%
  filter(str_count(word) > 1)

word_space

# 이것들을 한번에 처리해보자 
word_space <- word_space %>%
  count(word, sort = T) %>%
  filter(str_count(word) > 1)

## 자주 사용된 단어 추출하기
## 빈도가 높은 단어 추출하기 : head()

top20 <- word_space %>%
  head(20)

top20


library(ggplot2)

ggplot(top20, aes(x = reorder(word, n), y = n)) + #단어 빈도순 정렬
  geom_col() +
  coord_flip()
## 막대 그래프 만들기 : goem_col()
library(ggplot2)

ggplot(top20, aes(x = reorder(word, n), y = n)) + #단어 빈도순 정렬
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust=-0.3)+
  labs(title='문재인 대통령 출마 연설문 단어 빈도',x = NULL, x = NULL) + 
  theme(title = element_text(size = 12))
# 회전

# 그래프 다듬기

ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_filp() +
  geom_text(aes(label = n), hjust=-0.3) +  # 막대 밖 빈도 표시
  labs(title='문재인 대통령 출마 연설문 단어 빈도',
     x = NULL, x = NULL) + 
  
  theme(title = element_text(size = 12))

 ## 워드 클라우드 만들기 : geom_text_wordcloud()
install.packages("wordcloud")
library(wordcloud)

install.pakages('ggwordcloud')

install.packages("ggwordcloud")
library(ggwordcloud)

ggplot(word_space, aes(label = word, size = n)) +
  geom_text_wordcloud(seed = 1234) +
  scale_radius(limits =  c(3, NA),
               range = c(3, 30))

# 그래프 다듬기
ggplot(word_space,
       aes(label = word, 
           size = n,
           col = n)) +
  geom_text_wordcloud(seed = 1234) +
  scale_radius(limits =  c(3, NA),
               range = c(3, 30)) +
  scale_color_gradient(low = '#66AAF2',
                       high = '#004EA1') +
  theme_minimal()

# 그래프 폰트 바꾸기
install.packages('showtext')
library(showtext)
font_add_google(name = 'Nanum Gothic', family = 'nanumgothic')
showtext.auto()

# try
ggplot(word_space,
       aes(label = word, 
           size = n,
           col = n)) +
  geom_text_wordcloud(seed = 1234,
                      family = 'nanumgothic') +
  scale_radius(limits =  c(3, NA),
               range = c(3, 30)) +
  scale_color_gradient(low = '#66aaf2', 
                       high = '#004EA1') +
  theme_minimal()
font_add_google(name = 'Black Han Sans', family = 'blackhansans')
showtext.auto()

ggplot(word_space,
       aes(label = word, 
           size = n,
           col = n)) +
  geom_text_wordcloud(seed = 1234,
                      family = 'blackhansans') +
  scale_radius(limits =  c(3, NA),
               range = c(3, 30)) +
  scale_color_gradient(low = '#66aaf2', 
                       high = '#004EA1') +
  theme_minimal()

# ggplot 그래프 폰트 변경시키기

font_add_google(name = 'Gamja Flower', family = 'gamjaflower')
showtext_auto()

ggplot(top20, aes(x = reorder(word, n), y=n)) +
  geom_col() +
  coord_flip() +
 
  geom_text(aes(label = n), hjust = -0.3) +
  
  labs(title = '문재인 대통령 출마 선언문 단어 빈도',
       x = NULL, y = NULL) +
  
  theme(title = element_text(size = 12),
        text = element_text(family = 'gamjaflower'))

  theme_set(theme_gray(base_family = 'nanumgothic'))
  