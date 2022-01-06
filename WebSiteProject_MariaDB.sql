/*
#DB 생성
MariaDB [mysql]> create database hj890825;
#계정 생성
MariaDB [mysql]> create user 'hj890825'@'hj890825.cafe24.com' identified by 'varan@1350';
#계정에 DB관련 권한 부여
MariaDB [mysql]> grant all privileges on hj890825.* to 'hj890825'@'hj890825.cafe24.com';
#새로고침
MariaDB [mysql]> flush privileges;
*/

DROP TABLE Model2Board;
# 일반 게시판 테이블(자식)
create table Model2Board(
	idx INT PRIMARY KEY AUTO_INCREMENT NOT NULL,	#일련번호
	id VARCHAR(30) not null,
	title VARCHAR(300) not null,
	content TEXT not null,
	postdate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ofile varchar(200),		#첨부파일의 원본파일명
	sfile varchar(30),	#서버에 실제 저장된 파일명
	visitcount SMALLINT DEFAULT 0 NOT NULL,	#게시물 조회수
	boardName VARCHAR(30)	#직원 emp, 보호자 prt, 공지 not, 자유fre, 사진 gal, 자료실 ref
);

DROP TABLE ProjectMember;
#회원 테이블(부모)
create TABLE ProjectMember
(
	id VARCHAR(30) NOT NULL,
	pass VARCHAR(40) NOT NULL,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	regidate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	tellNum VARCHAR(30),
	mobile VARCHAR(30) NOT NULL,
	address TEXT NOT NULL,
	type SMALLINT DEFAULT 2,	#0:관리자 / 1:직원 / 2:일반회원
	PRIMARY KEY (id)
);

#SELECT * FROM Projectmember WHERE id ='admin' AND pass='1234';




alter table Model2Board drop foreign key fk_M2Board_pMember;
#외래키 설정(일반 게시판 테이블 --> 멤버 테이블)
ALTER TABLE Model2Board ADD CONSTRAINT fk_M2Board_pMember
	FOREIGN KEY (id) REFERENCES ProjectMember (id);
	
	
#캘린더형 게시판 테이블(자식)
DROP TABLE Model2BoardCal;
CREATE TABLE Model2BoardCal(
	idx INT PRIMARY KEY AUTO_INCREMENT NOT NULL,	#일련번호
	id VARCHAR(30) NOT NULL,
	title VARCHAR(300) NOT NULL,
	content TEXT NOT NULL,
	pdate DATE NOT NULL,
	boardName VARCHAR(30)
);

#수아몰 테이블 
create table product(
	pname VARCHAR(50) NOT NULL, #상품명
	pcontent VARCHAR(200) NOT NULL,	#상품설명
	pNum VARCHAR(50) PRIMARY key unique NOT NULL,	#상품번호
	price VARCHAR(50) NOT NULL,	#가격
	imgfile VARCHAR(200),	#이미지파일
	POINT VARCHAR(50) NOT NULL	#적립금
);

#장바구니 
create table basket(
	pNum VARCHAR(50) unique NOT NULL,	#상품번호
	id VARCHAR(30) primary key not null,
	eaNum VARCHAR(50) NOT NULL,	#선택수량
	sump VARCHAR(50) NOT NULL,	#합계금액
	delivery VARCHAR(50) not NULL,	#배송방법
	delVer VARCHAR(50) not NULL	#배송구분(무료배송/택배배송/직접배달)
); 

#외래키(장바구니 --> 상품)
ALTER TABLE basket ADD CONSTRAINT product_basket_fk
   FOREIGN KEY (pNum) REFERENCES product (pNum); 

#상품 주문서
create table orderl(
    id VARCHAR(30) primary KEY NOT NULL,
    address TEXT NOT NULL,    #배송지
    pay VARCHAR(50) NOT NULL    #결제방법
); 

#외래키(장바구니와 상품주문서) ※ 실행은 잘되지만 확인 요망.
ALTER TABLE basket
	ADD CONSTRAINT basket_orderl_fk
	FOREIGN KEY (id)
	REFERENCES orderl (id)
;