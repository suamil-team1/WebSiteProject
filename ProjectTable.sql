drop table Model2Board;

-- model2 ��� �Խ��� ���̺�
create table Model2Board(
    idx number primary key,--�Ϸù�ȣ
    id varchar2(30) not null,
    email varchar2(50),
    title varchar2(300) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),--÷�������� �������ϸ�
    sfile varchar2(30),--������ ���� ����� ���ϸ�
    visitcount number default 0 not null, --�Խù� ��ȸ��
    boardName varchar2(30) -- ���� emp, ��ȣ�� prt
);
    
-- �׽�Ʈ�� ���̵�����
insert into Model2Board(idx,id,email,title,content,boardName)
    values(seq_board_num.nextval,'age','age@oracle.com','���� �Խ��� �׽�Ʈ�� �Խù� 01','������������ �Ŷ��� ��29�� �ӱ�(����: 654��~661��)�̴�. ���������� �Ҹ��⵵ �Ѵ�.', 'emp');

insert into Model2Board(idx,id,email,title,content,boardName)
    values(seq_board_num.nextval,'yushin','ys@oracle.com','��ȣ�� �Խ��� �׽�Ʈ�� �Խù� 01',' �Ŷ� ������ ������ �����ϰ� �糪���� ������� �ﱹ ������ �̷�� ���� �������� ������ �� �Ŷ��� �屺�̸�, ��ġ���̴�.', 'prt');

commit;

-- ȸ�� ���̺�
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

insert into Projectmember(id,pass, name,mobile,address) values ('test', '1234', '�׽�Ʈ','01000000000','����� ���ﱸ �����20�� �������Ʈ');

-- ��2 �Խ��ǿ� ���̺� -> member �ܷ�Ű
ALTER TABLE Model2Board
	ADD CONSTRAINT pBoard_mem_fk
	FOREIGN KEY (id)
	REFERENCES Projectmember (id)
;

-- ���� �ڷ�ǿ� ������
create sequence seq_empBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

-- ��ȣ�� �Խ��� ������
create sequence seq_prtBoard_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

commit;

select * from Model2Board;


--���� ����
drop table mdl1brd;
create table mdl1brd(
    idx number primary key,--�Ϸù�ȣ
    id varchar2(30) not null,
    name varchar2(50) not null,--�ۼ��ڸ�
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

insert into mdl1brd(idx,id,name,email,title,content,pass)
    values(seq_mdl1brd_idx.nextval,'kim','������','babo@naver.com','�ڷ�� ����1�Դϴ�.','����','1234');
insert into mdl1brd(idx,id,name,email,title,content,pass)
    values(seq_mdl1brd_idx.nextval,'kim2','������','bapo@naver.com','�ڷ�� ����2�Դϴ�.','����','1234');
    
select Tb.*, rownum rNum from(
    select*from mdl1brd order by idx desc) Tb;
    