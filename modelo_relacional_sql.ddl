-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2025-07-19 08:20:07 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE clientes 
    ( 
     id_cliente       INTEGER  NOT NULL , 
     razao_social     VARCHAR2 (255 CHAR)  NOT NULL , 
     nome_fantasia    VARCHAR2 (200 CHAR)  NOT NULL , 
     cnpj             VARCHAR2 (14 CHAR)  NOT NULL , 
     email_financeiro VARCHAR2 (100 CHAR)  NOT NULL , 
     telefone         VARCHAR2 (20 CHAR)  NOT NULL , 
     endereco         VARCHAR2 (255 CHAR)  NOT NULL , 
     status           VARCHAR2 (10 CHAR)  NOT NULL , 
     data_cadastro    DATE  NOT NULL 
    ) 
;

ALTER TABLE clientes 
    ADD CONSTRAINT clientes_PK PRIMARY KEY ( id_cliente ) ;

CREATE TABLE condicoes_pagamento 
    ( 
     id_condicao_pgto INTEGER  NOT NULL , 
     descricao        VARCHAR2 (100 CHAR)  NOT NULL , 
     numero_parcelas  INTEGER  NOT NULL , 
     intervalo_dias   INTEGER  NOT NULL 
    ) 
;

ALTER TABLE condicoes_pagamento 
    ADD CONSTRAINT condicoes_pagamento_PK PRIMARY KEY ( id_condicao_pgto ) ;

CREATE TABLE configuracoes 
    ( 
     chave_config INTEGER  NOT NULL , 
     valor_config VARCHAR2 (255 CHAR)  NOT NULL 
    ) 
;

CREATE TABLE contas_a_receber 
    ( 
     id_conta_receber    INTEGER  NOT NULL , 
     numero_parcela      INTEGER , 
     data_emissao        DATE  NOT NULL , 
     data_vencimento     DATE  NOT NULL , 
     valor_original      NUMBER (12,2)  NOT NULL , 
     valor_pago          NUMBER (12,2) , 
     saldo_devedor       NUMBER (12,2)  NOT NULL , 
     status_conta        VARCHAR2 (20 CHAR)  NOT NULL , 
     vendas_id_venda     INTEGER  NOT NULL , 
     clientes_id_cliente INTEGER  NOT NULL , 
     filiais_id_filiais  INTEGER  NOT NULL , 
     negocios_id_negocio INTEGER  NOT NULL 
    ) 
;

ALTER TABLE contas_a_receber 
    ADD CONSTRAINT contas_a_receber_PK PRIMARY KEY ( id_conta_receber ) ;

CREATE TABLE faturas 
    ( 
     id_fatura        INTEGER  NOT NULL , 
     vendas_id_venda  INTEGER  NOT NULL , 
     numero_fatura    INTEGER  NOT NULL , 
     data_emissao     DATE  NOT NULL , 
     chave_acesso_nfe VARCHAR2 (44 CHAR)  NOT NULL 
    ) 
;

ALTER TABLE faturas 
    ADD CONSTRAINT faturas_PK PRIMARY KEY ( id_fatura ) ;

CREATE TABLE filiais 
    ( 
     id_filiais  INTEGER  NOT NULL , 
     nome_filial VARCHAR2 (100 CHAR)  NOT NULL , 
     cnpj_filial VARCHAR2 (14 CHAR)  NOT NULL , 
     cidade      VARCHAR2 (100 CHAR)  NOT NULL 
    ) 
;

ALTER TABLE filiais 
    ADD CONSTRAINT filiais_PK PRIMARY KEY ( id_filiais ) ;

CREATE TABLE formas_pagamento 
    ( 
     id_pagamento INTEGER  NOT NULL , 
     descricao    VARCHAR2 (50 CHAR)  NOT NULL 
    ) 
;

ALTER TABLE formas_pagamento 
    ADD CONSTRAINT formas_pagamento_PK PRIMARY KEY ( id_pagamento ) ;

CREATE TABLE itens_venda 
    ( 
     id_venda          INTEGER  NOT NULL , 
     id_produto        INTEGER  NOT NULL , 
     quantidade        NUMBER (10,2)  NOT NULL , 
     vl_unit_praticado NUMBER (10,2)  NOT NULL 
    ) 
;

ALTER TABLE itens_venda 
    ADD CONSTRAINT intens_venda_PK PRIMARY KEY ( id_venda, id_produto ) ;

CREATE TABLE negocios 
    ( 
     id_negocio        INTEGER  NOT NULL , 
     codigo_negocio    VARCHAR2 (20 CHAR)  NOT NULL , 
     descricao_negocio VARCHAR2 (100 CHAR)  NOT NULL 
    ) 
;

ALTER TABLE negocios 
    ADD CONSTRAINT negocios_PK PRIMARY KEY ( id_negocio ) ;

CREATE TABLE pagamentos 
    ( 
     id_pagamento     INTEGER  NOT NULL , 
     data_pagamento   DATE , 
     valor_pagamento  NUMBER (12,2) , 
     valor_juros      NUMBER (12,2) , 
     valor_desconto   NUMBER (12,2) , 
     id_conta_receber INTEGER  NOT NULL 
    ) 
;

ALTER TABLE pagamentos 
    ADD CONSTRAINT pagamentos_PK PRIMARY KEY ( id_pagamento ) ;

CREATE TABLE produtos 
    ( 
     id_produto     INTEGER  NOT NULL , 
     id_negocio     INTEGER  NOT NULL , 
     descricao      VARCHAR2 (255 CHAR)  NOT NULL , 
     tipo_produto   VARCHAR2 (20 CHAR)  NOT NULL , 
     valor_unitario NUMBER (10,2)  NOT NULL , 
     unidade_medida VARCHAR2 (10 CHAR)  NOT NULL , 
     estoque_atual  NUMBER  NOT NULL 
    ) 
;

ALTER TABLE produtos 
    ADD CONSTRAINT produtos_PK PRIMARY KEY ( id_produto ) ;

CREATE TABLE usuarios 
    ( 
     id_usuario   INTEGER  NOT NULL , 
     nome_usuario VARCHAR2 (200 CHAR)  NOT NULL , 
     email        VARCHAR2 (100 CHAR)  NOT NULL , 
     firebase_uid VARCHAR2 (100 CHAR)  NOT NULL , 
     perfil       VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE usuarios 
    ADD CONSTRAINT usuarios_PK PRIMARY KEY ( id_usuario ) ;

CREATE TABLE vendas 
    ( 
     id_venda            INTEGER  NOT NULL , 
     negocios_id_negocio INTEGER  NOT NULL , 
     filiais_id_filiais  INTEGER  NOT NULL , 
     usuarios_id_usuario INTEGER  NOT NULL , 
     id_forma_pagamento  INTEGER  NOT NULL , 
     data_venda          DATE  NOT NULL , 
     valor_bruto         NUMBER (12,2)  NOT NULL , 
     valor_desconto      NUMBER (12,2)  NOT NULL , 
     valor_liquido       NUMBER (12,2)  NOT NULL , 
     status_venda        VARCHAR2 (20 CHAR)  NOT NULL 
    ) 
;

ALTER TABLE vendas 
    ADD CONSTRAINT vendas_PK PRIMARY KEY ( id_venda ) ;

ALTER TABLE contas_a_receber 
    ADD CONSTRAINT FK_contas_a_receber_clientes FOREIGN KEY 
    ( 
     clientes_id_cliente
    ) 
    REFERENCES clientes 
    ( 
     id_cliente
    ) 
;

ALTER TABLE contas_a_receber 
    ADD CONSTRAINT FK_contas_a_receber_filiais FOREIGN KEY 
    ( 
     filiais_id_filiais
    ) 
    REFERENCES filiais 
    ( 
     id_filiais
    ) 
;

ALTER TABLE contas_a_receber 
    ADD CONSTRAINT FK_contas_a_receber_negocios FOREIGN KEY 
    ( 
     negocios_id_negocio
    ) 
    REFERENCES negocios 
    ( 
     id_negocio
    ) 
;

ALTER TABLE contas_a_receber 
    ADD CONSTRAINT FK_contas_a_receber_vendas FOREIGN KEY 
    ( 
     vendas_id_venda
    ) 
    REFERENCES vendas 
    ( 
     id_venda
    ) 
;

ALTER TABLE faturas 
    ADD CONSTRAINT FK_faturas_vendas FOREIGN KEY 
    ( 
     vendas_id_venda
    ) 
    REFERENCES vendas 
    ( 
     id_venda
    ) 
;

ALTER TABLE pagamentos 
    ADD CONSTRAINT FK_pagamentos_contas_a_receber FOREIGN KEY 
    ( 
     id_conta_receber
    ) 
    REFERENCES contas_a_receber 
    ( 
     id_conta_receber
    ) 
;

ALTER TABLE produtos 
    ADD CONSTRAINT FK_produtos_negocios FOREIGN KEY 
    ( 
     id_negocio
    ) 
    REFERENCES negocios 
    ( 
     id_negocio
    ) 
;

ALTER TABLE vendas 
    ADD CONSTRAINT FK_vendas_filiais FOREIGN KEY 
    ( 
     filiais_id_filiais
    ) 
    REFERENCES filiais 
    ( 
     id_filiais
    ) 
;

ALTER TABLE vendas 
    ADD CONSTRAINT FK_vendas_negocios FOREIGN KEY 
    ( 
     negocios_id_negocio
    ) 
    REFERENCES negocios 
    ( 
     id_negocio
    ) 
;

ALTER TABLE vendas 
    ADD CONSTRAINT "FK_vendas_pagamento._FK" FOREIGN KEY 
    ( 
     id_forma_pagamento
    ) 
    REFERENCES formas_pagamento 
    ( 
     id_pagamento
    ) 
;

ALTER TABLE vendas 
    ADD CONSTRAINT FK_vendas_usuario FOREIGN KEY 
    ( 
     usuarios_id_usuario
    ) 
    REFERENCES usuarios 
    ( 
     id_usuario
    ) 
;



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             0
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
