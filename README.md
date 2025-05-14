# Intoduction
### Explore the Data Job Market
This project focuses on 📊 Data Analyst roles, analyzing top-paying positions, 🔥identifying in-demand skills, and uncovering regions where high demand aligns with higher salaries in the field of data analytics.

🔍 SQL queries? Check them out here:[project_sql folder](/project_sql/)

# Background
This project was initiated with the objective of gaining a deeper understanding of the data analyst job market. It focuses on identifying top-paying positions and the most sought-after skills, with the goal of streamlining the job search process and supporting professionals in securing the most competitive opportunities.

I was previlaged to acquire data from [SQL course](https://lukebarousse.com/sql). It offers valuable insights on job_titles, salaries, locations, and vital skills.

### The questions i desired to answer throught my SQL queries were:

1. What are the top_paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are mopst in demand for Data analysts?
4. Which skills are associated with higher salaries?
5. what are the most optimal skills to learn?

# Tools I Used
To conduct an in-depth analysis of the data analyst job market, I utilized a range of tools;

- **SQL:** This is the backbone of my analysis, of which i carried out my queries on the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** This is where my database management and executing SQL queries.
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
For each query for this project, the aim was at finding out specific areas of the data analyst job market.
Here is how i approached each question:

### **1. Top Paying Data Analyst Jobs**

My aim was to identify the highest-paying data analyst roles, i filtered data analyst positions by average yearly salary and location,focusing on job in Germany and Japan. This query highlights the high paying opportunities in the field.

```sql
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
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potiential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering hihg salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](assets\Picture1.png)
*Chart representation of the average salary of top-paying jobs in Germany and Japan*


### **2. Skills for Top Paying Jobs**

To understand what skills are required for the top_paying jobs specifically in Germany & Japan, i joined the job postings with the skills data providing insights into what employers value for high-compensation roles.

```sql
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
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023

- **Excel** is leading with a bold count of 3.
- **SQL** followws closly with a bold count of 2.
- Other skills like Airtable, Looker, Power bi, Python, R, Spss, Tableau & Vba shows similar degrees of demand.

![Top Paying Skills](assets\Picture3.png)
*Bar chart representaion of the top paying Data Analyst skills in Germnay and Japan*

### **3. In-Demand Skills For Data Analyst**

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demnad.

```sql
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
```
- **SQL** and **Excel** remain fundamental, emphasizing the need fro strong foundational skills in data proccessing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power Bi** are essential, poimtinng towards the increasing importance of thechnical skills in data storytelling and decision support.

| Skills    | Demand Count |
|-----------|--------------|
|SQL        | 7291         |
|Excel      | 4611         |
|Python     | 4330         |
|Tableau    | 3745         |
|Power Bi   | 2609         |

*Table of the demand for the top 5 skils in data amalyst job postings*

### **4. Skills Based on Salary**

Explorings the avarage salaries assoiciated with different skills revealed with skills are the highest paying.

```sql
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
```

Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies


|Skills       | Average Salary ($)|
|-------------|------------------:|
|power Bi     |            111,175|
|vba          |            111,175|
|airtable     |            105,000|
|looker       |            105,000|
|r            |            105,000|
|spss         |            105,000|
|excel        |             99,838|
|sql          |             98,458|
|python       |             92,100|
|tableau      |             92,100|

*Table of the avarage salary for the top 10 skills for data analysts in Germmany & Japan.*

### **5. Most Optimal Skills to Learn**
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both high in demand and have high slaries, offering a strategic focus for skill development.

```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact AS job_postings
    INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings.job_title_short = 'Data Analyst' AND 
        job_postings.salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
), avg_salary AS (
SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst' AND 
    job_postings.salary_year_avg IS NOT NULL 
    AND (job_postings.job_location = 'Germany' OR 
    job_postings.job_location = 'Japan')
GROUP BY 
    skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT
    20
```

|Skill ID     | Skills         | Demand Count     | Avereage Salary ($)  |
|-------------|----------------|------------------|---------------------:|
| 183         | power bi       | 110              | 111,175              |
| 22          | vba            | 24               | 111,175              |
| 5           | r              | 148              | 105,000              |
| 185         | looker         | 49               | 105,000              |
| 199         | spss           | 24               | 105,000              |
| 181         | excel          | 256              |  99,838              |
| 0           | sql            | 398              |  98,458              |
| 1           | python         | 236              |  92,100              |
| 182         | tableau        | 230              |  92,100              |
| 76          | aws            | 32               |  79,200              |
| 215         | flow           | 28               |  79,200              |
| 97          | hadoop         | 22               |  79,200              |
| 78          | redshift       | 16               |  79,200              |
| 92          | spark          | 13               |  79,200              |

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023;
- **High-Demand programming Langueages:** SQL and Excel stands out for their high demand, with demand count of 398 and 256 respectively. Despicte their high demand, their average salary is around $98,458 for SQL and $99,838 for Excel, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Power Bi and AWS shows significant demand with relatively high  average slsaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligience nad Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $92,100 and $105,000, highlights the critical role of data visualization and business intelligence in deriving actionable insights of data.

### **6. Top Paying Jobs with skills and company**
Exploring companies and skills associated with top paying data analyst jobs in Germany and Japan.

```sql
WITH top_jobs AS (
    SELECT 
        job_id,
        job_title_short,
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
```

|Job ID    | Company     | Job Location      | Average Salary       | Skills    |
|----------|-------------|-------------------|----------------------|-----------|
| 68662    | Amazon      | Japan             | 111,175              | vba       |
| 774732   | Grover      | Germany           | 111,175              | excel     |
| 774732   | Grover      | Germany           | 111,175              | power bi  |
| 280141   | SquareTrade | Japan             | 111,175              | sql       |
| 280141   | SquareTrade | Japan             | 111,175              | excel     |

*Table of the top paying skills with company in GERMANY and JAPAN.*




# What I Learned

Throughout this adventure, i've turbocharged my SQL toolkit with some serious firepower:

- **Complex Query Crafting:** I was able to master the art of advanced SQL, merging tools like a pro and welding WITH clauses for ninja-level temporary table maneuvers.
- **Data Aggregation:** Got familiar with **GROUP BY** and turned aggregate functions like **COUNT()** and **AVG()** into my data-summerizing sidekicks.
- **Analytical Wizardry:** I leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries

# Conclusion
 
### Insights
From the analysis, several general iinsights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analyst between Germany and Japan that offers a wide range of salaries is Germany, with Germany at $179,500 and japan at $111,175!
2. **Skills for Top-Pying Jobs**: High-paying data analyst jobs  in Germnay and Japan require advanced proficiency in SQL, suggesting it is crucial skill for earning top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, suchs as Power Bi and VBA are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers  for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.


### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to priortizing skill development and job search efforts. Aspiring  data analyst can better position themselves in a competitive job market by focusing on high-demnd, high-salary skills. This exploration highlights the importance of continous learning and adapttion to emerging trends in the field of data analytics.
