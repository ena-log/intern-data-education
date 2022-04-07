##1. 10~20까지 2씩 증가시킨 값으로 벡터 생성
a <- seq(10,20,2)
a

##2. 10~20까지 1씩 증가시킨 값으로 벡터 생성 
b <- seq(10,20,1)
b

##3.  첫번째 벡터와 두번째 벡터 더하기 연산
c <- c(a, b)
c

##4.  3번 연산 결과 중 첫 6개만 출력 
head(c)
c[1:6]

##5   3번 연산 결과 중 마지막 6개만 출력 
tail(c)
c[12: length(c)]

##6. 1~15 까지 1씩 증가시킨 벡터로 3행 5열 행렬 생성.  단, 열 우선으로 생성
d <- c(1:15)
x <- matrix(d, nrow = 3)
x

##7. 1~15 까지 1씩 증가시킨 벡터로 3행 5열 행렬 생성.  단, 행 우선으로 생성
y <- matrix(d, nrow = 3, byrow = T)
y

##8. 1~27까지 1씩 증가시킨 벡터로 3,3,3 Array 생성.
e <- array(1:27, dim = c(3,3,3))
e

##9.  8번 Array에서 10개 sample만 무작위 추출 
f <- sample(e, 10)
f

##10.  6번 행렬에 행별 평균 구하기 
x.1 <- apply(x, 1, mean)
x.1

##11.  6번 행렬에 열별 평균 구하기 
x.2 <- apply(x, 2, mean)
x.2

##12. 다음과 같은 데이터 프레임 생성 . 단, book_type 은 범주형 변수이다. 
  ##book_id book_price  book_type
  ##1             10000           소설
  ##2             20000           IT
  ##3             15000           소설
book_id <- c(1,2,3)
book_price <- c(10000, 20000, 15000)
book_type <- factor(c('소설', 'IT', '소설'))
book <- data.frame(book_id, book_price, book_type)
book

##13. book_price 만 출력
book$book_price

##14. book_price 가 15000이상인  책의 book_type 출력
book$book_type[book$book_price >= 15000]
subset(book$book_type, book_price >= 15000)

##15. book_type이 소설인 모든 책 정보 출력
subset(book, book_type == '소설')

##16. 12의 데이터프레임과 1의 벡터를 저장하는 리스트 생성. 
list.a <- list(book, data.frame(c(1)))
list.a

##17. 16의 리스트의 데이터프레임이름은 "book", 벡터의 이름은 "test_vector"로 지정 
list.a <- list(book=book, test_vector=data.frame(c(1)))
list.a

##18. 16리스트의 "book" 데이터프레임만 출력 
list.a[["book"]]
