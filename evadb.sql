USE evaldb;


/************ Update: Tables ***************/

/******************** Add Table: Answers ************************/

/* Build Table Structure */
CREATE TABLE Answers
(
	id INTEGER NOT NULL,
	question_id INTEGER NOT NULL,
	classroom_id INTEGER NOT NULL,
	response BIGINT NOT NULL
) ENGINE=InnoDB;

/* Add Primary Key */
ALTER TABLE Answers ADD CONSTRAINT pkAnswers
	PRIMARY KEY (id);


/******************** Add Table: Classroom ************************/

/* Build Table Structure */
CREATE TABLE Classroom
(
	id INTEGER NOT NULL,
	instructor_id INTEGER NOT NULL,
	academic_year INTEGER UNSIGNED NOT NULL,
	semester BIGINT UNSIGNED NOT NULL,
	course_id INTEGER NOT NULL,
	program_id INTEGER NOT NULL
) ENGINE=InnoDB;

/* Add Primary Key */
ALTER TABLE Classroom ADD CONSTRAINT pkClassroom
	PRIMARY KEY (id);

/* Add Comments */
ALTER TABLE Classroom COMMENT = 'Student course table';


/******************** Add Table: Course ************************/

/* Build Table Structure */
CREATE TABLE Course
(
	id CHAR(100) NOT NULL,
	course_code VARCHAR(100) NOT NULL,
	credit_hr INTEGER UNSIGNED NOT NULL,
	ects INTEGER UNSIGNED NOT NULL,
	dept_id INTEGER NOT NULL
) ENGINE=InnoDB;

/* Add Primary Key */
ALTER TABLE Course ADD CONSTRAINT pkCourse
	PRIMARY KEY (id);


/******************** Add Table: Department ************************/

/* Build Table Structure */
CREATE TABLE Department
(
	id SMALLINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	dept_name VARCHAR(100) 
		COMMENT 'Department Number' NOT NULL,
	dept_head VARCHAR(100) NOT NULL,
	dept_type ENUM('School','Center') NOT NULL
) ENGINE=InnoDB;


/******************** Add Table: Instructor ************************/

/* Build Table Structure */
CREATE TABLE Instructor
(
	id INTEGER NOT NULL,
	instructor_name VARCHAR(100) NOT NULL,
	dept_id INTEGER NOT NULL,
	title VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

/* Add Primary Key */
ALTER TABLE Instructor ADD CONSTRAINT pkInstructor
	PRIMARY KEY (id);


/******************** Add Table: Program ************************/

/* Build Table Structure */
CREATE TABLE Program
(
	id INTEGER NOT NULL,
	dept_id SMALLINT NOT NULL,
	name VARCHAR(200) NOT NULL,
	stream VARCHAR(200) NOT NULL,
	program_type ENUM('regular','extension,'summer'') NOT NULL,
	degree_program ENUM('Undergraduate','Graduate','PhD','Certificate') NOT NULL
) ENGINE=InnoDB;

/* Add Primary Key */
ALTER TABLE Program ADD CONSTRAINT pkProgram
	PRIMARY KEY (id);


/******************** Add Table: Question ************************/

/* Build Table Structure */
CREATE TABLE Question
(
	id INTEGER NOT NULL,
	question VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

/* Add Primary Key */
ALTER TABLE Question ADD CONSTRAINT pkQuestion
	PRIMARY KEY (id);

/* Add Comments */
ALTER TABLE Question COMMENT = 'questions ...';


/******************** Add Table: Registration ************************/

/* Build Table Structure */
CREATE TABLE Registration
(
	id INTEGER NOT NULL,
	student_id INTEGER NOT NULL,
	classroom_id INTEGER NOT NULL,
	has_rated ENUM('Rated','Unrated') NOT NULL
) ENGINE=InnoDB;

/* Add Primary Key */
ALTER TABLE Registration ADD CONSTRAINT pkRegistration
	PRIMARY KEY (id);


/******************** Add Table: Student ************************/

/* Build Table Structure */
CREATE TABLE Student
(
	id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	year INTEGER 
		COMMENT 'year' NOT NULL,
	program_id INTEGER NOT NULL,
	student_id VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

/* Add Primary Key */
ALTER TABLE Student ADD CONSTRAINT pkStudent
	PRIMARY KEY (id);


/******************** Add Table: `User` ************************/

/* Build Table Structure */
CREATE TABLE `User`
(
	id INTEGER NOT NULL,
	reg_date DATE NOT NULL,
	user_name VARCHAR(100) NOT NULL,
	user_type ENUM('student','admin') NOT NULL,
	password VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

/* Add Primary Key */
ALTER TABLE `User` ADD CONSTRAINT pkUser
	PRIMARY KEY (id);

/* Add Comments */
ALTER TABLE User COMMENT = 'The user ...';





/************ Add Foreign Keys ***************/
/*-----------------------------------------------------------
Warning: Versions of MySQL prior to 4.1.2 require indexes on all columns involved in a foreign key. The following indexes may be required: 
fk_Answers_ClassRoom may require an index on table: Answers, column: classroom_id
fk_Answers_Question may require an index on table: Answers, column: question_id
fk_ClassRoom_Course may require an index on table: Classroom, column: course_id
fk_ClassRoom_Instructor may require an index on table: Classroom, column: instructor_id
fk_Classroom_Program may require an index on table: Classroom, column: program_id
fk_Course_Department may require an index on table: Course, column: dept_id
fk_Instructor_Department may require an index on table: Instructor, column: dept_id
fk_Program_Department may require an index on table: Program, column: dept_id
fk_Registration_ClassRoom may require an index on table: Registration, column: classroom_id
fk_Registration_Student may require an index on table: Registration, column: student_id
fk_Student_Program may require an index on table: Student, column: program_id
fk_Student_User may require an index on table: Student, column: user_id
-----------------------------------------------------------
*/

/* Add Foreign Key: fk_Answers_ClassRoom */
ALTER TABLE Answers ADD CONSTRAINT fk_Answers_ClassRoom
	FOREIGN KEY (classroom_id) REFERENCES Classroom (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_Answers_Question */
ALTER TABLE Answers ADD CONSTRAINT fk_Answers_Question
	FOREIGN KEY (question_id) REFERENCES Question (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_ClassRoom_Course */
ALTER TABLE Classroom ADD CONSTRAINT fk_ClassRoom_Course
	FOREIGN KEY (course_id) REFERENCES Course (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_ClassRoom_Instructor */
ALTER TABLE Classroom ADD CONSTRAINT fk_ClassRoom_Instructor
	FOREIGN KEY (instructor_id) REFERENCES Instructor (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_Classroom_Program */
ALTER TABLE Classroom ADD CONSTRAINT fk_Classroom_Program
	FOREIGN KEY (program_id) REFERENCES Program (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_Course_Department */
ALTER TABLE Course ADD CONSTRAINT fk_Course_Department
	FOREIGN KEY (dept_id) REFERENCES Department (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_Instructor_Department */
ALTER TABLE Instructor ADD CONSTRAINT fk_Instructor_Department
	FOREIGN KEY (dept_id) REFERENCES Department (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_Program_Department */
ALTER TABLE Program ADD CONSTRAINT fk_Program_Department
	FOREIGN KEY (dept_id) REFERENCES Department (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_Registration_ClassRoom */
ALTER TABLE Registration ADD CONSTRAINT fk_Registration_ClassRoom
	FOREIGN KEY (classroom_id) REFERENCES Classroom (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_Registration_Student */
ALTER TABLE Registration ADD CONSTRAINT fk_Registration_Student
	FOREIGN KEY (student_id) REFERENCES Student (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_Student_Program */
ALTER TABLE Student ADD CONSTRAINT fk_Student_Program
	FOREIGN KEY (program_id) REFERENCES Program (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_Student_User */
ALTER TABLE Student ADD CONSTRAINT fk_Student_User
	FOREIGN KEY (user_id) REFERENCES `User` (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;