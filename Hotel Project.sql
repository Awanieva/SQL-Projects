
WITH Hotels as
(
select * from [2018]
union
select * from [2019]
union 
select * from [2020]
)

Select arrival_date_year, hotel, Round(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr),2) as Revenue from Hotels
Group by arrival_date_year, hotel





WITH Hotels as
(
select * from [2018]
union
select * from [2019]
union 
select * from [2020]
)
Select * from Hotels
LEFT JOIN market_segment
ON Hotels.market_segment = market_segment.market_segment
LEFT JOIN meal_cost
ON meal_cost.meal = hotels.meal

