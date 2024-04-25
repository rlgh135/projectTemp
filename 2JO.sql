create database jspteam;
drop database jspteam;
use jspteam;
CREATE TABLE user (
  userid varchar(300) PRIMARY KEY,
  userpw varchar(300) NOT NULL,
  username varchar(300) NOT NULL,
  useraddr varchar(1000),
  useraddrdetail varchar(1000) default '집',
  useraddretc varchar(1000) default null,
  useraddrgu varchar(1000),
  userhobby varchar(1000),
  gender varchar(300) default '남자',
  userzipcode varchar(1000),
  joinregdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from user;
select * from user where userid='cherry';
insert into user(userid, userpw, username, useraddr, useraddretc, useraddrgu, userhobby) 
value('abc1', '1234', '김셩억', '강남구', '강남구', '강남구', '스포츠/레저');
update user
set useraddrgu = '강남구'
where userid='apple';
drop table user;

CREATE TABLE userimg (
  userimgnum bigint PRIMARY KEY AUTO_INCREMENT,
  userid varchar(1000),
  userimgorgname varchar(1000),
  userimgsysname varchar(1000)
);
select * from userimg;
update userimg set userimgorgname='defaultuserbadge.png', userimgsysname='defaultuserbadge.png' where userid='apple'; 
CREATE TABLE `lpost` (
  lpostnum bigint PRIMARY KEY AUTO_INCREMENT,
  `lpostcategory` varchar(1000),
  `userid` varchar(300),
  `lposttitle` varchar(300),
  `lpostcontents` text,
  `lpostregdate` datetime default now(),
  `lpostlikecnt` int default 0,
  `readcount` int default 0,
  `imageCount` int default 0,
  `lpostaddr` varchar(1000),
  `deadline` datetime default null
);
SELECT *
FROM lpost
WHERE deadline > NOW() and lpostaddr like '%송파구%'
ORDER BY deadline ASC
LIMIT 4;
insert into lpost(lpostcategory, userid, lposttitle, lpostcontents, lpostaddr) values('수영', 'abc1', '제목입니다', '내용입니다', '강남구');
select * from lpost;
select count(*) from lpost where lpostaddr='관악구';
delete from lpost where deadline = '없음';
drop table lpost;
delete from lpost
where lpostaddr='강남구';
select * from lpost where userid='abc1';

/*0415추가*/
create table lpost_user(
   boardnum bigint,
   userid varchar(300)
);
drop table lpost_user;
select * from lpost_user;
/*0416 ALTER문 액션(Ctrl+Enter) 해줘야함*/
ALTER TABLE lpost_user ADD CONSTRAINT LUP UNIQUE(boardnum, userid);
CREATE TABLE lpost_addr(
   lpostnum bigint,
   placeName varchar(300),
   roadAddress varchar(300),
   address varchar(300),
   phone varchar(300),
    CONSTRAINT fk_lpostnum FOREIGN KEY (lpostnum) REFERENCES lpost(lpostnum)
);
select * from lpost_addr;
drop table lpost_addr;

CREATE TABLE `lreply` (
  `lreplynum` bigint PRIMARY KEY AUTO_INCREMENT,
  `lpostnum` bigint,
  `userid` varchar(300),
  `updatechk` char DEFAULT 'x',
  `lreplycontents` text,
  `lpostregdate` datetime
);
select * from lreply;


CREATE TABLE `group` (
  `groupnum` bigint PRIMARY KEY AUTO_INCREMENT,
  `groupname` varchar(300),
  `groupaddr` varchar(1000),
  `groupcategory` varchar(1000),
  `groupmaster` varchar(300),
  `groupregdate` datetime default now(),
  `groupcontents` text,
  `grouplikecnt` int default 0,
  `groupledaer` varchar(300) default null
);
SELECT groupnum FROM `group` WHERE groupmaster='abc1'order by groupnum desc limit 1;
select * from `group` where groupmaster='abc1';
delete from `group` where groupnum>3001;
 SET SQL_SAFE_UPDATES = 0;
select count(*) from `group`;
select * from `group` where groupmaster='abc10';
delete from `group` where groupmaster='abc10' and groupnum>1;
update `group` 
set groupmaster='abc3'
where groupnum=2;

select count(*) from `group_user`;

select g.*, top_groups.groupusercnt from `group` g 
    	join (select gu.groupnum, count(gu.userid) groupusercnt from group_user gu 
    	join `group` g on gu.groupnum = g.groupnum 
    	where g.groupaddr = '용산구' 
    	group by gu.groupnum 
    	order by count(gu.userid) desc 
    	limit 5) 
    	as top_groups on g.groupnum = top_groups.groupnum;



create table `group_user`(
	groupnum bigint,
    userid varchar(300),
    joindate datetime default now()
);
select * from `group_user`;
drop table group_user;
insert into group_user(groupnum, userid) value(2, 'abc3');
delete from group_user where userid='abc1' and groupnum=2;
select * from group_user where userid='abc1';
select * from group_user where groupnum=1;
select * from group_user where groupnum=2 order by joindate desc limit 5;
SELECT * FROM information_schema.INNODB_LOCKS;
SELECT * FROM information_schema.INNODB_LOCK_WAITS;
select * from INFORMATION_SCHEMA.INNODB_TRX;
KILL 46;
SHOW processlist;
SELECT * FROM information_schema.processlist;
select * from group_user ;
CREATE TABLE `groupimg` (
  `imgnum` bigint PRIMARY KEY AUTO_INCREMENT,
  `groupnum` bigint,
  `imgorgname` varchar(1000),
  `imgsysname` varchar(1000)
);
select * from groupimg where groupnum>3001;
select count(*) from `groupimg`;
CREATE TABLE `gpost` (
  `gpostnum` bigint PRIMARY KEY AUTO_INCREMENT,
  `groupnum` bigint,
  `userid` varchar(300),
  `gpostcontents` text,
  `gposttitle` varchar(1000) default '없음',
  `gpostlike` int default 0,
  `gprcnt` int default 0,
  `gpostgongji` int default 0,
  `gpostregdate` datetime default now()
);
update `gpost` set gpostcontents = '내용이엥', gpostregdate = now() where gpostnum=46;
drop table `gpost`;	
select * from `gpost` where groupnum=1;
insert into gpost(groupnum, gposttitle, userid, gpostcontents) value(2, 'd', 'abc3', '그룹2내용');
select * from `gpost` where groupnum=2 and gpostgongji=1;
update gpost set gpostgongji=1 where gpostnum=2;
update gpost set gpostlike=(gpostlike+1) where gpostnum=2;
SELECT * FROM gpost WHERE groupnum=1 and gpostlike = (SELECT MAX(gpostlike) FROM gpost) order by gpostnum desc;
update `gpost` set gprcnt = 0 where gpostnum=1;
select * from gpost;
select * from gpost where gpostcontents like "%내용%";
select count(*) from gpost where groupnum = 1;
select count(*) from gpost where gpostcontents = "%내용%";
select count(*) from gpost where groupnum = 1 and gpostcontents like "%1%";
select * from gpostlike;
delete from gpostlike where gpostnum='46';
insert into gpostlike values(40, 'abc1');
create table gpostlike(
	gpostnum bigint,
    userid varchar(300)
);
select * from gpostlike where userid='abc1';
CREATE TABLE `gfile` (
  `gfilenum` bigint PRIMARY KEY AUTO_INCREMENT,
  `gpostnum` bigint,
  `gfileorgname` varchar(1000),
  `gfilesysname` varchar(1000)
);

drop table gfile;
select * from gfile;
select * from gfile where `gpostnum`=45;
insert into gfile(`gpostnum`, `gfileorgname`, `gfilesysname`) values('45', 'bibisong.txt', 'bibisong.txt');
insert into gfile(`gpostnum`, `gfileorgname`, `gfilesysname`) values('45', ',gp45_1번파일.txt', 'gp45_1번파일.txt');
insert into gfile(`gpostnum`, `gfileorgname`, `gfilesysname`) values('45', ',gp45_2번파일.txt', 'gp45_2번파일.txt');
insert into gfile(`gpostnum`, `gfileorgname`, `gfilesysname`) values('45', ',gp45_3번파일.txt', 'gp45_3번파일.txt');
insert into gfile(`gpostnum`, `gfileorgname`, `gfilesysname`) values('44', ',gp44_1번파일.txt', 'gp44_1번파일.txt');
insert into gfile(`gpostnum`, `gfileorgname`, `gfilesysname`) values('41', ',gp41_1번파일.txt', 'gp41_1번파일.txt');
insert into gfile(`gpostnum`, `gfileorgname`, `gfilesysname`) values('41', ',gp41_2번파일.txt', 'gp41_2번파일.txt');
insert into gfile(`gpostnum`, `gfileorgname`, `gfilesysname`) values('40', ',gp40_1번파일.txt', 'gp40_1번파일.txt');

CREATE TABLE `gpreply` (
  `gprnum` bigint PRIMARY KEY AUTO_INCREMENT,
  `userid` varchar(300),
  `gpostnum` bigint,
  `gprcontents` text,
  `gprregdate` datetime default now()
);
select * from gpreply;

create table reqlist(
	groupnum bigint,
    userid varchar(300) default null,
    leaderid varchar(300) default null,
    question varchar(3000) default '§',
    answer varchar(6000) default null,
    autoreg int default 0
);
drop table reqlist;

delete from reqlist where userid='abc3';
delete from reqlist where leaderid='abc320';
select * from reqlist;
select * from reqlist where (groupnum=1 and leaderid is null);
select * from reqlist where (groupnum=2 and autoreg=1);
insert into reqlist(groupnum, leaderid, question) value(1, 'abc1', '1번 질문 입니다§2번 질문 입니다§3번 질문 입니다§4번 질문 입니다§');
insert into reqlist(groupnum, leaderid, question, autoreg) value(1, 'abc1', '모임에 가입하시겠어요?§' , 1);
insert into reqlist(groupnum, userid, answer) value(1, 'abc1', '답1-1§답2-1§답3-1§답4-1§');
/*0417 추가*/


create table message(
messagenum bigint PRIMARY KEY AUTO_INCREMENT,
sendid varchar(300),
receiveid varchar(300),
msgcontent varchar(3000),
msregdate datetime default now(),
linkstring varchar(3000) default null,
msgcheck int
);
insert into message (sendid, receiveid, msgcontent, msgcheck, linkstring)
		values('system','abc1','가입',0,'/groupinner.gp?groupnum=1');
        insert into message (sendid, receiveid, msgcontent, msgcheck, linkstring)
		values('abc100','abc1','가입',0,'/groupinner.gp?groupnum=1');
select * from message;
drop table message;