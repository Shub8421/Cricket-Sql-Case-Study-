# Cricket-Sql-Case-Study-
This case study focuses on analyzing cricket match data using SQL. It is designed to challenge your SQL skills, covering schema design, data insertion, and complex queries, including the use of joins, subqueries, window functions, and aggregate functions.

# Tool used 
Sql Server Management Studio

# Language used 
Sql 

# Created Tables and inserted values into them 
CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    PlayerName VARCHAR(100),
    TeamName VARCHAR(100),
    Role VARCHAR(50),
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
    NotOut BOOLEAN,
    RunOuts INT,
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

CREATE TABLE Teams (
    TeamName VARCHAR(100) PRIMARY KEY,
    Coach VARCHAR(100),
    Captain VARCHAR(100)
);


-- Insert Teams


INSERT INTO Teams VALUES
('India', 'Rahul Dravid', 'Rohit Sharma'),
('Australia', 'Andrew McDonald', 'Pat Cummins'),
('England', 'Brendon McCullum', 'Ben Stokes'),
('Afghanistan', 'Jonathan Trott', 'Hashmatullah Shahidi'),
('New Zealand', 'Gary Stead', 'Kane Williamson');


-- Insert Players


INSERT INTO Players VALUES
(1, 'Virat Kohli', 'India', 'Batsman', 2008),
(4, 'MS Dhoni', 'India', 'Wicket-Keeper', 2004),
(8, 'Jasprit Bumrah', 'India', 'Bowler', 2016),
(11, 'Rohit Sharma', 'India', 'Batsman', 2007),
(12, 'Hardik Pandya', 'India', 'All-Rounder', 2016),

(2, 'Steve Smith', 'Australia', 'Batsman', 2010),
(3, 'Mitchell Starc', 'Australia', 'Bowler', 2010),
(7, 'David Warner', 'Australia', 'Batsman', 2009),
(13, 'Pat Cummins', 'Australia', 'Bowler', 2011),
(14, 'Glenn Maxwell', 'Australia', 'All-Rounder', 2012),

(5, 'Ben Stokes', 'England', 'All-Rounder', 2011),
(9, 'Joe Root', 'England', 'Batsman', 2012),
(15, 'Jos Buttler', 'England', 'Wicket-Keeper', 2011),
(16, 'Jofra Archer', 'England', 'Bowler', 2019),
(17, 'Moeen Ali', 'England', 'All-Rounder', 2014),

(6, 'Rashid Khan', 'Afghanistan', 'Bowler', 2015),
(18, 'Mohammad Nabi', 'Afghanistan', 'All-Rounder', 2010),
(19, 'Hazratullah Zazai', 'Afghanistan', 'Batsman', 2016),
(20, 'Rahmanullah Gurbaz', 'Afghanistan', 'Wicket-Keeper', 2019),

(10, 'Kane Williamson', 'New Zealand', 'Batsman', 2010),
(21, 'Trent Boult', 'New Zealand', 'Bowler', 2011),
(22, 'Devon Conway', 'New Zealand', 'Batsman', 2020),
(23, 'Tom Latham', 'New Zealand', 'Wicket-Keeper', 2012);


-- Insert Matches


INSERT INTO Matches VALUES
(1, '2023-03-01', 'Mumbai', 'India', 'Australia', 'India'),
(2, '2023-03-05', 'Sydney', 'Australia', 'England', 'England'),
(3, '2023-04-10', 'London', 'England', 'India', 'India'),
(4, '2023-05-15', 'Dubai', 'India', 'Afghanistan', 'India'),
(5, '2023-06-20', 'Melbourne', 'Australia', 'New Zealand', 'Australia');


-- Insert Performance


-- Match 1: India vs Australia (Winner: India)
INSERT INTO Performance VALUES
(1, 1, 82, 0, 1, 0, FALSE, 0),
(1, 4, 35, 0, 0, 1, TRUE, 0),
(1, 8, 15, 2, 0, 0, FALSE, 0),
(1, 11, 55, 0, 1, 0, FALSE, 0),
(1, 12, 25, 1, 0, 0, FALSE, 0),
(1, 2, 60, 0, 1, 0, FALSE, 0),
(1, 3, 10, 3, 0, 0, FALSE, 0),
(1, 7, 40, 0, 0, 0, TRUE, 0),
(1, 13, 5, 2, 0, 0, FALSE, 0),
(1, 14, 35, 1, 1, 0, FALSE, 0);

-- Match 2: Australia vs England (Winner: England)
INSERT INTO Performance VALUES
(2, 2, 75, 0, 1, 0, FALSE, 0),
(2, 3, 20, 2, 0, 0, FALSE, 0),
(2, 7, 55, 0, 0, 0, FALSE, 0),
(2, 13, 15, 3, 0, 0, FALSE, 0),
(2, 14, 30, 1, 0, 0, FALSE, 0),
(2, 5, 85, 0, 0, 0, FALSE, 0),
(2, 9, 120, 0, 2, 0, TRUE, 0),
(2, 15, 25, 0, 1, 1, FALSE, 0),
(2, 16, 5, 4, 0, 0, FALSE, 0),
(2, 17, 40, 1, 0, 0, FALSE, 0);

-- Match 3: England vs India (Winner: India)
INSERT INTO Performance VALUES
(3, 5, 35, 0, 1, 0, FALSE, 0),
(3, 9, 90, 0, 0, 0, TRUE, 0),
(3, 15, 15, 0, 2, 1, FALSE, 0),
(3, 16, 10, 3, 0, 0, FALSE, 0),
(3, 1, 45, 0, 1, 0, FALSE, 0),
(3, 4, 22, 0, 0, 2, TRUE, 0),
(3, 8, 12, 2, 0, 0, FALSE, 0),
(3, 11, 65, 0, 0, 0, FALSE, 0),
(3, 12, 35, 1, 1, 0, FALSE, 0);

-- Match 4: India vs Afghanistan (Winner: India)
INSERT INTO Performance VALUES
(4, 1, 90, 0, 1, 0, FALSE, 0),
(4, 4, 30, 0, 0, 1, TRUE, 0),
(4, 8, 20, 3, 0, 0, FALSE, 0),
(4, 11, 75, 0, 0, 0, FALSE, 0),
(4, 12, 40, 1, 1, 0, FALSE, 0),
(4, 6, 35, 5, 0, 0, FALSE, 0),
(4, 18, 55, 2, 1, 0, FALSE, 0),
(4, 19, 20, 0, 0, 0, FALSE, 0),
(4, 20, 45, 0, 0, 1, FALSE, 0);

-- Match 5: Australia vs New Zealand (Winner: Australia)
INSERT INTO Performance VALUES
(5, 2, 70, 0, 1, 0, FALSE, 0),
(5, 3, 18, 3, 1, 0, FALSE, 0),
(5, 7, 75, 0, 0, 0, TRUE, 0),
(5, 13, 5, 2, 0, 0, FALSE, 0),
(5, 14, 60, 1, 1, 0, FALSE, 0),
(5, 10, 85, 0, 0, 0, FALSE, 1),
(5, 21, 12, 4, 0, 0, FALSE, 0),
(5, 22, 40, 0, 1, 0, FALSE, 0),
(5, 23, 25, 0, 2, 1, FALSE, 0);

# Question and the Insights have to find out from the Sql Query
1. Identify the player with the best batting average (total runs scored divided by the number of matches played) across all matches.
2. Find the team with the highest win percentage in matches played across all locations.
3. Identify the player who contributed the highest percentage of their team's total runs in any single match.
4. Determine the most consistent player, defined as the one with the smallest standard deviation of runs scored across matches.
5. Find all matches where the combined total of runs scored, wickets taken, and catches exceeded 500.
6. Identify the player who has won the most "Player of the Match" awards (highest runs scored or wickets taken in a match).
7. Determine the team that has the most diverse player roles in their squad.
8. Identify matches where the runs scored by both teams were unequal and sort them by the smallest difference in total runs between the two teams.
9. Find players who contributed (batted, bowled, or fielded) in every match that their team participated in.
10. Identify the match with the closest margin of victory, based on runs scored by both teams.
11. Calculate the total runs scored by each team across all matches.
12. List matches where the total wickets taken by the winning team exceeded 2.
13. Retrieve the top 5 matches with the highest individual scores by any player.
14. Identify all bowlers who have taken at least 5 wickets across all matches.
15. Find the total number of catches taken by players from the team that won each match.
16.  Identify the player with the highest combined impact score in all matches.
The impact score is calculated as:
Runs scored × 1.5 + Wickets taken × 25 + Catches × 10 + Stumpings × 15 + Run outs × 10.
Only include players who participated in at least 3 matches.
17.Find the match where the winning team had the narrowest margin of victory based on total runs scored by both teams.
If multiple matches have the same margin, list all of them.
18.List all players who have outperformed their teammates in terms of total runs scored in more than half the matches they played.
This requires finding matches where a player scored the most runs among their teammates and calculating the percentage.
19.Rank players by their average impact per match, considering only those who played at least three matches.
The impact is calculated as:
Runs scored × 1.5 + Wickets taken × 25 + Catches × 10 + Stumpings × 15 + Run outs × 10.
Players with the same average impact should share the same rank.

20.Identify the top 3 matches with the highest cumulative total runs scored by both teams.
Rank the matches based on total runs using window functions. If multiple matches have the same total runs, they should share the same rank.

21.For each player, calculate their running cumulative impact score across all matches they’ve played, ordered by match date.
Include only players who have played in at least 3 matches.
