DROP TABLE IF EXISTS Cabinet cascade;

CREATE TABLE Cabinet
(
  ID     int  NOT NULL,
  coord  json NOT NULL,
  aval   bool NOT NULL DEFAULT true,
  open   bool NOT NULL DEFAULT false,
  start  time,
  userID int ,
  PRIMARY KEY (ID)
);
DROP TABLE IF EXISTS cabinet_locker_rentals cascade;

CREATE TABLE Cabinet_Locker_Rentals
(
  ID            int       NOT NULL,
  cabinetID     int       NOT NULL,
  CustomerID    int       NOT NULL,
  rentdate      timestamp,
  duration      interval  NOT NULL,
  paymentMethod varchar      NOT NULL,
  fee           decimal   NOT NULL,
  PRIMARY KEY (ID)
);


DROP TABLE IF EXISTS customer cascade;

CREATE TABLE customer
(
  ID          int     NOT NULL,
  Name        varchar NOT NULL,
  Credentials         VARCHAR,
  PRIMARY KEY (ID)
);

COMMENT ON COLUMN customer.Credentials IS 'another table if needed';

ALTER TABLE Cabinet_Locker_Rentals
  ADD CONSTRAINT FK_customer_TO_Cabinet_Locker_Rentals
    FOREIGN KEY (CustomerID)
    REFERENCES customer (ID);

ALTER TABLE Cabinet_Locker_Rentals
  ADD CONSTRAINT FK_Cabinet_TO_Cabinet_Locker_Rentals
    FOREIGN KEY (cabinetID)
    REFERENCES Cabinet (ID);

ALTER TABLE Cabinet
  ADD CONSTRAINT FK_customer_TO_Cabinet
    FOREIGN KEY (userID)
    REFERENCES customer (ID);
