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
# ___________________________________________________________________________________________________

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

# group by 연습
# 문제1 : 직급별 급여의 평균 (NULL 직급 제외)
SELECT jikwonjik AS 직급, SUM(jikwonpay) AS 급여합, AVG(jikwonpay) AS 급여평균
FROM jikwon -- where jikwonjik is not null 도 ㄱㅊㄱㅊ
GROUP BY jikwonjik HAVING jikwonjik IS NOT NULL;

# 문제2 : 부장, 과장에 대해 직급별 급여의 총합
SELECT jikwonjik AS 직급, SUM(jikwonpay) AS 급여합 FROM jikwon 
WHERE jikwonjik IN ('부장',  '과장') -- jikwonjik = '부장' or jikwonjik = '과장' 도 ㄱㅊㄱㅊ
GROUP BY jikwonjik;

# 문제3 : 2015년 이전에 입사한 자료 중 년도별 직원 수 출력
SELECT COUNT(*) AS 직원수, DATE_FORMAT(jikwonibsail, '%Y') AS 2015년이전 FROM jikwon 
WHERE jikwonibsail <= '2014-12-31'
GROUP BY DATE_FORMAT(jikwonibsail, '%Y');

# 문제4 : 직급별 성별 인원수, 급여합 출력 (NULL인 직급은 임시직으로 표현)
SELECT nvl(jikwonjik, '임시직') AS 직급, jikwongen AS 성별, 
SUM(jikwonpay) AS 급여합, COUNT(*) AS 인원수 FROM jikwon
GROUP BY nvl(jikwonjik, '임시직'), jikwongen;

# 문제5 : 부서번호 10, 20 에대한 부서별 급여 합 출력
SELECT busernum AS 부서번호, SUM(jikwonpay) AS 급여합 FROM jikwon
WHERE busernum IN (10, 20)
GROUP BY busernum; 

# 문제6 : 급여의 총합이 7000 이상인 직급 출력(NULL인 직급은 임시직으로 표현)
SELECT  nvl(jikwonjik, '임시직') AS 직급, SUM(jikwonpay) AS 급여합 
FROM jikwon GROUP BY nvl(jikwonjik, '임시직') 
HAVING SUM(jikwonpay) >= 7000;

# 문제7 : 직급별 인원수, 급여합계를 구하되 인원수가 3명 이상인 직급만 출력(NULL인 직급은 임시직으로 표현)
SELECT nvl(jikwonjik,'임시직') AS 직급, COUNT(*) AS 인원수, SUM(jikwonpay) AS 급여합 
FROM jikwon GROUP BY jikwonjik 
HAVING COUNT(*) >= 3;

# JOIN 연습1
# 문제 1 : 직급이 '사원'인 직원이 관리하는 고객자료 출력
SELECT jikwonno AS 사번, jikwonname AS 직원명, jikwonjik AS 직급,
gogekname AS 고객명, gogektel AS 고객전화,
case
when SUBSTR(gogekjumin,8,1) IN ('1', '3') then '남'
when SUBSTR(gogekjumin,8,1) IN ('2', '4') then '여'
ELSE "사람아님" END AS 고객성별
FROM jikwon INNER JOIN gogek ON jikwonno = gogekdamsano
WHERE jikwonjik = '사원';

# 문제 2 : 직원별 고객 확보 수 <== group by 사용
SELECT jikwonno AS 사번, jikwonname AS 직원이름, jikwonjik AS 직급,
gogekname AS 고객명, COUNT(gogekname) AS 고객확보
FROM jikwon LEFT OUTER JOIN gogek ON jikwonno = gogekdamsano
GROUP BY jikwonno;

# 문제 3 : 고객이 담당직원의 자료를 보고 싶을 때 즉, 고객명을 입력하면, 담당직원 자료 출력
SELECT jikwonname AS 직원명, jikwonjik AS 직급 
FROM jikwon INNER JOIN gogek 
ON jikwonno = gogekdamsano
WHERE gogekname = '강나루';

# 문제 4 : 직원명을 입력하면 관리고객 자료 출력
SELECT gogekname AS 고객명, gogektel AS 고객전화, gogekjumin AS 주민번호,
(YEAR(SYSDATE()) - (1900 + LEFT(gogekjumin, 2)) + 1) AS 나이
FROM gogek INNER JOIN jikwon ON gogekdamsano = jikwonno
WHERE jikwonname = '이순신';

-- 세 개의 테이블 조인 : 두 개를 먼저 조인 후 그 결과와 나머지 테이블로 조인
SELECT jikwonname, busername, gogekname FROM jikwon, buser, gogek
WHERE busernum = buserno AND jikwonno = gogekdamsano;

SELECT jikwonname,busername,gogekname FROM jikwon
INNER JOIN buser ON busernum = buserno
INNER JOIN gogek ON jikwonno = gogekdamsano;

# JOIN 연습2
-- 문제 1 : 총무부에서 관리하는 고객수 출력 (고객 30살 이상만 작업에 참여)
SELECT busername AS 부서, COUNT(*) AS 고객수 
FROM jikwon
INNER JOIN buser ON busernum = buserno
INNER JOIN gogek ON jikwonno = gogekdamsano
WHERE busername = '총무부'  AND (YEAR(SYSDATE()) - (1900 + LEFT(gogekjumin, 2)) + 1) >= 30
GROUP BY busername;

-- 문제 2 : 부서명별 고객 인원수 (부서가 없으면 "무소속")
SELECT busername AS 부서, COUNT(gogekno) AS 고객수 FROM jikwon
LEFT JOIN buser ON busernum = buserno
INNER JOIN gogek ON jikwonno = gogekdamsano
GROUP BY buserno;

-- 문제 3 : 고객이 담당직원의 자료를 보고 싶을 때 즉, 고객명을 입력하면 담당직원 자료 출력
SELECT jikwonname AS 직원명, jikwonjik AS 직급, busername AS 부서명, 
busertel AS 부서전화, jikwongen AS 성별 FROM jikwon
INNER JOIN buser ON busernum = buserno
INNER JOIN gogek ON jikwonno = gogekdamsano
WHERE gogekname = '강나루';

# SubQeury 연습문제
# 문1) 2010년 이후 입사한 남자 중 급여를 가장 많이 받는 직원은?
SELECT * FROM jikwon
WHERE jikwongen = '남' AND jikwonibsail > '2010-01-01' AND 
jikwonpay = (SELECT MAX(jikwonpay) FROM jikwon WHERE jikwonibsail > '2010-01-01' 
AND jikwongen = '남');

# 문2) '이미라' 직원의 입사 이후에 입사한 직원은?
SELECT * FROM jikwon
WHERE jikwonibsail > (SELECT jikwonibsail FROM jikwon WHERE jikwonname = '이미라');

# 문3) 평균급여보다 급여를 많이 받는 직원은?
SELECT * FROM jikwon
WHERE jikwonpay > (SELECT AVG(jikwonpay) FROM jikwon);

# 문4) 2010 ~ 2015년 사이에 입사한 총무부(10), 영업부(20), 전산부(30) 직원 중 급여가 가장 적은 사람은?
# 직급이 NULL인 자료는 작업에서 제외
SELECT * FROM jikwon
WHERE jikwonibsail BETWEEN '2010-01-01' AND '2015-12-31' AND
busernum IN (10, 20, 30) AND 
jikwonpay = (SELECT MIN(jikwonpay) FROM jikwon 
WHERE jikwonibsail BETWEEN '2010-01-01' AND '2015-12-31' AND
busernum IN (10, 20, 30)) AND jikwonjik IS NOT NULL ;

# 문5) 한송이, 이순신과 직급이 같은 사람은 누구인가?
SELECT * FROM jikwon
WHERE jikwonjik IN (SELECT jikwonjik FROM jikwon WHERE jikwonname IN('한송이', '이순신'))
AND jikwonname NOT IN('한송이', '이순신');

# 문6) 과장 중에서 최대급여, 최소급여를 받는 사람은?
SELECT * FROM jikwon 
WHERE jikwonjik = '과장' AND 
jikwonpay IN ((SELECT MAX(jikwonpay) FROM jikwon WHERE jikwonjik = '과장'),
(SELECT MIN(jikwonpay) FROM jikwon WHERE jikwonjik = '과장')); 

# 문7) 10번 부서의 최소급여보다 많은 사람은?
SELECT * FROM jikwon
WHERE busernum = 10 AND jikwonpay > (SELECT MIN(jikwonpay) FROM jikwon WHERE busernum = 10);

# 문8) 30번 부서의 평균급여보다 많은 '대리'는 몇명인가?
SELECT COUNT(jikwonjik) AS 대리인원수 FROM jikwon
WHERE jikwonjik = '대리' AND
jikwonpay > (SELECT AVG(jikwonpay) FROM jikwon WHERE busernum = 30);

# 문9) 고객을 확보하고 있는 직원들의 이름, 직급, 부서명을 입사일 별로 출력하라
SELECT DISTINCT jikwonname AS 직원이름, jikwonjik AS 직급, busername AS 부서명, jikwonibsail AS 입사일 FROM jikwon 
LEFT JOIN buser ON busernum = buserno
INNER JOIN gogek ON jikwonno = gogekdamsano
WHERE jikwonno IN (SELECT gogekdamsano FROM gogek) ORDER BY jikwonibsail ASC ;


# 문제10)  이순신과 같은 부서에 근무하는 직원과 해당 직원이 관리하는 고객 출력
# (고객은 나이가 30 이하면 '청년', 50 이하면 '중년', 그 외는 '노년'으로 표시하고, 고객 연장자 부터 출력)
SELECT jikwonname AS 직원이름, busernum AS 부서, gogekname AS 고객이름,
case 
when (YEAR(CURDATE()) - (1900 + LEFT(gogekjumin, 2)) + 1) <= 30 then '청년'
when (YEAR(CURDATE()) - (1900 + LEFT(gogekjumin, 2)) + 1) <= 50 then '중년'
ELSE '노년' 
END AS '고객분류' FROM jikwon
INNER JOIN gogek ON jikwonno = gogekdamsano
WHERE busernum = (SELECT busernum FROM jikwon WHERE jikwonname = '이순신')
ORDER BY gogekjumin ASC;

#1. INNER JOIN (교집합)
#"양쪽에 데이터가 다 있는 것만 가져와!"
#언제 쓰나: 서로 연결 고리가 확실한 데이터만 보고 싶을 때 씁니다.
#예시: 부서 번호를 가진 직원과 실제 그 번호가 존재하는 부서를 합칠 때.
#결과: 부서가 없는 신입 사원이나, 직원이 한 명도 없는 신입 부서는 결과에서 제외됩니다.
#2. LEFT (OUTER) JOIN (왼쪽 기준)
#"왼쪽은 무조건 다 보여주고, 오른쪽은 있으면 가져오고 없으면 말아!"
#언제 쓰나: '누락'되면 안 되는 메인 데이터가 왼쪽에 있을 때 씁니다.
#예시: 전체 직원 명단을 뽑으면서 부서명을 옆에 붙일 때.
#결과: 부서가 아직 정해지지 않은 직원도 명단에 나옵니다. (대신 부서명 칸은 NULL로 표시되겠죠.)
#3. RIGHT (OUTER) JOIN (오른쪽 기준)
#"오른쪽은 무조건 다 보여주고, 왼쪽은 있으면 가져오고 없으면 말아!"
#언제 쓰나: 사실 LEFT JOIN과 방향만 반대라 실무에서는 잘 안 씁니다. (테이블 순서만 바꾸면 LEFT JOIN이 되니까요.)
#예시: 전체 부서 목록을 보면서, 각 부서에 누가 근무하는지 알고 싶을 때.
#결과: 직원이 한 명도 없는 유령 부서도 부서 이름이 결과에 나타납니다.

#1. OUTER JOIN의 핵심 개념
#INNER JOIN이 **"조건에 맞는 행만!"**이라면, OUTER JOIN은 **"조건에 안 맞아도 일단 한쪽(또는 양쪽)은 다 보여줘!"**입니다.
#LEFT OUTER JOIN: 왼쪽 테이블의 모든 데이터를 가져옵니다. 오른쪽 테이블에 짝이 없으면 NULL로 채웁니다.
#RIGHT OUTER JOIN: 오른쪽 테이블의 모든 데이터를 가져옵니다. 왼쪽 테이블에 짝이 없으면 NULL로 채웁니다.
#FULL OUTER JOIN: 왼쪽, 오른쪽 가리지 않고 일단 양쪽 데이터를 전부 다 가져옵니다. 짝이 있으면 합치고, 없으면 없는 대로 NULL을 넣어 보여줍니다.



-- 문항7) buser 테이블에서 buserno(부서번호)가 3인 데이터(레코드)를 삭제하는 SQL 구문을 작성하시오.

DELETE FROM buser WHERE buserno = 3;

--  문항9) jikwon 테이블과 buser 테이블을 이용하여 직급이 '과장'인 직원만 조회하는 query문을 작성하시오.
-- 조건 : join 사용
--  jikwonno  jikwonname  busername  jikwonjik
--     3         이순신     영업부     과장

SELECT jikwonno, jikwonname, busername, jikwonjik FROM jikwon
INNER JOIN buser ON busernum = buserno
WHERE jikwonjik = '과장';

-- [문항11] jikwon 테이블에서 연봉이 5000 이상이고 7000 이하인 직원을 검색하여 직원번호, 직원명, 연봉을 출력하는 SQL문을 
-- 두 가지 방법(and, between)으로 작성하시오.

SELECT jikwonno AS 직원번호, jikwonname AS 직원명, jikwonpay AS 연봉 FROM jikwon
WHERE jikwonpay >= 5000 AND jikwonpay <= 7000;

SELECT jikwonno AS 직원번호, jikwonname AS 직원명, jikwonpay AS 연봉 FROM jikwon
WHERE jikwonpay BETWEEN 5000 AND 7000;


-- [문항12] jikwon 테이블을 사용하여 평균 연봉보다 연봉이 높은 직원들을 모두 출력하는 select 문(sub query)을 작성하시오. 
-- 칼럼은 모두 출력.
SELECT * FROM jikwon
WHERE jikwonpay > (SELECT AVG(jikwonpay) FROM jikwon);

-- [문항13] 아래 두 개의 ERD를 보고 테이블 생성을 위한 DDL문을 MariaDB 형식에 맞게 작성하시오.
-- customers          ----------        orders
-- ==================================
-- pk  cno  : 정수                            pk  ono : 정수 
-- ---------------------------------------------------------
--     cname : 고정문자(10)          odate : 날짜시간
--     caddress : 가변문자(50)      oaddress : 가변문자(50)
--     cemail  : 고정문자(20)        ophone : 가변문자(20)
--     cphone : 가변문자(20)        ostatus : 가변문자(10)
--                                             ono_cus : fk
-- ==================================

CREATE TABLE customers(cno INT PRIMARY KEY, cname CHAR(10), caddress VARCHAR(50), cemail CHAR(20), cphone VARCHAR(20));

CREATE TABLE orders(ono INT PRIMARY KEY, odate DATETIME DEFAULT CURRENT_TIMESTAMP, oaddress VARCHAR(10), 
ophone VARCHAR(20), ostatus VARCHAR(10), ono_cus INT, FOREIGN KEY(ono_cus) REFERENCES customers(cno));

-- [문항14] jikwon 테이블을 사용하기로 한다.
-- 2015 ~ 2020 년 사이에 입사한 직원을 대상으로 년도별 인원수와 연봉평균을 출력하는 DML문을 기술하시오.
SELECT DATE_FORMAT(jikwonibsail, '%Y') AS 년도, COUNT(*) AS 인원수, AVG(jikwonpay) AS 연봉평균 FROM jikwon
WHERE jikwonibsail BETWEEN '2015-01-01' AND '2020-12-31'
GROUP BY DATE_FORMAT(jikwonibsail, '%Y')


-- [문항15] jikwon, gogek 테이블을 사용해 '평균 급여보다 급여가 높은 직원과 
-- 그 직원이 담당하는 고객 수'를 조회하는 select 문을 작성하시오.
-- 직원명  급여  고객수
-- 홍길동  9900    1

SELECT jikwonname AS 직원명, jikwonpay AS 급여, COUNT(*) AS 고객수 FROM jikwon
LEFT OUTER JOIN gogek ON jikwonno = gogekdamsano
WHERE jikwonpay > (SELECT AVG(jikwonpay) FROM jikwon)
GROUP BY jikwonname
DESC;



















