-----Procesamiento------

-----Crear tablar con usuarios que han calificado 35 o más películas

drop table if exists usuarios_sel;

create table usuarios_sel as select UserId, 
                        count(*) as cnt_rat
                        from ratings
                        group by UserId
                        having cnt_rat >=35
                        order by cnt_rat desc ;

-----Crear tablar con películas que han sido calificadas por 9 o más usuarios

drop table if exists movies_sel;

create table movies_sel as select movieId,
                        count(*) as cnt_rat
                        from ratings
                        group by movieId
                        having cnt_rat>=9
                        order by cnt_rat desc ;

-------crear tablas filtradas de películas, usuarios y calificaciones ----

drop table if exists ratings_final;

create table ratings_final as
select a.userId,
a.rating, 
a.movieId
from ratings a 
inner join movies_sel b
on a.movieId =b.movieId
inner join usuarios_sel c
on a.userId =c.userId;

drop table if exists movies_final;

create table movies_final as
select a.movieId,
a.title,
a.genres
from movies a
inner join movies_sel c
on a.movieId =c.movieId;

---crear tabla completa ----

drop table if exists full_ratings;

create table full_ratings as select 
a.*,
b.title,
b.genres
 from ratings_final a inner join
 movies_final b on a.movieId=b.movieId;
           