-- model2 방식 게시판 테이블
create table Model2Board(
    idx number primary key,--일련번호
    id varchar2(30) not null,
    name varchar2(50) not null,--작성자명
    email varchar2(50),
    title varchar2(300) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),--첨부파일의 원본파일명
    sfile varchar2(30),--서버에 실제 저장된 파일명
    pass varchar2(50) not null,--비밀번호(수정,삭제에서 확인을 위해 사용)
    visitcount number default 0 not null, --게시물 조회수
    boardName varchar2(30) -- 직원 emp, 보호자 prt
    );
    
-- 테스트용 더미데이터
insert into Model2Board(idx,id,name,email,title,content,pass)
    values(seq_board_num.nextval,'kim','김유신','babo@naver.com','자료실 제목1입니다.','내용','1234');
insert into Model2Board(idx,id,name,email,title,content,pass)
    values(seq_board_num.nextval,'kim2','김춘추','bapo@naver.com','자료실 제목2입니다.','내용','1234');
commit;

-- 회원 테이블
create table Projectmember
(
    id varchar2(30) not null,
    pass varchar2(40) not null,
    name varchar2(50) not null,
    regidate date default sysdate,
    tellNum varchar2(30),
    mobile varchar2(30) not null,
    address varchar2(200) not null,
    primary key (id)
);

insert into Projectmember(id,pass, name,mobile,address) values ('test', '1234', '테스트','01000000000','서울시 서울구 서울로20길 서울아파트');

-- 모델2 게시판용 테이블 -> member 외래키
ALTER TABLE Model2Board
	ADD CONSTRAINT pBoard_mem_fk
	FOREIGN KEY (id)
	REFERENCES Projectmember (id)
;

-- 직원 자료실용 시퀀스
create sequence seq_empBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

-- 보호자 게시판 시퀀스
create sequence seq_prtBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

commit;


--유미 보영
drop table mdl1brd;
create table mdl1brd(
    idx number primary key,--일련번호
    id varchar2(30) not null,
    name varchar2(50) not null,--작성자명
    email varchar2(50) not null,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),--첨부파일의 원본파일명
    sfile varchar2(30),--서버에 실제 저장된 파일명
    pass varchar2(50) not null,--비밀번호(수정,삭제에서 확인을 위해 사용)
    visitcount number default 0 not null--게시물 조회수
    );
    
create sequence seq_mdl1brd_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

insert into mdl1brd(idx,id,name,email,title,content,pass)
    values(seq_mdl1brd_idx.nextval,'kim','김유신','babo@naver.com','자료실 제목1입니다.','내용','1234');
insert into mdl1brd(idx,id,name,email,title,content,pass)
    values(seq_mdl1brd_idx.nextval,'kim2','김춘추','bapo@naver.com','자료실 제목2입니다.','내용','1234');
    
select Tb.*, rownum rNum from(
    select*from mdl1brd order by idx desc) Tb;
    