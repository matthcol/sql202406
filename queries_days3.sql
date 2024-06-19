select count(*) from movie;

select count(*) from movie.movie;

-- need privilege: grant create synonym to movie;
create synonym "MOVIE".star for "MOVIE"."PERSON";

select * from star where name like 'Clint%';

-- JOINTURES: interne
select
    m.title
    , m.year
    , m.director_id
    , d.id
    , d.name
from
    movie m
    join person d on m.director_id = d.id
where m.year between 1970 and 1979
order by m.year, m.title;  

-- les acteurs du film  Alien - 1979
select 
    a.name
    , pl.role
    , m.title
    , m.year
from 
    movie m
    join play pl on pl.movie_id = m.id
    join person a on pl.actor_id = a.id
where
    m.title = 'Alien'
    and m.year = 1979
;

-- 
select
    m.title
    , m.year
    , m.director_id
    , d.id
    , d.name
from
    movie m
    left join person d on m.director_id = d.id
where m.year between 1970 and 1979
order by m.year, m.title; 

-- filmographie en tant que réalisateur de Clint Eastwood
select 
    m.year
    , m.title
    , d.name
    , m.director_id 
from
    movie m
    join person d on m.director_id = d.id
where
    d.name = 'Clint Eastwood'
order by m.year, m.title -- add in first d.id si homonymes
; 
    
-- filmographie en tant qu'acteur de Clint Eastwood
select
    m.year
    , a.name
    , m.title
    , pl.role
from 
    movie m
    join play pl on pl.movie_id = m.id
    join person a on pl.actor_id = a.id
where
    -- a.name = 'Clint Eastwood'
    a.name = 'Quentin Tarantino'
order by m.year, m.title -- add in first d.id si homonymes
; 


-- acteurs ayant joué James Bond (avec titre et année des films)
select 
    m.year
    , a.name
    , m.title
    , pl.role
from 
    person a
    join play pl on pl.actor_id = a.id
    join movie m on pl.movie_id = m.id
where
    pl.role = 'James Bond'
order by 
    m.year
;

-- films de Clint Eastwood où il est à la fois réalisateur et acteur
-- films de Clint Eastwood où il est que réalisateur
-- films de Clint Eastwood où il est que acteur

-- stats: agregate functions
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/
select
    count(*) as nb_movie
    , count(id) as nb_movie_id
    , count(title) as nb_movie_title
    , count(duration) as nb_duration
    , count(distinct year) as nb_year
    , ceil(sum(duration) / 60 / 24) as total_duration
    -- , year  -- interdit ici
    , min(year) as first_year
    , max(year) as last_year
from 
    movie
where
    year between 1970 and 1979
;

select 
    count(distinct name) as nb_007
from 
    person a
    join play pl on pl.actor_id = a.id
where
    pl.role like '%James Bond%'
;

select 
    m.year
    , a.name
    , m.title
    , pl.role
from 
    person a
    join play pl on pl.actor_id = a.id
    join movie m on pl.movie_id = m.id
where
    pl.role like '%James Bond%'
    -- and pl.role != 'James Bond in Gunbarrel Sequence'
    and pl.role not in(
        'James Bond in Gunbarrel Sequence'
        , 'Fake James Bond'
    )
order by m.year, m.title
;


-- 
select
    year
    , count(*) as nb_movie
    , count(id) as nb_movie_id
    , count(title) as nb_movie_title
    , count(duration) as nb_duration
    , count(distinct year) as nb_year
    , ceil(sum(duration) / 60 / 24) as total_duration
from 
    movie
where
    year between 1970 and 1979
group by 
    year
order by
    year
;


-- nombre de réalisation par personne, trié par nombre de réalisations desc
select
    d.id
    , d.name
    , count(m.id) as nb_directed_movie
from 
    person d 
    join movie m on d.id = m.director_id
group by
    d.id, d.name
order by 
    nb_directed_movie desc
    , d.name
;












