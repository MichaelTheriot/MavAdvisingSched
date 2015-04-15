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
    DECLARE studentid INT;

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
    INSERT INTO student() VALUES();
    SET studentid = LAST_INSERT_ID();
    INSERT INTO student_user VALUES(studentid, userid, utastudentid, major);
END $$

CREATE PROCEDURE check_slot (
    IN slotid INT
)
BEGIN 
    IF NOT EXISTS (
        SELECT DISTINCT id
        FROM slot
        WHERE id = slotid
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tried to schedule an appointment on a non-existent slot.';
    ELSEIF EXISTS (
        SELECT DISTINCT A.slotid
        FROM appointment AS A
        WHERE A.slotid = slotid
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tried to schedule an appointment on a used slot.';
    END IF;
END $$

CREATE PROCEDURE schedule_appointment (
    IN studentid INT,
    IN reason VARCHAR(30),
    IN description VARCHAR(100),
    IN slotid INT
)
BEGIN
    CALL check_slot(slotid);

    IF NULLIF(reason, '') IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NOT NULL parameter is NULL';
    END IF;

    INSERT INTO appointment VALUES(slotid, studentid, reason, description);
END $$

CREATE PROCEDURE schedule_appointment_unregistered (
    IN fname VARCHAR(35) CHARSET utf8,
    IN lname VARCHAR(35) CHARSET utf8,
    IN email VARCHAR(85),
    IN phone CHAR(10),
    IN reason VARCHAR(30),
    IN description VARCHAR(100),
    IN slotid INT
)
BEGIN
    DECLARE studentid INT;

    CALL check_slot(slotid);

    IF (
        NULLIF(email, '') IS NULL
     OR NULLIF(fname, '') IS NULL
     OR NULLIF(lname, '') IS NULL
     OR NULLIF(reason, '') IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NOT NULL parameter is NULL';
    END IF;

    SELECT DISTINCT SU.studentid
    INTO studentid
    FROM student_unregistered AS SU
    WHERE SU.email = email;

    IF studentid IS NULL THEN
        INSERT INTO student VALUES();
        SET studentid = LAST_INSERT_ID();
        INSERT INTO student_unregistered VALUES(studentid, fname, lname, email, phone);
    END IF;

    INSERT INTO appointment VALUES(slotid, studentid, reason, description);
    UPDATE student_unregistered AS SU
    SET
        SU.fname = fname,
        SU.lname = lname,
        SU.phone = phone
    WHERE SU.email = email;
END $$

DELIMITER ;