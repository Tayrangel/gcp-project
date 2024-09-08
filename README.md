# GCP_Project
 Case utilizando as ferramentas do Google Cloud Platform (GCP) realizando ingest, etl e dashboard

### Arquitetura de dados:
A arquitetura proposta, utiliza Google Cloud Storage (GCS), Google Cloud Functions (GCF), BigQuery (BQ) e Looker Studio, seguindo o conceito de arquitetura medalhão. O processo de ETL começa com a ingestão de dados das fontes no bucket armazenado no GCS, acionando uma trigger que atualiza a camada Bronze (covid), onde o primeiro dataset reflete os dados brutos da fonte. A atualização é feita pelo Google Cloud Functions e a cada atualização, os dados são substituídos para evitar duplicidade.

Na camada Silver, os dados são processados e refinados, aplicando regras de negócio, testes de nulidade e completude para garantir a qualidade. Finalmente, na camada Gold, os dados são transformados em tabelas de dimensões e fatos, otimizadas para análises. Essas tabelas são então conectadas ao Looker Studio, permitindo a criação de dashboards e relatórios dinâmicos para insights estratégicos. Essa arquitetura garante uma solução escalável e eficiente, com governança de dados.
<img src="/Images/arquitetura_de_dados.png">

### Extração:
#### Cloud Storage
Os dados foram obtidos das fontes listadas abaixo, no formato .csv, e foram adicionados ao bucket do GCS chamado `data_upload_covid`. Para a configuração dos buckets foram consideradas a região `us-east1 (Carolina do Sul)`, o qual precisa ser mantida na configuração das demais aplicações.

<b>Fonte de dados:</b>
* https://brasil.io/dataset/covid19/caso_full/
* https://www.ibge.gov.br/explica/codigos-dos-municipios.php

<img src="/Cloud_Storage/gcs_bucket.gif">

#### Cloud Functions
