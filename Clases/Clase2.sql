create database imdb;
use imdb;
create table film(
film_id int AUTO_INCREMENT primary key,
title varchar(20),
description varchar(200),
release_year date
);
create table actor(
actor_id int AUTO_INCREMENT primary key,
nombre varchar(30),
apellido varchar(30)
);
create table film_actor(
film_actor_id int AUTO_INCREMENT primary key,
actor_id int,
film_id int,
constraint foreign key (actor_id) references actor(actor_id),
constraint foreign key (film_id) references film(film_id)
);
alter table film add last_update int;
alter table actor add last_update int;
insert into film( title, description, release_year) values('Epic','Fantasia','2009-11-13');
insert into actor( nombre,apellido ) values('Bautista','Cimatti');
insert into film_actor(actor_id,film_id) values(1,1);

