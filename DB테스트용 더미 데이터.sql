# 멤버 테이블 테스트용 더미데이터

INSERT INTO Projectmember(id, pass, name, email, mobile,address) 
	VALUES ('test', '1234', '김검사', 'test1@naver.com', '010-1234-5678','11900,서울시 서울구 서울로20길 서울아파트,11');
INSERT INTO Projectmember(id, pass, name, email, mobile,address) 
	VALUES ('test2', '1234', '이검수', 'test2@hanmail.net', '010-1111-2222','11900,서울시 서울구 서울로20길 서울아파트,5층');
INSERT INTO Projectmember(id, pass, name, email, mobile,address) 
	VALUES ('hj0825', '890825', '임시험', 'hj0825@gmail.com', '010-3333-9999','34560,경기도 수원시 권광로 21번길 보성아파트,가나다');
INSERT INTO Projectmember(id, pass, name, email, mobile,address,type) 
	VALUES ('admin', '1234', '어드민', 'tjcos3@hanmail.net', '010-1234-1111','08505,서울 금천구 가산디지털2로 123,4층',0);
#zip코드 붙이기 위해서 수정	
 UPDATE projectmember SET address='34560,경기도 수원시 권광로 21번길 보성아파트,가나다' WHERE id ='hj0825';

# 게시판 테이블 테스트용 더미데이터

insert into Model2Board(id,title,content,boardName)
    values('hj0825','로그인 연동 테스트','처음 뵙겠습니다', 'prt');


#캘린더형 게시판 테이블 테스트용 더미데이터

INSERT INTO Model2BoardCal (id, title, content, pdate, boardName)
	VALUES ('test' , '12월의 첫날' , '12월의 첫날 입니다.', (DATE_FORMAT('2021/12/01', '%Y/%m/%d')), 'cal');
#밑에 to_date쓰면 에러남
/*	VALUES ('test' , '12월의 첫날' , '12월의 첫날 입니다.', to_date('12/01/2021', 'mm/dd/yyyy'), 'cal');*/


#수아몰 상품 테이블 테스트용 더미데이터
insert into product(pname, pcontent,pNum,price,point)
    values('참기름','고소해요','1','30000원','300포인트');

insert into product(pname, pcontent,pNum,price,point)
    values('간장','짜요','2','20000원','200포인트');


#수아몰 장바구니 테이블 테스트용 더미데이터
insert into basket(pNum,id,eaNum,sump,delivery,delVer)
    values('1','test','5','300000원','2500원','기본배송'); 

insert into basket(pNum,id,eaNum,sump,delivery,delVer)
    VALUES('2','test1','6','200000원','2500원','기본배송');