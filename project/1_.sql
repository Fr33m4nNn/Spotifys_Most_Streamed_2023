SELECT *
FROM
    spotify_charts_2023
WHERE
    streams IS NOT NULL
ORDER BY streams DESC
LIMIT 15;

SELECT *
FROM
    dim_releases
