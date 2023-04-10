
CREATE TABLE Cabinet
(
  ID    int  NOT NULL,
  coord json NOT NULL,
  aval  bool NOT NULL DEFAULT true,
  PRIMARY KEY (ID)
);



CREATE TABLE Cabinet Locker Rentals
(
  ID            int     NOT NULL,
  cabinetID     int     NOT NULL,
  CustomerID    int     NOT NULL,
  start         time    NOT NULL,
  end           time   ,
  fee           decimal,
  paymentMethod char   ,
  PRIMARY KEY (ID)
);

CREATE TABLE customer
(
  ID          int     NOT NULL,
  Name        varchar NOT NULL,
  Credentials         NOT NULL,
  PRIMARY KEY (ID)
);

COMMENT ON COLUMN customer.Credentials IS 'another table if needed';

CREATE TABLE performance
(
  cabinetID    int  NOT NULL,
  duration     time NOT NULL ,
  rentalCount  int  NOT NULL,
  totalRevenue int  NOT NULL
);

ALTER TABLE Cabinet Locker Rentals
  ADD CONSTRAINT FK_customer_TO_Cabinet Locker Rentals
    FOREIGN KEY (CustomerID)
    REFERENCES customer (ID);

ALTER TABLE Cabinet Locker Rentals
  ADD CONSTRAINT FK_Cabinet_TO_Cabinet Locker Rentals
    FOREIGN KEY (cabinetID)
    REFERENCES Cabinet (ID);

ALTER TABLE performance
  ADD CONSTRAINT FK_Cabinet_TO_performance
    FOREIGN KEY (cabinetID)
    REFERENCES Cabinet (ID);
