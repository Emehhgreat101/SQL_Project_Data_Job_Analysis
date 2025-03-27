/*
QUESTION: What are the most in-demand skills for my role?
- Join the skills_job dim and skills_dim to the job_postungs_fact, using INNER JOIN.
- Find the count of job postings pers skill
- Identify the top 5 most in-demand skills for Data Analyst
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst'
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC    
LIMIT 5;





