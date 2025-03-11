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
