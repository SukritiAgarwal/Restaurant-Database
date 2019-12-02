/*
 * TERM PROJECT DDL FILE
 * Shivam Gupta - 016215795 
 * Sukriti Agarwal - 016280171 
 * Hamza Mekouar - 016099159 
 * Shashi Kumar Kadari Mallikarjuna - 015092348
 */
 
/* Table structure for contact */
CREATE TABLE contact (
	CID INT NOT NULL,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	CONSTRAINT contact_pk PRIMARY KEY (CID)
);

/* Table structure for crew */
CREATE TABLE crew (
	crewName VARCHAR(30) NOT NULL,
	CONSTRAINT crew_pk PRIMARY KEY (crewName)
);

/* Table structure for jobTitle */
CREATE TABLE jobTitle (
	jobTitle VARCHAR(30) NOT NULL,
	CONSTRAINT jobTitle_pk PRIMARY KEY (jobTitle)
);

/* Table structure for employee */
CREATE TABLE employee (
	CID INT NOT NULL,
	jobDescription VARCHAR(100) NOT NULL,
	supervisorID INT DEFAULT NULL,
	jobTitle VARCHAR(30) NOT NULL,
	CONSTRAINT employee_pk PRIMARY KEY (CID),
	CONSTRAINT employee_supervisor FOREIGN KEY (supervisorID) REFERENCES employee (CID),
	CONSTRAINT employee_contact_fk FOREIGN KEY (CID) REFERENCES contact (CID),
	CONSTRAINT employee_jobTitle_fk FOREIGN KEY (jobTitle) REFERENCES jobTitle (jobTitle)
);

/* Table structure for crewEmployee*/
CREATE TABLE crewEmployee (
	crewName VARCHAR(30) NOT NULL,
	CID INT NOT NULL,
	CONSTRAINT crewEmployee_pk PRIMARY KEY (crewName, CID),
	CONSTRAINT crewEmployee_crew_fk FOREIGN KEY (crewName) REFERENCES crew (crewName),
	CONSTRAINT crewEmployee_employee_fk FOREIGN KEY (CID) REFERENCES employee (CID)
);

/* Table structure for shift */
CREATE TABLE shift (
	shiftDay VARCHAR(15) NOT NULL,
  	shiftTime VARCHAR(15) NOT NULL,
  	CONSTRAINT shift_pk PRIMARY KEY (shiftDay, shiftTime)
);

/* Table structure for crewShift */
CREATE TABLE crewShift (
	crewName VARCHAR(30) NOT NULL,
  	shiftDay VARCHAR(15) NOT NULL,
  	shiftTime VARCHAR(15) NOT NULL,
  	CONSTRAINT employeeShift_pk PRIMARY KEY (crewName, shiftDay, shiftTime),
  	CONSTRAINT employeeShift_employee_fk FOREIGN KEY (crewName) REFERENCES crew (crewName),
  	CONSTRAINT employeeShift_shift_fk FOREIGN KEY (shiftDay, shiftTime) REFERENCES shift (shiftDay, shiftTime)
);

/* Table structure for partTime */
CREATE TABLE partTime (
	CID INT NOT NULL,
	hourlyRate DOUBLE NOT NULL,
	CONSTRAINT partTime_pk PRIMARY KEY (CID),
	CONSTRAINT partTime_employee_fk FOREIGN KEY (CID) REFERENCES employee (CID)
);

/* Table structure for waitStaff */
CREATE TABLE waitStaff (
	CID INT NOT NULL,
	CONSTRAINT waitStaff_pk PRIMARY KEY (CID),
	CONSTRAINT waitStaff_partTime_fk FOREIGN KEY (CID) REFERENCES partTime (CID)
);

/* Table structure for ctables */
CREATE TABLE ctables (
	tableNum INT NOT NULL,
	CONSTRAINT ctables_pk PRIMARY KEY (tableNum)
);

/* Table structure for waitStaffTable */
CREATE TABLE waitStaffTable (
	CID INT NOT NULL,
	tableNum INT NOT NULL,
	CONSTRAINT waitStaffTable_pk PRIMARY KEY (CID, tableNum),
	CONSTRAINT waitStaffTable_waitStaff_fk FOREIGN KEY (CID) REFERENCES waitStaff (CID),
	CONSTRAINT waitStaffTable_tables_fk FOREIGN KEY (tableNum) REFERENCES ctables (tableNum)
);

/* Table structure for fullTime */
CREATE TABLE fullTime (
	CID INT NOT NULL,
	salary DOUBLE NOT NULL,
	healthCare VARCHAR(5) NOT NULL,
	CONSTRAINT fullTime_pk PRIMARY KEY (CID),
	CONSTRAINT fullTime_employee_fk FOREIGN KEY (CID) REFERENCES employee (CID)
);

/* Table structure for headChef */
CREATE TABLE headChef (
	CID INT NOT NULL,
	recipe VARCHAR(30) NOT NULL,
	CONSTRAINT headChef_pk PRIMARY KEY (CID),
	CONSTRAINT headChef_fullTime_fk FOREIGN KEY (CID) REFERENCES fullTime (CID)
);

/* Table structure for departments */
CREATE TABLE departments (
	department VARCHAR(50) NOT NULL,
	CONSTRAINT department_pk PRIMARY KEY (department)
);

/* Table structure for lineCook */
CREATE TABLE lineCook (
	CID INT NOT NULL,
	department VARCHAR(50) NOT NULL,
	CONSTRAINT lineCook_pk PRIMARY KEY (CID),
	CONSTRAINT lineCook_fullTime_fk FOREIGN KEY (CID) REFERENCES fullTime (CID),
	CONSTRAINT lineCook_department_fk FOREIGN KEY (department) REFERENCES departments (department)
);

/* Table structure for stations */
CREATE TABLE stations (
	station VARCHAR(50) NOT NULL,
  	CONSTRAINT stations_pk PRIMARY KEY (station)
);

/* Table structure for lineCookStations */
CREATE TABLE lineCookStations (
	CID INT NOT NULL,
	station VARCHAR(50) NOT NULL,
	CONSTRAINT lineCookStations_pk PRIMARY KEY (CID, station),
	CONSTRAINT lineCookStations_lineCook_fk FOREIGN KEY (CID) REFERENCES lineCook (CID),
	CONSTRAINT lineCookStations_stations_fk FOREIGN KEY (station) REFERENCES stations (station)
);

/* Table structure for sousChef */
CREATE TABLE sousChef (
	CID INT NOT NULL,
	CONSTRAINT sousChef_pk PRIMARY KEY(CID),
	CONSTRAINT sousChef_fullTime_fk FOREIGN KEY(CID) REFERENCES fullTime (CID)
);

/* Table structure for expertises */
CREATE TABLE expertises (
	expertise VARCHAR(50) NOT NULL,
	CONSTRAINT expertises_pk PRIMARY KEY (expertise)
);

/* Table structure for sousChefExpertise */
CREATE TABLE sousChefExpertise (
	CID INT NOT NULL,
	expertise VARCHAR(50) NOT NULL,
	CONSTRAINT sousChefExpertise_pk PRIMARY KEY (CID,expertise),
	CONSTRAINT sousChefExpertise_sousChef_fk FOREIGN KEY (CID) REFERENCES sousChef (CID),
	CONSTRAINT sousChefExpertise_expertises_fk FOREIGN KEY (expertise) REFERENCES expertises (expertise)
);

/* Table structure for customer */
CREATE TABLE customer (
	CID INT NOT NULL,
  	mimingsMoney INT NOT NULL,
  	CONSTRAINT customer_pk PRIMARY KEY (CID),
  	CONSTRAINT customer_contact_fk FOREIGN KEY (CID) REFERENCES contact (CID)
);

/* Table structure for privateCustomer */
CREATE TABLE privateCustomer (
	CID INT NOT NULL,
  	snailMailAddress VARCHAR(100) NOT NULL,
  	CONSTRAINT privateCustomer_pk PRIMARY KEY (CID),
  	CONSTRAINT privateCustomer_customer_fk FOREIGN KEY (CID) REFERENCES customer (CID)
);

/* Table structure for corporateCustomer */
CREATE TABLE corporateCustomer (
	CID INT NOT NULL,
  	corporationName VARCHAR(50) NOT NULL,
  	organizationName VARCHAR(50) NOT NULL,
  	officeAddress VARCHAR(100) NOT NULL,
  	CONSTRAINT corporateCustomer_pk PRIMARY KEY (CID),
  	CONSTRAINT corporateCustomer_customer_fk FOREIGN KEY (CID) REFERENCES customer (CID)
);

/* Table structure for orders */
CREATE TABLE orders (
	orderID INT NOT NULL,
  	paymentType VARCHAR(30) NOT NULL,
  	tips DOUBLE NOT NULL,
  	orderDate DATE NOT NULL,
  	orderTime TIME NOT NULL,
  	CID INT NOT NULL,
  	CONSTRAINT orders_pk PRIMARY KEY (orderID),
  	CONSTRAINT orders_customer_fk FOREIGN KEY (CID) REFERENCES customer (CID),
  	CONSTRAINT orders_ck UNIQUE (orderDate,orderTime,CID)
);

/* Table structure for toGo */
CREATE TABLE toGo (
	orderID INT NOT NULL,
  	pickupTime TIME NOT NULL,
  	foodReadyTime TIME NOT NULL,
  	CONSTRAINT toGo_pk PRIMARY KEY (orderID),
  	CONSTRAINT toGo_orders_fk FOREIGN KEY (orderID) REFERENCES orders (orderID)
);

/* Table structure for eatIn */
CREATE TABLE eatIn (
	orderID INT NOT NULL,
  	TableNum INT NOT NULL,
  	CONSTRAINT eatIn_pk PRIMARY KEY (orderID),
  	CONSTRAINT eatIn_orders_fk FOREIGN KEY (orderID) REFERENCES orders (orderID)
);

/* Table structure for menu */
CREATE TABLE menu (
  	type VARCHAR(30) NOT NULL,
  	CONSTRAINT menu_pk PRIMARY KEY (type)
);

/* Table structure for categories */
CREATE TABLE categories (
	categoryName VARCHAR(30) NOT NULL,
  	CONSTRAINT categories_pk PRIMARY KEY (categoryName)
);

/* Table structure for menuItem */
CREATE TABLE menuItem (
	itemName VARCHAR(50) NOT NULL,
  	spiceLevel VARCHAR(10) NOT NULL,
  	categoryName VARCHAR(30) NOT NULL,
  	subCategory VARCHAR(30),
  	CONSTRAINT menuItem_pk PRIMARY KEY (itemName, spiceLevel),
  	CONSTRAINT menuItem_categories_fk FOREIGN KEY (categoryName) REFERENCES categories (categoryName)
);

/* Table structure for menuMenuItem */
CREATE TABLE menuMenuItem (
	itemName VARCHAR(50) NOT NULL,
  	spiceLevel VARCHAR(30) NOT NULL,
 	type VARCHAR(30) NOT NULL,
  	size VARCHAR(10) NOT NULL,
  	price DOUBLE NOT NULL,
  	CONSTRAINT menuMenuItem_pk PRIMARY KEY (itemName, spiceLevel, type),
  	CONSTRAINT menuMenuItem_menu_fk FOREIGN KEY (type) REFERENCES menu (type),
  	CONSTRAINT menuMenuItem_menuItem_fk FOREIGN KEY (itemName, spiceLevel) REFERENCES menuItem (itemName, spiceLevel)
);

/* Table structure for orderItem */
CREATE TABLE orderItem (
	orderID INT NOT NULL,
  	type VARCHAR(30) NOT NULL,
  	itemName VARCHAR(50) NOT NULL,
  	spiceLevel VARCHAR(30) NOT NULL,
  	quantity INT NOT NULL,
  	CONSTRAINT orderItem_pk PRIMARY KEY (orderID, type, itemName, spiceLevel),
  	CONSTRAINT orderItem_orders_fk FOREIGN KEY (orderID) REFERENCES orders (orderID),
  	CONSTRAINT orderItem_menuMenuItem_fk FOREIGN KEY (type,itemName,spiceLevel) REFERENCES menuMenuItem (type,itemName,spiceLevel)
);

/* Table structure for mentorship */
CREATE TABLE mentorship (
	mentorID INT NOT NULL,
	menteeID INT NOT NULL,
	startDate DATE NOT NULL,
	endDate DATE NOT NULL,
	itemName VARCHAR(50) NOT NULL,
  	spiceLevel VARCHAR(30) NOT NULL,
  	CONSTRAINT mentorship PRIMARY KEY (mentorID, menteeID, startDate, itemName, spiceLevel),
  	CONSTRAINT mentorship_mentor_sousChef_fk FOREIGN KEY (mentorID) REFERENCES sousChef (CID),
  	CONSTRAINT mentorship_mentee_sousChef_fk FOREIGN KEY (menteeID) REFERENCES sousChef (CID),
  	CONSTRAINT mentorship_menuItem_fk FOREIGN KEY (itemName, spiceLevel) REFERENCES menuItem (itemName, spiceLevel)
);

/**
DROP TABLE mentorship;
DROP TABLE orderItem;
DROP TABLE menuMenuItem;
DROP TABLE menuItem;
DROP TABLE categories;
DROP TABLE menu;
DROP TABLE eatIn;
DROP TABLE toGo;
DROP TABLE orders;
DROP TABLE corporateCustomer;
DROP TABLE privateCustomer;
DROP TABLE customer;
DROP TABLE sousChefExpertise;
DROP TABLE expertises;
DROP TABLE sousChef;
DROP TABLE lineCookStations;
DROP TABLE stations;
DROP TABLE lineCook;
DROP TABLE departments;
DROP TABLE headChef;
DROP TABLE fullTime;
DROP TABLE waitStaffTable;
DROP TABLE ctables;
DROP TABLE waitStaff;
DROP TABLE partTime;
DROP TABLE crewShift;
DROP TABLE shift;
DROP TABLE crewEmployee;
DROP TABLE employee;
DROP TABLE jobTitle;
DROP TABLE crew;
DROP TABLE contact;
**/