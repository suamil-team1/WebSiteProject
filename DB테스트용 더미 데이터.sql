# 게시판 테이블 테스트용 더미데이터

insert into Model2Board(id,title,content,boardName)
    values('hj0825','로그인 연동 테스트','처음 뵙겠습니다', 'prt');


# 멤버 테이블 테스트용 더미데이터

INSERT INTO Projectmember(id, pass, name, email, mobile,address) 
	VALUES ('test', '1234', '김검사', 'test1@naver.com', '010-1234-5678','서울시 서울구 서울로20길 서울아파트');
INSERT INTO Projectmember(id, pass, name, email, mobile,address) 
	VALUES ('test2', '1234', '이검수', 'test2@hanmail.net', '010-1111-2222','서울시 서울구 서울로20길 서울아파트');
INSERT INTO Projectmember(id, pass, name, email, mobile,address) 
	VALUES ('hj0825', '890825', '임시험', 'hj0825@gmail.com', '010-3333-9999','경기도 수원시 권광로 21번길 보성아파트');


#캘린더형 게시판 테이블 테스트용 더미데이터

INSERT INTO Model2BoardCal (id, title, content, pdate, boardName)
	VALUES ('test' , '12월의 첫날' , '12월의 첫날 입니다.', to_date('12/01/2021', 'mm/dd/yyyy'), 'cal');


#수아몰 테이블 테스트용 더미데이터

INSERT INTO product(pname, pcontent, price, point, id, eaNum, delivery, delVer)
   VALUES ('참기름','고소해요','3000','300', 'test', '1', '0','무료배송' ); 

INSERT INTO product(pname, pcontent, price, point, id, eaNum, delivery, delVer)
   VALUES ('피자','맛있어요','20000','2000', 'test', '1', '3000','택배배송' ); 
    
insert into product(pname, pcontent, price, point, id, eaNum, delivery, delVer)
   values('맥주','짱 맛있어요','50000','5000', 'test1', '1', '3000','직접배달' ); 
