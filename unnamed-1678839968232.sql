DROP TABLE IF EXISTS Cabinet;
CREATE TABLE Cabinet
(
  ID     int  NOT NULL,
  coord  json NOT NULL,
  aval   bool NOT NULL DEFAULT true,
  open   bool NOT NULL DEFAULT false,
  userID int ,
  start  time,
  PRIMARY KEY (ID)
);
DROP TABLE IF EXISTS Cabinet_Locker_Rentals;
CREATE TABLE Cabinet_Locker_Rentals
(
  ID            int      NOT NULL,
  cabinetID     int      NOT NULL,
  CustomerID    int      NOT NULL,
  duration      interval NOT NULL,
  paymentMethod char     NOT NULL,
  fee           decimal  NOT NULL,
  PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS customer;
CREATE TABLE customer
(
  ID          int     NOT NULL,
  Name        varchar NOT NULL,
  Credentials         NOT NULL,
  PRIMARY KEY (ID)
);


ALTER TABLE Cabinet_Locker_Rentals
  ADD CONSTRAINT FK_customer_TO_Cabinet_Locker_Rentals
    FOREIGN KEY (CustomerID)
    REFERENCES customer (ID);

ALTER TABLE Cabinet_Locker_Rentals
  ADD CONSTRAINT FK_Cabinet_TO_Cabinet_Locker_Rentals
    FOREIGN KEY (cabinetID)
    REFERENCES Cabinet (ID);
