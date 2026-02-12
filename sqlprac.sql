#교수 테이블
CREATE TABLE gsu(Gcode INT PRIMARY KEY, NAME CHAR(10), num INT CHECK ( num >= 100 AND num <=500));

INSERT INTO gsu VALUES (2401, '박유성', 486);
INSERT INTO gsu VALUES (3372, '이인수', 223);
INSERT INTO gsu VALUES (7163, '성유박', 99); -- err : num은 100보다 크거나 같고 500보다 작거나 같다.

SELECT * FROM gsu;
DROP TABLE gsu; -- 테이블 삭제

#과목 테이블
CREATE TABLE gwamok(Mcode INT AUTO_INCREMENT PRIMARY KEY, mokname char(10) NOT NULL UNIQUE, book CHAR(10), 
gcodeint INT, FOREIGN KEY(gcodeint) REFERENCES gsu(Gcode)); -- Mcode INT AUTO_INCREMENT PRIMARY KEY == 숫자 뭐를 입력하든 다음 입력은 +1 함.

INSERT INTO gwamok VALUES(1, 'MariaDB', '이것이MariaDB', 2401);
INSERT INTO gwamok(mokname, book, gcodeint) VALUES( 'python', 'python 기본', 3372);

SELECT * FROM gwamok;
DROP TABLE gwamok;

# 학생 테이블
CREATE TABLE haks(Hcode INT PRIMARY KEY, hakname CHAR(10), class INT DEFAULT 1 CHECK (class >= 1 AND class <= 4),
mcodeint INT, FOREIGN KEY(mcodeint) REFERENCES gwamok(Mcode)); -- 초기치 1 == DEFAULT 1

INSERT INTO haks VALUES(609, '김제형', 4, 1);
INSERT INTO haks VALUES(509, '유승우', 2, 2);
INSERT INTO haks VALUES(404, '김태현', 5, 1); -- err : class 4와 같거나 작다
INSERT INTO haks(Hcode, hakname, mcodeint) VALUES(404, '김규동', 2);

SELECT * FROM haks;
DROP TABLE haks;
--
