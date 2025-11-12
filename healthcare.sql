create database healthcare;

-- load data from the python by creating engine

-- data exploration analysis

SELECT 
    COUNT(*) AS total_records
FROM
    healthcare_dataset;


CREATE OR REPLACE VIEW healthcare_data AS
    SELECT 
        TRIM(LOWER(Patient_id)) AS patient_id,
        TRIM(LOWER(Name)) AS name,
        TRIM(LOWER(Gender)) AS gender,
        TRIM(LOWER(`Blood Type`)) AS blood_type,
        TRIM(LOWER(`Medical Condition`)) AS medical_condition,
        TRIM(LOWER(Doctor)) AS doctor,
        TRIM(LOWER(Hospital)) AS hospital,
        TRIM(LOWER(`Insurance Provider`)) AS insurance_provider,
        TRIM(LOWER(`Admission Type`)) AS admission_type,
        CAST(`Billing Amount` AS DECIMAL) AS billing_amount,
        CAST(`Room Number` AS DECIMAL) AS room_number,
        STR_TO_DATE(`Discharge Date`, '%d-%m-%Y') AS discharge_date,
        CAST(Medication AS CHAR (120)) AS medication,
        CAST(`Test Results` AS CHAR (100)) AS test_results,
        CAST(Age AS DECIMAL) AS age,
        STR_TO_DATE(`Date of Admission`, '%d-%m-%Y') AS date_of_admission
    FROM
        healthcare_dataset;

-- analysis of dataset

CREATE OR REPLACE VIEW length_of_stay AS
    SELECT 
        patient_id,
        DATEDIFF(discharge_date, date_of_admission) AS L_of_stay
    FROM
        healthcare_data;

 select count(L_of_stay) from length_of_stay;
 
CREATE OR REPLACE VIEW age_band AS
    SELECT 
        CASE
            WHEN age BETWEEN 1 AND 12 THEN 'child'
            WHEN age BETWEEN 13 AND 25 THEN 'younger'
            WHEN age BETWEEN 26 AND 55 THEN 'adult'
            ELSE 'senior_citizens'
        END AS age_band
    FROM
        healthcare_data;
 select count(age_band) from age_band;

CREATE OR REPLACE VIEW bills AS
    SELECT DISTINCT
        h.patient_id,
        h.billing_amount AS cost_per_stay,
        CAST((billing_amount / L_of_stay) AS DECIMAL (10 , 0 )) AS cost_per_day
    FROM
        healthcare_data h
            JOIN
        length_of_stay l ON h.patient_id = l.patient_id;
 select count(cost_per_stay) from bills;

CREATE OR REPLACE VIEW category AS
    SELECT 
        h.patient_id,
        CASE
            WHEN h.billing_amount BETWEEN 0 AND 5000 THEN 'low_cost'
            WHEN h.billing_amount BETWEEN 5000 AND 15000 THEN 'medium_cost'
            WHEN h.billing_amount BETWEEN 15000 AND 35000 THEN 'high_cost'
            ELSE 'extreme_cost'
        END AS amount_category,
        CASE
            WHEN l.L_of_stay BETWEEN 0 AND 5 THEN 'short_stay'
            WHEN l.L_of_stay BETWEEN 5 AND 10 THEN 'medium_stay'
            ELSE 'long_stay'
        END AS stay_category
    FROM
        healthcare_data h
            JOIN
        length_of_stay l ON h.patient_id = l.patient_id;
     
CREATE OR REPLACE VIEW healthcare_v AS
    SELECT 
        h.patient_id,
        h.name,
        h.gender,
        h.blood_type,
        h.medical_condition,
        h.doctor,
        h.hospital,
        h.insurance_provider,
        h.admission_type,
        h.billing_amount,
        h.room_number,
        h.medication,
        h.test_results,
        h.age,
        h.date_of_admission,
        a.age_band,
        h.discharge_date,
        cost_per_day,
        cost_per_stay,
        amount_category,
        stay_category,
        L_of_stay
    FROM
        healthcare_data h
            JOIN
        age_band a ON h.patient_id = a.patient_id
            JOIN
        bills b ON h.patient_id = b.patient_id
            JOIN
        category c ON h.patient_id = c.patient_id
            JOIN
        length_of_stay l ON h.patient_id = l.patient_id;