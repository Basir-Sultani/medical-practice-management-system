-- BASIR SULTANI Structured Query Language (SQL) query to provide the information requested 14/06/22

-- 1.	List the first name and last name of female patients who live in St Kilda or Lidcombe.
SELECT 
	FirstName,
	LastName 
FROM Patient
WHERE Gender = 'female'
AND Suburb = 'Lidcombe' 
OR Suburb = 'St Kilda';

-- 2.	List the first name, last name, state and Medicare Number of any patients who do not live in NSW.
SELECT 
	FirstName,
	LastName,
	State,
	MedicareNumber
FROM Patient
WHERE State != 'NSW';

-- 3.	For patients who have had pathology test requests, list the practitioner's and patient's first and last names, 
-- the date and time that the pathology tests were ordered and the name of the pathology test.

SELECT Patient.FirstName AS Patient_FirstName,
	   Patient.LastName AS Patient_LastName,
	   Practitioner.FirstName AS prc_FirstName,
	   Practitioner.LastName AS prc_LastName,
	   TestType.TestName AS TestName,
	   DateOrdered,
	   TimeOrdered
FROM Patient,
	 Practitioner,
	 PathTestReqs,
	 TestType
WHERE PathTestReqs.Patient_Ref = Patient.Patient_ID
AND PathTestReqs.Practitioner_Ref = Practitioner.Practitioner_ID
AND PathTestReqs.Test_Ref = TestType.Test_Code;
	
SELECT * FROM TestType;
select * from PathTestReqs;

-- 4.	List the Patient's first name, last name and the appointment date and time, 
-- for all appointments held on the 18/09/2019 by Dr Anne Funsworth.
SELECT Patient.FirstName,
	   Patient.LastName,
	   Appointment.AppDate,
	   Appointment.AppStartTime,
	   Appointment.Practitioner_Ref
FROM Patient
INNER JOIN Appointment ON Patient.Patient_ID = Appointment.Patient_Ref
WHERE Appointment.AppDate = '2019-09-18'
AND Appointment.Practitioner_Ref = 
	(SELECT Practitioner_ID   
	FROM Practitioner
	WHERE Practitioner.Title = 'Dr'
	AND	  Practitioner.FirstName = 'Anne'
	AND   Practitioner.LastName = 'Funsworth');

-- 5.	List each Patient's first name, last name, Medicare Number and their date of birth. 
-- Sort the list by date of birth, listing the youngest patients first.
SELECT FirstName,
	   LastName,
	   MedicareNumber,
	   DateOfBirth
FROM Patient
ORDER BY DateOfBirth DESC;


--6. For each pathology test request, list the test code, the test name the date and time that the test was ordered. 
-- Sort the results by the date the test was ordered and then by the time that it was ordered.

SELECT PathTestReqs.Test_Ref,
	   TestType.TestName,
	   PathTestReqs.DateOrdered,
	   PathTestReqs.TimeOrdered
FROM TestType
JOIN PathTestReqs ON PathTestReqs.Test_Ref = TestType.Test_Code
ORDER BY PathTestReqs.DateOrdered, PathTestReqs.TimeOrdered;

-- 7. List the ID and date of birth of any patient who has not had an appointment and was born before 1950.

SELECT Patient.Patient_ID,
	   Patient.DateOfBirth
FROM Patient
WHERE DateOfBirth < DATENAME(YEAR, '1950')
AND Patient_ID NOT IN (SELECT Patient_Ref
						FROM Appointment);

SELECT * FROM Patient;

-- 8.List the patient ID, last name and date of birth of all male patients born between 1962 and 1973 (inclusive).
SELECT	Patient_ID,
		LastName,
		DateOfBirth
FROM Patient
WHERE  Gender = 'male'
AND DateOfBirth 
BETWEEN DATENAME(YEAR, '1962') AND DATENAME(YEAR, '1973');

SELECT Patient_ID, DateOfBirth, Gender FROM Patient;

-- 9.	List the patient ID, first name and last name of any male patients who have had appointments
-- with either Dr Huston or Dr Vergenargen.

SELECT	Patient_ID,
		FirstName,
		LastName
FROM Patient
WHERE  Gender = 'male'
AND Patient_ID
IN (
	SELECT A.Patient_Ref 
	FROM Appointment AS A
	WHERE A.Practitioner_Ref 
	IN (
		SELECT PR.Practitioner_ID
		FROM Practitioner AS PR
		WHERE PR.Title = 'Dr'
		AND ( PR.LastName = 'Huston'
			OR PR.LastName = 'Vergenargen'
			)
		)
	);


SELECT * FROM Appointment;
SELECT * FROM Patient;

SELECT Patient_ID, DateOfBirth, Gender FROM Patient;


--10. List the practitioner ID, first name, last name and practitioner type of each practitioner, 
-- and the number of days of the week that they're available.
SELECT  PRC.Practitioner_ID, 
		PRC.FirstName,
		PRC.LastName,
		PRC.PractitionerType_Ref AS PractitionerType,
		COUNT(AV.Practitioner_Ref) AS NoOfDaysAvailable
FROM Practitioner AS PRC,
	 AvailabilitY AS AV
WHERE PRC.Practitioner_ID = AV.Practitioner_Ref
GROUP BY PRC.Practitioner_ID, 
		 PRC.FirstName,
		 PRC.LastName,
		 PRC.PractitionerType_Ref;


--11.List the patient ID, first name, last name and the number of appointments
 -- for patients who have had at least three appointments.
 SELECT P.Patient_ID,
		P.FirstName,
		P.LastName,
		COUNT(AP.Patient_Ref) AS NoOfAppointments
 FROM	Patient AS P,
		Appointment AS AP
 WHERE	P.Patient_ID = AP.Patient_Ref
 GROUP BY	P.Patient_ID,
			P.FirstName,
			P.LastName
 HAVING	COUNT(AP.Patient_Ref) >= 3;
		



--12.List the first name, last name, gender, and the number of days since 
-- the last appointment of each patient and the 23/09/2019.
 SELECT P.FirstName,
		P.LastName,
		P.Gender,
		A.NoOfDays
 FROM	Patient AS P
 INNER JOIN (SELECT Patient_Ref,
			MAX(DATEDIFF(DAY,AppDate, '2019-09-23')) AS NoOfDays
			FROM Appointment 
			GROUP BY Patient_Ref) AS A			
 ON A.Patient_Ref = P.Patient_ID;


 --13.For each practitioner, list their ID, first name, last name and 
 -- the total number of hours worked each week at the Medical Practice. 
 -- Assume a nine-hour working day and that practitioners work the full nine hours on each day that they're available.

SELECT PR.Practitioner_ID,
		PR.FirstName, 
		PR.LastName,
		(COUNT(AV.Practitioner_Ref)) * 9 AS HoursWorked
FROM Practitioner AS PR,
	AvailabilitY AS AV
WHERE PR.Practitioner_ID = AV.Practitioner_Ref
GROUP BY PR.Practitioner_ID,
		PR.FirstName, 
		PR.LastName;


-- 14.List the full name and full address of each practitioner in the following format exactly.
-- Dr Mark P. Huston. 21 Fuller Street SUNSHINE, NSW 2343
-- Make sure you include the punctuation and the suburb in upper case.

SELECT CONCAT(PR.Title,' ', 
				PR.FirstName, ' ',
				PR.MiddleInitial, '. ',
				PR.LastName+ '. ',
				PR.HouseUnitLotNum, ' ',
				PR.Street, ' ',
				UPPER(PR.Suburb), ', ',
				PR.State, ' ',
				PR.PostCode
			) AS PractitionerDetails 
FROM Practitioner AS PR;

--OR

SELECT PR.Title+ ' '+ PR.MiddleInitial+ '. '+ PR.LastName+ '. '+
		PR.HouseUnitLotNum+ ' '+ PR.Street+ ' '+ upper(PR.Suburb)+
		', '+ PR.State+ ' '+ PR.PostCode
FROM Practitioner AS PR;

-- 15.List the date of birth of the male practitioner named Leslie Gray in the following format exactly:
--	Saturday, 11 March 1989
SELECT PR.FirstName,
		PR.LastName,
		FORMAT(PR.DateOfBirth, 'dddd, dd MMMM yyyy') AS DateOfBirth
FROM Practitioner AS PR
WHERE PR.Gender = 'male'
AND PR.FirstName = 'Leslie'
AND PR.LastName = 'Gray';


-- 16. List the patient id, first name, last name and date of birth of the fifth oldest patient(s).

SELECT TOP 1 
		PR.Practitioner_ID,
		PR.FirstName,
		PR.LastName,
		PR.DateOfBirth
FROM Practitioner AS PR
WHERE PR.Practitioner_ID =
	(
		SELECT TOP 1 P.Practitioner_ID 
		FROM 
			(
				SELECT TOP 5 Prac.DateOfBirth,
						Prac.Practitioner_ID 
				FROM Practitioner AS Prac
				ORDER BY DateOfBirth
			) P 
		ORDER BY P.DateOfBirth DESC
	);

--17. List the patient ID, first name, last name, appointment date 
-- (in the format 'Tuesday 17 September, 2019') and appointment time (in the format '14:15 PM') 
-- for all patients who have had appointments on any Tuesday after 10:00 AM.

SELECT  P.Patient_ID, 
		P.FirstName,
		P.LastName,
		FORMAT(A.AppDate, 'dddd dd MMMM, yyyy') AS AppDate,
		FORMAT(CONVERT(DATETIME, A.AppStartTime), 'hh:mm tt') AS AppStartTime
		--CONVERT(VARCHAR, A.AppStartTime, 0) AS AppTime
FROM Patient AS P,
	 Appointment AS A
WHERE A.Patient_Ref = P.Patient_ID
AND FORMAT(A.AppDate, 'dddd') = 'Tuesday'
AND FORMAT(CONVERT(DATETIME, A.AppStartTime), 'hh:mm tt') > CONVERT(DATETIME, '10:00 AM');


-- 18.	Calculate and list the number of hours and minutes between Joan Wothers' 8:00 AM appointment 
-- on 17/09/2019 and Terrence Hill's 2:15 PM appointment on that same day with Dr Ludo Vergenargen. 
-- Format the result in the following format: 5 hrs 35 mins 

-- DECLARE A VARIABLE AND ASSIGN THE TIME DIFFERENCE BETWEEN TWO PATIENTS 

DECLARE @TimeDifference AS INTEGER = 
	DATEDIFF(MINUTE, 
					(   SELECT A.AppStartTime
						FROM Appointment AS A,
							 Patient AS P,
							 Practitioner AS PR
						WHERE A.Patient_Ref = P.Patient_ID
						AND A.Practitioner_Ref = PR.Practitioner_ID
						AND P.FirstName = 'Joan'
						AND P.LastName = 'Wothers'
						AND PR.Title = 'Dr'
						AND PR.FirstName = 'Ludo'
						AND PR.LastName = 'Vergenargen'
						AND A.AppDate = '2019-09-17'
						AND CONVERT(TIME, A.AppStartTime) = CONVERT(TIME, '08:00')
					),
					(
						SELECT A.AppStartTime
						FROM Appointment AS A,
							 Patient AS P,
							 Practitioner AS PR
						WHERE A.Patient_Ref = P.Patient_ID
						AND A.Practitioner_Ref = PR.Practitioner_ID
						AND P.FirstName = 'Terrence'
						AND P.LastName = 'hILL'
						AND PR.Title = 'Dr'
						AND PR.FirstName = 'Ludo'
						AND PR.LastName = 'Vergenargen'
						AND A.AppDate = '2019-09-17'
						AND CONVERT(TIME, A.AppStartTime) = CONVERT(TIME, '14:15')
					)
	);


SELECT CONCAT(
	 FLOOR(@TimeDifference / 60),
	 ' hrs ',
	 FLOOR(@TimeDifference % 60),
	 ' mins'
	) AS DifferenceBtwAppointments;


-- 19. List the age difference in years between the youngest patient and the oldest patient in the following format:
-- The age difference between our oldest and our youngest patient is 76 years.
SELECT  CONCAT(
			'The age difference between our oldest and our youngest patient is ',
			DATEDIFF(YEAR, MIN(DateOfBirth), MAX(DateOfBirth)),
			' years.'
	    ) AS AgeDifference
FROM Patient;





