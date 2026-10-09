-- Criação da tabela com estrutura desaninhada dos dados reais do governo
CREATE TABLE IF NOT EXISTS transacoes_cartao_corporativo (
    id_transacao BIGINT PRIMARY KEY,
    mes_extrato VARCHAR(10),
    data_transacao DATE,
    valor_transacao NUMERIC(15, 2),
    
    -- Dados de Tipo Cartão
    tipo_cartao_codigo VARCHAR(10),
    tipo_cartao_descricao VARCHAR(255),
    
    -- Dados do Estabelecimento / Favorecido
    estabelecimento_nome VARCHAR(255),
    estabelecimento_cnpj_cpf VARCHAR(20),
    
    -- Dados da Unidade Gestora / Órgão
    unidade_gestora_codigo VARCHAR(20),
    unidade_gestora_nome VARCHAR(255),
    
    -- Dados do Portador
    portador_cpf_formatado VARCHAR(20),
    portador_nome VARCHAR(255),
    
    -- Controle do Pipeline
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índices estratégicos para performance e busca incremental
CREATE INDEX IF NOT EXISTS idx_transacoes_data ON transacoes_cartao_corporativo (data_transacao);
CREATE INDEX IF NOT EXISTS idx_transacoes_updated_at ON transacoes_cartao_corporativo (updated_at);

-- Usuário restrito para o pipeline da VM Gateway ler sem risco
CREATE USER reader_analytics WITH PASSWORD 'SenhaSeguraAnalytics123!';
GRANT CONNECT ON DATABASE postgres TO reader_analytics;
GRANT USAGE ON SCHEMA public TO reader_analytics;
GRANT SELECT ON TABLE transacoes_cartao_corporativo TO reader_analytics;