# Overview

Welcome to my analysis of the most streamed Spotify songs 2023. This project was driven by my curiosity and a desire to apply SQL skills while exploring real-world music trends.

The data for this analysis is sourced from [Kaggle (Most Streamed Spotify Songs 2023)](https://www.kaggle.com/datasets/nelgiriyewithana/top-spotify-songs-2023?resource=download), which provides detailed information on tracks, artists, streaming counts, and platform presence. Using SQL and dimensional modeling, I examine key questions such as which artists dominated the charts, how streaming trends evolved over the year, and what factors contribute to a song’s popularity.

# The Questions
1. Top Performing Tracks & Artists
2. Which months had the most newly released songs that became popular?
3. Platform-Specific Trends (Which songs appeared in the most playlists across platforms?)
4. Streaming vs. Release Timing (Do older songs still perform well in 2023?)
5. What Makes a Viral Song? (Are higher-energy songs more likely to be charted?) (Is there a correlation between BPM and streaming success?)

# Tools I Used

For my exploration of the Spotify 2023 charts, I worked with structured data to uncover meaningful patterns and insights:
- **SQL:** Enabled efficient querying and data manipulation to analyze trends in music streaming.
- **PostgreSQL:** The selected database system, optimized for managing and analyzing the dataset.
- **DataGrip:** My preferred tool for managing databases and running SQL queries.
- **Git & GitHub:** Crucial for version control, sharing SQL scripts, analyzing data, and tracking project progress.

---

# The Analysis
Every query in this project was crafted to examine distinct trends in the Spotify 2023 charts. Here’s the approach I took for each analysis:

### 1. Top Performing Tracks & Artists
To identify the top-performing tracks, I aggregated all streaming data. 
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
### Visualize Data
![Top songs](images/1_1_top_10_streamed_songs.png)
*Bar graph visualizing the Top 10 most streamed songs on Spotify (2023); ChatGPT generated this graph from my SQL query results*

### Insights:
- "Blinding Lights" by The Weeknd dominates with over 37 billion streams.
- Multiple collaborations feature in the top 10, showcasing the impact of joint artist efforts.
- Songs from various years remain popular, proving longevity in streaming success.

For artists, I first separated them in cases where multiple were listed and then combined the data to get a comprehensive view.
```sql
CREATE TABLE artist_song_mapping AS
SELECT
    track_name,
    streams,
    unnest(string_to_array(artist_name, ', ')) AS artist
FROM spotify_charts_2023;

SELECT
    artist,
    SUM(streams) AS total_streams
FROM artist_song_mapping
WHERE
    streams IS NOT NULL
GROUP BY artist
ORDER BY total_streams DESC
LIMIT 10;
```
### Visualize Data
![Top Artists](images/1_2_top_10_streamed_artists.png)
*Bar graph visualizing the Top 10 most streamed artists on spotify (2023); ChatGPT generated this graph from my SQL query results*

### Insights:
- The Weeknd and Bad Bunny lead as the most-streamed artists, surpassing 20 billion streams each.
- Taylor Swift and Dua Lipa stand out as the most streamed female artists.
- A mix of pop, hip-hop, and Latin music influences reflects diverse global listening trends.

### 2. Which months had the most newly released songs that became popular?
To determine which months had the most newly released songs that became popular, I counted the number of tracks released in 2023 that appeared in the charts and grouped them by month.
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
### Visualize Data
![Best Months](images/2_popular_new_releases_by_month.png)
*Bar graph visualizing the Most Popular New Releases By Month (2023) ; ChatGPT generated this graph from my SQL query results*

### Insights:
- March had the highest number of popular new releases with 37 songs making an impact.
- June and May followed closely, with 32 and 29 popular releases respectively.
- July had the lowest count, indicating fewer successful new songs in that month.

### 3. Platform-Specific Trends (Which songs appeared in the most playlists across platforms?)
To identify the songs that appeared in the most charts across platforms, I summed their presence in Spotify, Apple, Deezer, and Shazam charts and ranked them accordingly.
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
### Visualize Data
![Most Peforming Tacks](images/3_platform_specific_trends.png)
*Bar graph visualizing the Top Songs Appearing in the Most Playlists Across Platforms; ChatGPT generated this graph from my SQL query results*

### Insights:

- "Makeba" by Jain topped the list with 1,674 playlist appearances.
- David Kushner’s "Daylight" and Billie Eilish’s "What Was I Made For?" were also highly featured, appearing in over 1,500 playlists.
- A mix of pop, rap, and alternative tracks dominated the charts, with collaborations like The Weeknd, Madonna & Playboi Carti’s "Popular" also making a strong impact.

### 4. Streaming vs. Release Timing (Do older songs still perform well in 2023?)
o analyze whether older songs still performed well in 2023, I calculated the total streams for each release year and ranked them accordingly.
```sql
SELECT
    released_year,
    SUM(streams) AS total_streams
FROM
    spotify_charts_2023
GROUP BY
    released_year
ORDER BY total_streams DESC
LIMIT 15;
```
### Visualize Data
![Steaming Performance vs. Release year](images/4_streaming_vs_release_timing.png)
*Bar graph visualizing the Streaming Performance vs. Release Year; ChatGPT generated this graph from my SQL query results*

### Insights:
- Recent dominance: Songs released in 2022 and 2021 amassed the highest total streams, suggesting newer music dominates streaming platforms.
- Older hits remain relevant: Songs from 2019-2017 still perform well, indicating longevity for some tracks.
- Classics still have an audience: Even songs from 2010 and earlier continue to generate significant streams, proving that older hits retain popularity.

### 5. What Makes a Viral Song? (Are higher-energy songs more likely to be charted?) (Is there a correlation between BPM and streaming success?)
To explore the characteristics of viral songs, I examined the relationship between a track's energy level and its success, measuring total streams and chart appearances across platforms.
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
    total_chart_appearances DESC
LIMIT 20;

```
### Visualize Data
![Energy% vs Chart and Streams](images/5_energy_vs_steams.png)
*Bar graph visualizing the Energy% vs Total Chart Appearances and Total Streams; ChatGPT generated this graph from my SQL query results*

### Insights:
- No Strong Correlation Between Energy % and Chart Appearances
- The scatter plot shows a spread-out distribution, indicating that higher-energy songs do not necessarily dominate the charts.
Higher Energy % Does Not Guarantee More Streams
- The second plot suggests that songs with both high and moderate energy levels can achieve high streaming numbers.
Other Factors Likely Play a Bigger Role in Virality
- Since energy % alone does not strongly correlate with success, factors like genre, artist popularity, and marketing likely influence chart appearances and streaming numbers more. ​​

---

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

---

# What I Learned 🎵
Through this project, I refined my SQL skills while diving deep into the world of music streaming data:

- **🔍 Dimensional Modeling:** Structured the dataset with fact and dimension tables for better query performance and analysis.
- **📊 Advanced Querying:** Used complex joins, aggregate functions, and CTEs to extract meaningful insights from large datasets.
- **📈 Data-Driven Insights:** Translated raw streaming data into actionable findings, improving my ability to analyze trends effectively.

# Conclusions

### Insights 🎶
From the analysis, several key takeaways emerged:

1. Top-Streamed Artists: The Weeknd and Bad Bunny dominated streaming numbers, showing their massive global reach.
2. Release Timing Matters: Songs from recent years (especially 2022) received the most streams, but older hits still maintain strong popularity.
3. Platform-Specific Popularity: Some songs performed exceptionally well across multiple streaming platforms, highlighting cross-platform appeal.
4. Seasonal Trends in New Releases: March and June saw the highest number of new songs that became popular, suggesting industry release patterns.
5. Evergreen Hits: Despite the dominance of new releases, some older tracks continue to amass significant streams, proving longevity matters.

# Closing Thoughts 🎼
This project strengthened my SQL abilities while providing fascinating insights into music streaming trends. Understanding how factors like release timing, artist popularity, and cross-platform performance impact streaming numbers is crucial for data-driven decision-making in the music industry. This exploration reinforced the power of SQL in uncovering trends and patterns hidden within large datasets.