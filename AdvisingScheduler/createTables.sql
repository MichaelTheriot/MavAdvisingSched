-- Note studentid is a database variable and utastudentid is the student's UT Arlington student ID

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
  FOREIGN KEY (userid) REFERENCES user(id) ON DELETE CASCADE
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

CREATE TABLE student (
  id INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id)
);

CREATE TABLE student_unregistered (
  studentid INT NOT NULL,
  fname VARCHAR(35) CHARSET utf8 NOT NULL,
  lname VARCHAR(35) CHARSET utf8 NOT NULL,
  email VARCHAR(85) NOT NULL,
  phone CHAR(10),
  PRIMARY KEY (studentid),
  UNIQUE (email)
);

CREATE TABLE student_user (
  studentid INT NOT NULL,
  userid INT NOT NULL,
  utastudentid CHAR(10) NOT NULL,
  major VARCHAR(30) NOT NULL,
  PRIMARY KEY (studentid),
  FOREIGN KEY (userid) REFERENCES user(id),
  UNIQUE (userid)
);

ALTER TABLE slot
  ADD UNIQUE unique_index(advisorid, starttime);

ALTER TABLE advisor
  ADD CONSTRAINT bind_userid_to_advisor
  FOREIGN KEY (userid)
  REFERENCES user(id);

ALTER TABLE advisor
  ADD CONSTRAINT bind_departmentid_to_advisor
  FOREIGN KEY (departmentid)
  REFERENCES department(id);

ALTER TABLE student_unregistered
  ADD CONSTRAINT bind_studentid_to_student_unregistered
  FOREIGN KEY (studentid)
  REFERENCES student(id);

ALTER TABLE student_user
  ADD CONSTRAINT bind_studentid_to_student_user
  FOREIGN KEY (studentid)
  REFERENCES student(id);

CREATE VIEW student_appointment AS
SELECT slot.starttime AS time, advisor.id AS advisor_id, concat(auser.fname, ' ', auser.lname) AS advisor, concat(suser.fname, ' ', suser.lname) AS student, stud_user.utastudentid AS uta_student_id, suser.email AS student_email, suser.phone AS student_phone, appt.reason, appt.description, slot.id AS appt_id
FROM slot, student AS stud, student_user AS stud_user, user AS auser, user AS suser, advisor, appointment AS appt
WHERE slot.id = appt.slotid AND appt.studentid = stud.id AND stud.id = stud_user.studentid AND stud_user.userid = suser.id AND advisor.id = slot.advisorid AND auser.id = advisor.userid
ORDER BY slot.starttime;

CREATE VIEW unregistered_appointment AS
SELECT advisor.id AS advisor_id, concat(auser.fname, ' ', auser.lname) AS advisor, concat(suser.fname, ' ', suser.lname) AS student, suser.email AS student_email, suser.phone AS student_phone, appt.reason, appt.description, slot.starttime AS time, slot.id AS appt_id
FROM slot, student AS stud, user AS auser, student_unregistered AS suser, advisor, appointment AS appt
WHERE slot.id = appt.slotid AND appt.studentid = stud.id AND stud.id = suser.studentid AND advisor.id = slot.advisorid AND auser.id = advisor.userid
ORDER BY slot.starttime;

CREATE VIEW any_appointment AS
SELECT advisor_id, advisor, student, uta_student_id, student_email, student_phone, reason, description, time, appt_id FROM student_appointment
UNION
SELECT advisor_id, advisor, student, NULL, student_email, student_phone, reason, description, time, appt_id from unregistered_appointment
ORDER BY time;

CREATE VIEW available_slot AS
SELECT  slot.id, department.name, concat(user.fname, ' ', user.lname) AS advisor_name, user.rank, starttime AS time
FROM slot, advisor, department, user
WHERE slot.id NOT IN (SELECT DISTINCT slotid FROM appointment) AND starttime > now() AND advisor.id = slot.advisorid AND department.id = advisor.departmentid AND user.id = advisor.userid
ORDER BY starttime;