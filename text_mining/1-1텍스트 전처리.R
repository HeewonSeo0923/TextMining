## 연설문 불러오기 : readLines()
raw_moon <- readLines('speech_moon.csv', encoding = 'UTF-8')
head(raw_moon)

## 불필요한 문자 제거하기 : str_replace_all('[^가-힇^]', ' ')
txt <- '치킨은!! 맛있다. xyz 정말 맛있다!@#'
txt

library(stringr)
# 파라미터명 입력 
str_replace_all(string = txt, pattern = '[^가-힇^]', replacement = ' ')
# 정규 표현식이란 ? : 특정한 규칙을 가진 문자열 표현 언어임.
# 특정 조건에 해당하는 문자 찾거나 수정할때 사용
# [^가-힇^] : 가부터 힇까지 모든 한글 문자, ^^는 반대를 의미한다.

library(ggplot2)
library(dplyr)
moon <- raw_moon %>%
  # 파라미터형 생략
  str_replace_all("[^가-힇]", ' ')

head(moon)

## 연속된 공백 제거하기 : str_squish()
txt <- '치킨은    맛있다   정말    맛있다    '
txt
str_squish(txt)

moon <- moon %>%
  str_squish()

head(moon)


## 문자열 벡터를 tibble구조로 바꾸기 : as_tibble()
moon <- as_tibble(moon)
moon

## 전처리 작업 한번에 실행
moon <- raw_moon %>%
  str_replace_all('[^가-힣]', ' ') %>%
  str_squish() %>%
  as_tibble()

moon

# tibble: 콘솔 창 크기 맞게 출력되 구조 파악 쉬움. 행열개수와 속성 알려줌