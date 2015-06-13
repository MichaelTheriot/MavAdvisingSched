DROP DATABASE IF EXISTS advisingteam3;
CREATE SCHEMA advisingteam3;
USE advisingteam3;

CREATE TABLE department (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE user (
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(85) NOT NULL,
  fname VARCHAR(35) CHARSET utf8 NOT NULL,
  lname VARCHAR(35) CHARSET utf8 NOT NULL,
  phone CHAR(10),
  PRIMARY KEY (id),
  UNIQUE (email)
);

CREATE TABLE advisor (
  id INT NOT NULL AUTO_INCREMENT,
  userid INT NOT NULL,
  departmentid INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (userid) REFERENCES user(id) ON DELETE CASCADE,
  FOREIGN KEY (departmentid) REFERENCES department(id),
  lead INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE slot (
  id INT NOT NULL AUTO_INCREMENT,
  advisorid INT NOT NULL,
  starttime DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (advisorid) REFERENCES advisor(id) ON DELETE CASCADE
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

CREATE TABLE appointment (
  slotid INT NOT NULL,
  studentid INT NOT NULL,
  reason VARCHAR(30) NOT NULL,
  description VARCHAR(100),
  PRIMARY KEY (slotid),
  FOREIGN KEY (slotid) REFERENCES slot(id) ON DELETE CASCADE,
  FOREIGN KEY (studentid) REFERENCES student_user(studentid) ON DELETE CASCADE
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

CREATE TABLE admin (
  userid INT NOT NULL,
  FOREIGN KEY (userid) REFERENCES user(id),
  PRIMARY KEY (userid)
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
         advisor.lead                          AS advisor_lead, 
         advisor.departmentid                  AS advisor_dept, 
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
         advisor.lead                          AS advisor_lead, 
         advisor.departmentid                  AS advisor_dept, 
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
        advisor_lead, 
        advisor_dept, 
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
        advisor_lead, 
        advisor_dept, 
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
         advisor.lead AS advisor_lead, 
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
         advisor.lead AS advisor_lead, 
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

CREATE VIEW ranked_user AS
    SELECT 
        user.id,
        user.email,
        user.fname,
        user.lname,
        user.phone,
        CASE
            WHEN admin.userid IS NOT NULL THEN 4
            ELSE (CASE
                WHEN advisor.lead = 0 THEN 2
                ELSE (CASE
                    WHEN advisor.lead = 1 THEN 3
                    ELSE (CASE
                        WHEN user.email LIKE '%@uta.edu' THEN 1
                        ELSE 0
                    END)
                END)
            END)
        END AS rank
    FROM
        user AS user
            LEFT JOIN
        advisor ON advisor.userid = user.id
            LEFT JOIN
        admin ON admin.userid = user.id;