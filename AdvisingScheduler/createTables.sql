DROP DATABASE IF EXISTS advising;
CREATE SCHEMA advising;
USE advising;

CREATE TABLE department (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE user (
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(85) NOT NULL,
  password CHAR(64) NOT NULL,
  fname VARCHAR(35) CHARSET utf8 NOT NULL,
  lname VARCHAR(35) CHARSET utf8 NOT NULL,
  phone CHAR(10),
  rank INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (email)
);

CREATE TABLE advisor (
  id INT NOT NULL AUTO_INCREMENT,
  userid INT NOT NULL,
  departmentid INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (userid) REFERENCES user(id) ON DELETE CASCADE,
  FOREIGN KEY (departmentid) REFERENCES department(id)
) ENGINE=InnoDB;

CREATE TABLE slot (
  id INT NOT NULL AUTO_INCREMENT,
  advisorid INT NOT NULL,
  starttime DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (advisorid) REFERENCES advisor(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE appointment (
  slotid INT NOT NULL,
  studentid INT NOT NULL,
  reason VARCHAR(30) NOT NULL,
  description VARCHAR(100),
  PRIMARY KEY (slotid),
  FOREIGN KEY (slotid) REFERENCES slot(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE appointment_unregistered (
  slotid INT NOT NULL,
  email VARCHAR(85) NOT NULL,
  fname VARCHAR(35) CHARSET utf8 NOT NULL,
  lname VARCHAR(35) CHARSET utf8 NOT NULL,
  phone CHAR(10),
  reason VARCHAR(30) NOT NULL,
  description VARCHAR(100),
  PRIMARY KEY (slotid),
  FOREIGN KEY (slotid) REFERENCES slot(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE student_user (
  studentid INT NOT NULL AUTO_INCREMENT,
  userid INT NOT NULL,
  utastudentid CHAR(10) NOT NULL,
  major VARCHAR(30) NOT NULL,
  PRIMARY KEY (studentid),
  FOREIGN KEY (userid) REFERENCES user(id),
  UNIQUE (userid)
);

ALTER TABLE slot
  ADD UNIQUE unique_index(advisorid, starttime);

-- views

CREATE VIEW student_appointment 
AS 
  SELECT slot.id                               AS appt_id, 
         advisor.id                            AS advisor_id, 
         Concat(auser.fname, ' ', auser.lname) AS advisor, 
         auser.phone                           AS advisor_phone, 
         auser.email                           AS advisor_email, 
         auser.rank                            AS advisor_rank, 
         stud_user.studentid                   AS student_id, 
         Concat(suser.fname, ' ', suser.lname) AS student, 
         stud_user.utastudentid                AS uta_student_id, 
         suser.email                           AS student_email, 
         suser.phone                           AS student_phone, 
         appt.reason, 
         appt.description, 
         slot.starttime                        AS time 
  FROM   slot, 
         student_user AS stud_user, 
         USER AS auser, 
         USER AS suser, 
         advisor, 
         appointment AS appt 
  WHERE  slot.id = appt.slotid 
         AND appt.studentid = stud_user.studentid 
         AND stud_user.userid = suser.id 
         AND advisor.id = slot.advisorid 
         AND auser.id = advisor.userid 
  ORDER  BY slot.starttime; 

CREATE VIEW unregistered_appointment 
AS 
  SELECT slot.id                               AS appt_id, 
         advisor.id                            AS advisor_id, 
         Concat(auser.fname, ' ', auser.lname) AS advisor, 
         auser.phone                           AS advisor_phone, 
         auser.email                           AS advisor_email, 
         auser.rank                            AS advisor_rank, 
         Concat(appt.fname, ' ', appt.lname)   AS student, 
         appt.email                            AS student_email, 
         appt.phone                            AS student_phone, 
         appt.reason, 
         appt.description, 
         slot.starttime                        AS time
  FROM   slot, 
         USER AS auser, 
         USER AS suser, 
         advisor, 
         appointment_unregistered AS appt 
  WHERE  slot.id = appt.slotid 
         AND advisor.id = slot.advisorid 
         AND auser.id = advisor.userid 
  ORDER  BY slot.starttime; 

CREATE VIEW any_appointment AS 
    SELECT  
        appt_id, 
        advisor_id, 
        advisor, 
        advisor_phone, 
        advisor_email, 
        advisor_rank, 
        student_id, 
        student, 
        uta_student_id, 
        student_email, 
        student_phone, 
        reason, 
        description, 
        time 
    FROM 
        student_appointment  
    UNION SELECT  
        appt_id, 
        advisor_id,
        advisor,
        advisor_phone, 
        advisor_email, 
        advisor_rank, 
        NULL,
        student, 
        NULL, 
        student_email, 
        student_phone, 
        reason, 
        description, 
        time
    FROM 
        unregistered_appointment 
    ORDER BY time; 

CREATE VIEW available_slot 
AS 
  SELECT slot.id, 
         department.id AS dept_id, 
         department.name AS dept_name, 
         advisor.id AS advisor_id, 
         Concat(user.fname, ' ', user.lname) AS advisor_name, 
         user.email AS advisor_email, 
         user.phone AS advisor_phone, 
         user.rank AS advisor_rank, 
         slot.starttime AS time 
  FROM   slot, 
         department, 
         advisor, 
         user 
  WHERE  slot.id NOT IN (SELECT DISTINCT slotid FROM appointment) 
         AND slot.id NOT IN (SELECT DISTINCT slotid FROM appointment_unregistered) 
         AND starttime > now() 
         AND department.id = advisor.departmentid 
         AND advisor.userid = user.id 
  ORDER  BY starttime; 

CREATE VIEW unavailable_slot 
AS 
  SELECT slot.id, 
         department.id AS dept_id, 
         department.name AS dept_name, 
         advisor.id AS advisor_id, 
         Concat(user.fname, ' ', user.lname) AS advisor_name, 
         user.email AS advisor_email, 
         user.phone AS advisor_phone, 
         user.rank AS advisor_rank, 
         slot.starttime AS time 
  FROM   slot, 
         department, 
         advisor, 
         user 
  WHERE  (slot.id IN (SELECT DISTINCT slotid FROM appointment) 
         OR slot.id IN (SELECT DISTINCT slotid FROM appointment_unregistered)) 
         AND starttime > now() 
         AND department.id = advisor.departmentid 
         AND advisor.userid = user.id 
  ORDER  BY starttime; 

CREATE VIEW future_slot AS
    SELECT 
        *, 1 AS available
    FROM
        available_slot 
    UNION SELECT 
        *, 0 AS available
    FROM
        unavailable_slot
    ORDER BY time; 

-- procedures

DELIMITER $$

CREATE PROCEDURE create_advisor (
    IN email VARCHAR(85),
    IN password CHAR(64),
    IN fname VARCHAR(35) CHARSET utf8,
    IN lname VARCHAR(35) CHARSET utf8,
    IN phone CHAR(10),
    IN departmentid INT,
    IN leadrole INT
)
BEGIN
    DECLARE userid INT;

    IF leadrole != 0 THEN
      SET leadrole = 1;
    END IF;

    IF (
        NULLIF(email, '') IS NULL
     OR NULLIF(password, '') IS NULL
     OR NULLIF(fname, '') IS NULL
     OR NULLIF(lname, '') IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NOT NULL parameter is NULL';
    END IF;

    IF NOT EXISTS (
        SELECT DISTINCT id
        FROM department
        WHERE id = departmentid
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tried to create an advisor with an unknown department.';
    END IF;

    INSERT INTO user(email, password, fname, lname, phone, rank) VALUES(email, password, fname, lname, phone, leadrole + 1);
    SET userid = LAST_INSERT_ID();
    INSERT INTO advisor(userid, departmentid) VALUES(userid, departmentid);
END $$

CREATE PROCEDURE create_student (
    IN email VARCHAR(85),
    IN password CHAR(64),
    IN fname VARCHAR(35) CHARSET utf8,
    IN lname VARCHAR(35) CHARSET utf8,
    IN phone CHAR(10),
    IN utastudentid CHAR(10),
    IN major VARCHAR(30)
)
BEGIN
    DECLARE userid INT;

    IF (
        NULLIF(email, '') IS NULL
     OR NULLIF(password, '') IS NULL
     OR NULLIF(utastudentid, '') IS NULL
     OR NULLIF(fname, '') IS NULL
     OR NULLIF(lname, '') IS NULL
     OR NULLIF(major, '') IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NOT NULL parameter is NULL';
    END IF;

    INSERT INTO user(email, password, fname, lname, phone, rank) VALUES(email, password, fname, lname, phone, 0);
    SET userid = LAST_INSERT_ID();
    INSERT INTO student_user(userid, utastudentid, major) VALUES(userid, utastudentid, major);
END $$

DELIMITER ;