-- create spotify_charts_2023

CREATE TABLE spotify_charts_2023 (
    track_name TEXT,
    artist_name TEXT,
    artist_count INT,
    released_year INT,
    released_month INT,
    released_day INT,
    in_spotify_playlists INT,
    in_spotify_charts INT,
    streams BIGINT,
    in_apple_playlists INT,
    in_apple_charts INT,
    in_deezer_playlists INT,
    in_deezer_charts INT,
    in_shazam_charts INT,
    bpm INT,
    key TEXT,
    mode TEXT,
    danceability_pct INT,
    valence_pct INT,
    energy_pct INT,
    acousticness_pct INT,
    instrumentalness_pct INT,
    liveness_pct INT,
    speechiness_pct INT
);

-- create dim_releases table
CREATE TABLE dim_releases (
    release_id SERIAL PRIMARY KEY,
    released_year INT NOT NULL,
    released_month INT NOT NULL
);

INSERT INTO dim_releases (released_year, released_month)
SELECT DISTINCT released_year, released_month
FROM spotify_charts_2023;

-- create dim_platforms table
CREATE TABLE dim_platforms (
    platform_id SERIAL PRIMARY KEY,
    in_spotify_playlists INT,
    in_spotify_charts INT,
    in_apple_playlists INT,
    in_apple_charts INT,
    in_deezer_playlists INT,
    in_deezer_charts INT,
    in_shazam_charts INT
);

INSERT INTO dim_platforms (in_spotify_playlists, in_spotify_charts, in_apple_playlists, in_apple_charts, in_deezer_playlists, in_deezer_charts, in_shazam_charts)
SELECT DISTINCT
    in_spotify_playlists,
    in_spotify_charts,
    in_apple_playlists,
    in_apple_charts,
    in_deezer_playlists,
    in_deezer_charts,
    in_shazam_charts
FROM spotify_charts_2023;

-- crete dim_audio_features table
CREATE TABLE dim_audio_features (
    audio_features_id SERIAL PRIMARY KEY,
    bpm INT,
    key TEXT,
    mode TEXT,
    danceability_pct INT,
    valence_pct INT,
    energy_pct INT,
    acousticness_pct INT,
    instrumentalness_pct INT
);


INSERT INTO dim_audio_features (bpm, key, mode, danceability_pct, valence_pct, energy_pct, acousticness_pct, instrumentalness_pct)
SELECT DISTINCT
    bpm, key, mode,
    danceability_pct, valence_pct, energy_pct, acousticness_pct, instrumentalness_pct
FROM spotify_charts_2023;
