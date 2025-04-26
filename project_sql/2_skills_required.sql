/*
QUESTION: What are the skills required for these top-paying roles?
- Make use of CTE as this is a complex table.
- I dentify the skills required for these roles using INNER JOIN.
*/

SELECT *
FROM job_postings_fact
LIMIT 50;

SELECT *
FROM skills_job_dim
LIMIT 20;

SELECT *
FROM skills_dim
LIMIT 20;



WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title_short,
        job_location,
        salary_year_avg,
        salary_rate,
        name AS company_name,
        link_google
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
    LIMIT 5  
)
SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC