CREATE DATABASE dbms1;
USE dbms1;
CREATE TABLE UserTable (
  ID INT AUTO_INCREMENT,
  Email VARCHAR(40) NOT NULL UNIQUE,
  Name VARCHAR(30),
  Password VARCHAR(15) NOT NULL,
  Usertype VARCHAR(10) NOT NULL,
  PRIMARY KEY (ID)
);
CREATE TABLE NonAdmin (
  ID INT,
  Gender VARCHAR(7),
  Phone NUMERIC(10,0) NOT NULL UNIQUE CHECK (Phone > 999999999),
  Address VARCHAR(100),
  PRIMARY KEY(ID),
  FOREIGN KEY(ID) REFERENCES UserTable(ID) ON DELETE CASCADE
);

CREATE TABLE Admin (
  ID INT,
  AgencyName VARCHAR(35) NOT NULL,
  AgencyPhone VARCHAR(10) NOT NULL UNIQUE CHECK (AgencyPhone > 999999999),
  AgencyOffice VARCHAR(50),
  PRIMARY KEY (AgencyName),
  FOREIGN KEY(ID) REFERENCES UserTable(ID) ON DELETE CASCADE
);
CREATE TABLE BusInfo (
  BusRegnNo VARCHAR(15) NOT NULL,
  AgencyName VARCHAR(35) NOT NULL,
  TotalSeats INT DEFAULT 40,
  AC TINYINT DEFAULT 0,
  LocationName VARCHAR(20),
  Latitude DECIMAL(17,10),
  Longitude DECIMAL(17,10),
  PRIMARY KEY (BusRegnNo),
  FOREIGN KEY (AgencyName) REFERENCES Admin(AgencyName) ON DELETE CASCADE
);

CREATE TABLE AgencyDetails (
  AgencyName VARCHAR(35) NOT NULL,
  AgencyAddress VARCHAR(50) NOT NULL
);
CREATE TABLE BusSchedule (
  BusRegnNo VARCHAR(15) NOT NULL,
  RouteID INT NOT NULL CHECK (RouteID > 0),
  DriverID INT UNIQUE CHECK (DriverID > 0),
  StartTime DECIMAL(4,2) CHECK (StartTime >= 0 AND StartTime < 2400),
  Fare INT CHECK (Fare > 0),
  ReservedSeats INT DEFAULT 0,
  TravelTime DECIMAL(10,2) CHECK (TravelTime > 0),
  PRIMARY KEY(RouteID, DriverID, StartTime),
  FOREIGN KEY(BusRegnNo) REFERENCES BusInfo(BusRegnNo) ON DELETE CASCADE
);

CREATE TABLE TimeForTravel (
  TravelTime DECIMAL(10,2) CHECK (TravelTime > 0),
  StartTime DECIMAL(4,2) CHECK (StartTime >= 0 AND StartTime < 24),
  EndTime DECIMAL(4,2) CHECK (EndTime >= 0 AND EndTime < 24),
  PRIMARY KEY(TravelTime, StartTime)
);
CREATE TABLE RouteDetails (
  RouteID INT CHECK (RouteID > 0),
  RouteName VARCHAR(30) NOT NULL,
  Source VARCHAR(30) NOT NULL,
  Destination VARCHAR(30) NOT NULL,
  AproxDistance INT CHECK (AproxDistance > 0)
);

CREATE TABLE BusStops (
  RouteID INT NOT NULL CHECK (RouteID > 0),
  IntermediateStops VARCHAR(20) NOT NULL,
  StopNumber INT NOT NULL CHECK (StopNumber > 0)
);

CREATE TABLE DriverDetails (
  DriverID INT AUTO_INCREMENT,
  DriverName VARCHAR(20) NOT NULL,
  DriverPhone NUMERIC(10,0) CHECK (DriverPhone > 999999999),
  Age INT CHECK (Age > 0),
  Date_Of_Join DATE,
  PRIMARY KEY (DriverID)
);
CREATE TABLE Ticket (
  BusRegnNo VARCHAR(15) NOT NULL,
  TicketPNR INT AUTO_INCREMENT,
  BookingDate DATE,
  TravelDate DATE,
  PRIMARY KEY(TicketPNR),
  FOREIGN KEY(BusRegnNo) REFERENCES BusInfo(BusRegnNo)
);
DELIMITER $$

CREATE TRIGGER check_travel_date
BEFORE INSERT ON Ticket
FOR EACH ROW
BEGIN
  IF NEW.TravelDate <= DATE_ADD(NEW.BookingDate, INTERVAL 2 DAY) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'TravelDate must be at least 2 days after BookingDate';
  END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER check_travel_date_update
BEFORE UPDATE ON Ticket
FOR EACH ROW
BEGIN
  IF NEW.TravelDate <= DATE_ADD(NEW.BookingDate, INTERVAL 2 DAY) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'TravelDate must be at least 2 days after BookingDate';
  END IF;
END$$

DELIMITER ;


CREATE TABLE SeatsBooked (
  TicketPNR INT,
  BookedSeats INT,
  PRIMARY KEY(TicketPNR, BookedSeats)
);

CREATE TABLE SeatInfo (
  BusRegnNo VARCHAR(15) NOT NULL UNIQUE,
  SeatNo INT CHECK (SeatNo <= 40),
  Sleeper TINYINT DEFAULT 0,
  FOREIGN KEY(BusRegnNo) REFERENCES BusInfo(BusRegnNo) ON DELETE CASCADE
);

CREATE TABLE Passenger (
  ID INT AUTO_INCREMENT,
  BusRegnNo VARCHAR(15) NOT NULL,
  PassengerID INT CHECK (PassengerID > 0),
  PassengerName VARCHAR(20),
  PassengeGender VARCHAR(7),
  Age INT CHECK (Age > 5),
  PRIMARY KEY(PassengerID),
  FOREIGN KEY(ID) REFERENCES NonAdmin(ID) ON DELETE CASCADE,
  FOREIGN KEY(BusRegnNo) REFERENCES BusInfo(BusRegnNo)
);
CREATE TABLE Through (
  RouteID INT,
  DriverID INT,
  StartTime DECIMAL(4,2),
  BusRegnNo VARCHAR(50) NOT NULL,
  TicketPNR INT NOT NULL CHECK (TicketPNR > 0),
  PRIMARY KEY(RouteID, DriverID, StartTime, TicketPNR)
);

DELIMITER $$

CREATE TRIGGER TimeTravel AFTER INSERT ON BusSchedule
FOR EACH ROW
BEGIN
  DECLARE endTime DECIMAL(4,2);
  SET endTime = NEW.TravelTime + NEW.StartTime;
  IF endTime >= 24 THEN
    SET endTime = endTime - 24;
  END IF;
  INSERT INTO TimeForTravel (TravelTime, StartTime, EndTime)
  VALUES (NEW.TravelTime, NEW.StartTime, endTime);
END$$

DELIMITER $$

CREATE PROCEDURE totalrevenue()
BEGIN
  SELECT AgencyName, SUM(Fare)
  FROM BusInfo NATURAL JOIN BusSchedule
  GROUP BY AgencyName;
END$$

DELIMITER ;

CALL totalrevenue();

-- Example insert
INSERT INTO DriverDetails (DriverID, DriverName, DriverPhone, Age, Date_Of_Join)
VALUES (126, 'Prithvi', 9834534565, 29, '2017-09-22');

INSERT INTO BusStops VALUES (4, 'Chennai', 7);

