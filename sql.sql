create database name_data_base -- создание базы данных

create schema lecture_4 -- создание схемы
--Что бы схема появилась слева, нужно обновить слева базу данных

set search_path to lecture_4 -- переключение на схему

create table author (   -- создание таблицы. но сначала надо создать таблицы родительские
	author_id serial primary key,
	author_name varchar(100) not null, -- размер текста для названия
	nick_name varchar(100),
	born_date date not null check (born_date <= current_date and date_part('year', born_date) > 1700),
	city_id int2 not null references city(city_id),
	--language_id int2 not null references language(language_id),
	created_et timestamp not null default current_timestamp,
	created_user varchar(64) not null default current_user,
	--deleted boolean not null default false 
	--deleted varchar(50) not null check (deleted in ('удалена','не удалена','план. удален.') default 'не удалена'
	--deleted deleted_type not null default 'не удалена'
	deleted int2 not null check (deleted in (0, 1)) default 0
)

create table city (
	city_id serial2 primary key,
	city_name varchar(100) not null,
	country_id int2 not null references country(country_id)
)

create table country (
	country_id serial2 primary key,
	country_name varchar(100) not null unique
)

	
create table language (
	language_id serial2 primary key,
	language_name varchar(100) not null unique
)


create type deleted_type as enum (
	'удалена',
	'не удалена',
	'план. удален.')

id
если счетчик
serial primary key

serial = integer + sequence + default nextval(sequence)
		целочисленное + счетчик	+ значение по умолчанию +1
		
		
создание uuid

create extension "uuid-ossp" with schema lecture_4

select lecture_4.uuid_generate_v4()

create table lang (
	lang_id uuid primary key default lecture_4.uuid_generate_v4(),
	lang_name varchar(50) not null unique
	)


create table lector (
	lector_id serial primary key,
	lector_name varchar(50) not null unique
	)

create table course (
	course_id serial primary key,
	course_name varchar(50) not null unique
	)

create table lector_course (
	lector_id int2 references lector(lector_id),
	course_id int2 references course(course_id),
	primary key (lector_id, course_id)
	)

drop table lector_course 

select *
from lector_course lc 


Внесение данных

insert into "language" (language_name)
values ('Русский'), ('Францезский'), ('Японский')

select * 
from "language" l 

insert into "language" 
values (4, 'Монгольский') -- займет 4 позицию счетчика

select * 
from "language" l 

insert into "language" (language_name)
values ('Китайский')

--SQL Error [23505]: ОШИБКА: повторяющееся значение ключа нарушает ограничение уникальности "language_pkey"
  Подробности: Ключ "(language_id)=(4)" уже существует.

Позиция ошибки:

insert into "language" (language_name)
values ('Китайский') -- заняло 5ю позицию

alter sequence language_language_id_seq restart with 667 
-- стартовать счетчик с 667 позиции

create table language (
	language_id int2 primary key generated always as identity,
	language_name varchar(100) not null unique
)

always - системное значение в приоритете над ручным вводом
default  - ручной ввод будет в приоритете над системными значениями



create table some_pay (
	id int2 primary key generated always as identity,
	cost_per_one numeric,
	qty numeric,
	total_cost numeric generated always as (round ((cost_per_one * qty) / 1.2, 2)) stored
	)
	
-- расчет налету данных

insert into some_pay (cost_per_one, qty)
values (1000, 45), (500, 11)

select *
from some_pay

-- 1	1000	45	37500.00
-- 2	500	 	11	4583.33


перенос данных из одной таблицы в другую

select *
from country c
-- пусто

select *
from public.country pc

insert into country
select country_id, country
from public.country pc
-- 109 строк
alter sequence country_country_id_seq restart with 110 
-- новый счетчик стартует с 110 номера

select *
from city c 

select *
from public.city c 

insert into city(city_name, country_id)
select city, country_id
from public.city pc



