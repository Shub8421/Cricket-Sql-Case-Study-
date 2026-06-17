# Cricket-Sql-Case-Study-
This case study focuses on analyzing cricket match data using SQL. It is designed to challenge your SQL skills, covering schema design, data insertion, and complex queries, including the use of joins, subqueries, window functions, and aggregate functions.

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

-- ======================================
-- Insert Teams
-- ======================================

INSERT INTO Teams VALUES
('India', 'Rahul Dravid', 'Rohit Sharma'),
('Australia', 'Andrew McDonald', 'Pat Cummins'),
('England', 'Brendon McCullum', 'Ben Stokes'),
('Afghanistan', 'Jonathan Trott', 'Hashmatullah Shahidi'),
('New Zealand', 'Gary Stead', 'Kane Williamson');

-- ======================================
-- Insert Players
-- ======================================

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

-- ======================================
-- Insert Matches
-- ======================================

INSERT INTO Matches VALUES
(1, '2023-03-01', 'Mumbai', 'India', 'Australia', 'India'),
(2, '2023-03-05', 'Sydney', 'Australia', 'England', 'England'),
(3, '2023-04-10', 'London', 'England', 'India', 'India'),
(4, '2023-05-15', 'Dubai', 'India', 'Afghanistan', 'India'),
(5, '2023-06-20', 'Melbourne', 'Australia', 'New Zealand', 'Australia');

-- ======================================
-- Insert Performance

-- ======================================

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
