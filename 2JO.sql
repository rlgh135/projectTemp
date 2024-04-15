create database jspteam;
drop database jspteam;
use jspteam;
CREATE TABLE user (
  userid varchar(300) PRIMARY KEY,
  userpw varchar(300) NOT NULL,
  username varchar(300) NOT NULL,
  useraddr varchar(1000),
  addrdetail varchar(1000) default '집',
  useraddretc varchar(1000),
  useraddrgu varchar(1000),
  userhobby varchar(1000),
  gender varchar(300) default '남자',
  userpoint int default 0,
  warningcnt int default 0
);
select * from user;
drop table user;
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
  `lpostaddr` varchar(1000)
);
select * from lpost where userid='abc1';
drop table lpost;
select * from lpost limit 0, 3000;

/*0415추가*/
create table lpost_user(
   boardnum bigint,
   userid varchar(300)
);

CREATE TABLE `lfile` (
  `lfilenum` bigint PRIMARY KEY AUTO_INCREMENT,
  `lpostnum` bigint,
  `lorgname` varchar(1000),
  `lsysname` varchar(1000)
);

CREATE TABLE `lreply` (
  `lreplynum` bigint PRIMARY KEY AUTO_INCREMENT,
  `lpostnum` bigint,
  `userid` varchar(300),
  `updatechk` char DEFAULT 'x',
  `lreplycontents` text,
  `lpostregdate` datetime
);
select * from lreply;
CREATE TABLE `lrfile` (
  `lrfilenum` bigint PRIMARY KEY AUTO_INCREMENT,
  `lreplynum` bigint,
  `lrorgname` varchar(1000),
  `lrsysname` varchar(1000)
);

CREATE TABLE `group` (
  `groupnum` bigint PRIMARY KEY AUTO_INCREMENT,
  `groupname` varchar(300),
  `groupaddr` varchar(1000),
  `groupcategory` varchar(1000),
  `groupmaster` varchar(300),
  `groupregdate` datetime default now(),
  `groupcontents` text,
  `grouplikecnt` int default 0
);
select count(*) from `group`;
create table board_user(
	boardnum bigint,
    userid varchar(300)
);
select count(*) from `group_user`;
create table group_user(
	groupnum bigint,
    userid varchar(300)
);

CREATE TABLE `groupimg` (
  `imgnum` bigint PRIMARY KEY AUTO_INCREMENT,
  `groupnum` bigint,
  `imgorgname` varchar(1000),
  `imgsysname` varchar(1000)
);
select count(*) from `groupimg`;
CREATE TABLE `gpost` (
  `gpostnum` bigint PRIMARY KEY AUTO_INCREMENT,
  `groupnum` bigint,
  `gposttitle` varchar(1000),
  `userid` varchar(300),
  `gpostcontents` text,
  `gpostlike` int default 0,
  `gpostgongji` int default 0,
  `gpostregdate` datetime default now()
);
select * from `gpost`;
select * from gpost;
select * from gpost where gpostcontents like "%내용%";
select count(*) from gpost where groupnum = 1;
select count(*) from gpost where gpostcontents = "%내용%";
select count(*) from gpost where groupnum = 1 and gpostcontents like "%1%";

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

CREATE TABLE `gprfile` (
  `gprfilenum` bigint PRIMARY KEY AUTO_INCREMENT,
  `gprnum` bigint,
  `gprfileorgname` varchar(1000),
  `gprfilesysname` varchar(1000)
);

CREATE TABLE `warning` (
  `warningnum` int PRIMARY KEY AUTO_INCREMENT,
  `reason` text
);

CREATE TABLE `userwarning` (
  `warningnum` int,
  `userid` varchar(300)
);