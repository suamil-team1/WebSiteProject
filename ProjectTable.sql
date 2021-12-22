drop table Model2Board;
create table Model2Board(
    idx number primary key,--일련번호
    id varchar2(30) not null,
    --name varchar2(50) not null,--작성자명
    --email varchar2(50) not null,
    title varchar2(300) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),--첨부파일의 원본파일명
    sfile varchar2(30),--서버에 실제 저장된 파일명
    --pass varchar2(50) not null,--비밀번호(수정,삭제에서 확인을 위해 사용)
    visitcount number default 0 not null, --게시물 조회수
    boardName varchar2(30)
    );
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_board_num.nextval,'kim','자료실 제목1입니다.','내용', 'F');
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_board_num.nextval,'kim2','자료실 제목2입니다.','내용', 'F');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_board_num.nextval,'test1','자료실 제목3입니다.','내용3', 'F');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_board_num.nextval,'test2','자료실 제목4입니다.','내용4', 'F');
insert into Model2Board(idx, id, title, content, boardName )
    values(seq_board_num.nextval,'kim','자료실 제목1입니다.','내용', 'N');
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_board_num.nextval,'kim2','자료실 제목2입니다.','내용', 'N');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_board_num.nextval,'test1','자료실 제목3입니다.','내용3', 'N');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_board_num.nextval,'test2','자료실 제목4입니다.','내용4', 'N');

drop table Projectmember;
create table Projectmember
(
    id varchar2(30) not null,
    pass varchar2(40) not null,
    name varchar2(50) not null,
    email varchar2(50) not null,
    regidate date default sysdate,
    tellNum varchar2(30),
    mobile varchar2(30) not null,
    address varchar2(200) not null,
    type number(10) default 2,
    primary key (id)
);

insert into Projectmember(id, pass, name, email, mobile,address) values ('test', '1234', '테스트', 'apple@naver.com', '01000000000','서울시 서울구 서울로20길 서울아파트');
insert into Projectmember(id, pass, name, email, mobile,address) values ('test2', '1234', '보내줘', 'tjcos3@hanmail.net', '01012345678','서울시 서울구 서울로20길 서울아파트');

ALTER TABLE Model2Board
	ADD CONSTRAINT pBoard_mem_fk
	FOREIGN KEY (id)
	REFERENCES Projectmember (id)
;
DROP SEQUENCE seq_empBoard_idx;
create sequence seq_empBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
DROP SEQUENCE seq_prtBoard_idx;
create sequence seq_prtBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    


commit;
