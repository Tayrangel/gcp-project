# GCP_Project
 Case utilizando as ferramentas do Google Cloud Platform (GCP) realizando ingest, etl e dashboard

## Arquitetura de dados:
A arquitetura proposta, utiliza Google Cloud Storage (GCS), Google Cloud Functions (GCF), BigQuery (BQ) e Looker Studio, seguindo o conceito de arquitetura medalhão. O processo de ETL começa com a ingestão de dados das fontes no bucket armazenado no GCS, acionando uma trigger que atualiza a camada Bronze (covid), onde o primeiro dataset reflete os dados brutos da fonte. A atualização é feita pelo Google Cloud Functions e a cada atualização, os dados são substituídos para evitar duplicidade.

Na camada Silver, os dados são processados e refinados, aplicando regras de negócio, testes de nulidade e completude para garantir a qualidade. Finalmente, na camada Gold, os dados são transformados em tabelas de dimensões e fatos, otimizadas para análises. Essas tabelas são então conectadas ao Looker Studio, permitindo a criação de dashboards e relatórios dinâmicos para insights estratégicos. Essa arquitetura garante uma solução escalável e eficiente, com governança de dados.
<img src="/Images/arquitetura_de_dados.png">

## Extração:
### Cloud Storage
Os dados foram obtidos das fontes listadas abaixo, no formato .csv, e foram adicionados ao bucket do GCS chamado `data_upload_covid`. Para a configuração dos buckets foram consideradas a região `us-east1 (Carolina do Sul)`, o qual precisa ser mantida na configuração das demais aplicações.

<b>Fonte de dados:</b>
* https://brasil.io/dataset/covid19/caso_full/
* https://www.ibge.gov.br/explica/codigos-dos-municipios.php

<img src="/Cloud_Storage/gcs_bucket.gif">

### Cloud Functions
Desenvolvido o script com o mecanismo de acionar o GCF quando adicionado os arquivos no bucket GCS.

<img src="/Cloud_Functions/gcf_function.gif">

## Análise
### BigQuery
As análises realizadas com os dados se encontram em forma de perguntas em:

* [BigQuery](/BigQuery)

### Looker Studio
Para o dashboard utilizou a ferramenta Looker Studio.

<h5 style="color: #2846AB">Dashboard Covid-19 - Home</h5>
<img src="/Images/home.png">

<h5 style="color: #2846AB">Dashboard Covid-19 - Visão Geral</h5>
<img src="/Images/visao_geral.png">

<h5 style="color: #2846AB">Dashboard Covid-19 - Detalhamento</h5>
<img src="/Images/detalhamento.png">

#### Acessibilidade
A paleta de cores foi escolhida pensando no tema do dashboard, bem como, validada por uma ferramenta que informa se pessoas com daltonismo teriam conflitos com as cores selecionadas. Além disso, Todas as escolhas de proporção de contraste das cores do texto e de fundo, passaram no teste.

<img src="/Images/acessibilidade.png">
