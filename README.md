## 👥 Divisão de Responsabilidades

### 🖥️ Infraestrutura & Virtualização (On-Premises)
- **Topologia de Rede:** Configuração de vSwitches no Hyper-V (Rede Privada isolada e Rede Externa/NAT).
- **Provisionamento e Hardening:** Configuração de VMs Linux (Ubuntu Server) para o banco de produção e o gateway intermediário.
- **Segurança de Acesso:** Implementação de regras de firewall (`ufw`/`iptables`), segmentação de tráfego e políticas de menor privilégio para usuários de banco.
- **Automação:** Scripts (PowerShell / Bash) para inicialização, backup de snapshots e monitoramento de integridade das VMs.

---

### 📊 Engenharia de Dados & Cloud (AWS)
- **Massa de Dados & Modelagem:** Modelagem relacional e script de geração de dados sintéticos de transações bancárias (via Python Faker).
- **Pipeline de Extração Local:** Script conteinerizado (Docker) para extração incremental (watermarking por timestamp) e conversão colunar (Parquet particionado via DuckDB/PyArrow).
- **Integração Cloud:** Envio seguro para bucket AWS S3 via AWS SDK (`boto3`) com políticas restritas de IAM.
- **Camada Analítica:** Criação e particionamento de tabelas no AWS Athena para análises analíticas serverless.

---

## 🗺️ Roadmap de Execução

### Fase 1: Setup da Infraestrutura On-Premise
- [ ] Criação dos vSwitches no Hyper-V (Rede Interna e Rede NAT).
- [ ] Provisionamento da VM 1 (PostgreSQL) e da VM 2 (Gateway/Docker).
- [ ] Teste de isolamento de rede: garantir que a VM 1 não navegue na internet e só responda à VM 2 na porta do banco.

### Fase 2: Modelagem e Ingestão Local
- [ ] Criação das tabelas no PostgreSQL (contas, clientes, transações Pix).
- [ ] Carga inicial de dados sintéticos para testes de estresse.
- [ ] Criação do usuário analítico com permissão estritamente de leitura (`SELECT`).

### Fase 3: Pipeline de Extração e Conversão
- [ ] Desenvolvimento do script Python para extração incremental baseada em `updated_at`.
- [ ] Otimização da escrita em Parquet particionado por data localmente.
- [ ] Empacotamento do processo em container Docker na VM 2 com rotina agendada (Cron).

### Fase 4: Integração AWS & Analytics
- [ ] Criação do bucket S3 e da política IAM de menor privilégio (`s3:PutObject`).
- [ ] Configuração do envio automatizado para a AWS.
- [ ] Criação das tabelas externas no Amazon Athena e validação de consultas analíticas.

---

## 💰 Política de Custo Zero (Free Tier)
- **Hyper-V & Linux:** 100% open-source / nativo do sistema operacional.
- **Processamento:** 100% local no hardware de desenvolvimento.
- **AWS S3:** Dentro do limite gratuito de 5 GB de armazenamento.
- **AWS Athena:** Dentro do limite gratuito de 1 TB de dados escaneados por mês.