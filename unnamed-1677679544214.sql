DROP TABLE IF EXISTS Cabinet;

CREATE TABLE Cabinet
(
  ID    int  NOT NULL,
  coord json NOT NULL,
  aval  bool NOT NULL DEFAULT true,
  PRIMARY KEY (ID)
);
DROP TABLE IF EXISTS Cabinet_Locker_Rentals;
CREATE TABLE Cabinet_Locker_Rentals
(
  ID            int     NOT NULL,
  cabinetID     int     NOT NULL,
  CustomerID    int     NOT NULL,
  startt         time    NOT NULL,
  endd           time   ,
  fee           decimal,
  paymentMethod char   ,
  PRIMARY KEY (ID)
);
DROP TABLE IF EXISTS customer;
CREATE TABLE customer
(
  ID          int     NOT NULL,
  Name        varchar NOT NULL,
  Credentials  varchar       NOT NULL,
  PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS performance;
CREATE TABLE performance
(
  cabinetID    int  NOT NULL,
  duration     time NOT NULL,
  rentalCount  int  NOT NULL,
  totalRevenue int  NOT NULL
);

ALTER TABLE Cabinet_Locker_Rentals
  ADD CONSTRAINT FK_customer_TO_Cabinet_Locker_Rentals
    FOREIGN KEY (CustomerID)
    REFERENCES customer (ID);

ALTER TABLE Cabinet_Locker_Rentals
  ADD CONSTRAINT FK_Cabinet_TO_Cabinet_Locker_Rentals
    FOREIGN KEY (cabinetID)
    REFERENCES Cabinet (ID);

ALTER TABLE performance
  ADD CONSTRAINT FK_Cabinet_TO_performance
    FOREIGN KEY (cabinetID)
    REFERENCES Cabinet (ID);
