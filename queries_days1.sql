-- Toute une table

select * from person;
select * from movie;

-- Projection: choix colonnes
select title, year from movie;

-- Sélection: filtrer les lignes  
-- filtre année =    118 lignes => 16
select * from movie where year = 1984;
-- filtre => 0 lignes
select * from movie where year = 2050;
-- filtre intervalle année
select * from movie where year between 1980 and 1989;

-- Tri 1 critère
select * 
from movie 
where year between 1980 and 1989
order by year;
-- Tri 2 critères
select * 
from movie 
where year between 1980 and 1989
order by year, title;
-- Tri: croissant, décroissant: ASC DESC
select * 
from movie 
where year between 1980 and 1989
order by year desc, title;

-- titre, année, durée des films des années 80s et de durée supérieure à 2H
select title, year, duration
from movie
where 
	year between 1980 and 1989
	and duration >= 120
order by duration desc;

-- predicats sur des nombres
-- year != 2020     year <> 2020
-- year = 1984
-- year >= 1980
-- year > 1980
-- year < 1980
-- year <= 1980
-- year between 1980 and 1989

-- combinaisons de filtres: and or not

select title, year, duration
from movie
where
	year < 1920
	or year >= 2020
order by year;

select title, year, duration
from movie
where
	(year < 1920 or year >= 2020)
	and duration < 100
order by year;

select title, year
from movie
where year != 2020
order by year desc;

select title, year
from movie
where year <> 2020
order by year desc;

-- predicats sur les textes
-- name = 'Clint Eastwood'
-- name != 'Clint Eastwood'
-- name like 'Clint Eastwood'

select *
from person
where name = 'Clint Eastwood';

select *
from person
where name = 'Steve McQueen';

-- Case Insensitive = Insensible à la casse
-- Spécificité de MSSQL
select *
from person
where name = 'Steve mcquEen';

select *
from person
where name like 'Steve mcquEen';

select *
from person
where name like '%Queen';

select *
from person
where name like '% McQueen';

select *
from person
where name like 'Steve%';

select *
from person
where name like 'Steve %';

-- film dont le titre contient 'star'
select * 
from movie
where title like '%star%';