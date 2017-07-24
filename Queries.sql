-- Write a code to join the two tables on the year and state fields into one SQL table that 
-- identifies the absolute differences (in whole rounded hundreds) in the estimates of 
-- 10,000 individuals or more between the two datasets. If the earlier estimates are larger
-- than 10,000, the cells should indicate a negative value. Provide a screenshot of your
-- tested code showing successful execution.
select a.state, (a.pop16-a.pop15)*-1 as Difference 
	from (
		select 
			pop2015.state,
			round(pop2015.population,-2) as pop15, 
            round(pop2016.population,-2) as pop16
			from pop2015
			inner join pop2016
			on pop2015.state=pop2016.state
            and pop2016.year=pop2016.year
			where (pop2015.population < pop2016.population) 
            ) a
            where a.pop16-a.pop15 > 10000
;

-- Export the data from the SQL table into a CSV file, with rows representing the states 
-- and columns representing the years that both datasets estimate, that only shows the 
-- differences between the datasets (in whole rounded tens of thousands) that exceed 
-- 10,000 individuals.

select b.state as State,b.pop15 as 'Population 2015', b.pop16 as 'Population 2016', b.diff*-1 as Difference
	from (
		select (a.pop16-a.pop15) as diff, a.state, a.pop15, a.pop16 
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
            
            
            
select 
	a.state as State,
	a.pop15 as 'Population 2015', 
    a.pop16 as 'Population 2016', (a.pop16-a.pop15)*-1 as Difference 
		from (
			select 
				pop2015.state,
				round(pop2015.population,-2) as pop15, 
				round(pop2016.population,-2) as pop16
				from pop2015
					inner join pop2016
					on pop2015.state=pop2016.state
						and pop2016.year=pop2016.year
						where (pop2015.population < pop2016.population) 
            ) a
            where a.pop16-a.pop15 > 10000;