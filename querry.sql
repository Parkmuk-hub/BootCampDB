CREATE TABLE dept(NO INT PRIMARY KEY, NAME VARCHAR(10),
tel VARCHAR(15), inwon INT, addr TEXT) CHARSET = UTF8; -- 테이블 생성

-- 자료추가
# insert into 테이블명(칼럼명,...NO) values(입력자료, ...)
INSERT INTO dept(NO,NAME,tel,inwon,addr) VALUES(1,'인사과','7163-111',3,'삼성동12');
INSERT INTO dept VALUES(2,'영업과','111-2401',6,'서초동12');
INSERT INTO dept(NO, NAME) VALUES(3,'자재과'); -- 칼럼이랑 같으면 칼럼 스킵, 다르면 칼럼 써줘야함
INSERT INTO dept(NO, addr, tel, NAME) VALUES(4,'역삼2동33', '111-555', '자재2과'); -- 칼럼 안에 순서는 상관없음 

INSERT INTO dept(VALUES(5,'판매과'); -- err : 입력자료와 칼럼 갯수 불일치
INSERT INTO dept(NAME, tel) VALUES('판매2과', '111-2222'); -- NO:primary key, 생략 불가
INSERT INTO dept(NO, NAME) VALUES(7, '판매과부서는 사람들이 좋아 일하기 좋은 우수한 부서임'); --  err : 자릿수 넘침 => NAME VARCHAR(10)

SELECT * FROM dept;
SELECT * FROM dept WHERE NO=1;

-- 자료 수정
-- update 테이블명 set 수정칼럼명=수정값,... where 조건 <== 수정 대상 칼럼을 지정
-- primary KEY 칼럼의 자료는 수정 대상에서 제외
UPDATE dept SET tel ='123-4567' WHERE NO = 2;
UPDATE dept SET addr ='압구정동33', inwon=7,tel='777-7777' WHERE NO = 3;

SELECT * FROM dept;

-- 자료 삭제
-- delete from 테이블명 where 조건	-- 전체 또는 부분적 레코드 삭제 가능
-- turncate table 테이블명	-- where조건을 사용하지 않음,  전체 레코드 삭제 가능
DELETE from dept WHERE NAME = '자재2과'; -- where 안붙이면 다 날려버림
turncate TABLE dept;

SELECT * FROM dept;

DROP TABLE dept; -- 테이블 자체가(구조, 자료) 제거됨


-- 무결성 제약 조건
-- : 테이블 생성 시 잘못된 자료 입력을 막고자 다양한 입력 제한 조건을 줄 수 있음
-- 1) 기본키 제약 : Primary Key(pk) 사용, 중복 레코드 입력 방지
CREATE TABLE aa(bun INT PRIMARY KEY, irum CHAR(10)); -- bun : NOT NULL, UNIQUE
SELECT * FROM information_schema.table_constraints WHERE TABLE_NAME='aa' 

INSERT INTO aa VALUES(1, 'tom');
INSERT INTO aa VALUES(2, 'holland'); 
INSERT INTO aa VALUES(2, 'holland'); -- err : pk 중복
INSERT INTO aa(irum) VALUES('holland'); -- err : pk 미입력 오류
INSERT INTO aa(bun) VALUES(3);

SELECT * FROM aa;
DROP TABLE aa;

CREATE TABLE aa(bun INT, irum CHAR(10), CONSTRAINT aa_bun_pk PRIMARY KEY(bun));
INSERT INTO aa VALUES(1, 'tom');

SELECT * FROM aa;
DROP TABLE aa;

-- 2) check 제약 : 입력 자료의 특정 칼럼 값 조건 검사== 입력 자료 검사 very important
CREATE TABLE aa(bun INT, nai INT CHECK(nai >= 20));
INSERT INTO aa VALUES(1, 23);
INSERT INTO aa VALUES(2, 16);
INSERT INTO aa VALUES(3, 16);
SELECT * FROM aa;
DROP TABLE aa;

-- 3) unique 제약 : 특정 칼럼값 중복 방지
CREATE TABLE aa(bun INT, irum CHAR(10) NOT NULL UNIQUE);
INSERT INTO aa VALUES(1, 'tom');
INSERT INTO aa VALUES(2, 'holland');
INSERT INTO aa VALUES(3, 'holland'); -- err : NOT NULL UNIQUE => NULL 이 아니라면 중복금지 

SELECT * FROM aa;
DROP TABLE aa;

-- 4) foreign key(fk), 외부키, 참조키 제약. 특정 칼럼이 다름 테이블의 칼럼을 참조
-- fk 대상은 pk다 !!
CREATE TABLE jikwon(bun INT PRIMARY KEY, irum VARCHAR(10) NOT NULL,
buser CHAR(10) NOT NULL);
INSERT INTO jikwon VALUES(1, '한송이','인사과');
INSERT INTO jikwon VALUES(2, '이기자','인사과');
INSERT INTO jikwon VALUES(3, '한송이','판매과');
SELECT * FROM jikwon;

CREATE TABLE gajok(CODE INT PRIMARY KEY, NAME VARCHAR(10) NOT NULL, 
bitrh DATETIME, jikwonbun INT, FOREIGN KEY(jikwonbun) REFERENCES jikwon(bun));

INSERT INTO gajok VALUES(10, '이관민','2015-09-09',3);
INSERT INTO gajok VALUES(20, '김태현','2010-11-18',2);
INSERT INTO gajok VALUES(30, '강예찬','2012-05-07',1);
INSERT INTO gajok VALUES(40, '김제형','2015-06-28',5); -- err : 직원 테이블에 존재하지않은 번호 사용

DELETE FROM jikwon WHERE bun = 1; -- 참조 자료(가족)가 있으므로 삭제 불가
DROP TABLE jikwon; -- err : 참조하는 테이블 있으면 삭제 불가

DELETE FROM gajok WHERE jikwonbun = 2; -- 참조키(pk가 2번) 가족자료 삭제
DELETE FROM jikwon WHERE bun = 2; 		-- 참조 가족이 없으므로 2번 직원 삭제 가능
SELECT * FROM gajok;

-- 참고
-- CREATE TABLE gajok(CODE INT PRIMARY KEY, ...) on delete cascade
-- 직원 자료를 삭제하려면 참조하는 테이블에서 삭제 후 삭제가능
DROP TABLE gajok;
DROP TABLE jikwon;

-- default : 특정 칼럼에 초기치 부여. NULL 예방
-- 변수 INT AUTO_INCREMENT PRIMARY KEY : pk 값이 자동 증가 / sql마다 다른데 oracle에는 없음
CREATE TABLE aa(bun INT AUTO_INCREMENT PRIMARY KEY, juso CHAR(20) DEFAULT '강남구 역삼동');

INSERT INTO aa VALUES(1, '서초구 서초2동');
INSERT INTO aa(juso) VALUES('서초구 서초3동');
INSERT INTO aa(juso) VALUES('서초구 서초4동'); -- AUTO_INCREMENT로 값이 자동으로 증가해서 따로 작성안해도 ㄱㅊ
INSERT INTO aa(bun) VALUES(5); -- 주소를 입력하지 않아도 DEFAULT 값이 있기 때문에 실행됨
INSERT INTO aa(juso) VALUES('서초구 서초5동'); -- 전 내용이 5번이라 여기에는 다음 번호 6이 들어감

SELECT * FROM aa;
DROP TABLE aa;

-- index (색인) : 검색 속도 향상을 위해 특정 column에 색인 부여 가능
-- pk column은 자동으로 인덱싱됨(ascending sort : 오름차순 정렬)
-- index 를 자제해야하는 경우 : 입력, 수정, 삭제 등의 작업이 빈번한 경우
CREATE TABLE aa(bun INT PRIMARY KEY, irum VARCHAR(10) NOT NULL, juso VARCHAR(50));
INSERT INTO aa VALUES(1, '선경호', '테헤란로 111');

ALTER TABLE aa ADD INDEX ind_jsuo(juso); -- juso column 에 인덱스를 부여
SELECT * FROM aa;
EXPLAIN SELECT * FROM aa; -- 설명해라 aa 를
DESC aa; -- 구조를 보여줌
SHOW INDEX from aa; -- aa의 모든 것을 보여줌 index_type == BTREE [절반을 잘라서 찾음 (기본적으로 사용)] or Hash
ALTER TABLE aa DROP INDEX ind_jsuo; -- juso index 지우기
SHOW INDEX FROM aa;
DROP TABLE aa;

-- 테이블 관련 주요 명령
-- CREATE TABLE 테이블명 ...
-- ALTER TABLE 테이블명 ...
-- DROP TABLE 테이블명 ...
CREATE TABLE aa(bun INT, irum VARCHAR(10), juso VARCHAR(50));
INSERT INTO aa VALUES(1, 'tom', 'seoul')

SELECT * FROM aa;

ALTER TABLE aa RENAME kbs; -- 테이블명 변경
SELECT * FROM aa;
ALTER TABLE kbs RENAME aa;

-- 칼럼 관련 명령
ALTER TABLE aa ADD (job_id int DEFAULT 10); -- 칼럼 추가
SELECT * FROM aa;
ALTER TABLE aa CHANGE job_id job_num INT ; -- 칼럼 수정 (이름이나 성격 변경)
SELECT * FROM aa;
ALTER TABLE aa MODIFY job_num VARCHAR(10); -- 칼럼 성격 변경 int -> varchar
DESC aa;

ALTER TABLE aa DROP COLUMN job_num; -- 칼럼 삭제
DESC aa;
DROP TABLE aa;

--

create table sangdata(
code int primary key,
sang varchar(20),
su int,
dan INT);
insert into sangdata values(1,'장갑',3,10000);
insert into sangdata values(2,'벙어리장갑',2,12000);
insert into sangdata values(3,'가죽장갑',10,50000);
insert into sangdata values(4,'가죽점퍼',5,650000);
SELECT * FROM sangdata

create table buser(
buserno int primary key, 
busername varchar(10) not null,
buserloc varchar(10),
busertel varchar(15));
insert into buser values(10,'총무부','서울','02-100-1111');
insert into buser values(20,'영업부','서울','02-100-2222');
insert into buser values(30,'전산부','서울','02-100-3333');
insert into buser values(40,'관리부','인천','032-200-4444');
SELECT * FROM buser

create table jikwon(
jikwonno int primary key,
jikwonname varchar(10) not null,
busernum int not null,
jikwonjik varchar(10) default '사원', 
jikwonpay int,
jikwonibsail date,
jikwongen varchar(4),
jikwonrating char(3),
CONSTRAINT ck_jikwongen check(jikwongen='남' or jikwongen='여'));
insert into jikwon values(1,'홍길동',10,'이사',9900,'2008-09-01','남','a');
insert into jikwon values(2,'한송이',20,'부장',8800,'2010-01-03','여','b');
insert into jikwon values(3,'이순신',20,'과장',7900,'2010-03-03','남','b');
insert into jikwon values(4,'이미라',30,'대리',4500,'2014-01-04','여','b');
insert into jikwon values(5,'이순라',20,'사원',3000,'2017-08-05','여','b');
insert into jikwon values(6,'김이화',20,'사원',2950,'2019-08-05','여','c');
insert into jikwon values(7,'김부만',40,'부장',8600,'2009-01-05','남','a');
insert into jikwon values(8,'김기만',20,'과장',7800,'2011-01-03','남','a');
insert into jikwon values(9,'채송화',30,'대리',5000,'2013-03-02','여','a');
insert into jikwon values(10,'박치기',10,'사원',3700,'2016-11-02','남','a');
insert into jikwon values(11,'김부해',30,'사원',3900,'2016-03-06','남','a');
insert into jikwon values(12,'박별나',40,'과장',7200,'2011-03-05','여','b');
insert into jikwon values(13,'박명화',10,'대리',4900,'2013-05-11','남','a');
insert into jikwon values(14,'박궁화',40,'사원',3400,'2016-01-15','여','b');
insert into jikwon values(15,'채미리',20,'사원',4000,'2016-11-03','여','a');
insert into jikwon values(16,'이유가',20,'사원',3000,'2016-02-01','여','c');
insert into jikwon values(17,'한국인',10,'부장',8000,'2006-01-13','남','c');
insert into jikwon values(18,'이순기',30,'과장',7800,'2011-11-03','남','a');
insert into jikwon values(19,'이유라',30,'대리',5500,'2014-03-04','여','a');
insert into jikwon values(20,'김유라',20,'사원',2900,'2019-12-05','여','b');
insert into jikwon values(21,'장비',20,'사원',2950,'2019-08-05','남','b');
insert into jikwon values(22,'김기욱',40,'대리',5850,'2013-02-05','남','a');
insert into jikwon values(23,'김기만',30,'과장',6600,'2015-01-09','남','a');
insert into jikwon values(24,'유비',20,'대리',4500,'2014-03-02','남','b');
insert into jikwon values(25,'박혁기',10,'사원',3800,'2016-11-02','남','a');
insert into jikwon values(26,'김나라',10,'사원',3500,'2016-06-06','남','b');
insert into jikwon values(27,'박하나',20,'과장',5900,'2012-06-05','여','c');
insert into jikwon values(28,'박명화',20,'대리',5200,'2013-06-01','여','a');
insert into jikwon values(29,'박가희',10,'사원',4100,'2016-08-05','여','a');
insert into jikwon values(30,'최미숙',30,'사원',4000,'2015-08-03','여','b');
SELECT * FROM jikwon;

create table gogek(
gogekno int primary key,
gogekname varchar(10) not null,
gogektel varchar(20),
gogekjumin char(14),
gogekdamsano int,
CONSTRAINT FK_gogekdamsano foreign key(gogekdamsano) references jikwon(jikwonno));

insert into gogek values(1,'이나라','02-535-2580','850612-1156777',5);
insert into gogek values(2,'김혜순','02-375-6946','700101-1054777',3);
insert into gogek values(3,'최부자','02-692-8926','890305-1065777',3);
insert into gogek values(4,'김해자','032-393-6277','770412-2028777',13);
insert into gogek values(5,'차일호','02-294-2946','790509-1062777',2);
insert into gogek values(6,'박상운','032-631-1204','790623-1023777',6);
insert into gogek values(7,'이분','02-546-2372','880323-2558777',2);
insert into gogek values(8,'신영래','031-948-0283','790908-1063777',5);
insert into gogek values(9,'장도리','02-496-1204','870206-2063777',4);
insert into gogek values(10,'강나루','032-341-2867','780301-1070777',12);
insert into gogek values(11,'이영희','02-195-1764','810103-2070777',3);
insert into gogek values(12,'이소리','02-296-1066','810609-2046777',9);
insert into gogek values(13,'배용중','02-691-7692','820920-1052777',1);
insert into gogek values(14,'김현주','031-167-1884','800128-2062777',11);
insert into gogek values(15,'송운하','02-887-9344','830301-2013777',2);
SELECT * FROM gogek;

-- select : db 서버로부터 클라이언트 자료를 읽는 명령
-- select 칼럼명 as 별명,...from 테이블명 where 조건 order by 기준키,...

SELECT * FROM jikwon; -- * FROM은  모든 칼럼 읽기
SELECT jikwonno, jikwonname FROM jikwon; -- 원하는 칼럼 읽기 == 셀렉션
SELECT jikwonno, jikwongen, busernum, jikwonname FROM jikwon; -- 순서 맘대로 선택 가능
SELECT jikwonno AS 직원번호, jikwonname AS 직원명 FROM jikwon; -- 별명 주기
SELECT 10, '안녕', 12/3 AS 결과 FROM DUAL; -- 가상 테이블 MAKE, 칼럼명에 수식이 있어도 그것이 칼럼명이 되고 값이 작성된다.
SELECT jikwonname, jikwonpay, jikwonpay * 0.05 AS tax FROM jikwon; -- 기존 칼럼을 가공해서 새로운걸 만들어서 출력할 수 있음. 수식보기 싫으면 AS로 별명줌
SELECT jikwonname, CONCAT(jikwonname,'님') AS jikwonnim FROM jikwon; -- CONCAT == 문자열 + 함수

-- 정렬(sort)
SELECT * FROM  jikwon;-- 칼럼명을 다 작성하는 것을 원칙으로함.
SELECT * FROM  jikwon ORDER BY jikwonpay ASC; -- ORDER BY 칼럼명 ASC ==  오름차순으로 출력하게 명령
SELECT * FROM jikwon ORDER BY jikwonpay;
SELECT * FROM jikwon ORDER BY jikwonpay DESC; -- 내림차순 정렬
SELECT * FROM jikwon ORDER BY jikwonjik ASC; -- 같은 것끼리 정렬
SELECT * FROM jikwon ORDER BY jikwonjik ASC, busernum DESC, jikwongen ASC, jikwonpay;
SELECT jikwonname, jikwonpay, jikwonpay / 100 AS pay FROM jikwon ORDER BY pay DESC; -- jikwonpay 추가 계산한 것을 pay라는 별명을 붙이고 내림차순 

SELECT DISTINCT jikwonjik FROM jikwon; -- 중복배제
SELECT DISTINCT jikwonjik, jikwonname FROM jikwon; -- 배제 안됨;;;;

-- 연산자 : () > 산술 > 관계(비교), is null, like, in > between, not > and > or
SELECT * FROM jikwon WHERE jikwonjik = '대리'; -- 대리만 불러옴
SELECT * FROM jikwon WHERE jikwonno = '3';
SELECT * FROM jikwon WHERE jikwonibsail = '2010-03-03';
SELECT * FROM jikwon WHERE jikwonno = '5' OR jikwonno = '7';
SELECT * FROM jikwon WHERE jikwonno = '5' AND jikwonno = '7'; -- 직원 번호는 pk
SELECT * FROM jikwon WHERE jikwonjik = '사원' AND jikwongen = '여';
SELECT * FROM jikwon WHERE jikwonjik = '사원' AND jikwongen = '여' AND jikwonpay <= 3000;
SELECT * FROM jikwon WHERE jikwonjik = '사원' AND (jikwongen = '여' or jikwonibsail >= '2017-01-01');

SELECT * FROM jikwon WHERE jikwonno >= 5 AND jikwonno <= 10 ;
SELECT * FROM jikwon WHERE jikwonno BETWEEN 5 AND 10;
SELECT * FROM jikwon WHERE jikwonibsail BETWEEN '2017-01-01' AND '2019-12-31';

SELECT * FROM jikwon WHERE jikwonno < 5 OR jikwonno > 20;
SELECT * FROM jikwon WHERE jikwonno NOT BETWEEN 5 AND 20; -- 긍정적 형태의 조건이 속도를 향상시킨다.

SELECT * FROM jikwon WHERE jikwonpay > 5000;
SELECT * FROM jikwon WHERE jikwonpay > 3000 + 2000;

SELECT * FROM jikwon WHERE jikwonname = '홍길동';
SELECT * FROM jikwon WHERE jikwonname >= '김';
SELECT ASCII('a'), ASCII('A'), ASCII('박'), ASCII('삭') FROM DUAL; -- 문자도 대소 비교 가능
SELECT * FROM jikwon WHERE jikwonname BETWEEN '김' AND '이';

-- in 멤버 조건 연산
SELECT * FROM jikwon WHERE jikwonjik='대리' OR jikwonjik ='과장' OR jikwonjik = '부장';
SELECT * FROM jikwon WHERE jikwonjik IN('대리', '과장', '부장');
SELECT * FROM jikwon WHERE jikwonno IN(3, 12, 29);

-- like 조건 연산: %(0개 이상의 문자열), _(한개 문자)
SELECT * FROM jikwon WHERE jikwonname LIKE '이%';
SELECT * FROM jikwon WHERE jikwonname LIKE '이순%';
SELECT * FROM jikwon WHERE jikwonname LIKE '%라';
SELECT * FROM jikwon WHERE jikwonname LIKE '이%라';

SELECT * FROM jikwon WHERE jikwonname LIKE "이__";
SELECT * FROM jikwon WHERE jikwonname LIKE "이_라";

SELECT * FROM jikwon WHERE jikwonname LIKE "__"; -- 두글자 이름만 출력 == "__"
SELECT * FROM jikwon WHERE jikwonpay LIKE '3___';
SELECT * FROM jikwon WHERE jikwonpay LIKE '3%';

SELECT * FROM gogek WHERE gogekjumin LIKE '_______1%';
SELECT * FROM gogek WHERE gogekjumin LIKE '%-1%';

SELECT * FROM jikwon;
UPDATE jikwon SET jikwonjik=NULL WHERE jikwonno = 5;
SELECT * FROM jikwon;
SELECT * FROM jikwon WHERE jikwonjik = NULL; -- false
SELECT * FROM jikwon WHERE jikwonjik IS NULL; -- true

SELECT * FROM jikwon LIMIT 3;
SELECT * FROM jikwon ORDER BY jikwonno DESC LIMIT 3;
SELECT * FROM jikwon LIMIT 5, 3; -- 시작행, 갯수 ==> index 0부터 시작이라  5,3 은 6부터 3개 출력

SELECT jikwonno AS 직원번호,jikwonname AS 직원명,jikwonjik AS 직급,
jikwonpay AS 연봉, jikwonpay / 12 AS 보너스, jikwonibsail AS 입사일
FROM jikwon
WHERE jikwonjik IN('과장', '부장', '사원')
AND jikwonpay >= 4000 
AND jikwonibsail BETWEEN '2015-01-01' AND '2019-12-31'
ORDER BY jikwonjik, jikwonpay DESC LIMIT 3;

-- 내장함수 : 데이터 조작의 효율성 증진이 목적
-- 단일 행 함수 : 각 행에 대해 작업한다. 행 단위 처리
-- 문자 함수

SELECT LOWER('Hello'), UPPER('Hello') FROM DUAL;
SELECT SUBSTR('hello world', 3),SUBSTR('hello world', 3, 3),
SUBSTR('hello world', -3,3) FROM DUAL;
SELECT LENGTH('hello world'), INSTR('hello world', 'e') FROM DUAL;
SELECT REPLACE('010.1111.2222','.','-') FROM DUAL; -- 문자 치환
-- ...
-- jikwon 테이블에서 이름에 '이'가 포함된 직원이 있으면 '이'부터 두글자 출력하기
SELECT jikwonname, SUBSTR(jikwonname, INSTR(jikwonname,'이'),2) 
FROM jikwon WHERE jikwonname LIKE '%이%';


-- 숫자 함수
SELECT ROUND(45.678, 2),ROUND(45.678),ROUND(45.678, 0),ROUND(45.678, -1) FROM DUAL;
SELECT jikwonname, jikwonpay, jikwonpay * 0.25 AS tax, 
ROUND(jikwonpay * 0.25,0) FROM jikwon;

SELECT TRUNCATE(45.678,0),TRUNCATE(45.678,1),TRUNCATE(45.678,-1) FROM DUAL;
SELECT MOD(15,2), 15/2 from DUAL;
SELECT GREATEST(23, 25, 5, 1, 12),LEAST(23, 25, 5, 1, 12) FROM DUAL;

-- 날짜 함수
SELECT NOW(), NOW() + 2, SYSDATE(), CURDATE() FROM DUAL;
SELECT NOW(), SLEEP(3), NOW();						 -- 하나의 query 내에서는 동일 값 출력
SELECT SYSDATE(), SLEEP(3), SYSDATE() FROM DUAL; -- 실행 시점값 출력
SELECT ADDDATE('2020-08-01' , 3),ADDDATE('2020-08-01' , -3), -- 윤년 check //  날짜 더하고 빼기
SUBDATE('2020-08-01',3);

SELECT DATE_ADD(NOW(),INTERVAL 1 MINUTE),
DATE_ADD(NOW(),INTERVAL 5 DAY ),
DATE_ADD(NOW(),INTERVAL 2 MONTH) FROM DUAL; -- year도 있음

SELECT DATEDIFF(NOW(),'2025-05-01');

-- 형변환 함수
SELECT NOW(), DATE_FORMAT(NOW(), '%Y%m%d'),DATE_FORMAT(NOW(), '%Y년%m월%d일');
SELECT jikwonname, jikwonibsail, DATE_FORMAT(jikwonibsail, '%W') 
FROM jikwon WHERE busernum = 10;

SELECT STR_TO_DATE('2026-02-12','%Y-%m-%d');
SELECT STR_TO_DATE('2026-02-12 13:16:34','%Y-%m-%d %H:%i:%S');

-- 기타 함수
-- rank() : 순위 결정
SELECT jikwonno, jikwonname, jikwonpay,
RANK() OVER (ORDER  BY jikwonpay) AS result,
DENSE_RANK() OVER (ORDER BY jikwonpay) AS result2 FROM jikwon;

SELECT jikwonno, jikwonname, jikwonpay,
RANK() OVER (ORDER  BY jikwonpay DESC ) AS result,
DENSE_RANK() OVER (ORDER BY jikwonpay DESC ) AS result2 FROM jikwon;

-- nvl(value1, value2) : value1 이 null이면 value2를 취함
SELECT jikwonname, jikwonjik, nvl(jikwonjik, '임시직') FROM jikwon;

-- nvl2(value1, value2, value3) : value1이 null이면 value3, 아니면 value2 취함
SELECT jikwonname, jikwonjik, nvl2(jikwonjik, '정규직', '임시직') FROM jikwon;

-- nullif(value1, value2) : 두 개의 값이 일치하면 null, 아니면 value1 취함
SELECT jikwonname, jikwonjik, NULLIF(jikwonjik, '대리') FROM jikwon;

-- 조건 표현식
-- 형식 1)
-- case 표현식 when 비교값 1 then 결과값1  when 비교값2 then 결과값2...[else 결과값n] end as 별명
SELECT case 10 / 5 
when 5 then '안녕' 
when 2 then '반가워' 
ELSE '잘가' END AS 결과 FROM DUAL;

SELECT jikwonname, jikwonpay, jikwonjik,
case jikwonjik
when '이사' then jikwonpay * 0.05
when '부장' then jikwonpay * 0.04
when '과장' then jikwonpay * 0.03
else jikwonpay * 0.02 END donation FROM jikwon;

-- 형식 2)
-- case when 조건1 then 결과값1  when 조건2 then 결과값2...[else 결과값n] end as 별명
SELECT jikwonname, 
case when jikwongen = '남' then '남성' 
when jikwongen = '여' then '여성'
END AS gender FROM jikwon;

SELECT jikwonname, jikwonpay,
case 
when jikwonpay >= 7000 then '우수연봉'
when jikwonpay >= 5000 then '보통연봉'
ELSE '저조' END AS result FROM jikwon
WHERE jikwonjik IN ('대리', '과장');

-- if(조건) 참값, 거짓값 as 별명
SELECT jikwonname, jikwonpay, TRUNCATE(jikwonpay/1000,0) FROM jikwon;

SELECT jikwonname, jikwonpay, jikwonjik,
if(TRUNCATE(jikwonpay/1000,0) >= 5, 'good', 'normal') as result FROM jikwon; 

-- 문제1
-- 근속년수 구하기 : 
-- DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(jikwonibsail, '%y')
-- DATEDIFF(NOW(), jikwonibsail)
SELECT jikwonname AS 직원명,  TIMESTAMPDIFF(year,jikwonibsail,'2024-02-12') AS  근무년수,
if(TIMESTAMPDIFF(year,jikwonibsail,'2026-02-12') >=10, '감사합니다','열심히') AS 표현,
if(TIMESTAMPDIFF(year,jikwonibsail,'2026-02-12') >=5, ROUND(jikwonpay * 0.05), ROUND(jikwonpay*0.03)) AS 특별수당
FROM jikwon;

--문제2

SELECT jikwonname AS 직원명, jikwonjik AS 직급, 
REPLACE(jikwonibsail, '-', '.') AS 입사년월일,
case 
when TIMESTAMPDIFF(year,jikwonibsail,'2026-02-12')>=10 then '왕고참'
when TIMESTAMPDIFF(year,jikwonibsail,'2026-02-12')>=5 then '고참'
ELSE '일반' END AS 구분,
case 
when busernum = 10 then '총무부'
when busernum = 20 then '영업부'
when busernum = 30 then '전산부'
when busernum = 40 then '관리부'
END AS 부서 FROM jikwon;

--문제3

SELECT jikwonno AS 사번, jikwonname AS 직원명,
busernum AS 부서,
jikwonpay AS 연봉,
case
when busernum = 10 then ROUND(jikwonpay * 0.01)
when busernum = 30 then ROUND(jikwonpay * 0.02)
ELSE '동결' END AS 인상연봉,
if(TIMESTAMPDIFF(year,jikwonibsail,'2026-02-12') >=10, 'O', 'X') AS 장기근속
FROM jikwon;


-- 집게함수(복수행 함수) : 전체 자료를 그룹별로 구분해 통계 결과를 얻기 위한 함수
SELECT SUM(jikwonpay) AS 합,AVG(jikwonpay) AS 평균 FROM jikwon;
SELECT MAX(jikwonpay) AS 최대값,MIN(jikwonpay) AS 최소값 FROM jikwon;

SELECT * FROM jikwon;
UPDATE jikwon SET jikwonpay=NULL WHERE jikwonno = 5;
SELECT * FROM jikwon;
DESC jikwon;
--     null제외하고진행, NULL을 0으로 바꿔서 작업시킴
SELECT AVG(jikwonpay), AVG(nvl(jikwonpay,0)) FROM jikwon; -- NULL은 작업에서 제외하고 처리
SELECT SUM(jikwonpay) / 29, SUM(jikwonpay) / 30 FROM jikwon;
SELECT SUM(jikwonpay), AVG(jikwonpay) FROM jikwon;

SELECT COUNT(jikwonno), COUNT(jikwonpay), COUNT(jikwonjik) FROM jikwon;
SELECT STDDEV(jikwonpay) AS 표준편차, VAR_SAMP(jikwonpay) as 분산 FROM jikwon;
SELECT COUNT(*) AS 인원수 FROM jikwon; -- NULL찾기 귀찮을 때 사용

SELECT COUNT(*) AS 인원,VAR_SAMP(jikwonpay) as 분산 FROM jikwon WHERE busernum = 10; 
SELECT COUNT(*) AS 인원,VAR_SAMP(jikwonpay) as 분산 FROM jikwon WHERE busernum = 20;




