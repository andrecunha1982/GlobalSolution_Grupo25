-- TABELA 1: GS_FAIXA_CONSUMO
CREATE TABLE GS_FAIXA_CONSUMO (
    ID NUMBER PRIMARY KEY,
    Faixa_Consumo_N1 VARCHAR2(5000),
    Faixa_Consumo_N2 VARCHAR2(5000)
);

-- TABELA 02: GS_SETOR_ECONOMICO
CREATE TABLE GS_SETOR_ECONOMICO (
    ID NUMBER PRIMARY KEY,
    Setor_Economico_N1 VARCHAR2(5000),
    Setor_Economico_N2 VARCHAR2(5000),
    Setor_Economico_N3 VARCHAR2(5000)
);

-- TABELA 03: GS_TIPO_TENSAO
CREATE TABLE GS_TIPO_TENSAO (
    ID NUMBER PRIMARY KEY,
    Tipo_Tensao_N1 VARCHAR2(5000),
    Tipo_Tensao_N2 VARCHAR2(5000),
    Tipo_Tensao_N3 VARCHAR2(5000)
);

-- TABELA 04: GS_UF
CREATE TABLE GS_UF (
    ID NUMBER PRIMARY KEY,
    UF VARCHAR2(5000)
);

-- TABELA 05: GS_SISTEMA
CREATE TABLE GS_SISTEMA (
    ID NUMBER PRIMARY KEY,
    Sistema VARCHAR2(5000)
);

-- TABELA 06: GS_TIPO_CONSUMIDOR
CREATE TABLE GS_TIPO_CONSUMIDOR (
    ID NUMBER PRIMARY KEY,
    TipoConsumidor VARCHAR2(5000)
);

-- TABELA 07: GS_REGISTROS
CREATE TABLE GS_REGISTROS (
    ID NUMBER PRIMARY KEY,
    Data DATE,
    TipoConsumidor NUMBER,
    Sistema NUMBER,
    UF NUMBER,
    SetorEconomico NUMBER,
    TipoTensao NUMBER,
    FaixaConsumo NUMBER,
    Consumidores FLOAT,
    Consumo FLOAT,
    CONSTRAINT FK_TipoConsumidor FOREIGN KEY (TipoConsumidor) REFERENCES GS_TIPO_CONSUMIDOR(ID),
    CONSTRAINT FK_Sistema FOREIGN KEY (Sistema) REFERENCES GS_SISTEMA(ID),
    CONSTRAINT FK_UF FOREIGN KEY (UF) REFERENCES GS_UF(ID),
    CONSTRAINT FK_SetorEconomico FOREIGN KEY (SetorEconomico) REFERENCES GS_SETOR_ECONOMICO(ID),
    CONSTRAINT FK_TipoTensao FOREIGN KEY (TipoTensao) REFERENCES GS_TIPO_TENSAO(ID),
    CONSTRAINT FK_FaixaConsumo FOREIGN KEY (FaixaConsumo) REFERENCES GS_FAIXA_CONSUMO(ID)
);
