/* =============================================================================
 ANÁLISE DE NEGÓCIO - CARTÃO DE CRÉDITO
 Objetivo: Entender comportamento, rentabilidade e risco.
=============================================================================
*/

-- 1. Qual faixa etária gasta mais? (Criação de Buckets de Idade)
SELECT 
    CASE 
        WHEN idade < 30 THEN '1. Até 29 anos'
        WHEN idade BETWEEN 30 AND 39 THEN '2. 30 a 39 anos'
        WHEN idade BETWEEN 40 AND 49 THEN '3. 40 a 49 anos'
        WHEN idade BETWEEN 50 AND 59 THEN '4. 50 a 59 anos'
        ELSE '5. 60+ anos'
    END AS faixa_etaria,
    COUNT(id_cliente) AS total_clientes,
    CAST(AVG(valor_total_transacoes) AS DECIMAL(10,2)) AS ticket_medio_gasto,
    CAST(SUM(valor_total_transacoes) AS DECIMAL(15,2)) AS receita_total_gerada
FROM 
    clientes_credito
GROUP BY 
    CASE 
        WHEN idade < 30 THEN '1. Até 29 anos'
        WHEN idade BETWEEN 30 AND 39 THEN '2. 30 a 39 anos'
        WHEN idade BETWEEN 40 AND 49 THEN '3. 40 a 49 anos'
        WHEN idade BETWEEN 50 AND 59 THEN '4. 50 a 59 anos'
        ELSE '5. 60+ anos'
    END
ORDER BY 
    receita_total_gerada DESC;


-- 2. Quais categorias de cartão geram mais receita e qual a taxa de uso do limite?
SELECT 
    categoria_cartao,
    COUNT(id_cliente) AS volume_clientes,
    CAST(SUM(limite_credito) AS DECIMAL(15,2)) AS limite_total_concedido,
    CAST(SUM(valor_total_transacoes) AS DECIMAL(15,2)) AS volume_transacionado,
    -- Calculando a % de utilização do limite (Gasto / Limite)
    CAST((SUM(valor_total_transacoes) / SUM(limite_credito)) * 100 AS DECIMAL(5,2)) AS pct_utilizacao_limite
FROM 
    clientes_credito
GROUP BY 
    categoria_cartao
ORDER BY 
    volume_transacionado DESC;


-- 3. Quem são os clientes mais rentáveis e com alto risco de churn? (Visão de Risco)
-- Regra: Clientes que gastam muito (acima de 5000), mas fizeram poucas transações (menos de 45).
SELECT 
    id_cliente,
    idade,
    categoria_cartao,
    valor_total_transacoes,
    qtd_total_transacoes,
    status_cliente
FROM 
    clientes_credito
WHERE 
    valor_total_transacoes > 4000 
    AND qtd_total_transacoes < 45
    AND status_cliente = 'Existing Customer' -- Focando em quem ainda não cancelou para agir preventivamente
ORDER BY 
    valor_total_transacoes DESC;
