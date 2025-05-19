WITH daily_data AS (
    SELECT * 
    FROM {{ref('staging_weather_daily')}}
),
add_features AS (
    SELECT *
        ,date_part('day', date) AS date_day_num         -- Day of the month
        ,date_part('month', date) AS date_month          -- Month as number
        ,date_part('year', date) AS date_year            -- Year
        ,date_part('week', date) AS cw                   -- Calendar week number
        ,TO_CHAR(date, 'FMMonth') AS month_name              -- Full month name (padded)
        ,to_char(date,'FMDay') AS weekday                  -- Full weekday name (padded)
    FROM daily_data 
),
add_more_features AS (
    SELECT *
		, CASE 
            WHEN DATE_PART('month', date) IN (12, 1, 2) THEN 'winter'
            WHEN DATE_PART('month', date) IN (3, 4, 5) THEN 'spring'
            WHEN DATE_PART('month', date) IN (6, 7, 8) THEN 'summer'
            WHEN DATE_PART('month', date) IN (9, 10, 11) THEN 'autumn'
 END AS season
FROM add_features
)
SELECT *
FROM add_more_features
ORDER BY date