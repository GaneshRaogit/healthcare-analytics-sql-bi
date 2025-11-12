# Patient Journey & Financials — Healthcare Analytics (SQL + BI)

A production‑style analytics project that standardizes hospital encounter data in SQL and delivers three decision‑ready dashboards: Demographics & Conditions, Patient Journey, and Financials (Doctors, Hospitals, Insurers).​

## 📌 Table of contents

- [Overview](#overview)
- [Business problem](#Business-problem)
- [Dataset](#Dataset)
- [Tech stack](#Tech-stack)
- [Project structure](#Project-structure)
- [Data preparation](#data-preparation)
- [Data modeling](#Data-modeling)
- [Dashboards delivered](#Dashboards-delivered)
- [KPI-definitions](#KPI-definitions)
- [How to run Project](#How-to-run-Project)
- [Findings snapshot](#Findings-snapshot)
- [Limitations](#Limitations)
- [Author.​](#Author.)

## Overview
This repository turns raw hospital data into a governed semantic layer and executive‑ready visuals that answer who the patients are, how care flows from admission to discharge, and where spend concentrates across providers and payers, following common healthcare dashboard practices for leadership reviews.​

## Business problem
- **Visibility**: Leadership needs a unified, trustworthy view of patient cohorts and seasonality to plan staffing and beds, which fragmented exports currently hinder.​
- **Throughput**: Operations requires a standardized LOS and admissions trend to identify bottlenecks and manage bed‑day utilization across conditions and facilities.​
- **Financials**: Finance must see concentration of billed amounts by doctor, hospital, condition, and insurer to focus contracting and documentation rigor efficiently.​

## Dataset
- **Core fields**: patient_id, name, gender, blood_type, medical_condition, doctor, hospital, insurance_provider, admission_type, billing_amount, room_number, medication, test_results, age, date_of_admission, discharge_date, which map directly to the modeled views and BI entities for slicing and KPI computation.​

## Tech stack
- **SQL (MySQL)** :- for canonicalization, feature engineering, and semantic views, aligned with standard analytics layering for repeatable KPIs.​
- **Power BI** :- for interactive dashboards and drill‑downs with reusable measures and on‑canvas definitions to preserve trust in metrics.​

 ````
## Project structure
Project Structure (suggested)
/
├─ sql/
│ ├─ 01_healthcare_data.sql
│ ├─ 02_length_of_stay.sql
│ ├─ 03_age_band.sql
│ ├─ 04_bills.sql
│ └─ 05_category_and_healthcare_v.sql
├─ bi/
│ ├─ demographics_overview.png
│ ├─ patient_journey_overview.png
│ └─ financials_doctors_hospitals.png
└─ docs/
└─ kpi_definitions.md
````
## Data preparation
- **Text normalization**: TRIM/LOWER across name, provider, and hospital dimensions prevents grouping fragmentation in BI and ensures stable joins over time.​
- **Date parsing**: STR_TO_DATE on admission/discharge enables deterministic LOS and seasonality analyses; invalid or missing dates are handled upstream to avoid runtime errors.​
- **Typing**: billing_amount and room_number cast to numerics, and long text fields cast to bounded CHAR for predictable query plans and report rendering.​

## Data modeling
- **healthcare_data**: Canonicalized base view with typed columns and normalized categories as the single source of truth for downstream modeling in BI.​
- **length_of_stay**: LOS = DATEDIFF(discharge_date, date_of_admission) in days, the throughput backbone for operations monitoring and cost normalization.​
- **age_band**: Cohorts — child (1–12), younger (13–25), adult (26–55), senior_citizens (56+) — to enable stratified insights and equitable reviews.​
- **bills**: cost_per_stay = billing_amount; cost_per_day = billing_amount / LOS, with BI guardrails recommended for LOS=0 cases to avoid misleading ratios in cards.​
- **category**: amount_category (low/medium/high/extreme) and stay_category (short/medium/long) to drive Pareto charts and segmentation without complex measures.​
- **healthcare_v**: Unified semantic view joining demographics, clinical, finance, LOS, and categories for clean report modeling and cross‑filtering in dashboards.​

## Dashboards delivered
- **Demographics & Conditions**: Gender split, blood type distribution, age bands, monthly patient volumes, and top medical conditions to profile population health and seasonality.​
- **Patient Journey**: Cards for total admissions, average LOS, total amount, number of hospitals/insurers, plus multi‑year admissions trend for throughput and demand cycles.
- **Financials** — Doctors & Hospitals: Top doctors and hospitals by billed amount, insurer mix by count and amount, and spend by condition to reveal margin levers quickly.​

## KPI definitions
- **Average LOS**: Mean of LOS in days over the filtered cohort/time window; display alongside distributions where possible to avoid masking variation in tails.​
- **Cost per stay/day**: billing_amount per encounter and billing_amount ÷ LOS for normalization; label or exclude LOS=0 encounters in cards to maintain interpretability.​

## How to run Project
- **SQL**: Execute scripts in /sql in numeric order to materialize all views and the final semantic layer healthcare_v; validate date parsing and numeric casts in staging before BI connect.​

- **BI**: Connect to healthcare_v, build measures for admissions, ALOS, totals, cost per day/stay, and reproduce delivered visuals; include KPI definitions in tooltips/on‑canvas notes for governance.​

## Findings snapshot
Adults and senior citizens dominate encounter volumes; mild but repeatable monthly seasonality informs roster and bed planning cycles in operations reviews.​
Average LOS at 16 days indicates high bed‑day consumption; pairing LOS with condition and provider segments highlights candidates for pathway standardization.​
Billed amounts are concentrated among a few doctors, hospitals, and five insurers; these segments are immediate levers for finance and contracting focus.​
Limitations
Same‑day discharges (LOS=0) can inflate cost per day; apply clear guardrails in cards and document treatment in docs to preserve metric trust during reviews.​
Billing captured at encounter level without reimbursement/line‑item detail; analyses focus on billed totals and normalized cost ratios rather than net collections.​

## Author & Contact

**[Your Name]**  
*Data Analyst & Business Intelligence Specialist*

🎯 **Specialized in**: Retail Analytics, Customer Behavior Analysis, Statistical Modeling  
📊 **Experience**: Advanced EDA, Python Programming, Business Intelligence  
🎓 **Focus Areas**: Data Analytics, SQL, Machine Learning, Statistical Analysis

### Connect with me:
📧 **Email**: [jganeshrao5@gmail.com](mailto:jganeshrao5@gmail.com)  
🔗 **LinkedIn**: [linkedin.com/in/j-ganesh-rao-055ba2279](https://linkedin.com/in/j-ganesh-rao-055ba2279)  
🐙 **GitHub**: [https://github.com/GaneshRaogit](https://github.com/GaneshRaogit)  

---
*This project demonstrates advanced analytical skills, attention to data quality, and ability to derive actionable business insights from complex datasets. The comprehensive approach showcases proficiency in data science methodologies and business acumen essential for data analyst roles.*
