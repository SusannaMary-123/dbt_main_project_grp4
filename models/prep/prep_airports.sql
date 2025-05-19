WITH airports_reorder AS (
    SELECT faa
           ,city
           ,name
           ,lat
           ,lon
           ,alt
           ,tz
           ,dst
           ,country
    FROM {{ref('staging_airports')}}
)
SELECT * FROM airports_reorder