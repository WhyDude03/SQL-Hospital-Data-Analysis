DROP TABLE IF EXISTS hospital_data;

CREATE TABLE hospital_data (
    hospital_name VARCHAR(100),
    locations VARCHAR(100),
    department VARCHAR(100),
    doctors_count INTEGER,
    patients_count INTEGER,
    admission_date DATE,
    discharge_date DATE,
    medical_expenses NUMERIC
);
SELECT *FROM 
hospital_data
--path copy didn't work so used the import method(Permission Denied)

-- 1. Total Number of Patients( Write an SQL query to find the total number of patients across all hospitals)
SELECT hospital_name, SUM(patients_count) as total_sum
FROM hospital_data
group by hospital_name
ORDER BY total_sum DESC;
--if total number is needed
SELECT SUM(patients_count) as total_sum
FROM hospital_data;

--2. Average Number of Doctors per Hospital (Retrieve the average count of doctors available in each hospital.)
SELECT hospital_name, AVG(doctors_count)
FROM hospital_data
GROUP BY hospital_name;

-- 3. Top 3 Departments with the Highest Number of Patients (Find the top 3 hospital departments that have the highest number of patients).

SELECT department, SUM(patients_count) as total_patients
FROM hospital_data
group by department
ORDER BY total_patients DESC LIMIT 3;

--4. Hospital with the Maximum Medical Expenses (Identify the hospital that recorded the highest medical expenses.)
SELECT hospital_name, SUM(medical_expenses) as total_expense
	FROM hospital_data
	group by hospital_name
	ORDER BY total_expense DESC LIMIT 3;
	
--5. Daily Average Medical Expenses (Calculate the average medical expenses per day for each hospital.)

SELECT 
    hospital_name, AVG(medical_expenses / (discharge_date - admission_date) + 1) AS avg_daily_expenses
FROM hospital_data
GROUP BY hospital_name
ORDER BY avg_daily_expenses DESC;

--6. Longest Hospital Stay Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.

SELECT 
    hospital_name,department, ((discharge_date - admission_date) + 1) AS avg_daily_expenses
FROM hospital_data
ORDER BY avg_daily_expenses DESC limit 1;

--7. Total Patients Treated Per City Count the total number of patients treated in each city.
SELECT hospital_name,locations AS city, SUM(patients_count) as total_patients
	FROM hospital_data
	group by city ,hospital_name
	ORDER BY total_patients DESC;
(--added hospital name as extra to practice)


--8. Average Length of Stay Per Department  Calculate the average number of days patients spend in each department.

SELECT department, AVG((discharge_date - admission_date) + 1) AS avg_stay
FROM hospital_data
GROUP BY department;

--9. Identify the Department with the Lowest Number of Patients (Find the department with the least number of patients.)
SELECT department, SUM(patients_count) as total_patients
FROM hospital_data
group by department
ORDER BY total_patients ASC;

--10. Monthly Medical Expenses Report (Group the data by month and calculate the total medical expenses for each month.)

 SELECT 
    SUM(medical_expenses),
    EXTRACT(MONTH FROM admission_date) AS month_name
FROM hospital_data
GROUP BY month_name;