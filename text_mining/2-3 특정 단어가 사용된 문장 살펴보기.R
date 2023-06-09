sentences_moon <- raw_moon %>%
  str_squish() %>%
  as_tibble() %>%
  unnest_tokens(input = value,
                output = sentence,
                token = 'sentences')

sentences_moon

str_detect('치킨은 맛있다', '치킨')

str_detect('치킨은 맛있다', '피자')

sentences_moon %>%
  filter(str_detect(sentence, '국민'))

sentences_moon %>%
  filter(str_detect(sentence, '일자리'))
