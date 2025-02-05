use littlelemondb;

INSERT INTO address (country, state, city, street, zipcode)
VALUES
  ("Vietnam","auctor.","St. Andrä","499-7670 Dolor Av.",815181),
  ("Spain","pede.","Galway","Ap #573-6161 Quam St.",34151),
  ("France","vehicula","Brussel","Ap #254-2724 Donec St.",47691),
  ("Ireland","senectus","Yurimaguas","Ap #722-7357 Porttitor Ave",1214),
  ("Sweden","ante","Outram","175-4313 Rhoncus. Avenue",83713);
  
 INSERT INTO customers (name, contactnumber, addressid)
VALUES
  ("Timon Bush","9291234567",1),
  ("Sacha Carrillo","3471236547",2),
  ("Dylan Bowen","8296444444",3),
  ("Xavier Tucker","7878889999",4),
  ("Ignatius Cash","8096454444",5); 
  
  
INSERT INTO employees (idemployees,`name`,`role`,`salary`,`email`,`addressid`)
VALUES
  (1,"Len Sims","Receptionist",2541,"lorem.fringilla@google.com",1),
  (2,"Nina Donovan","Waitres",6925,"quis.lectus.nullam@aol.com",2),
  (3,"Wylie Cleveland","Assistant",5979,"eget@outlook.org",3),
  (4,"Orlando Moody","Manager",3735,"donec.luctus@protonmail.net",4),
  (5,"Wendy Eaton","Chef",8182,"semper@icloud.com",5);
  
INSERT INTO menu_items (`name`,`type`,`price`)
VALUES
  ("Cheesecake","Dessert",109492),
  ("Rice","Main Course",72984),
  ("Ham Sandwich","Apetizer",72236),
  ("Crab Soup","Soup",39130),
  ("Coffee","Drink",39051);
  
INSERT INTO menu(`itemid`,`cusine`)
VALUES
  (1,"European"),
  (2,"Fusion"),
  (3,"American"),
  (4,"Mediterranean"),
  (5,"Caribbean");
  
INSERT INTO delivery 
VALUES
  (1,"In-Transit","2024-12-08"),
  (2,"Delivered","2026-11-11"),
  (3,"In-Progress","2025-02-08"),
  (4,"Waiting","2024-01-02"),
  (5,"Cancelled","2024-12-31");
INSERT INTO bookings (idbookings,`tableno`,`customerid`,bookingslot,`employeeid`)
VALUES
  (1,2,1,"2024-11-26",5),
  (2,3,2,"2025-08-29",4),
  (3,4,3,"2024-09-03",3),
  (4,5,4,"2024-02-15",2),
  (5,1,5,"2025-01-26",1);


INSERT INTO orders (`menuid`,`bookingid`,`billamount`,`quantity`,`orderdate`,`statusid`)
VALUES
  (1,1,4944,6,"2024-12-08",1),
  (2,2,3587,5,"2026-11-11",2),
  (3,3,5739,4,"2025-02-08",3),
  (4,4,4543,3,"2024-01-02",4),
  (5,5,3213,1,"2024-12-31",4);  


  
