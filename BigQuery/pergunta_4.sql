-- Pergunta 4 - Qual a Taxa de Óbitos por cada mil habitantes, por estado , listar os 5 primeiros estados com maior concentração de óbitos por cada mil habitantes (população) ?
WITH
  casos_estado AS (
    SELECT 
      date
      ,state AS estado
      ,estimated_population AS total_populacao
      ,SUM(deaths) AS total_obitos
      ,ROW_NUMBER() OVER (PARTITION BY state ORDER BY date DESC) AS rn
    FROM `coral-bebop-357319.Sandbox.caso`
    WHERE
      place_type = 'state'
    GROUP BY 1,2,3
    QUALIFY rn = 1
  )

  ,letalidade AS (
    SELECT
      estado
      ,total_populacao
      ,total_obitos
      ,ROUND((total_obitos/total_populacao) * 1000, 2) AS taxa_obitos_mil
    FROM casos_estado
  )

SELECT
  estado
  ,total_populacao
  ,total_obitos
  ,taxa_obitos_mil
FROM letalidade
ORDER BY 4 DESC
LIMIT 5  

-- Resultado
-- estado	total_populacao	total_obitos	taxa_obitos_mil
-- MT	3526220	14854	4.21
-- RJ	17366189	72695	4.19
-- RO	1796460	7172	3.99
-- DF	3055149	11573	3.79
-- MS	2809394	10486	3.73