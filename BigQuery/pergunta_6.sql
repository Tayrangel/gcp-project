-- Pergunta 6 - Qual a população total por estado , o município mais populoso de cada estado e a representatividade de concentração populacional 
-- em porcentagem deste município em relação ao total de habitantes do estado ?
WITH
  populacao_estado AS (
    SELECT 
      state AS estado
      ,date
      ,estimated_population AS populacao_estado
      ,ROW_NUMBER() OVER (PARTITION BY state ORDER BY date DESC) AS rn
    FROM `coral-bebop-357319.covid.caso`
    WHERE 
      place_type = 'state'
    QUALIFY rn = 1
  )

  ,municipio_mais_populoso AS (
    SELECT
      state AS estado
      ,city_ibge_code AS municipio
      ,estimated_population AS populacao_municipio
      ,ROW_NUMBER() OVER (PARTITION BY state ORDER BY date DESC) AS rn
    FROM `coral-bebop-357319.covid.caso`
    WHERE 
      place_type = 'city'
    QUALIFY rn = 1
  )

SELECT
  mmp.estado
  ,municipio
  ,populacao_estado
  ,mmp.populacao_municipio
  ,ROUND((populacao_municipio/populacao_estado) * 100, 2) AS pct_representatividade
FROM municipio_mais_populoso AS mmp
  LEFT JOIN populacao_estado AS pe
    ON mmp.estado = pe.estado
ORDER BY 5 DESC

-- Resultado
-- estado	municipio	populacao_estado	populacao_municipio	pct_representatividade
-- DF	5300108	3055149	3055149	100.0
-- RR	1400050	631181	15380	2.44
-- PA	1500107	8690745	159080	1.83
-- AC	1200013	894470	15490	1.73
-- RO	1100015	1796460	22728	1.27
-- RJ	3300100	17366189	207044	1.19
-- AP	1600105	861773	9187	1.07
-- PE	2600054	9616621	100346	1.04
-- ES	3200102	4064052	30455	0.75
-- AL	2700201	3351543	17526	0.52
-- AM	1300029	4207714	16220	0.39
-- RN	2400109	3534165	11121	0.31
-- PI	2200053	3281480	7102	0.22
-- MS	5000252	2809394	5417	0.19
-- TO	1700251	1590248	2594	0.16
-- MT	5100102	3526220	5334	0.15
-- BA	2900207	14930634	20347	0.14
-- PB	2500205	4039277	5630	0.14
-- CE	2300101	9187103	11853	0.13
-- GO	5200050	7113540	8958	0.13
-- SE	2800100	2318822	2380	0.1
-- MA	2100105	7114598	6578	0.09
-- SP	3500105	46289333	35111	0.08
-- PR	4100103	11516840	7408	0.06
-- SC	4200051	7252502	2548	0.04
-- RS	4300034	11422973	4942	0.04
-- MG	3100104	21292666	7006	0.03