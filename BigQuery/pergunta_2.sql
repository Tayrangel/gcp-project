-- Pergunta 2 - Qual a quantidade de Casos confirmados por Estado, classificando os 5 primeiros estados com mais casos?
WITH
  casos_estado AS (
    SELECT 
      date
      ,state
      ,SUM(confirmed) AS total_casos_confirmados
      ,ROW_NUMBER() OVER (PARTITION BY state ORDER BY date DESC) AS rn
    FROM `coral-bebop-357319.Sandbox.caso`
    WHERE
      place_type = 'state'
    GROUP BY 1,2
    QUALIFY rn = 1
  )

SELECT
  state
  ,total_casos_confirmados
FROM casos_estado
ORDER BY 2 DESC
LIMIT 5  