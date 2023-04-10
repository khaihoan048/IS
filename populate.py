import json
import random
import string
import psycopg2
import random
from datetime import datetime, timedelta


first_names = ['Alice', 'Bob', 'Charlie', 'David', 'Emily', 'Frank', 'Gina', 'Hannah', 'Isaac', 'Julia', 'Kevin', 'Lily', 'Mike', 'Nancy', 'Olivia', 'Peter', 'Qiana', 'Rachel', 'Sarah', 'Tom', 'Ursula', 'Vicky', 'Wendy', 'Xander', 'Yvonne', 'Zach']

last_names = ['Adams', 'Brown', 'Clark', 'Davis', 'Edwards', 'Foster', 'Gomez', 'Harris', 'Ivanov', 'Johnson', 'Kim', 'Lopez', 'Martin', 'Nguyen', 'Olsen', 'Parker', 'Quinn', 'Rivera', 'Smith', 'Taylor', 'Upton', 'Vargas', 'Walker', 'Xu', 'Young', 'Zhang']


conn = psycopg2.connect(database="is_project", user="nvkhoan", password="asdf", host="localhost", port="5432")

def populate_cabinet_table(conn, r,c):
    """Populate the Cabinet table with random data.

    Args:
        conn: A psycopg2 database connection object.
        num_rows: The number of rows to insert into the table.
    """
    cur = conn.cursor()
    cur.execute("DELETE FROM cabinet")
    for y in range (0,r):
        for x in range (0,c):
            coord = json.dumps({'x': x, 'y': y})
            id=y*c+x+1
            cur.execute("INSERT INTO Cabinet (ID, coord) VALUES (%s, %s)", (id, coord))
    conn.commit()
populate_cabinet_table(conn,3,20)
def populate_customer_table(conn, num):
    cur = conn.cursor()
    cur.execute("DELETE FROM customer")
    for id in range (1,num+1):
        name= random.choice(first_names)+" "+ random.choice(last_names)
        cur.execute("INSERT INTO customer (ID, Name) VALUES (%s, %s)",(id,name))
    conn.commit()
populate_customer_table(conn,50)
def populate(conn,num_rentals):
    cur = conn.cursor()
    cur.execute("DELETE FROM cabinet_locker_rentals")
    cabinetIDs = [i for i in range(1,61)]
    customerIDs = [i for i in range (1,51)]
    paymentMethods = ['credit card', 'cash', 'banking','ewallet']
    for i in range (0,num_rentals):
        cabinetID = random.choice(cabinetIDs)
        customerID = random.choice(customerIDs)
        rentdate = datetime.now() - timedelta(days=random.randint(0, 30), hours=random.randint(0, 23), minutes=random.randint(0, 59), seconds=random.randint(0, 59))
        duration = timedelta(hours=random.randint(1, 30),minutes=random.randint(0,59))
        paymentMethod = random.choice(paymentMethods)
        fee = random.randint(10, 50)
        cur.execute("INSERT INTO Cabinet_Locker_Rentals (ID, cabinetID, CustomerID, rentdate, duration, paymentMethod, fee) VALUES (%s, %s, %s, %s, %s, %s, %s)", (i+1, cabinetID, customerID, rentdate, duration, paymentMethod, fee))
    conn.commit()
    cur.close()
    conn.close()
populate (conn,20)