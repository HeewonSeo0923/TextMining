## 토큰화하기 : unnest_tokens()
# tidytext : 텍스트를 정돈된 데이터 형태 유지하며 분석 가능 패키지임
text <- tibble(value = '대한민국은 민주공화국이다. 대한민국의 주권은 국민에게 있고, 모든 권력은 국민으로부터 나온다')
text
# unnest_tokens() 사용
# input : 토큰화할 텍스트 , output : 토큰을 담을 변수명  , token : 텍스트 나누는 기준임. 문장 기준이면  'sentences', 띄어쓰기 기준으로 나누려면 'words', 글자 기준으로 나누려면 'charaters'입력해야 한다
install.packages('tidytext')
library(tidytext)
library(dplyr)
library(ggplot2)

# 문장 기준 토큰화
text %>%
  unnest_tokens(input = value,
                output = word,
                token = 'sentences')

# 띄어쓰기 기준 토큰화
text %>%
  unnest_tokens(input = value,
                output = word,
                token = 'words')

# 문자 기준 토큰화
text %>%
  unnest_tokens(input = value,
                output = word,
                token = 'characters')

# 연설문 토큰화하기
word_space <- moon %>%
  unnest_tokens(input = value,
                output = word,
                token = 'words')

word_space  

