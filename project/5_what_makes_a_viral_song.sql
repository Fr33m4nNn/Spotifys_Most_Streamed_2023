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
