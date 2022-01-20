2022-0104-01)사용자 생성
CREATE USER - 사용자생성
GRANT - 권한부여

1) 사용자 생성
CREATE USER 유저명 IDENTIFIED BY 암호;
유저명 첫글자는 무조건 영어
두번째부터 숫자가능
대소문자 구분 X
특수문자는 두개 사용가능 _,$
하지만 _만 사용하기

~ 틸드 > 1의 보수를 구하는 연산자
@ 전치사 AT
& 엔퍼센드(엔드연산자)
* 아스트릭스(오라클에서는 ALL의 의미 > 모든의 의미, 곱연산자)

스크립트실행시: ctrl+enter

    CREATE USER LSG9 IDENTIFIED BY java;
    
2)권한부여
GRANT 권한명1[, 권한명2,.....] TO 유저명;
[] 대괄호는 생략가능하다는 뜻

GRANT CONNECT, RESOURCE, DBA TO LSG9;
    