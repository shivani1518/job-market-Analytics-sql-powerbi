-- =====================================
-- JOB MARKET ANALYTICS PROJECT
-- =====================================
USE job_market_analytics;
-- =====================================
-- DATA EXPLORATION
-- =====================================
SELECT * FROM companies;
SELECT *FROM jobs;
SELECT * FROM candidates;
SELECT * FROM applications;
-- =====================================
-- AGGREGATE FUNCTIONS & ANALYSIS
-- =====================================
SELECT
    role_name,
    salary
FROM jobs
ORDER BY salary DESC
LIMIT 5;
SELECT
    j.role_name,
    COUNT(a.application_id) AS applications
FROM jobs j
JOIN applications a
ON j.job_id = a.job_id
GROUP BY j.role_name
ORDER BY applications DESC;
SELECT
    candidate_id,
    COUNT(job_id) AS applications
FROM applications
GROUP BY candidate_id
HAVING COUNT(job_id) > 1;
SELECT DISTINCT salary
FROM jobs
ORDER BY salary DESC
LIMIT 1,1;
DESC jobs;
SELECT
    city,
    MAX(salary) AS highest_salary
FROM jobs
GROUP BY city
ORDER BY highest_salary DESC;
SELECT
    city,
    AVG(salary) AS avg_salary
FROM jobs
GROUP BY city;
SELECT
    city,
    COUNT(*) AS total_jobs
FROM jobs
GROUP BY city;
SELECT
    c.company_name,
    j.role_name,
    j.city,
    j.salary
FROM companies c
JOIN jobs j
ON c.company_id = j.company_id;
SELECT
    role_name,
    city,
    salary
FROM jobs
ORDER BY salary DESC
LIMIT 1;
-- =====================================
-- WINDOW FUNCTIONS
-- =====================================
SELECT
    role_name,
    city,
    salary,
    RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM jobs;
SELECT
    role_name,
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS rank_no
FROM jobs;
-- =====================================
-- VIEW CREATION
-- =====================================
CREATE OR REPLACE VIEW company_jobs AS
SELECT
    c.company_name,
    j.role_name,
    j.city,
    j.salary
FROM companies c
JOIN jobs j
ON c.company_id = j.company_id;
SELECT * FROM company_jobs;
SELECT
    c.company_name,
    j.role_name,
    j.salary
FROM companies c
JOIN jobs j
ON c.company_id = j.company_id
ORDER BY j.salary DESC
LIMIT 1;
SELECT
    c.candidate_name,
    COUNT(a.job_id) AS applications
FROM candidates c
JOIN applications a
ON c.candidate_id = a.candidate_id
GROUP BY c.candidate_name
ORDER BY applications DESC
LIMIT 1;
SELECT
    j.role_name,
    COUNT(a.application_id) AS applications
FROM jobs j
LEFT JOIN applications a
ON j.job_id = a.job_id
GROUP BY j.role_name
ORDER BY applications DESC;
-- PROJECT INSIGHTS

-- Highest Paying Job
SELECT role_name, city, salary
FROM jobs
ORDER BY salary DESC
LIMIT 1;

-- Most Applied Job
SELECT
    j.role_name,
    COUNT(a.application_id) AS applications
FROM jobs j
LEFT JOIN applications a
ON j.job_id = a.job_id
GROUP BY j.role_name
ORDER BY applications DESC
LIMIT 1;
-- Company Offering Highest Salary
SELECT
    c.company_name,
    j.role_name,
    j.salary
FROM companies c
JOIN jobs j
ON c.company_id = j.company_id
ORDER BY j.salary DESC
LIMIT 1;
-- Candidate With Most Applications
SELECT
    c.candidate_name,
    COUNT(a.job_id) AS applications
FROM candidates c
JOIN applications a
ON c.candidate_id = a.candidate_id
GROUP BY c.candidate_name
ORDER BY applications DESC
LIMIT 1;

-- Average Salary By City
SELECT
    city,
    AVG(salary) AS avg_salary
FROM jobs
GROUP BY city;

-- Jobs By City
SELECT
    city,
    COUNT(*) AS total_jobs
FROM jobs
GROUP BY city;
-- Jobs Paying Above Average Salary

SELECT
    role_name,
    city,
    salary
FROM jobs
WHERE salary >
(
    SELECT AVG(salary)
    FROM jobs
);


