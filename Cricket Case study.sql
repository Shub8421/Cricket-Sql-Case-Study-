drop database case_study ;

create database case_s ;
use case_s ;

CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    PlayerName VARCHAR(100),
    TeamName VARCHAR(100),
    Role VARCHAR(50), -- e.g., Batsman, Bowler, All-Rounder, Wicket-Keeper
    DebutYear INT
);

CREATE TABLE Matches (
    MatchID INT PRIMARY KEY,
    MatchDate DATE,
    Location VARCHAR(100),
    Team1 VARCHAR(100),
    Team2 VARCHAR(100),
    Winner VARCHAR(100)
);

CREATE TABLE Performance (
    MatchID INT,
    PlayerID INT,
    RunsScored INT,
    WicketsTaken INT,
    Catches INT,
    Stumpings INT,
    NotOut BIT,
    RunOuts INT,
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

CREATE TABLE Teams (
    TeamName VARCHAR(100) PRIMARY KEY,
    Coach VARCHAR(100),
    Captain VARCHAR(100)
);

INSERT INTO Performance VALUES
(2, 2, 75, 0, 1, 0, 0, 0),
(2, 3, 20, 2, 0, 0, 0, 0),
(2, 7, 55, 0, 0, 0, 0, 0),
(2, 13, 15, 3, 0, 0, 0, 0),
(2, 14, 30, 1, 0, 0, 0, 0),
(2, 5, 85, 0, 0, 0, 0, 0),
(2, 9, 120, 0, 2, 0, 1, 0),
(2, 15, 25, 0, 1, 1, 0, 0),
(2, 16, 5, 4, 0, 0, 0, 0),
(2, 17, 40, 1, 0, 0, 0, 0);

INSERT INTO Performance VALUES
(3, 5, 35, 0, 1, 0, 0, 0),
(3, 9, 90, 0, 0, 0, 1, 0),
(3, 15, 15, 0, 2, 1, 0, 0),
(3, 16, 10, 3, 0, 0, 0, 0),
(3, 1, 45, 0, 1, 0, 0, 0),
(3, 4, 22, 0, 0, 2, 1, 0),
(3, 8, 12, 2, 0, 0, 0, 0),
(3, 11, 65, 0, 0, 0, 0, 0),
(3, 12, 35, 1, 1, 0, 0, 0);

INSERT INTO Performance VALUES
(4, 1, 90, 0, 1, 0, 0, 0),
(4, 4, 30, 0, 0, 1, 1, 0),
(4, 8, 20, 3, 0, 0, 0, 0),
(4, 11, 75, 0, 0, 0, 0, 0),
(4, 12, 40, 1, 1, 0, 0, 0),
(4, 6, 35, 5, 0, 0, 0, 0),
(4, 18, 55, 2, 1, 0, 0, 0),
(4, 19, 20, 0, 0, 0, 0, 0),
(4, 20, 45, 0, 0, 1, 0, 0);

INSERT INTO Performance VALUES
(5, 2, 70, 0, 1, 0, 0, 0),
(5, 3, 18, 3, 1, 0, 0, 0),
(5, 7, 75, 0, 0, 0, 1, 0),
(5, 13, 5, 2, 0, 0, 0, 0),
(5, 14, 60, 1, 1, 0, 0, 0),
(5, 10, 85, 0, 0, 0, 0, 1),
(5, 21, 12, 4, 0, 0, 0, 0),
(5, 22, 40, 0, 1, 0, 0, 0),
(5, 23, 25, 0, 2, 1, 0, 0);



select * from Players;
select * from Matches;
select * from Performance ;
select * from Teams;

select top 1 p.PlayerName ,sum(Per.RunsScored)/count(Per.MatchID) as Bat_avg from Players p 
join Performance Per on p.Playerid=Per.PlayerID group by p.PlayerName order by Bat_avg desc;

#used join and aggregate function with group by and order by 

select Top 1 Winner as Teamname , (count(*) * 100)/ (select count(*)  from Matches mp 
where mp.Team1=Matches.Winner or mp.Team2 = Matches.Winner ) as Winpercentage
from Matches 
group by Winner order by Winpercentage desc;
#USED COUNT(*) TO COUNT ALL ROWS AND TO CALCULATE THE PERCENTAGE USED THE FORMULA 


with team as(
select sum(P.RunsScored) as Total_run  ,PP.TeamName,P.MatchID from Performance p
join Players PP on P.PlayerID=PP.PlayerID    group by PP.TeamName,P.MatchID
)
select top 1 PP.PlayerName,PP.TeamName,tr.Total_run ,(P.RunsScored*100)/tr.Total_run as percentage
from Players PP
join Performance P on P.PlayerID=PP.PlayerID join team tr on  tr.TeamName=tr.TeamName
and P.MatchID = tr.MatchID order by percentage desc ;
#USED CTC JOIN AND ORDER BY TO SORT TO CALCULATE PERCENTAGE USED THE FORMULA 



select Top 1 P.PlayerName,Round(stdev(Per.RunsScored),2) as Standard_deviation from Players P  
join Performance Per on P.PlayerID=Per.PlayerID
group by P.PlayerName,P.PlayerID having count(*)>1  order by Standard_deviation asc ;
#used function and round for to get decimal upto 2 place  count(*) to identify duplicate records sort by asc to get smallest str 


select sum(Per.RunsScored+Per.WicketsTaken+Per.catches) as Total,Per.MatchID   from Performance Per
 group by Per.MatchID having sum(Per.RunsScored+Per.WicketsTaken+Per.catches)>500 ;
 #used Aggregate and having to give condition

 select Top 1 P.PlayerName,count(*) as Awards_won from Players P 
 join Performance Per on P.PlayerID=Per.PlayerID  where Per.RunsScored in
(select Max(RunsScored) from Performance group by MatchID
) 
group by P.PlayerName order by Awards_won Desc ;
# used Join and aggregate and Max to give max run scored with respect to the Match Id 


select Top 1 count(distinct P.Role) as Rolename,P.TeamName as TeamName  from Players P 
group by P.TeamName order by Rolename Desc ;
# Used distinct to remove duplicates and group sort by desending for larger number ;




select Per.MatchID,Abs(sum(case when P.TeamName= M.team1 then Per.RunsScored else 0 end )-
sum(case when P.TeamName=M.team2 then Per.RunsScored else 0 end)) as Run_difference 
from Performance Per
join Players P on P.PlayerID=Per.PlayerID join Matches M on Per.MatchID=M.MatchID
group by Per.MatchID order by Run_difference Asc ;
# Use substraction and case condition to get scored for particular team and then subtract to get the difference the sort then with ascennding to get smallest differnce 


select P.PlayerName,P.TeamName from  Players P  join Performance Per on P.PlayerID=Per.PlayerID
group by P.PlayerName,P.TeamName  having count(distinct Per.MatchID) = ( select count(*) from 
Matches M where P.TeamName = M.team1 or P.TeamName = M.team2 ) ;
#Used the join and subquery to get the matched playered  by both the team 



select Top 1 Per.MatchID,Abs(sum(case when P.TeamName= M.team1 then Per.RunsScored else 0 end )-
sum(case when P.TeamName=M.team2 then Per.RunsScored else 0 end)) as Margins 
from Performance Per
join Players P on P.PlayerID=Per.PlayerID join Matches M on Per.MatchID=M.MatchID
group by Per.MatchID  order by Margins asc;
#Used Case conditon to get the scored for both the teams and subtract them to get the lowest margins join and sort by asc to get the smallest number 
#used Abs to get the  absolute number 



select Per.MatchID,M.Team1,Abs(sum(case when P.TeamName= M.team1 then Per.RunsScored else 0 end )) as Totalruns1,M.Team2,
Abs(sum(case when P.TeamName=M.team2 then Per.RunsScored else 0 end)) as Totalruns2
from Performance Per
join Players P on P.PlayerID=Per.PlayerID join Matches M on Per.MatchID=M.MatchID
group by Per.MatchID,M.Team1,M.Team2;
#used case to get total runs scored for the both teams  used join and grouop by on both the teams





select M.MatchID,M.Winner as TeamName ,Sum(Per.WicketsTaken) as TotalWickettaken from Matches M 
join Performance Per on Per.MatchID=M.MatchID join Players P on P.PlayerID=Per.MatchID 
where P.TeamName=M.Team1 or P.TeamName=M.Team2 
group by M.Winner,M.MatchID having sum(Per.WicketsTaken) > 2 ;
#Use Aggregate and join on table and having condition to get the result 


select top 5 Per.MatchID,P.PlayerName,P.TeamName as TeamName ,Per.RunsScored as Highestrunscored from Performance Per
join  Players P on P.PlayerID=Per.PlayerID  order by Highestrunscored desc ;
#used join and sort by descending order to get the top 5 run scored



select P.Playername,Sum(Per.WicketsTaken) as TotalWicketTaken from
Performance  Per join Players P on P.PlayerID=Per.PlayerID 
where P.Role = 'Bowler' group by P.PlayerName,P.PlayerID having sum(Per.WicketsTaken) >=5;
#used join and where to get the Role which have taken 5 or more wickets 


select  M.MatchID,sum(Per.Catches) as Totalcatches,M.Winner from Matches M 
join Performance Per on Per.MatchID=M.MatchID join Players P on P.PlayerID=Per.PlayerID
where P.TeamName=M.winner  group by M.MatchID,M.Winner ;
# Used Aggregate and join to get matchid and where to fliter the winner team 

select M.MatchID,sum(Per.Catches) as Totalcatches,M.Winner from Matches M 
join Performance Per on Per.MatchID=M.MatchID join Players P on P.PlayerID=Per.PlayerID
where P.TeamName=M.winner  group by M.MatchID,M.Winner;
#Used Aggregate joins and where to get the Winner team 

select Top 1 P.PlayerName, sum(Per.RunsScored * 1.5+Per.WicketsTaken*25+
Per.Catches*10+Per.Stumpings*15+Per.RunOuts*10) as Score ,Count(Distinct Per.MatchID) as MatchPLayer    from Players P 
join Performance Per on Per.PlayerID=P.PlayerID group by P.PlayerID,P.PlayerName having count(Distinct Per.MatchID)>=3
order by Score Desc;
#Used  Aggregate and sum all to get Score used count distint to remove dulicates used join and having condition to get more and equal to three 


with Matchrun as (
select Per.MatchID,M.Winner as Winner,Abs(sum(case when P.TeamName= M.team1 then Per.RunsScored else 0 end )) as Total_team1,
Abs(sum(case when P.TeamName=M.team2 then Per.RunsScored else 0 end)) as Total_team2 from  Matches M 
Join Performance Per  on M.MatchID=Per.MatchID join Players P on P.PlayerID=Per.PlayerID
group by Per.MatchID,M.Winner
), Margins as  
( 
select MatchID,Winner,Abs(Total_team1-Total_team2) as Margin
from Matchrun
)
select MatchID,Margin,Winner from Margins 
where Margin = (select Min(Margin) from Margins);
#Used Cte to get the score for team 1 and team 2 ,then in subquery  tried to get the differnce with the minimum margins 


with Teamtop as (select Per.MatchID,P.Playername,P.TeamName,Per.RunsScored,P.PlayerID,Rank() over(Partition by Per.MatchId,P.Playername 
order by Per.RunsScored desc )  as rnk
from Performance Per 
join Players P on P.PlayerID=Per.PlayerID  
)
select Playername, count(*) as MatchedPlayed ,
Sum(case when rnk=1 then 1 else 0 end) as Matchtopscorer,
round(100*sum(case when rnk=1 then 1 else 0 end )/count(*),2) as TopScorerPercentage
from Teamtop group by PlayerID,PlayerName having sum( case when rnk=1 then 1 else 0 end)> count(*)/ 2.0
order by TopScorerPercentage desc ,Matchtopscorer desc ;
# used Cte Rank over the partition for particular rows and used join  then in subquery used Aggregate and case condition to get Matchtopscorer and percentage 
used group and having condition  and order by descending for top match and perscentage 



select P.PlayerName,Round(Avg(Per.RunsScored*1.5+Per.WicketsTaken*25+Per.Catches*10+Per.Stumpings*15+Per.RunOuts*10),2) as AvgImpact,
DENSE_RANK() over( order by Avg(Per.RunsScored*1.5+Per.WicketsTaken*25+Per.Catches*10+Per.Stumpings*15+Per.RunOuts*10) desc) as Playerrank
from Performance Per join Players P on P.PlayerID=Per.PlayerID  group by P.PlayerName
having count(Distinct Per.MatchID)>=3;
#Used Aggregate round to get 2 decimal place and avg for average used window function dense rank to get the similar rank and join to having condition where player played more than 3 matches 


with Matchruns as ( 
select MatchID,sum(RunsScored) as total_runs from Performance 
group by MatchID
), Ranked as (
select MatchID,total_runs,
DENSE_RANK() over ( order by total_runs desc) as Matchrank 
from Matchruns
)
select * from Ranked where Matchrank<=3 order by Matchrank,MatchID


WITH PlayerImpact AS (
    SELECT
        p.PlayerID,
        p.PlayerName,
        m.MatchDate,
        pr.MatchID,
        (
            pr.RunsScored * 1.5 +
            pr.WicketsTaken * 25 +
            pr.Catches * 10 +
            pr.Stumpings * 15 +
            pr.RunOuts * 10
        ) AS ImpactScore
    FROM Players p
    JOIN Performance pr
        ON p.PlayerID = pr.PlayerID
    JOIN Matches m
        ON pr.MatchID = m.MatchID
),
EligiblePlayers AS (
    SELECT PlayerID
    FROM Performance
    GROUP BY PlayerID
    HAVING COUNT(DISTINCT MatchID) >= 3
)
SELECT
    pi.PlayerName,
    pi.MatchID,
    pi.MatchDate,
    pi.ImpactScore,
    SUM(pi.ImpactScore) OVER (
        PARTITION BY pi.PlayerID
        ORDER BY pi.MatchDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeImpact
FROM PlayerImpact pi
JOIN EligiblePlayers ep
    ON pi.PlayerID = ep.PlayerID
ORDER BY pi.PlayerName, pi.MatchDate;
#Used Aggregate round to get 2 decimal place and avg for average used window function dense rank to get the similar rank on total run  and join to having condition where player played more than 3 matches 