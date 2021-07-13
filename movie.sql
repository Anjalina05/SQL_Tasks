create database movies_database;

drop database movies_database;

create table movies_database.movie
(
movie_id int not null auto_increment primary key,
movie_name varchar(50)
);

create table movies_database.actor
(
actor_id int not null auto_increment primary key,
actor_name varchar(50)
);

create table movies_database.award
(
award_id varchar(50),
award_name varchar(50)
);

create table movies_database.movie_cast
(
movie_id int not null references movie(castID),
actor_id int not null references actor(actorID)
);

create table movies_database.award_results
(
award_year int(50),
award_id varchar(50),
movie_id int(50)
);

alter table movies_database.movie_cast add constraint fk_movie_id FOREIGN KEY(movie_id)
references movies_database.movie(movie_id);

alter table movies_database.movie_cast add constraint fk_actor_id FOREIGN KEY(actor_id)
references movies_database.actor(actor_id);

insert into movies_database.movie values('10','Nomadland'),('11','The Father'),('12','Joker'),('13','Parasite'),('14','Once Upon a Time in Hollywood'),('15','Judas and the Black Messiah' ),('16','Green Book'),('17','Bohemian Rhapsody'),('18','Bacurau'),('19','The Trial of the Chicago 7'),('20','Sound of Metal'),('21','The Shape of Water'),('22','Darkest Hour '),('23','Three Billboards Outside Ebbing, Missouri'),('24','The Master'),('25','12 Years a Slave');
insert into movies_database.actor values('201','Frances McDormand'),('202','Anthony Hopkins'),('203','Joaquin Phoenix'),('204','Song Kang-ho '),('205','Brad pitt'),('206','Daniel Kaluuya'),('207','Jim Burke'),('208','Rami Malek'),('209','Cannes Jury Prize'),('210','Eddie Redmayne'),('211','Riz Ahmed'),('212','Guillermo del Toro'),('213','Gary Oldman');
insert into movies_database.award values ('1A','Best Actor/Actress nominations'),('2A','Best Supporting Actor/Actress nominations'),('3A','Oscar Winner'),('4A','Elite Actors'),('5A','Academy Awards'),('6A','Golden Globe Awards'),('7A','Best Picture');
insert into movies_database.movie_cast values('10','201'),('11','202'),('12','203'),('13','204'),('14','205'),('15','206'),('16','207'),('17','208'),('18','209'),('19','210'),('20','211'),('21','212'),('22','213'),('23','201'),('24','203'),('25','205');
insert into movies_database.award_results values('2021','1A','10'),('2021','1A','11'),('2021','3A','10'),('2021','4A','10'),('2021','3A','11'),('2021','7A','10'),('2021','5A','10'),('2021','6A','10'),('2020','2A','15'),('2020','1A','11'),('2020','5A','11'),('2020','7A','13'),('2020','7A','12'),('2020','3A','12'),('2020','5A','12'),('2020','6A','12'),('2019','1A','16'),('2019','6A','16'),('2019','2A','14'),('2019','3A','17'),('2019','5A','17'),('2019','7A','17'),('2019','6A','17'),('2019','1A','12'),('2018','1A','22'),('2018','3A','21'),('2018','5A','21'),('2018','6A','21'),('2018','7A','21'),('2018','1A','23'),('2014','1A','25'),('2012','1A','24');

select * from movies_database.movie;
select * from movies_database.actor;
select * from movies_database.award;
select * from movies_database.movie_cast;
select * from movies_database.award_results;

                                                         ## ASSIGNMENT 2 ##
                                                         
 # 1. List of actors without any award winning movie
 select distinct(actor_name) from movies_database.actor ac inner join movies_database.movie_cast mc 
  on ac.actor_id = mc.actor_id 
  where movie_id not in 
   (select movie_id from movies_database.award_results);

# 2. List of actors with maximum number of award winning movies by year
select award_year, max(actor_name) as actor_name, count(movie_id) as movie_count
from movies_database.actor ac
cross join movies_database.movie_cast using(actor_id)
cross join movies_database.movie using(movie_id)
cross join movies_database.award_results using(movie_id)
where movie_id in (select movie_id from movies_database.award_results) 
group by award_year, movie_id order by count(movie_id) desc
;


