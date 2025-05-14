/*
Question: What are the top-paying data analyst jobs with thier skills and company?
- Identify the 5 top-paying data analyst jobs in both Germany and Japan.
- Identify salary_year_average where not NULL.
- Include name of companies
*/




WITH top_jobs AS (
    SELECT 
        job_id,
        company_dim.name AS company,
        job_location,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id    
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location IN ('Germany','Japan') AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
)
SELECT 
    top_jobs.*,
    skills_dim.skills
FROM
    top_jobs
INNER JOIN skills_job_dim AS skills_job ON top_jobs.job_id = skills_job.job_id
INNER JOIN skills_dim ON skills_job.skill_id = skills_dim.skill_id
LIMIT
    5

/*
WITH top_paying_jobs AS (
    SELECT 
        company_id,
        job_title_short,
        skills_dim.skills,
        job_location,
        salary_year_avg
    FROM job_postings_fact AS job_postings
    INNER JOIN skills_job_dim AS skills_job ON job_postings.job_id =  skills_job.job_id
    INNER JOIN skills_dim ON skills_job.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        (job_location = 'Germany' OR   
        job_location = 'Japan') AND
        salary_year_avg IS NOT NULL
    LIMIT 20
)
SELECT 
    top_paying_jobs.job_title_short,
    top_paying_jobs.skills,
    top_paying_jobs.job_location,
    company_dim.name AS company,
    top_paying_jobs.salary_year_avg
FROM 
    top_paying_jobs
LEFT JOIN company_dim ON top_paying_jobs.company_id = company_dim.company_id
ORDER BY 
    top_paying_jobs.salary_year_avg DESC
LIMIT
    5    
*/    