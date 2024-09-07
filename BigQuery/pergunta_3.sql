-- Pergunta 3 - Qual a Letalidade em % (mortes/casos confirmados) por Estado, classificando os 5 primeiros estados com maior letalidade ?
WITH
  casos_estado AS (
    SELECT 
      date
      ,state AS estado
      ,SUM(confirmed) AS total_casos_confirmados
      ,SUM(deaths) AS total_obitos
      ,ROW_NUMBER() OVER (PARTITION BY state ORDER BY date DESC) AS rn
    FROM `coral-bebop-357319.Sandbox.caso`
    WHERE
      place_type = 'state'
    GROUP BY 1,2
    QUALIFY rn = 1
  )

  ,letalidade AS (
    SELECT
      estado
      ,total_casos_confirmados
      ,total_obitos
      ,ROUND((total_obitos/total_casos_confirmados) * 100, 2) AS pct_letalidade
    FROM casos_estado
  )

SELECT
  estado
  ,total_casos_confirmados
  ,total_obitos
  ,pct_letalidade
FROM letalidade
ORDER BY 4 DESC
LIMIT 5  

-- Resultado
-- estado	total_casos_confirmados	total_obitos	pct_letalidade
-- RJ	2078817	72695	3.5
-- SP	5232374	167110	3.19
-- MA	424199	10869	2.56
-- AM	581070	14151	2.44
-- PA	751293	18079	2.41