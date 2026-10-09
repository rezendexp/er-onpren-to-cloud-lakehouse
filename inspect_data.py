import os
import requests
import pandas as pd
from dotenv import load_dotenv

# Carrega as variáveis de ambiente do arquivo .env
load_dotenv()

API_KEY = os.getenv("PORTAL_API_KEY")

if not API_KEY:
    raise ValueError("❌ Chave da API não encontrada! Verifique se o arquivo .env contém a variável PORTAL_API_KEY.")

url = "https://api.portaldatransparencia.gov.br/api-de-dados/cartoes"

params = {
    "pagina": 1,
    "mesExtratoInicio": "01/2024",
    "mesExtratoFim": "01/2024"
}

headers = {
    "chave-api-dados": API_KEY,
    "Accept": "application/json"
}

print("🌐 Conectando à API do Portal da Transparência com autenticação...")
response = requests.get(url, headers=headers, params=params)

print(f"HTTP Status Code: {response.status_code}")

if response.status_code == 200:
    data = response.json()
    if data:
        df_sample = pd.DataFrame(data)
        
        print("\n📋 CAMPOS RETORNADOS PELA API OFICIAL:")
        for idx, col in enumerate(df_sample.columns, 1):
            print(f" {idx}. {col}")
            
        print("\n🔍 AMOSTRA DOS DADOS (Primeiros 2 registros):")
        print(df_sample.head(2).T)
    else:
        print("⚠️ A API respondeu com sucesso (200), mas a consulta não retornou registros para esse período.")
else:
    print(f"❌ Erro na requisição ({response.status_code}): {response.text}")