df_long <- frequency %>%
  group_by(president) %>%
  slice_max(n, n = 10) %>%
  filter(word %in% c('국민', '우리', '정치', '행복'))

df_long

install.packages('tidyr')
library(tidyr)

df_wide <- df_long %>%
  pivot_wider(names_from = president,
              values_from = n)

df_wide

df_wide <- df_long %>%
  pivot_wider(names_from = president,
              values_from = n,
              values_fill = list(n = 0))

df_wide

frequency_wide <- frequency %>%
  pivot_wider(names_from = president,
              values_from = n,
              values_fill = list(n = 0))

frequency_wide

frequency_wide <- frequency_wide %>%
  mutate(ratio_moon = ((moon)/(sum(moon))), # moon에서 단어의 비중
         ratio_park = ((park)/(sum(park)))) # park에서 단어의 비중

frequency_wide <- frequency_wide %>%
  mutate(ratio_moon = ((moon + 1)/ (sum(moon + 1))),
         ratio_park = ((park + 1)/ (sum(park + 1))))

frequency_wide <- frequency_wide %>%
  mutate(odds_ratio = ratio_moon/ratio_park)

frequency_wide %>%
  arrange(-odds_ratio)

frequency_wide %>%
  arrange(odds_ratio)

frequency_wide <- frequency_wide %>%
  mutate(ratio_moon = ((moon + 1)/ (sum(moon + 1))),
         ratio_park = ((park + 1)/ (sum(park + 1))),
         odds_ratio = ratio_moon/ratio_park)

frequency_wide <- frequency_wide %>%
  mutate(odds_ratio  = ((moon + 1)/ (sum(moon + 1)))/
         ((park + 1)/ (sum(park + 1))))

         
top10 <- frequency_wide %>%
  filter(rank(odds_ratio) <= 10 | rank(-odds_ratio) <= 10)

top10 %>%
  arrange(-odds_ratio)

top10 <- top10 %>%
  mutate(president = ifelse(odds_ratio > 1, 'moon', 'park'),
         n = ifelse(odds_ratio >1 , moon, park))

top10

ggplot(top10, aes(x = reorder_within(word, n , president),
                  y = n,
                  fill = president)) + 
  geom_col() +
  coord_flip()+
  facet_wrap(~ president, scales = 'free_y') +
  scale_x_reordered()

ggplot(top10, aes(x = reorder_within(word, n , president),
                  y = n,
                  fill = president)) + 
  geom_col() +
  coord_flip()+
  facet_wrap(~ president, scales = 'free') +
  scale_x_reordered()+
  labs(x = NULL) +
  theme(text = element_text(family = 'nanumgothic'))

speeches_sentence <- bind_speeches %>%
  as_tibble() %>%
  unnest_tokens(input = value,
                output = sentence,
                token = 'sentences')

head(speeches_sentence)

tail(speeches_sentence)

speeches_sentence %>%
  filter(president == 'moon' & str_detect(sentence, '복지국가'))

speeches_sentence %>%
  filter(president == 'park' & str_detect(sentence, '행복'))

frequency_wide %>% 
  arrange(abs(1 - odds_ratio)) %>%
  head(10)

frequency_wide %>%
  filter(moon >= 5 & park >= 5) %>%
  arrange(abs(1 - odds_ratio)) %>%
  head(10)

