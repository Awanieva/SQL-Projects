

--Getting an full view of the data
select *  from airline_passenger_satisfaction$


--Total Number of Passengers
select COUNT(ID)  from airline_passenger_satisfaction$ AS Total_Passengers



--Looking at the percentage of customer type the airline has (Firsttime/Returning)
select [Customer Type], COUNT([ID]) AS Total_Customer,
ROUND((COUNT([Customer Type])/MAX(ID)*100),2) as Percentage

from airline_passenger_satisfaction$
group by [Customer Type]
order by Percentage desc




--Looking at the Number and Percentage of customer type the airline has does it vary by Type of Travel? (Business/Personal)
select [Customer Type], [Type of Travel], COUNT([ID]) AS Total_Customer,
ROUND((COUNT([Type of Travel])/MAX(ID) * 100),2) as Percentage
from airline_passenger_satisfaction$
group by [Customer Type], [Type of Travel]
order by Total_Customer desc




--Looking at the number and percentage of passengers that are satisfied, Neutral or Dissatisfied 
select  Satisfaction, COUNT(Satisfaction)  as Total_Passengers, 
ROUND(((COUNT(Satisfaction)/MAX(ID)) *100),2) as SatisfactionPercentage
from airline_passenger_satisfaction$
GROUP BY Satisfaction




--Looking at the number and percentage of passengers that are satisfied, Neutral or Dissatisfied by Customertype?
select  [Customer Type], Satisfaction, COUNT(Satisfaction)  as Total_Customer, 
ROUND(((COUNT(Satisfaction)/MAX(ID)) *100),2) as SatisfactionPercentage
from airline_passenger_satisfaction$
GROUP BY Satisfaction, [Customer Type]
order by SatisfactionPercentage desc




--Looking at the number and percentage of passengers that are satisfied, Neutral or Dissatisfied by Type of Travel?
select  [Type of Travel], Satisfaction, COUNT(Satisfaction)  as Total_Customer, 
ROUND(((COUNT(Satisfaction)/MAX(ID)) *100),2) as SatisfactionPercentage
from airline_passenger_satisfaction$
GROUP BY Satisfaction, [Type of Travel]
order by SatisfactionPercentage desc



--Evaluating the Number/Percentage of Airline Passengers based on Type of Travel
SELECT [Type of Travel], COUNT(ID) as Total_Customer,
ROUND((COUNT([Type of Travel])/MAX(ID) * 100),2) AS Percentage
FROM airline_passenger_satisfaction$
GROUP BY [Type of Travel]
order by Percentage desc



--Evaluating the Number/Percentage of Airline Passengers based on Class
SELECT Class, COUNT(ID) as Total_Customer,
ROUND((COUNT(Class)/MAX(ID) * 100),2) AS Percentage
FROM airline_passenger_satisfaction$
GROUP BY Class
order by Percentage desc



--Evaluating if the airline has more firsttime customers or returning customers
select [Customer Type], COUNT([Customer Type]) as Total_Customer
from airline_passenger_satisfaction$
GROUP BY [Customer Type]



--Looking at flight distance by Customer Type
select [Flight Distance], [Customer Type], COUNT([Flight Distance]) AS No_Of_Passengers
from airline_passenger_satisfaction$
group by [Flight Distance],  [Customer Type]
ORDER  BY No_Of_Passengers DESC




--Looking at the Number of passengers /Percentage of Total flight distance by  Type Of Travel (Business/Personal)
select [Type of Travel], SUM([Flight Distance]) as Total_Flight_Distance, COUNT([Type of Travel]) AS Number_of_Passengers,
ROUND((COUNT([Type of Travel])/MAX(ID)* 100),2) AS PercentageofPassengers
from airline_passenger_satisfaction$
group by [Type of Travel]
ORDER  BY Total_Flight_Distance DESC



--Looking at flight distance with highest - lowest passengers by  Type Of Travel
select [Flight Distance], [Type of Travel], COUNT([Flight Distance]) AS No_Of_Passengers
from airline_passenger_satisfaction$
group by [Flight Distance],  [Type of Travel]
ORDER  BY No_Of_Passengers DESC



--Looking at Total flight distance by  Customer Type (FirstTime/Returning)
select [Customer Type], SUM([Flight Distance]) as Total_Flight_Distance, COUNT([Customer Type]) AS Number_of_Passengers,
ROUND((COUNT([Customer Type])/MAX(ID)* 100),2) AS PercentageofPassengers
from airline_passenger_satisfaction$
group by [Customer Type]
ORDER  BY Total_Flight_Distance DESC


--Looking at Average flight distance
select AVG([Flight Distance]) as Average_Flight_Distance
from airline_passenger_satisfaction$


--Looking at Minimum flight distance
select MIN([Flight Distance]) as Minimum_Flight_Distance
from airline_passenger_satisfaction$


--Looking at Maximum flight distance
select MAX([Flight Distance]) as Maximum_Flight_Distance
from airline_passenger_satisfaction$



--Looking at Number and percentage of Age that Travels More or Travels Less
select Age, COUNT(ID) as Total_Passengers,
ROUND((COUNT(ID)/max(ID) * 100),2) as Percentage
from airline_passenger_satisfaction$
Group by Age
Order by Total_Passengers  desc


--Looking at Percentage age that travel the Longest/Lowest
select Age, SUM([Flight Distance]) AS Total_Passengers,
ROUND(((SUM([Flight Distance])/(154598293)) * 100),2) AS Percentage
from airline_passenger_satisfaction$
group by Age
order by Total_Passengers desc



--Looking at the gender that patronize the airline more
select Gender, COUNT(Gender) as Total_Customer
from airline_passenger_satisfaction$
GROUP BY Gender




--AVERAGE DEPARTURE DELAY
SELECT ROUND(AVG([Departure Delay]),2) AS Average_Departure_Delay
from airline_passenger_satisfaction$


--AVERAGE ARRIVAL  DELAY
SELECT ROUND(AVG([Arrival Delay]),2) AS Average_Arrival_Delay
from airline_passenger_satisfaction$




--RATING LOOKING AT WHAT FACTOR CONTIBUTED THE MOST TO CUSTOMER SATISFACTION AND DISSATISFACTION  
SELECT Satisfaction, 
ROUND(AVG(([Departure and Arrival Time Convenience])),2) AS Departure_and_Arrival_Time_Convenience_Rating, 
ROUND(AVG(([Ease of Online Booking])),2) AS Ease_Of_Online_Rating,
ROUND(AVG(([Check-in Service])),2) AS Check_in_Service_Rating,
ROUND(AVG(([Online Boarding])),2) AS Online_Boarding_Rating,
ROUND(AVG(([Gate Location])),2) AS Gate_Location_Rating,
ROUND(AVG(([On-board Service])),2) AS On_board_Service_Rating,
ROUND(AVG(([Seat Comfort])),2) AS Seat_Comfort_Rating,
ROUND(AVG(([Leg Room Service])),2) AS Leg_Room_Service_Rating,
ROUND(AVG(([Cleanliness])),2) AS Cleanliness_Rating,
ROUND(AVG(([Food and Drink])),2) AS Food_andDrink_Rating,
ROUND(AVG(([In-flight Service])),2) AS In_flight_Service_Rating,
ROUND(AVG(([In-flight Entertainment])),2) AS In_flight_Entertainment_Rating,
ROUND(AVG(([Baggage Handling])),2) AS Baggage_Handling_Rating
FROM airline_passenger_satisfaction$
GROUP BY Satisfaction
ORDER BY Satisfaction DESC