-- Crating Medical practice database
CREATE DATABASE MedicalPractice -- Crating Patient table
CREATE TABLE Patient(
    Patient_ID INTEGER NOT NULL,
    Title NVARCHAR(20),
    FirstName NVARCHAR(50) NOT NULL,
    MiddleInitial NCHAR(1),
    LastName NVARCHAR(50) NOT NULL,
    HouseUnitLotNum NVARCHAR(5) NOT NULL,
    Street NVARCHAR(50) NOT NULL,
    Suburb NVARCHAR(50) NOT NULL,
    State NVARCHAR(3) NOT NULL,
    PostCode NCHAR(4) NOT NULL,
    HomePhone NCHAR(10),
    MobilePhone NCHAR(10),
    MedicareNumber NCHAR(16),
    DateOfBirth DATE NOT NULL,
    Gender NCHAR(20) NOT NULL,
    PRIMARY KEY (Patient_ID)
);



-- CRATING PractitionerType TABLE
CREATE TABLE PractitionerType(PractitionerType NVARCHAR(50) PRIMARY KEY);


-- CREATING Practitioner TABLE
CREATE TABLE Practitioner(
    Practitioner_ID INTEGER NOT NULL,
    Title NVARCHAR(20),
    FirstName NVARCHAR(50) NOT NULL,
    MiddleInitial NCHAR(1),
    LastName NVARCHAR(50) NOT NULL,
    HouseUnitLotNum NVARCHAR(5) NOT NULL,
    Street NVARCHAR(50) NOT NULL,
    Suburb NVARCHAR(50) NOT NULL,
    State NVARCHAR(3) NOT NULL,
    PostCode NCHAR(4) NOT NULL,
    HomePhone NCHAR(10),
    MobilePhone NCHAR(10),
    MedicareNumber NCHAR(16),
    MedicalRegistrationNumber NCHAR(11) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender NCHAR(20) NOT NULL,
    PractitionerType_Ref NVARCHAR(50) NOT NULL,
    PRIMARY KEY (Practitioner_ID),
    FOREIGN KEY (PractitionerType_Ref) REFERENCES PractitionerType(PractitionerType)
);


-- CREATING WeekDays TABLE
CREATE TABLE WeekDays(
    WeekDayName NVARCHAR(9) NOT NULL PRIMARY KEY
);

-- CREATING Availability TABLE
CREATE TABLE AvailabilitY (
    Practitioner_Ref INTEGER NOT NULL,
    WeekDayName_Ref NVARCHAR(9) NOT NULL,
    CONSTRAINT PK_AvailabilitY PRIMARY KEY (WeekDayName_Ref, Practitioner_Ref),
    FOREIGN KEY (WeekDayName_Ref) REFERENCES WeekDays(WeekDayName),
    FOREIGN KEY (Practitioner_Ref) REFERENCES Practitioner(Practitioner_ID)
);


-- CREATING Appointment TABLE
CREATE TABLE Appointment(
    Practitioner_Ref INTEGER NOT NULL,
    AppDate DATE NOT NULL,
    AppStartTime TIME NOT NULL,
    Patient_Ref INTEGER NOT NULL,
    CONSTRAINT PK_Appointment PRIMARY KEY(Practitioner_Ref, AppDate, AppStartTime),
    FOREIGN KEY (Practitioner_Ref) REFERENCES Practitioner(Practitioner_ID),
    FOREIGN KEY (Patient_Ref) REFERENCES Patient(Patient_ID)
);


-- CREATING TestType TABLE
CREATE TABLE TestType(
    Test_Code NVARCHAR(20) NOT NULL,
    TestName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500),
    PRIMARY KEY (Test_Code)
);


-- CREATING PathTestReqs TABLE
CREATE TABLE PathTestReqs(
    Practitioner_Ref INTEGER NOT NULL,
    DateOrdered DATE NOT NULL,
    TimeOrdered TIME NOT NULL,
    Patient_Ref INTEGER NOT NULL,
    Test_Ref NVARCHAR(20) NOT NULL,
    CONSTRAINT PK_PathTestReqs PRIMARY KEY(Practitioner_Ref, DateOrdered, TimeOrdered),
    FOREIGN KEY (Practitioner_Ref) REFERENCES Practitioner(Practitioner_ID),
    FOREIGN KEY (Patient_Ref) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Test_Ref) REFERENCES TestType(Test_Code)
);


-- TESTING THE DATABASE
INSERT INTO Patient
values
(
    10000,
    'Mr',
    'Mackenzie',
    'J',
    'Fleetwood',
    '233',
    'Dreaming Street',
    'Roseville',
    'NSW',
    '2069',
    '0298654743',
    '0465375486',
    '7253418356478253',
    '2000-03-12',
    'male'
);


INSERT INTO Patient VALUES
(
        'Mackenzie',
        'Mr',
        10000,
        'J',
        'Fleetwood',
        233,
        'Dreaming Street',
        'Roseville',
        'NSW',
        '2069',
        '0298654743',
        '0465375486',
        '7253418356478253',
        '2000-03-12',
        '7253418356478253'
    );

	INSERT INTO Patient VALUES
(
        NULL, 
        'Mr',
        'Mackenzie',
        'J',
        'Fleetwood',
        '233',
        'Dreaming Street',
        'Roseville',
        'NSW',
        '2069',
        '0298654743',
        '0465375486',
        '7253418356478253',
        '2000-03-12',
        'male'
    );

INSERT INTO PractitionerType VALUES
(
	'Medical Practitioner (Doctor or GP)'	
);

SELECT * FROM PractitionerType;


INSERT INTO Practitioner VALUES
(
    10000, 'Dr', 'Mark', 'P', 'Huston', '21', 'Fuller Street',
	'Sunshine', 'NSW', '2343', '0287657483', '0476352638',
	'9878986473892753', '63738276173', '1975-07-07', 'male',
	'Medical Practitioner (Doctor or GP)'
);

INSERT INTO Practitioner VALUES
(
    20000, 'Dr', 'Basir', 'P', 'Huston', '21', 'Fuller Street',
	'Sunshine', 'NSW', 2343, '0287657483', '0476352638', 9878986473892753,
	'63738276173', '1975-07-07', 2, 'Medical Practitioner (Doctor or GP)'
);

SELECT * FROM AvailabilitY;



INSERT INTO AvailabilitY VALUES
(
	'Sunday', 10000
);
SELECT * FROM AvailabilitY;

INSERT INTO WeekDays VALUES
(
	'Sunday'
);

SELECT * FROM Practitioner;

DELETE FROM WeekDays;
DELETE FROM AvailabilitY;
DELETE FROM Practitioner;
DELETE FROM Patient;



--Populating the database tables 


-- PatientData.csv
INSERT into Patient
    VALUES(
        10000, 'Mr', 'Mackenzie', 'J', 'Fleetwood', '233', 'Dreaming Street', 'Roseville', 'NSW', '2069', '0298654743', '0465375486', '7253418356478253', '2000-03-12', 'male'
    );
INSERT into Patient
    VALUES(
        10001, 'Ms', 'Jane', 'P', 'Killingsworth', '34', 'Southern Road', 'Yarramundi', 'NSW', '2753', '0234654345', '0342134679', '9365243640183640', '1943-04-08', 'female'
    );
INSERT into Patient
    VALUES(
        10002, 'Mr', 'Peter', 'D', 'Leons', '21', 'Constitution Drive', 'West Hoxton', 'NSW', '2171', '0276539183', '0125364927', '1873652945578932', '1962-07-08', 'male'
    );
INSERT into Patient
    VALUES(
        10003, 'Mr', 'Phill', 'B', 'Greggan', '42', 'Donn Lane', 'Killara', 'NSW', '2071', '0276548709', '1234326789', '6473645782345678', '1971-08-31', 'male'
    );
INSERT into Patient
    VALUES(
        10004, 'Dr', 'John', 'W', 'Ward', '332', 'Tomorrow Road', 'Chatswood', 'NSW', '2488', '4847383848', '4838382728', '4738294848484838', '1978-02-12', 'male'
    );
INSERT into Patient
    VALUES(
        10005, 'Mrs', 'Mary', 'D', 'Brown', 'Lot23', 'Johnston Road', 'Warwick Farm', 'NSW', '2170', '0297465243', '0417335224', '9356273321176546', '1972-03-05', 'female'
    );
INSERT into Patient
    VALUES(
        10006, 'Mr', 'Terrence', 'D', 'Hill', '43', 'Somerland Road', 'La Perouse', 'NSW', '2987', '0266645432', '0365243561', '6363525353535356', '2005-10-04', 'male'
    );
INSERT into Patient
    VALUES(
        10007, 'Master', 'Adrian', 'B', 'Tamerkand', '44', 'The Hill Road', 'Macquarie Fields', 'NSW', '2756', '0276546783', '4848473738', '9863652527637332', '2008-12-12', 'male'
    );
INSERT into Patient
    VALUES(
        10008, 'Ms', 'Joan', 'D', 'Wothers', '32', 'Slapping Street',	 'Mount Lewis', 'NSW', '2343', '1294848777', '8484737384', '9484746125364765', '1997-06-12', 'female'
    );
INSERT into Patient
    VALUES(
        10009, 'Mrs', 'Caroline', 'J', 'Barrette', '44', 'Biggramham Road', 'St Kilda', 'VIC', '4332', '0384736278', '9383827373', '1234565725463728', '1965-04-04', 'female'
    );
INSERT into Patient
    VALUES(
        10010, 'Mrs', 'Wendy', 'J', 'Pilington',  '182',  'Parramatta Road', 'Lidcombe', 'NSW', '2345', '4837383848', '8473838383', '8483727616273838', '1985-09-17', 'female'
    );




-- PractitionerTypeData.csv
INSERT INTO PractitionerType
    VALUES(
        'Diagnostic radiographer'
    );
INSERT INTO PractitionerType
    VALUES(
        'Enrolled nurse'
    );
INSERT INTO PractitionerType
    VALUES(
        'Medical Practitioner (Doctor or GP)'
    );
INSERT INTO PractitionerType
    VALUES(
        'Medical radiation practitioner'
    );
INSERT INTO PractitionerType
    VALUES(
        'Midwife'
    );
INSERT INTO PractitionerType
    VALUES(
        'Nurse'
    );
INSERT INTO PractitionerType
    VALUES(
        'Occupational therapist'
    );
INSERT INTO PractitionerType
    VALUES(
        'Optometrist'
    );
INSERT INTO PractitionerType
    VALUES(
        'Osteopath'
    );
INSERT INTO PractitionerType
    VALUES(
        'Physical therapist'
    );
INSERT INTO PractitionerType
    VALUES(
        'Physiotherapist'
    );
INSERT INTO PractitionerType
    VALUES(
        'Podiatrist'
    );
INSERT INTO PractitionerType
    VALUES(
        'Psychologist'
    );
INSERT INTO PractitionerType
    VALUES(
        'Radiation therapist'
    );
INSERT INTO PractitionerType
    VALUES(
        'Registered nurse'
    );

	SELECT * FROM PractitionerType;



-- PractitionerData.csv
INSERT INTO Practitioner
    VALUES(
        10000,  'Dr',  'Mark',  'P',  'Huston',  '21',  'Fuller Street',  'Sunshine',  'NSW',  '2343',  '0287657483',  '0476352638',  '9878986473892753',  '63738276173',  '1975-07-07',  'male',  'Medical Practitioner (Doctor or GP)'
    );
INSERT INTO Practitioner
    VALUES(    
        10001,  'Mrs',  'Hilda',  'D',  'Brown',  '32',  'Argyle Street',  'Bonnels Bay',  'NSW',  '2264',  '0249756544',  '0318466453',  '4635278435099921',  '37876273849',  '1993-12-03',  'female',  'Registered nurse'
    );
INSERT INTO Practitioner
    VALUES(    
        10002,  'Mrs',  'Jennifer',  'J',  'Dunsworth',  '45',  'Dora Street',  'Morriset',  'NSW',  '2264',  '0249767574',  '0228484373',  '7666777833449876',  '48372678939',  '1991-06-04',  'female',  'Registered nurse'
    );
INSERT INTO Practitioner
    VALUES(    
        10003,  'Mr',  'Jason',  'D',  'Lithdon',  '43',  'Fowler Street',  'Camperdown',  'NSW',  '2050',  '0298785645',  '0317896453',  '0487736265377777',  '12345678901',  '1989-08-09',  'male',  'nurse'
    );
INSERT INTO Practitioner
    VALUES(    
        10004,  'Ms',  'Paula',  'D',  'Yates',  '89',  'Tableton Road',  'Newtown',  'NSW',  '2051',  '0289876432',  '0938473625',  '6637474433222881',  '84763892834',  '1982-09-07',  'female',  'Midwife'
    );
INSERT INTO Practitioner
    VALUES(    
        10005,  'Dr',  'Ludo',  'V',  'Vergenargen',  '27',  'Pembleton Place',  'Redfern',  'NSW',  '2049',  '9383737627',  '8372727283',  '8484737626278884',  '84737626673',  '1986-05-15',  'male',  'Medical Practitioner (Doctor or GP)'
    );
INSERT INTO Practitioner
    VALUES(    
        10006,  'Dr',  'Anne',  'D',  'Funsworth',  '4/89',  'Pacific Highway',  'St Leonards',  'NSW',  '2984',  '8847362839',  '8372688949',  '8477666525173738',  '36271663788',  '1991-12-11',  'female',  'Psychologist'
    );
INSERT INTO Practitioner
    VALUES(    
        10007,  'Mrs',  'Leslie',  'V',  'Gray',  '98',  'Dandaraga Road',  'Mirrabooka',  'NSW',  '2264',  '4736728288',  '4837726789',  '4847473737277276',  '05958474636',  '1989-03-11',  'female',  'Podiatrist'
    );
INSERT INTO Practitioner
    VALUES(    
        10008,  'Dr',  'Adam',  'J',  'Moody',  '35',  'Mullabinga Way',  'Brightwaters',  'NSW',  '2264',  '8476635678',  '2736352536',  '7473636527771183',  '63635245256',  '1990-09-23',  'male',  'Medical practitioner (Doctor or GP)'
    );
INSERT INTO Practitioner
    VALUES(    
        10009,  'Mr',  'Leslie',  'Y',  'Gray',  '3',  'Dorwington Place',  'Enmore',  'NSW',  '2048',  '8473763678',  '4484837289',  '3827284716390987',  '38277121234',  '1991-04-11',  'male',  'nurse'
    );



-- WeekDaysData.csv
INSERT INTO WeekDays
    VALUES(
        'Friday'
    );

INSERT INTO WeekDays
    VALUES(
        'Monday'
    );

INSERT INTO WeekDays
    VALUES(
        'Thursday'
    );

INSERT INTO WeekDays
    VALUES(
        'Tuesday'
    );

INSERT INTO WeekDays
    VALUES(
        'Wednesday'
    );


-- TestTypeData.csv
INSERT INTO TestType
    VALUES(
        'CPEP',  'C Peptide',  'C-Peptide; CPEP'
    );
INSERT INTO TestType
    VALUES(
        'ECH',  'Echis Time',  'Ecarin time'
    );
INSERT INTO TestType
    VALUES(
        'ENT',  'Ear  Nose  Throat  Eye Swab',  'includes gram stain (except throat swab) and bacterial culture. Contact screening for Corynebacterium'
    );
INSERT INTO TestType
    VALUES(
        'HLYSN',  'ABO',  'Haemolysins (serum)'
    );
INSERT INTO TestType
    VALUES(
        'IMISC',  'Paraneoplastic',  'Paraneoplastic Pemphigus Antibodies [NOTE: Authorisation required from an Immunopathologist]'
    );
INSERT INTO TestType
    VALUES(
        'MOLINT',  'Deafness',  'Autosomal Recessive  Complete GJB2 Gene Sequencing Analysis Connexin 26; CX26; CXB2; Recessive Autosomal Deafness; Autosomal Deafness; Hereditary Deafness; GJB2; DFNB1; Nonsyndromic Neurosensory Deafness; Neurosensory Deafness Type'
    );
INSERT INTO TestType
    VALUES(
        'RAST',  'Radioallergosorbent Test',  'RAST; IgE RAST; Allergen Screen; Radioimmunosorbent Assay of Allergens; Allergen-Specific IgE; Aspergillus RAST  Specific IgE; Ig to specific allergens'
    );


	
-- AppointmentData.csv
INSERT INTO Appointment
    VALUES(
        10005,  '2019-09-17',  '08:15:00', 10000
    );
INSERT INTO Appointment
    VALUES(
        10006,  '2019-09-18',  '10:00:00', 10000
    );
INSERT INTO Appointment
    VALUES(
        10006,  '2019-09-18',  '10:15:00', 10000
    );
INSERT INTO Appointment
    VALUES(
        10006,  '2019-09-18',  '10:30:00', 10000
    );
INSERT INTO Appointment
    VALUES(
        10006,  '2019-09-18',  '10:45:00', 10000
    );
INSERT INTO Appointment
    VALUES(
        10006,  '2019-09-18',  '11:00:00', 10000
    );
INSERT INTO Appointment
    VALUES(
        10005,  '2019-09-17',  '09:00:00', 10002
    );
INSERT INTO Appointment
    VALUES(
        10000,  '2019-09-18',  '08:00:00', 10003
    );
INSERT INTO Appointment
    VALUES(
        10005,  '2019-09-17',  '08:30:00', 10005
    );
INSERT INTO Appointment
    VALUES(
        10000,  '2019-09-18',  '08:30:00', 10005
    );
INSERT INTO Appointment
    VALUES(
        10005,  '2019-09-17',  '14:15:00', 10006
    );
INSERT INTO Appointment
    VALUES(
        10008,  '2019-09-18',  '08:30:00', 10006
    );
INSERT INTO Appointment
    VALUES(
        10005,  '2019-09-17',  '08:00:00', 10008
    );
INSERT INTO Appointment
    VALUES(
        10002,  '2019-09-17',  '08:30:00', 10008
    );
INSERT INTO Appointment
    VALUES(
        10005,  '2019-09-18',  '08:00:00', 10008
    );
INSERT INTO Appointment
    VALUES(
        10005,  '2019-09-17',  '10:00:00', 10009
    );
INSERT INTO Appointment
    VALUES(
        10001,  '2019-09-17',  '08:00:00', 10010
    );
INSERT INTO Appointment
    VALUES(
        10005,  '2019-09-17',  '10:15:00', 10010
    );
INSERT INTO Appointment
    VALUES(
        10008,  '2019-09-18',  '08:00:00', 10010
    );
INSERT INTO Appointment
    VALUES(
        10006,  '2019-09-18',  '09:30:00', 10010
    );



-- AvailabilityData.csv
INSERT INTO AvailabilitY
    VALUES(
        10000,  'Friday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10000,  'Monday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10000,  'Wednesday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10001,  'Thursday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10001,  'Tuesday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10002,  'Thursday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10002,  'Tuesday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10003,  'Friday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10003,  'Monday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10003,  'Wednesday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10004,  'Friday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10004,  'Monday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10005,  'Thursday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10005,  'Tuesday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10006,  'Wednesday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10007,  'Thursday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10007,  'Tuesday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10008,  'Friday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10008,  'Monday'
    );
INSERT INTO AvailabilitY
    VALUES(    
        10008,  'Wednesday'
    );



-- PathTestReqsData.csv
INSERT INTO PathTestReqs
    VALUES(
        10005,  '2019-09-17',  '10:30:00',  10010,  'HLYSN'
    );
INSERT INTO PathTestReqs
    VALUES(    
        10005,  '2019-09-18',  '08:15:00',  10008,  'RAST'
    );
INSERT INTO PathTestReqs
    VALUES(    
        10006,  '2019-09-18',  '10:30:00',  10000,  'HLYSN'
    );
INSERT INTO PathTestReqs
    VALUES(    
        10008,  '2019-09-18',  '08:15:00',  10010,  'IMISC'
    );
