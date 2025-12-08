WITH AggregatedData AS (
    SELECT
        System.Timestamp AS windowEnd,
        location,
        
        AVG(iceThicknessCm) AS avgIceThicknessCm,
        MIN(iceThicknessCm) AS minIceThicknessCm,
        MAX(iceThicknessCm) AS maxIceThicknessCm,
        
        AVG(surfaceTemperatureC) AS avgSurfaceTemperatureC,
        MIN(surfaceTemperatureC) AS minSurfaceTemperatureC,
        MAX(surfaceTemperatureC) AS maxSurfaceTemperatureC,
        
        MAX(snowAccumulationCm) AS maxSnowAccumulationCm,
        
        AVG(externalTemperatureC) AS avgExternalTemperatureC,
        
        COUNT(*) AS readingCount
    FROM iotinput
    GROUP BY
        location,
        TumblingWindow(minute, 5)
)

-- Send aggregated results to Cosmos DB
SELECT
    windowEnd,
    location,
    avgIceThicknessCm,
    minIceThicknessCm,
    maxIceThicknessCm,
    avgSurfaceTemperatureC,
    minSurfaceTemperatureC,
    maxSurfaceTemperatureC,
    maxSnowAccumulationCm,
    avgExternalTemperatureC,
    readingCount,

    CASE
        WHEN avgIceThicknessCm >= 30 AND avgSurfaceTemperatureC <= -2 THEN 'Safe'
        WHEN avgIceThicknessCm >= 25 AND avgSurfaceTemperatureC <= 0 THEN 'Caution'
        ELSE 'Unsafe'
    END AS safetyStatus
INTO cosmosoutput
FROM AggregatedData;

-- Also send raw aggregates to Blob Storage
SELECT *
INTO bloboutput
FROM AggregatedData;

