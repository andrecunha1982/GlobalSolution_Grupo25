WITH Consumo_Agrupado AS (
    SELECT
        TO_CHAR(r.Data, 'YYYY-MM') AS Mes_Ano,
        uf.UF,
        SUM(r.Consumidores) AS Total_Consumidores,
        SUM(r.Consumo) AS Total_Consumo
    FROM
        GS_REGISTROS r
    INNER JOIN
        GS_UF uf ON r.UF = uf.ID
    WHERE
        uf.UF = 'Brasil'
    GROUP BY
        TO_CHAR(r.Data, 'YYYY-MM'), uf.UF
),
Consumo_Per_Capita AS (
    SELECT
        Mes_Ano,
        UF,
        Total_Consumidores,
        Total_Consumo,
        CASE 
            WHEN Total_Consumidores > 0 THEN Total_Consumo / Total_Consumidores
            ELSE 0
        END AS Consumo_Per_Capita
    FROM
        Consumo_Agrupado
)
SELECT
    cpc.Mes_Ano,
    cpc.UF,
    cpc.Total_Consumidores,
    cpc.Total_Consumo,
    cpc.Consumo_Per_Capita,
    LAG(cpc.Total_Consumo) OVER (PARTITION BY cpc.UF ORDER BY cpc.Mes_Ano) AS Consumo_Anterior,
    CASE 
        WHEN LAG(cpc.Total_Consumo) OVER (PARTITION BY cpc.UF ORDER BY cpc.Mes_Ano) IS NULL THEN NULL
        WHEN cpc.Total_Consumo > LAG(cpc.Total_Consumo) OVER (PARTITION BY cpc.UF ORDER BY cpc.Mes_Ano) THEN 'Aumento'
        WHEN cpc.Total_Consumo < LAG(cpc.Total_Consumo) OVER (PARTITION BY cpc.UF ORDER BY cpc.Mes_Ano) THEN 'Diminuição'
        ELSE 'Estável'
    END AS Tendencia_Consumo
FROM
    Consumo_Per_Capita cpc
ORDER BY
    cpc.Mes_Ano;
