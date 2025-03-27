/*
QUESTON: What are the top skills based on salary for my role?
- Average associate with each skill for Data Anaylst positio 
- Join the skills_job_dim ON job_postings_fact AND skills_dim ON skills_job_dim.
- Identify top salary for job_postings in Germany & Japan.
-  Identify the top 10 hghest salary linked with skills.
*/


SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst' AND 
    job_postings.salary_year_avg IS NOT NULL AND
    (job_postings.job_location = 'Germany' OR 
    job_postings.job_location = 'Japan')
GROUP BY 
    skills
ORDER BY 
    average_salary DESC
LIMIT 20;      