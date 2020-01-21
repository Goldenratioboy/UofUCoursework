--Written by Jonathan Pilling for HW2

CREATE TABLE Player {
    player_name varchar(50),
    ELO_Rating int,
    PlayerID int NOT NULL PRIMARY KEY,
};

CREATE TABLE Game {
    GameID int NOT NULL PRIMARY KEY, 
    blackID int NOT NULL FOREIGN KEY REFERENCES Player(PlayerID),
    whiteID int NOT NULL FOREIGN KEY REFERENCES Player(PlayerID),
    Result varchar(10),
    list_of_moves varchar(1000)
};

CREATE TABLE Chess_Event{
    event_name varchar(50),
    site_name varchar(100),
    event_date varchar(50),
    PRIMARY KEY (event_name, event_date)
};
