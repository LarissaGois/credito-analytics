-- Criação da tabela de Clientes de Crédito
-- Banco de Dados: PostgreSQL / SQL Server (Padrão ANSI)

CREATE TABLE clientes_credito (
    id_cliente INT PRIMARY KEY,
    status_cliente VARCHAR(50),
    idade INT,
    genero VARCHAR(10),
    dependentes INT,
    escolaridade VARCHAR(50),
    estado_civil VARCHAR(50),
    faixa_renda VARCHAR(50),
    categoria_cartao VARCHAR(20),
    meses_relacionamento INT,
    limite_credito DECIMAL(15, 2),
    valor_total_transacoes DECIMAL(15, 2),
    qtd_total_transacoes INT
);

-- Comentário de documentação da tabela
COMMENT ON TABLE clientes_credito IS 'Tabela contendo perfil demográfico e comportamento de gastos de cartão de crédito para análise de churn.';