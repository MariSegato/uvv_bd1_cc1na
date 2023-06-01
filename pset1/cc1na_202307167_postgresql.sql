

DO $$BEGIN
    IF EXISTS (
        SELECT 1 FROM pg_roles WHERE rolname = 'mariana'
    ) AND EXISTS (
        SELECT 1 FROM pg_namespace WHERE nspname = 'lojas'
    ) THEN
        REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA lojas FROM mariana;
    END IF;
END$$;
--Deletar tabelas se existir - necessario para apagar relacoes e constraints
DROP TABLE IF EXISTS lojas.clientes, lojas.pedidos, lojas.lojas, lojas.produtos, lojas.envios, lojas.estoques, lojas.pedidos_itens;
--Deletar schema se existir- necessario senao schema nao sera apagado
DROP SCHEMA IF EXISTS lojas;
--Deletar BD se existir
DROP DATABASE IF EXISTS uvv;
--Deletar usuario se existir
DROP ROLE IF EXISTS mariana;


--Criar usuario
CREATE USER mariana WITH PASSWORD 'mariana' CREATEDB CREATEROLE;

--Criar BD
CREATE DATABASE uvv
WITH OWNER = mariana
       ENCODING = 'UTF8'
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       TEMPLATE = template0;
--Comentar BD
COMMENT ON DATABASE uvv IS 'Banco de dados "UVV" da atividade "PSET1" da disciplina "Design e Desenvolvimento de Banco de Dados1".';

--AJUSTAR SEARCH PATH
\set db_user mariana;
\set db_name uvv;

--Conectar ao BD com o usuario mariana
\c "dbname=uvv user=mariana password=mariana";

--Criar schema "lojas"
CREATE SCHEMA lojas;
--Comentar schema
COMMENT ON SCHEMA lojas IS 'Schema "lojas", com 7 relações/tabelas e 9 relacionamentos';
ALTER SCHEMA lojas OWNER TO mariana;

--CRIAR E COMENTAR TABELAS E COLUNAS
--Criar tabela/relação "produtos"
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);

--Comentar tabela/relação "produtos"
COMMENT ON TABLE lojas.produtos IS 'Tabela de produtos';
--Comentar colunas/atributos da tabela "produtos"
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Coluna do id do produto';
COMMENT ON COLUMN lojas.produtos.nome IS 'Coluna do nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Coluna do preco unitario do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Coluna dos detalhes do produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Coluna da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Coluna do tipo MIME da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Coluna do arquivo no qual esta a imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Coluna do charset da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Coluna da data da ultima atualizacao da imagem do produto';

--Criar tabela/relação "lojas"
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC(8,6),
                longitude NUMERIC(9,6),
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);

--Comentar tabela/relação "lojas"
COMMENT ON TABLE lojas.lojas IS 'Tabela de lojas';
--Comentar colunas/atributos da tabela "lojas"
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Coluna do id da loja';
COMMENT ON COLUMN lojas.lojas.nome IS 'Coluna do nome da loja';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Coluna do endereco na web da loja';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Coluna do endereco fisico da loja';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Coluna da latitude do endereco da loja';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Coluna da longitude do endereco da loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'Coluna da logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Coluna do tipo MIME da logo';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Coluna do arquivo no qual a logo esta salva';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Coluna do charset da logo';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Coluna da data da ultima atualizacao da logo';

--Criar tabela/relação "estoques"
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);
--Comentar tabela/relação "estoques"
COMMENT ON TABLE lojas.estoques IS 'Tabela de estoques de produtos em lojas';
--Comentar colunas/atributos da tabela "estoques"
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Coluna do id do estoque';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Coluna da id da loja na qual o estoque esta';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Coluna da id do produto em que consiste o estoque';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Coluna da quantidade de certo produto que ha no estoque';

--Criar tabela/relação "clientes"
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
--Comentar tabela/relação "clientes"
COMMENT ON TABLE lojas.clientes IS 'Tabela de clientes';
--Comentar colunas/atributos da tabela "clientes"
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Coluna do id do cliente';
COMMENT ON COLUMN lojas.clientes.email IS 'Coluna do email do cliente';
COMMENT ON COLUMN lojas.clientes.nome IS 'Coluna do nome do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Coluna do primeiro telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Coluna do segundo telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Coluna do terceiro telefone do cliente';

--Criar tabela/relação "pedidos"
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);
--Comentar tabela/relação "pedidos"
COMMENT ON TABLE lojas.pedidos IS 'Tabela de pedidos';
--Comentar colunas/atributos da tabela "pedidos"
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Coluna do id do pedido';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Coluna da data e da hora do pedido';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Coluna do id do cliente que fez o pedido';
COMMENT ON COLUMN lojas.pedidos.status IS 'Coluna do status do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Coluna do id da loja que entrega o pedido';

--Criar tabela/relação "envios"
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);
--Comentar tabela/relação "envios"
COMMENT ON TABLE lojas.envios IS 'Tabela de envios';
--Comentar colunas/atributos da tabela "envios"
COMMENT ON COLUMN lojas.envios.envio_id IS 'Coluna do id do envio';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Coluna do id da loja que realiza o envio';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Coluna do id do cliente que recebe o envio';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Coluna do endereco da entrega do envio';
COMMENT ON COLUMN lojas.envios.status IS 'Coluna do status do envio';

--Criar tabela/relação "pedidos_itens"
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);
--Comentar tabela/relação "pedidos_itens"
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela de itens dos pedidos';
--Comentar colunas/atributos da tabela "pedidos_itens"
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Coluna do id do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Coluna do id do produto do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Coluna do numero da linha dos itens do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preco unitario do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Coluna da quantidade de itens no pedido';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Coluna do id do envio dos itens do pedido';



--CRIAR RELACIONAMENTOS

--Criar relacionamento não identificado entre tabela filha "estoques" e tabela pai "produtos" pelos atributos homonimos "produto_id"
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "pedidos_itens" e tabela pai "produtos" pelos atributos homonimos "produto_id"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "envios" e tabela pai "lojas" pelos atributos homonimos "loja_id"
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "estoques" e tabela pai "lojas" pelos atributos homonimos "loja_id"
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "pedidos" e tabela pai "lojas" pelos atributos homonimos "loja_id"
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "envios" e tabela pai "clientes" pelos atributos homonimos "cliente_id"
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "pedidos" e tabela pai "clientes" pelos atributos homonimos "cliente_id"
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "pedidos_itens" e tabela pai "pedidos" pelos atributos homonimos "pedido_id"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "pedidos_itens" e tabela pai "envios" pelos atributos homonimos "envio_id"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



--CRIAR RESTRICOES/CONSTRAINT CHECK

--RELACAO PRODUTOS
--Criar restricao para o atributo "produto_id"// ID=0 poderia causar confusao
ALTER TABLE lojas.produtos ADD CONSTRAINT cc_produtos_produto_id CHECK (lojas.produtos.produto_id >0);
--Criar restricao para o atributo "preco_unitario"
ALTER TABLE lojas.produtos ADD CONSTRAINT cc_produtos_preco_unitario CHECK (lojas.produtos.preco_unitario >=0);
--Criar restricao para o atributo "nome_ultima_atualizacao"


--RELACAO LOJAS
--Criar restricao para o atributo "loja_id"
ALTER TABLE lojas.lojas ADD CONSTRAINT cc_lojas_loja_id CHECK (lojas.lojas.loja_id>0);
--Criar restricao para o atributo "latitude"
ALTER TABLE lojas.lojas ADD CONSTRAINT cc_lojas_latitude CHECK (lojas.lojas.latitude>=-90 AND lojas.lojas.latitude<=90);
--Criar restricao para o atributo "longitude"
ALTER TABLE lojas.lojas ADD CONSTRAINT cc_lojas_longitude CHECK (lojas.lojas.longitude>=-180 AND lojas.lojas.longitude<=180);


--RELACAO ESTOQUES
--Criar restricao para o atributo "estoque_id"
ALTER TABLE lojas.estoques ADD CONSTRAINT cc_estoques_estoque_id CHECK (lojas.estoques.estoque_id>0);
--Criar restricao para o atributo "loja_id"
ALTER TABLE lojas.estoques ADD CONSTRAINT cc_estoques_loja_id CHECK (lojas.estoques.loja_id>0);
--Criar restricao para o atributo "produto_id"
ALTER TABLE lojas.estoques ADD CONSTRAINT cc_estoques_produto_id CHECK (lojas.estoques.produto_id>0);
--Criar restricao para o atributo "quantidade"
ALTER TABLE lojas.estoques ADD CONSTRAINT cc_estoques_quantidade CHECK (lojas.estoques.quantidade>=0);

--RELACAO CLIENTES
--Criar restricao para o atributo "cliente_id" // ID=0 poderia causar confusao
ALTER TABLE lojas.clientes ADD CONSTRAINT cc_clientes_cliente_id CHECK (lojas.clientes.cliente_id>0);
--Criar restricao para o atributo "email"
ALTER TABLE lojas.clientes ADD CONSTRAINT cc_clientes_email CHECK (lojas.clientes.email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
--Criar restricao para o atributo "nome"
ALTER TABLE lojas.clientes ADD CONSTRAINT cc_clientes_nome CHECK (lojas.clientes.nome ~* '^[A-Za-z\s]+$');
--Criar restricao para o atributo "telefone1"
ALTER TABLE lojas.clientes ADD CONSTRAINT cc_clientes_telefone1 CHECK (lojas.clientes.telefone1 ~* '^\+?[0-9\-\(\)\s]+$');
--Criar restricao para o atributo "telefone1"
ALTER TABLE lojas.clientes ADD CONSTRAINT cc_clientes_telefone2 CHECK (lojas.clientes.telefone2 ~* '^\+?[0-9\-\(\)\s]+$');
--Criar restricao para o atributo "telefone1"
ALTER TABLE lojas.clientes ADD CONSTRAINT cc_clientes_telefone3 CHECK (lojas.clientes.telefone3 ~* '^\+?[0-9\-\(\)\s]+$');

--RELACAO PEDIDOS
--Criar restricao para o atributo "pedido_id"
ALTER TABLE lojas.pedidos ADD CONSTRAINT cc_pedidos_pedido_id CHECK (lojas.pedidos.pedido_id>0);
--Criar restricao para o atributo "cliente_id"
ALTER TABLE lojas.pedidos ADD CONSTRAINT cc_pedidos_cliente_id CHECK (lojas.pedidos.cliente_id>0);
--Criar restricao para o atributo "loja_id"
ALTER TABLE lojas.pedidos ADD CONSTRAINT cc_pedidos_loja_id CHECK (lojas.pedidos.loja_id>0);

--RELACAO ENVIOS
--Criar restricao para o atributo "envio_id"
ALTER TABLE lojas.envios ADD CONSTRAINT cc_envios_envio_id CHECK (lojas.envios.envio_id>0);
--Criar restricao para o atributo "loja_id"
ALTER TABLE lojas.envios ADD CONSTRAINT cc_envios_loja_id CHECK (lojas.envios.loja_id>0);
--Criar restricao para o atributo "cliente_id"
ALTER TABLE lojas.envios ADD CONSTRAINT cc_envios_cliente_id CHECK (lojas.envios.cliente_id>0);

--RELACAO PEDIDOS_ITENS
--Criar restricao para o atributo "pedido_id"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT cc_pedidos_itens_pedido_id CHECK (lojas.pedidos_itens.pedido_id>0);
--Criar restricao para o atributo "produto_id"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT cc_pedidos_itens_produto_id CHECK (lojas.pedidos_itens.produto_id>0);
--Criar restricao para o atributo "numero_da_linha"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT cc_pedidos_itens_numero_da_linha CHECK (lojas.pedidos_itens.numero_da_linha>0);
--Criar restricao para o atributo "preco_unitario"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT cc_pedidos_itens_preco_unitario CHECK (lojas.pedidos_itens.preco_unitario>=0);
--Criar restricao para o atributo "quantidade"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT cc_pedidos_itens_quantidade CHECK (lojas.pedidos_itens.quantidade>=0);
--Criar restricao para o atributo "envio_id"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT cc_pedidos_itens_envio_id CHECK (lojas.pedidos_itens.envio_id>0);
