/*
Question: What are the top-paying data analyst jobs?
- Identify the 5 top-paying data analyst jobs in both Germany and Japan.
- Identify salary_year_average where not NULL.
- Include name of companies
*/

SELECT
    job_title_short,
    job_location,
    job_schedule_type,
    job_work_from_home,
    job_posted_date::DATE,
    job_no_degree_mention,
    salary_year_avg,
    name AS company_name
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
LIMIT 5;   