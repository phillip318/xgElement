/*
  ��Ʒ��Ϣ��
*/
drop table goods;
create table goods(
 g_id varchar2(36) primary key,                --ID
 g_name varchar2(20) not null unique,          --��Ʒ����
 c_id varchar2(36) not null references cate(c_id),
 g_logo varchar2(200) not null,                --��Ʒ����Сͼ
 g_price number(4,2) not null,                 --��Ʒԭ��
 g_market_price number(4,2),                   --��Ʒ������
 g_imgs varchar2(600),                         --��Ʒ����ͼƬ���ж��
 g_sold_num number,                            --��������
 g_big_tit varchar2(40),                       --�����
 g_small_tit varchar2(40),                     --С����
 g_short_des varchar2(100),                    --��Ʒ������
 g_long_des varchar2(600),                     --��Ʒ��ϸ����
 g_spec varchar2(50),                          --���
 g_status number                               --״̬�� 1�ϼ�   0�¼� 
)
select * from goods;
/*
 ��Ʒ���
*/
drop table cate;
create table cate(
 c_id varchar2(36) primary key,
 c_name varchar2(20)��                         --��������
 c_desc varchar2(200)                          --��������
)
select * from cate;

/*
 �û���
*/

create table tuser(
 u_id varchar2(36) primary key,                --ID
 u_name varchar2(20) not null,                 --����
 u_sex char(4),                                --�Ա�
 u_tel varchar2(20),                           --�绰
 u_logo varchar2(100),                         --ͷ��
 u_open_id varchar2(100),                      --openID
 u_addr varchar2(100)                          --��ַ
)
alter table tuser
add (u_pwd varchar2(30) default '1234');
insert into tuser values(1,'luolu','M','15200721772','logourlxxxxxx','openidxxxxx','addrxxxx');
