import os
from google.cloud import bigquery
from google.cloud import storage

def load_to_bigquery(event, context):
    # Configurações
    bucket_name = 'data_upload_covid'
    dataset_name = 'covid'    
    
    file = event
    file_name = file['name']
    file_path = 'gs://{}/{}'.format(bucket_name, file_name)
    
    client = bigquery.Client()
    dataset_ref = client.dataset(dataset_name)

    # Verifica o nome do arquivo e define o nome da tabela
    table_name = None
    if file_name == 'caso.csv':
        table_name = 'caso'
    elif file_name == 'obito_cartorio.csv':
        table_name = 'obito_cartorio'
    elif file_name == 'RELATORIO_DTB_BRASIL_MUNICIPIO - DTB_2022_Municipio.csv':
        table_name = 'localizacao'
    else:
        print(f"Arquivo {file_name} não reconhecido.")
        return

    # Configura a tabela no BigQuery
    table_ref = dataset_ref.table(table_name)
    
    # Configura o job para sobrescrever a tabela
    job_config = bigquery.LoadJobConfig(
        skip_leading_rows=1,
        source_format=bigquery.SourceFormat.CSV,
        autodetect=True,
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE  # Sobrescreve a tabela
    )

    load_job = client.load_table_from_uri(
        file_path,
        table_ref,
        job_config=job_config
    )
    
    load_job.result()  # Espera a conclusão do job

    print('File {} loaded to {}.{}'.format(file_name, dataset_name, table_name))