show databases;
select current_user();
select database();
select * from problemset;

use problemset;
use sql1;
select * from TestScore;
select * from BigStudent;
select * from Club;

select first_name,last_name from BigStudent
INNER JOIN Club
on BigStudent.student_id = Club.student_id;

select birthdate from Club
INNER JOIN BigStudent
on Club.student_id = BigStudent.student_id;


-- EXAMPLE
SELECT *
FROM BigStudent
INNER JOIN Club
ON BigStudent.student_id = Club.student_id
WHERE years_served >1 ; -- You need to fill the condition

use sql1;
select * from BigStudent LEFT JOIN Club on BigStudent.student_id=Club.student_id;
select * from BigStudent RIGHT JOIN Club on BigStudent.student_id=Club.student_id;


use Shared;

select * from Movie;
select * from Rating;

select * from Shared.Movie 
inner join Shared.Rating
on Movie.movie_id=Rating.movie_id order by rating desc;

describe Rating;

select sum(rating) from Rating;

select * from Movie where title='GoldenEye';
select avg(rating) from Rating where movie_id=10;

select * from Movie order by year_released asc;

select user_id, avg(rating) from Rating group by user_id;

select count(*) from Rating;
select avg(rating)
from Rating
where rating < 
(select avg(rating) from Rating
);

select title, rating from Movie
inner join Rating
on Rating.movie_id = Movie.movie_id
where Movie.title='Pulp Fiction';

select a.PF_title, avg(a.PF_rating) from
(
	select title as PF_title, rating as PF_rating from Movie
    inner join Rating
    on Rating.movie_id=Movie.movie_id
    where Movie.title='Citizen Kane'
) as a;

select * from Movie
inner join Rating
on Movie.movie_id=Rating.movie_id
order by Movie.movie_id desc
limit 100;

select * from 
	(
	select * from Movie
    order by movie_id desc
    limit 1250)
    as SmallMovie
    left outer join Rating
    on SmallMovie.movie_id=Rating.movie_id
    order by SmallMovie.movie_id desc
    limit 100;


use ProblemSet;

select count(*) from Concession;
select * from Concession order by order_create_time asc;
select avg(revenue), category_name from Concession group by category_name ;
show databases;

use dev_tt_2363987;
create table pop2015 (year int(4), state varchar(20), population int(15));
create table pop2016 (year int(4), state varchar(20), population int(15));

select * from results2015
inner join results2016
on results2015.state=results2016.state
where (results2015.population - results2016.population) ;> 1000;

select * from results2015;
update results2015 set year=2015;
delete from results2016;
alter table results2015 add column year int(4);

select a.state, a.pop16-a.pop15 as newpop 
	from (
		select pop2015.state,pop2015.population as pop15,pop2016.population as pop16
			from pop2015
			inner join pop2016
			on pop2015.state=pop2016.state
			where (pop2015.population < pop2016.population) 
            ) a
            where a.pop16-a.pop15 > 10000
;

select b.* 
	from (
		select a.pop16-a.pop15 as diff, a.* 
			from ( 
				select 
					pop2015.state,
					round(pop2015.population,-2) as pop15,
					round(pop2016.population,-2) as pop16
					from pop2015
					inner join pop2016
					on pop2015.state=pop2016.state
					and pop2016.year=pop2016.year
				) a 
			) b 
	where b.diff >10000;
            ;