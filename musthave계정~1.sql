create table Model2BoardCal(
    idx number primary key,--일련번호
    id varchar2(30) not null, --제약조건
    title varchar2(300) not null,
    content varchar2(2000) not null,
    pdate date not null,
    boardName varchar2(30)
    );
    

insert into Model2BoardCal (idx, id, title, content, pdate, boardName)
values (seq_prtBoard_idx.NEXTVAL, "test" , "안녕" , "안녕내용", to_date('12/10/2021', 'mm/dd/yyyy'), "cal");
;

ALTER TABLE Model2BoardCal
	ADD CONSTRAINT pCal_mem_fk
	FOREIGN KEY (id)
	REFERENCES Projectmember (id)
;


commit;

select title
from Model2BoardCal where pdate='2021-12-17';

select count(*) from Model2Board where boardName='gal';