-- Pergunta 5 - Qual a porcentagem de municípios que registraram óbito em relação ao total de municípios da amostra?
-- (pode-se obter os municípios brasileiros através do link:
-- https://www.ibge.gov.br/explica/codigos-dos-municipios.php / https://www.ibge.gov.br/cidades-e-estados)
WITH
  municipios AS (
    SELECT 
      COUNT(DISTINCT(city_ibge_code)) AS total_municipios
    FROM `coral-bebop-357319.Sandbox.caso`
    WHERE
      place_type = 'city'
  )

  ,municipios_com_obitos AS (
    SELECT 
      COUNT(DISTINCT(city_ibge_code)) AS total_municipios_obitos
    FROM `coral-bebop-357319.Sandbox.caso`
    WHERE 
      deaths > 0
      AND place_type = 'city'
  )

SELECT
  total_municipios
  ,total_municipios_obitos
  ,ROUND((total_municipios_obitos/total_municipios) * 100, 2) AS pct_municipios
FROM municipios
  CROSS JOIN 
    municipios_com_obitos
GROUP BY 1,2

-- Resultado
-- total_municipios	total_municipios_obitos	pct_municipios
-- 5570	5549	99.62