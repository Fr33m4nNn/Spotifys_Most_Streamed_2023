# Overview

Welcome to my analysis of the Spotify 2023 charts. This project was driven by my curiosity and a desire to apply SQL skills while exploring real-world music trends.

The data for this analysis is sourced from [Kaggle (Spotify 2023 Charts)](https://www.kaggle.com/datasets/nelgiriyewithana/top-spotify-songs-2023?resource=download), which provides detailed information on tracks, artists, streaming counts, and platform presence. Using SQL and dimensional modeling, I examine key questions such as which artists dominated the charts, how streaming trends evolved over the year, and what factors contribute to a song’s popularity.

# The Questions

# Tools I Used

For my exploration of the Spotify 2023 charts, I worked with structured data to uncover meaningful patterns and insights:
- **SQL:** Enabled efficient querying and data manipulation to analyze trends in music streaming.
- **PostgreSQL:** The selected database system, optimized for managing and analyzing the dataset.
- **DataGrip:** My preferred tool for managing databases and running SQL queries.
- **Git & GitHub:** Crucial for version control, sharing SQL scripts, analyzing data, and tracking project progress.

# The Analysis
Every query in this project was crafted to examine distinct trends in the Spotify 2023 charts. Here’s the approach I took for each analysis:

--------

### 1. Top Performing Tracks & Artists
```sql
SELECT
    track_name,
    artist_name,
    SUM(streams) AS total_streams
FROM
    spotify_charts_2023
WHERE
    streams IS NOT NULL
GROUP BY
    track_name, artist_name
ORDER BY
    total_streams DESC
LIMIT 10;

```
### 2. Which months had the most newly released songs that became popular?
```sql
SELECT
    released_month,
    COUNT(*) AS popular_new_releases
FROM
    spotify_charts_2023
WHERE
    released_year = 2023
GROUP BY
    released_month
ORDER BY
    popular_new_releases DESC;

```
### 3. Platform-Specific Trends (Which songs appeared in the most playlists across platforms?)
```sql
SELECT
    track_name,
    artist_name,
    (COALESCE(in_spotify_charts, 0) +
    COALESCE(in_apple_charts, 0) +
    COALESCE(in_deezer_charts, 0) +
    COALESCE(in_shazam_charts, 0)) AS charts_count
FROM spotify_charts_2023
ORDER BY charts_count DESC
LIMIT 10;

```
### 4. Streaming vs. Release Timing (Do older songs still perform well in 2023?)
```sql
SELECT
    released_year,
    SUM(streams) AS total_streams
FROM
    spotify_charts_2023
GROUP BY
    released_year
ORDER BY total_streams DESC;

```
### 5. What Makes a Viral Song? (Are higher-energy songs more likely to be charted?) (Is there a correlation between BPM and streaming success?)
```sql
SELECT
    energy_pct,
    SUM(streams) AS total_streams,
    SUM(COALESCE(in_spotify_charts, 0) +
        COALESCE(in_apple_charts, 0) +
        COALESCE(in_deezer_charts, 0) +
        COALESCE(in_shazam_charts, 0)) AS total_chart_appearances
FROM
    spotify_charts_2023
GROUP BY
    energy_pct
ORDER BY
    total_chart_appearances DESC;

```


# What I Learned ??

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights ??
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts ??

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.