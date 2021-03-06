/*
  商品信息表
*/
drop table goods;
create table goods(
 g_id varchar2(36) primary key,                --ID
 g_name varchar2(20) not null unique,          --商品名称
 c_id varchar2(36) not null references cate(c_id),
 g_logo varchar2(200) not null,                --商品封面小图
 g_price number(4,2) not null,                 --商品原价
 g_market_price number(4,2),                   --商品促销价
 g_imgs varchar2(600),                         --商品详情图片，有多个
 g_sold_num number,                            --已售数量
 g_big_tit varchar2(40),                       --大标题
 g_small_tit varchar2(40),                     --小标题
 g_short_des varchar2(100),                    --商品简单描述
 g_long_des varchar2(600),                     --商品详细描述
 g_spec varchar2(50),                          --规格
 g_status number                               --状态： 1上架   0下架 
)
select * from goods;
/*
 商品类别
*/
drop table cate;
create table cate(
 c_id varchar2(36) primary key,
 c_name varchar2(20)，                         --分类名称
 c_desc varchar2(200)                          --分类描述
)
select * from cate;

/*
 用户表
*/

create table tuser(
 u_id varchar2(36) primary key,                --ID
 u_name varchar2(20) not null,                 --姓名
 u_sex char(4),                                --性别
 u_tel varchar2(20),                           --电话
 u_logo varchar2(100),                         --头像
 u_open_id varchar2(100),                      --openID
 u_addr varchar2(100)                          --地址
)
alter table tuser
add (u_pwd varchar2(30) default '1234');
insert into tuser values(1,'luolu','M','15200721772','logourlxxxxxx','openidxxxxx','addrxxxx');
