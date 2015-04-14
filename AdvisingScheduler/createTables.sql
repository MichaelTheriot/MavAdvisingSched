-- Note studentid is a database variable and utastudentid is the student's UT Arlington student ID

CREATE TABLE appointment (
  slotid INT NOT NULL,
  studentid INT NOT NULL,
  reason VARCHAR(30) NOT NULL,
  description VARCHAR(100),
  PRIMARY KEY (slotid)
);

CREATE TABLE student_appt (
  apptid INT NOT NULL,
  studentid INT NOT NULL,
  PRIMARY KEY (apptid)
);

CREATE TABLE slot (
  id INT NOT NULL AUTO_INCREMENT,
  starttime DATETIME NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE student (
  id INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id)
);

CREATE TABLE student_unregistered (
  studentid INT NOT NULL,
  fname VARCHAR(35) CHARSET utf8 NOT NULL,
  lname VARCHAR(35) CHARSET utf8 NOT NULL,
  email VARCHAR(85) NOT NULL,
  PRIMARY KEY (studentid),
  UNIQUE (email)
);

CREATE TABLE student_user (
  studentid INT NOT NULL,
  userid INT NOT NULL,
  utastudentid CHAR(10) NOT NULL,
  major VARCHAR(30) NOT NULL,
  PRIMARY KEY (studentid),
  UNIQUE (userid)
);

CREATE TABLE user (
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(85) NOT NULL,
  password CHAR(64) NOT NULL,
  fname VARCHAR(35) CHARSET utf8 NOT NULL,
  lname VARCHAR(35) CHARSET utf8 NOT NULL,
  rank INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (email)
);

ALTER TABLE appointment
  ADD CONSTRAINT bind_slotid_to_appointment
  FOREIGN KEY (slotid)
  REFERENCES slot(id);

ALTER TABLE appointment
  ADD CONSTRAINT bind_studentid_to_appointment
  FOREIGN KEY (studentid)
  REFERENCES student(id);

ALTER TABLE student_appt
  ADD CONSTRAINT bind_apptid_to_student_appt
  FOREIGN KEY (apptid)
  REFERENCES appointment(slotid);

ALTER TABLE student_appt
  ADD CONSTRAINT bind_studentid_to_student_appt
  FOREIGN KEY (studentid)
  REFERENCES student(id);

ALTER TABLE student_unregistered
  ADD CONSTRAINT bind_studentid_to_student_unregistered
  FOREIGN KEY (studentid)
  REFERENCES student(id);

ALTER TABLE student_user
  ADD CONSTRAINT bind_studentid_to_student_user
  FOREIGN KEY (studentid)
  REFERENCES student(id);

ALTER TABLE student_user
  ADD CONSTRAINT bind_userid_to_student_user
  FOREIGN KEY (userid)
  REFERENCES student(id);