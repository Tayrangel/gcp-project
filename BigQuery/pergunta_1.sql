-- Pergunta 1 - Qual o total de Casos Confirmados?
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
  SUM(total_casos_confirmados) AS total_casos_confirmados
FROM casos_estado

-- Resultado
-- 29849740
