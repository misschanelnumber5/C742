select 
c.state, 
c.pop15 as 'Population 2015',
c.pop16 as 'Population 2016', 
case
	when 
		c.diff > 10000 then c.diff*-1
    else 
    	c.diff
    end  as diff
 from
(
	select 
	b.state as State, 
	b.pop15 as pop15, 
	b.pop16 as pop16, 
	round(abs(b.diff),-2) as diff
	from (
		select 
		(a.pop16-a.pop15) as diff, 
		a.state, 
		a.pop15, 
		a.pop16 
		from ( 
			select 
			pop2015.state,
			pop2015.population as pop15,
			pop2016.population as pop16
			from pop2015
			inner join pop2016
			on pop2015.state=pop2016.state
			and pop2016.year=pop2016.year
			) a 
		) b 
            where b.diff > 10000
) c ;