-- COPY "spotify_charts_2023"

\copy spotify_charts_2023 FROM 'C:/Users/user/DataGripProjects/Spotify Charts 2023/csv_files/spotify_2023.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
