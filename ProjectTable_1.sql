drop table Model2Board;
create table Model2Board(
    idx number primary key,--�Ϸù�ȣ
    id varchar2(30) not null,
    --name varchar2(50) not null,--�ۼ��ڸ�
    --email varchar2(50) not null,
    title varchar2(300) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),--÷�������� �������ϸ�
    sfile varchar2(30),--������ ���� ����� ���ϸ�
    --pass varchar2(50) not null,--��й�ȣ(����,�������� Ȯ���� ���� ���)
    visitcount number default 0 not null, --�Խù� ��ȸ��
    boardName varchar2(30)
    );
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_board_num.nextval,'kim','�ڷ�� ����1�Դϴ�.','����', 'F');
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_board_num.nextval,'kim2','�ڷ�� ����2�Դϴ�.','����', 'F');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_board_num.nextval,'test1','�ڷ�� ����3�Դϴ�.','����3', 'F');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_board_num.nextval,'test2','�ڷ�� ����4�Դϴ�.','����4', 'F');
insert into Model2Board(idx, id, title, content, boardName )
    values(seq_board_num.nextval,'kim','�ڷ�� ����1�Դϴ�.','����', 'N');
insert into Model2Board(idx, id, title, content,  boardName)
    values(seq_board_num.nextval,'kim2','�ڷ�� ����2�Դϴ�.','����', 'N');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_board_num.nextval,'test1','�ڷ�� ����3�Դϴ�.','����3', 'N');
insert into Model2Board(idx, id, title, content, boardName)
    values(seq_board_num.nextval,'test2','�ڷ�� ����4�Դϴ�.','����4', 'N');

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

insert into Projectmember(id, pass, name, email, mobile,address) values ('test', '1234', '�׽�Ʈ', 'apple@naver.com', '01000000000','����� ���ﱸ �����20�� �������Ʈ');

ALTER TABLE Model2Board
	ADD CONSTRAINT pBoard_mem_fk
	FOREIGN KEY (id)
	REFERENCES Projectmember (id)
;

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
--���� ����
drop table mdl1brd;
create table mdl1brd(
    idx number primary key,--�Ϸù�ȣ
    id varchar2(30) not null, --member
    email varchar2(50) not null, 
    title varchar2(200) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),--÷�������� �������ϸ�
    sfile varchar2(30),--������ ���� ����� ���ϸ�
    pass varchar2(50) not null,--��й�ȣ(����,�������� Ȯ���� ���� ���)
    visitcount number default 0 not null--�Խù� ��ȸ��
    );
    
create sequence seq_mdl1brd_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

insert into mdl1brd(idx, id, email, title, content, pass)
    values(seq_mdl1brd_idx.nextval,'kim','babo@naver.com','�ڷ�� ����1�Դϴ�.','����','1234');
insert into mdl1brd(idx, id , email, title, content, pass)
    values(seq_mdl1brd_idx.nextval,'kim2','bapo@naver.com','�ڷ�� ����2�Դϴ�.','����','1234');
    
select Tb.*, rownum rNum from(
    select*from mdl1brd order by idx desc) Tb; */

commit;

SELECT id FROM ProjectMember WHERE name='�׽�Ʈ' AND email='apple@naver.com';

