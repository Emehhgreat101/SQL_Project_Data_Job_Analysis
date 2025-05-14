/*
Question: What are the top-paying data analyst jobs?
- Identify the 5 top-paying data analyst jobs in both Germany and Japan.
- Identify salary_year_average where not NULL.
- Include name of companies
*/

/*
SELECT *
FROM job_postings_fact
LIMIT 5

SELECT *
FROM company_dim
LIMIT 5
*/

SELECT 
    job_title_short,
    job_location,
    company_dim.name AS company,
    salary_year_avg
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id    
WHERE
    job_title_short = 'Data Analyst' AND 
    (job_location = 'Germany' OR 
    job_location = 'Japan') AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;