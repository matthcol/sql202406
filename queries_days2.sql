-- predicat sur NULL
select title, year, duration
from movie
where duration is null;

select title, year, duration
from movie
where 
	duration is not null
	and year = 1983;

-- DML: insert
insert into movie (title, year) values ('Les Bronzés font du ski', 1979);
select * from movie where title like '% ski';
-- Cannot insert the value NULL into column 'year', table 'dbmovie.dbo.movie'; column does not allow nulls. INSERT fails.
-- insert into movie (title) values ('Les Bronzés');
insert into movie (title, year) values ('Les Bronzés', 1900); -- id=8080252
select * from movie where title like '%bronzés%';

-- The DELETE statement conflicted with the REFERENCE constraint "FK_PLAY_MOVIE". The conflict occurred in database "dbmovie", table "dbo.play", column 'movie_id'.
-- NB: movies avec acteurs et genres
-- delete from movie;
delete from movie where id = 8080252;
select * from movie where title like '%bronzés%';

-- The INSERT statement conflicted with the CHECK constraint "chk_movie_year". The conflict occurred in database "dbmovie", table "dbo.movie", column 'year'.
-- CHECK: year >= 1850
-- insert into movie (title, year) values ('Les Bronzés', 1800);

-- Violation of UNIQUE KEY constraint 'uniq_movie'. Cannot insert duplicate key in object 'dbo.movie'. The duplicate key value is (Les Bronzés font du ski, 1979).
-- insert into movie (title, year) values ('Les Bronzés font du ski', 1979);

-- pas une très bonne idée: texte vide '' => meilleure idée NULL 
-- SQL Server: garder '', Oracle transforme '' en NULL
insert into movie (title, year, poster_uri) values ('Opération Portugal 2', 2024, '');
select * from movie where title like 'Opération Portugal%';

select title, year, poster_uri
from movie
where poster_uri is null or poster_uri = '';

update movie set poster_uri = NULL where poster_uri = '';
select title, year, poster_uri
from movie
where poster_uri is null or poster_uri = '';

-- ajouter la durée du film les bronzéx font du ski
select * from movie where title like '%bronzés%';
update movie set duration = 90 where id = 8080248;
select * from movie where title like '%bronzés%';

update movie 
set duration = 90, 
	synopsis = 'Huit touristes qui ont fait connaissance dans un club de vacances en Côte d''Ivoire se retrouvent dans une station de sports d''hiver.'
where id = 8080248;
select * from movie where title like '%bronzés%';



-- index
select title, year, director_id from movie where director_id = 33;
create index idx_movie_director on movie(director_id);

-- calculs: operateurs et fonctions
-- operateurs: + - * / (modulo)
-- Oracle: operator / sur des entiers => nombre decimal
select
    title,
    year,
    duration / 60 as duration_hours
from movie
where year = 1985
order by title;

-- personalisation Oracle:
-- doc: https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/index.html
-- arrondis: floor, ceil, round, trunc
select
    title
    , year
    , duration
    , round(duration / 60.0, 2) as duration_h_dec
    , floor(duration / 60) as duration_hours
    , mod(duration, 60) as duration_minutes
from movie
where year = 1985
order by title;

-- personnalisation mssql
select
    title
    , year
    , duration
	, round(duration / 60.0, 2) as duration_h_dec
    , duration / 60 as duration_hours
    , duration % 60 as duration_minutes
from movie
where year = 1985
order by title;

-- calcul: texte
select
    upper(title) as title_u
    , lower(title) as title_l
    , length(title) as title_length
    , year
from movie
where year = 1992
order by title;

-- + long titre
select
    title
    , length(title) as title_length
    , year
from movie
where length(title) > 50
order by title_length desc;

-- Top 10
-- MSSQL
select top(10)
    title
    , len(title) as title_length
    , year
from movie
order by title_length desc;

-- top 10 Oracle ???
select top(10)
    title
    , length(title) as title_length
    , year
from movie
order by title_length desc;

-- scrolling
select * from movie;

-- liste des films des années 90 sous la forme: title (year)
-- Oracle, PostgreSQL
select title || ' (' || year || ')' as title_year
from movie
where year between 1990 and 1999
order by title_year;

-- SQL Server, PostgreSQL
select concat(title, ' (', year, ')') as title_year
from movie
where year between 1990 and 1999
order by title_year;

-- pour les films des années 90 produire un code alphanumerique avec
-- - les 3 premieres lettres du films en majuscule
-- - l'année
select 
    rpad(upper(substr(title, 1, 3)), 3, '_') || year as title_ref
from 
    movie
where 
    -- year between 1990 and 1999
    year between 2010 and 2019
order by title_ref;


select * from movie where length(title) < 3;

select count(*) as nb_movie
from movie
where year between 1970 and 1979;


select
    title
    , year
    , director_id
from
    movie
where year between 1970 and 1979;    










