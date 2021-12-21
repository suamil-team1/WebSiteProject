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
    values(seq_prtBoard_idx.nextval,'test','자료실 제목1입니다.','내용', 'not');
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_prtBoard_idx.nextval,'test','자료실 제목2입니다.','내용', 'not');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test','자료실 제목3입니다.','내용3', 'not');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test2','자료실 제목4입니다.','내용4', 'not');
insert into Model2Board(idx, id, title, content, boardName )
    values(seq_prtBoard_idx.nextval,'test2','자료실 제목1입니다.','내용', 'fre');
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_prtBoard_idx.nextval,'test2','자료실 제목2입니다.','내용', 'fre');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test1','자료실 제목3입니다.','내용3', 'fre');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test2','자료실 제목4입니다.','내용4', 'fre');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_prtBoard_idx.nextval,'test5','자료실 제목5입니다.','내용5', 'fre');

SELECT B.*, M.name
  			   FROM Model2Board B INNER JOIN Projectmember M 
  			   ON B.id = M.id
  			   WHERE idx=2 ;

drop table Projectmember;
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
insert into Projectmember(id, pass, name ,mobile, address) values ('test', '1234', '테스트','01000000000','서울시 서울구 서울로20길 서울아파트');
insert into Projectmember(id, pass, name ,mobile, address) values ('test2', '1234', '테스트','01000000000','서울시 서울구 서울로20길 서울아파트');

drop table pboard;

ALTER TABLE Model2Board
	ADD CONSTRAINT pBoard_mem_fk
	FOREIGN KEY (id)
	REFERENCES Projectmember (id)
;

alter table PROJECTMEMBER DROP CONSTRAINT SYS_C007639;

select * from user_constraints;

create sequence seq_empBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

create sequence seq_prtBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    


commit;

/*
--유미 보영
drop table mdl1brd;
create table mdl1brd(
    idx number primary key,--일련번호
    id varchar2(30) not null, --member
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

insert into mdl1brd(idx, id, email, title, content, pass)
    values(seq_mdl1brd_idx.nextval,'kim','babo@naver.com','자료실 제목1입니다.','내용','1234');
insert into mdl1brd(idx, id , email, title, content, pass)
    values(seq_mdl1brd_idx.nextval,'kim2','bapo@naver.com','자료실 제목2입니다.','내용','1234');
    
select Tb.*, rownum rNum from(
    select*from mdl1brd order by idx desc) Tb; */

commit;

