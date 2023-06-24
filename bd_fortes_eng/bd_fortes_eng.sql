--Schema não definido -> schema public

--CRIAR E COMENTAR TABELAS E PRIMARY KEYS - PKs

--Criar e comentar tabela "categorias"
CREATE TABLE categorias (
                codigo_categoria NUMERIC(3) NOT NULL,
                nome_categoria VARCHAR(250) NOT NULL,
                CONSTRAINT categorias_pk PRIMARY KEY (codigo_categoria)
);
COMMENT ON TABLE categorias IS 'categoria de habilidade, podendo ser categoria de hard skill, de soft skill ou de hobby';
COMMENT ON COLUMN categorias.codigo_categoria IS 'codigo da categoria de habilidade';
COMMENT ON COLUMN categorias.nome_categoria IS 'nome da categoria de habilidade';

--Criar tabela "skills"
CREATE TABLE skills (
                codigo_skill NUMERIC(3) NOT NULL,
                codigo_categoria NUMERIC(3) NOT NULL,
                nome_skill VARCHAR(250) NOT NULL,
                tipo_skill VARCHAR(4) NOT NULL,
                CONSTRAINT skills_pk PRIMARY KEY (codigo_skill)
);
COMMENT ON TABLE skills IS 'tabela das skills, que compreende hard e soft skills';
COMMENT ON COLUMN skills.codigo_skill IS 'codigo numerico da skill';
COMMENT ON COLUMN skills.nome_skill IS 'nome da skill';
COMMENT ON COLUMN skills.tipo_skill IS 'tipo da skill, podendo ser "hard" ou "soft"';

--Criar e comentar tabela "hobbies"
CREATE TABLE hobbies (
                codigo_hobby NUMERIC(3) NOT NULL,
                codigo_categoria NUMERIC(3) NOT NULL,
                nome_hobby VARCHAR(250) NOT NULL,
                CONSTRAINT hobbies_pk PRIMARY KEY (codigo_hobby)
);
COMMENT ON COLUMN hobbies.codigo_hobby IS 'codigo numerico do hobby';
COMMENT ON COLUMN hobbies.nome_hobby IS 'nome do hobby';

--Criar e comentar tabela "permissoes"
CREATE TABLE permissoes (
                codigo_permissao NUMERIC(3) NOT NULL,
                nome_permissao VARCHAR(250) NOT NULL,
                CONSTRAINT permissoes_pk PRIMARY KEY (codigo_permissao)
);
COMMENT ON TABLE permissoes IS 'permissoes do sistema';
COMMENT ON COLUMN permissoes.codigo_permissao IS 'codigo da permissao do sistema';
COMMENT ON COLUMN permissoes.nome_permissao IS 'nome da permissao do sistema';

--Criar e comentar tabela "papeis"
CREATE TABLE papeis (
                codigo_papel NUMERIC(3) NOT NULL,
                codigo_permissao NUMERIC(3) NOT NULL,
                nome_papel VARCHAR(250) NOT NULL,
                CONSTRAINT papeis_pk PRIMARY KEY (codigo_papel)
);
COMMENT ON TABLE papeis IS 'papel ou cargo do usuario (ex.: engenheiro civil, engenheiro quimico, etc)';
COMMENT ON COLUMN papeis.codigo_papel IS 'codigo do papel ou cargo do usuario';
COMMENT ON COLUMN papeis.codigo_permissao IS 'codigo da permissao do sistema';
COMMENT ON COLUMN papeis.nome_papel IS 'nome do papel ou cargo';

--Criar e comentar tabela "usuarios"
CREATE TABLE usuarios (
                cpf VARCHAR(11) NOT NULL,
                codigo_papel NUMERIC(3) NOT NULL,
                primeiro_nome VARCHAR(50) NOT NULL,
                sobrenome VARCHAR(250) NOT NULL,
                data_nascimento DATE NOT NULL,
                genero VARCHAR(20) NOT NULL,
                email VARCHAR(250) NOT NULL,
                senha VARCHAR(30) NOT NULL,
                CONSTRAINT usuarios_pk PRIMARY KEY (cpf)
);
COMMENT ON TABLE usuarios IS 'Tabela de usuarios do banco de talentos';
COMMENT ON COLUMN usuarios.cpf IS 'Coluna do CPF do usuario';
COMMENT ON COLUMN usuarios.codigo_papel IS 'codigo do papel ou cargo do usuario';
COMMENT ON COLUMN usuarios.primeiro_nome IS 'Primeiro nome do usuario';
COMMENT ON COLUMN usuarios.sobrenome IS 'sobrenome do usuario';
COMMENT ON COLUMN usuarios.data_nascimento IS 'data de nascimento do usuario, no formato dd/mm/aaa';
COMMENT ON COLUMN usuarios.genero IS 'genero do usuario (aceita valores "masculino", "feminino", ou "outro")';
COMMENT ON COLUMN usuarios.email IS 'email no formato "__@__"';
COMMENT ON COLUMN usuarios.senha IS 'senha a ser inserida criptografada';

--Criar e comentar tabela "usuarios_skills"
CREATE TABLE usuarios_skills (
                cpf VARCHAR(11) NOT NULL,
                codigo_skill NUMERIC(3) NOT NULL,
                CONSTRAINT usuarios_skills_pk PRIMARY KEY (cpf, codigo_skill)
);
COMMENT ON TABLE usuarios_skills IS 'Tabela de relacionamento entre as tabelas usuarios e skills para representar um relacionamento N:N';
COMMENT ON COLUMN usuarios_skills.cpf IS 'Coluna do CPF do usuario';
COMMENT ON COLUMN usuarios_skills.codigo_skill IS 'codigo numerico da skill';

--Criar e comentar tabela "hobbies"
CREATE TABLE usuarios_hobbies (
                cpf VARCHAR(11) NOT NULL,
                codigo_hobby NUMERIC(3) NOT NULL,
                CONSTRAINT usuarios_hobbies_pk PRIMARY KEY (cpf, codigo_hobby)
);
COMMENT ON TABLE usuarios_hobbies IS 'Tabela de licacao entre as tabelas usuarios e hobbies para representar um relacionamento N:N';
COMMENT ON COLUMN usuarios_hobbies.cpf IS 'Coluna do CPF do usuario';
COMMENT ON COLUMN usuarios_hobbies.codigo_hobby IS 'codigo numerico do hobby';

--Criar e comentar tabela "comunidades"
CREATE TABLE comunidades (
                codigo_comunidade VARCHAR NOT NULL,
                cpf VARCHAR(11) NOT NULL,
                codigo_skill NUMERIC(3),
                codigo_hobby NUMERIC(3),
                nome_comunidade VARCHAR(250) NOT NULL,
                CONSTRAINT comunidades_pk PRIMARY KEY (codigo_comunidade)
);
COMMENT ON COLUMN comunidades.codigo_comunidade IS 'codigo numerico da comunidade';
COMMENT ON COLUMN comunidades.cpf IS 'Coluna do CPF do usuario, que tambem e PK';
COMMENT ON COLUMN comunidades.nome_comunidade IS 'nome da comunidade';

--Criar e comentar tabela "usuarios_comunidades"
CREATE TABLE usuarios_comunidades (
                cpf VARCHAR(11) NOT NULL,
                codigo_comunidade VARCHAR NOT NULL,
                CONSTRAINT usuarios_comunidades_pk PRIMARY KEY (cpf, codigo_comunidade)
);
COMMENT ON TABLE usuarios_comunidades IS 'tabela de ligacao entre as tabelas usuarios e comunidades para representar um relacionamento N:N';
COMMENT ON COLUMN usuarios_comunidades.cpf IS 'Coluna do CPF do usuario';
COMMENT ON COLUMN usuarios_comunidades.codigo_comunidade IS 'codigo numerico da comunidade';

--Criar e comentar tabela "enderecos"
CREATE TABLE enderecos (
                codigo_endereco NUMERIC(5) NOT NULL,
                cpf VARCHAR(11) NOT NULL,
                uf VARCHAR(2) NOT NULL,
                cidade VARCHAR(50) NOT NULL,
                bairro VARCHAR(100) NOT NULL,
                logradouro VARCHAR(250) NOT NULL,
                numero NUMERIC(7) NOT NULL,
                complemento VARCHAR(100),
                cep VARCHAR(8) NOT NULL,
                CONSTRAINT enderecos_pk PRIMARY KEY (codigo_endereco, cpf)
);
COMMENT ON TABLE enderecos IS 'endereco do usuario, podendo ser mais de um';
COMMENT ON COLUMN enderecos.codigo_endereco IS 'codigo numerico referente ao endereco';
COMMENT ON COLUMN enderecos.cpf IS 'cpf do usuario';
COMMENT ON COLUMN enderecos.uf IS 'uniao federativa do endereco do usuario';
COMMENT ON COLUMN enderecos.cidade IS 'cidade do endereco do usuario';
COMMENT ON COLUMN enderecos.bairro IS 'bairro do endereco do usuario';
COMMENT ON COLUMN enderecos.logradouro IS 'logradouro do endereco do usuario';
COMMENT ON COLUMN enderecos.numero IS 'numero do logradouro do endereco do usuario';
COMMENT ON COLUMN enderecos.complemento IS 'complemento do endereco do usuario, sendo opcional';
COMMENT ON COLUMN enderecos.cep IS 'cep do endereco do usuario';

--Criar e comentar tabela "telefones"
CREATE TABLE telefones (
                telefone VARCHAR(9) NOT NULL,
                cpf VARCHAR(11) NOT NULL,
                ddi NUMERIC(3) NOT NULL,
                ddd NUMERIC(2) NOT NULL,
                CONSTRAINT telefones_pk PRIMARY KEY (telefone, cpf)
);
COMMENT ON COLUMN telefones.ddi IS 'discagem direta internacional, mais conhecido como codigo do pais de um numero';

--CRIAR RELACIONAMENTOS

--Criar relacionamento não identificado entre tabela filha "hobbies" e tabela pai "categorias" pelas colunas homonimas "codigo_categoria"
ALTER TABLE hobbies ADD CONSTRAINT categorias_hobbies_fk
FOREIGN KEY (codigo_categoria)
REFERENCES categorias (codigo_categoria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "skills" e tabela pai "categorias" pelas colunas homonimas "codigo_categoria"
ALTER TABLE skills ADD CONSTRAINT categorias_skills_fk
FOREIGN KEY (codigo_categoria)
REFERENCES categorias (codigo_categoria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "comunidades" e tabela pai "skills" pelas colunas homonimas "codigo_skill"
ALTER TABLE comunidades ADD CONSTRAINT skills_comunidades_fk
FOREIGN KEY (codigo_skill)
REFERENCES skills (codigo_skill)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "usuarios_skills" e tabela pai "skills" pelas colunas homonimas "codigo_skill"
ALTER TABLE usuarios_skills ADD CONSTRAINT skills_usuarios_skills_fk
FOREIGN KEY (codigo_skill)
REFERENCES skills (codigo_skill)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "comunidades" e tabela pai "hobbies" pelas colunas homonimas "codigo_hobby"
ALTER TABLE comunidades ADD CONSTRAINT hobbies_comunidades_fk
FOREIGN KEY (codigo_hobby)
REFERENCES hobbies (codigo_hobby)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "usuarios_hobbies" e tabela pai "hobbies" pelas colunas homonimas "codigo_hobby"
ALTER TABLE usuarios_hobbies ADD CONSTRAINT hobbies_usuarios_hobbies_fk
FOREIGN KEY (codigo_hobby)
REFERENCES hobbies (codigo_hobby)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "papeis" e tabela pai "permissoes" pelas colunas homonimas "codigo_permissao"
ALTER TABLE papeis ADD CONSTRAINT permissoes_papeis_fk
FOREIGN KEY (codigo_permissao)
REFERENCES permissoes (codigo_permissao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "usuarios" e tabela pai "papeis" pelas colunas homonimas "codigo_papel"
ALTER TABLE usuarios ADD CONSTRAINT papeis_usuarios_fk
FOREIGN KEY (codigo_papel)
REFERENCES papeis (codigo_papel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "telefones" e tabela pai "usuarios" pelas colunas homonimas "cpf"
ALTER TABLE telefones ADD CONSTRAINT usuarios_telefones_fk
FOREIGN KEY (cpf)
REFERENCES usuarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "enderecos" e tabela pai "usuarios" pelas colunas homonimas "cpf"
ALTER TABLE enderecos ADD CONSTRAINT usuarios_endereco_fk
FOREIGN KEY (cpf)
REFERENCES usuarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento não identificado entre tabela filha "comunidades" e tabela pai "usuarios" pelas colunas homonimas "cpf"
--Representando usuarios que lideram comunidades
ALTER TABLE comunidades ADD CONSTRAINT usuarios_comunidades_fk
FOREIGN KEY (cpf)
REFERENCES usuarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "usuarios_comunidades" e tabela pai "usuarios" pelas colunas homonimas "cpf"
ALTER TABLE usuarios_comunidades ADD CONSTRAINT usuarios_usuarios_comunidades_fk
FOREIGN KEY (cpf)
REFERENCES usuarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "usuarios_hobbies" e tabela pai "usuarios" pelas colunas homonimas "cpf"
ALTER TABLE usuarios_hobbies ADD CONSTRAINT usuarios_usuarios_hobbies_fk
FOREIGN KEY (cpf)
REFERENCES usuarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "usuarios_skills" e tabela pai "usuarios" pelas colunas homonimas "cpf"
ALTER TABLE usuarios_skills ADD CONSTRAINT usuarios_usuarios_skills_fk
FOREIGN KEY (cpf)
REFERENCES usuarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Criar relacionamento identificado entre tabela filha "usuarios_comunidades" e tabela pai "comunidades" pelas colunas homonimas "codigo_comunidade"
ALTER TABLE usuarios_comunidades ADD CONSTRAINT comunidades_usuarios_comunidades_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criar e comentar constraint Checks - CCs

--TABELA "USUARIOS"
--Restricao para a coluna "cpf"
ALTER TABLE usuarios ADD CONSTRAINT cc_usuarios_cpf CHECK (lenght(usuarios.cpf)=11 AND cpf ~ '^[0-9]{11}$');
COMMENT ON CONSTRAINT cc_usuarios_cpf IS 'Verifica se o CPF possui 11 dígitos numéricos (0-9)';
--Restricao para a coluna "primeiro_nome"
ALTER TABLE usuarios ADD CONSTRAINT cc_usuarios_primeiro_nome CHECK (usuarios.primeiro_nome ~ '^[A-Za-zÀ-ú\s-]+$');
COMMENT ON CONSTRAINT cc_usuarios_primeiro_nome IS 'Verifica se o primeiro nome contém apenas letras, espaços e hifens';
--Restricao para a coluna "sobrenome"
ALTER TABLE usuarios ADD CONSTRAINT cc_usuarios_sobrenome CHECK (usuarios.sobrenome ~ '^[A-Za-zÀ-ú\s-]+$');
COMMENT ON CONSTRAINT cc_usuarios_sobrenome IS 'Verifica se o sobrenome contém apenas letras, espaços e hifens';
--Restricao para a coluna "data_nascimento"
ALTER TABLE usuarios ADD CONSTRAINT cc_usuarios_data_nascimento CHECK (
  DATE_PART('year', usuarios.data_nascimento) BETWEEN 1900 AND 2100
  AND DATE_PART('month', usuarios.data_nascimento) BETWEEN 1 AND 12
  AND DATE_PART('day', usuarios.data_nascimento) BETWEEN 1 AND 31);
COMMENT ON CONSTRAINT cc_usuarios_data_nascimento IS 'Verifica se data de nascimento é valida, sem se atentar ao numero de dias pos meses e anos bissextos';
--Restricao para a coluna "genero"
ALTER TABLE usuarios ADD CONSTRAINT cc_usuarios_genero CHECK (LOWER(usuarios.genero) IN ('feminino', 'masculino', 'outro'));
COMMENT ON CONSTRAINT cc_usuarios_genero IS 'Verifica se o gênero é válido (feminino, masculino ou outro)';
--Restricao para a coluna "email"
ALTER TABLE usuarios ADD CONSTRAINT cc_usuarios_email CHECK (usuarios.email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

--TABELA "PAPEIS"
--Restricao para a coluna "codigo_papel"
ALTER TABLE papeis ADD CONSTRAINT cc_papeis_codigo_papel CHECK (papeis.codigo_papel > 0);
COMMENT ON CONSTRAINT cc_papeis_codigo_papel IS 'Verifica se o código é maior que zero';

--TABELA "PERMISSOES"
--Restricao para a coluna "codigo_permissao"
ALTER TABLE permissoes ADD CONSTRAINT cc_permissoes_codigo_permissao CHECK (permissoes.codigo_permissao > 0);
COMMENT ON CONSTRAINT cc_permissoes_codigo_permissao IS 'Verifica se o código é maior que zero';

--TABELA "ENDERECOS"
--Restricao para a coluna "codigo_endereco"
ALTER TABLE enderecos ADD CONSTRAINT cc_enderecos_codigo_endereco CHECK (enderecos.codigo_endereco > 0);
COMMENT ON CONSTRAINT cc_enderecos_codigo_endereco IS 'Verifica se o código é maior que zero';
--Restricao para a coluna "uf"
ALTER TABLE enderecos ADD CONSTRAINT cc_enderecos_uf CHECK (LOWER(enderecos.uf) IN ('ac', 'al', 'ap', 'am', 'ba', 'ce', 'df', 'es', 'go', 'ma', 'mt', 'ms', 'mg', 'pa',
'pb', 'pr', 'pe', 'pi', 'rj', 'rn', 'rs', 'ro', 'rr', 'sc', 'sp', 'se', 'to'));
COMMENT ON CONSTRAINT cc_enderecos_uf IS 'Verifica se a UF é válida (siglas das unidades federativas do Brasil)'
--Restricao para a coluna "numero"
ALTER TABLE enderecos ADD CONSTRAINT cc_enderecos_numero CHECK (enderecos.numero>0);
--Restricao para a coluna "cep"
ALTER TABLE enderecos ADD CONSTRAINT cc_enderecos_cep CHECK (enderecos.cep ~ '^[0-9]{8}$');
COMMENT ON CONSTRAINT cc_enderecos_cep IS 'Verifica se o CEP é válido (8 dígitos numéricos)';

--TABELA "TELEFONES"
--Restricao para a coluna "ddi"
ALTER TABLE telefones ADD CONSTRAINT cc_telefones_ddi CHECK (telefones.ddi >0);
COMMENT ON CONSTRAINT cc_telefones_ddi IS 'Verifica se o DDI é maior que zero';
--Restricao para a coluna "ddd"
ALTER TABLE telefones ADD CONSTRAINT cc_telefones_ddd CHECK (telefones.ddd >0);
COMMENT ON CONSTRAINT cc_telefones_ddd IS 'Verifica se o DDD é maior que zero';
--Restricao para a coluna "telefone"
ALTER TABLE telefones ADD CONSTRAINT cc_telefones_telefone CHECK (telefones.telefone ~ '^[0-9]{8,9}$');
COMMENT ON CONSTRAINT cc_telefones_telefone IS 'Verifica se o telefone é válido (8 a 9 dígitos numéricos)';

--TABELA "COMUNIDADES"
--Restricao para a coluna "codigo_comunidade"
ALTER TABLE comunidades ADD CONSTRAINT cc_comunidades_codigo_comunidade CHECK (comunidades.codigo_comunidade > 0);
COMMENT ON CONSTRAINT cc_comunidades_codigo_comunidade IS 'Verifica se o código é maior que zero';
--Restrição para que uma comunidade OU tenha "codigo_skill" OU tenha "codigo_hobby"
ALTER TABLE comunidades ADD CONSTRAINT cc_comunidades_ouSkill_ouHobby CHECK ((comunidades.codigo_skill IS NOT NULL AND comunidades.codigo_hobby IS NULL)
  OR (comunidades.codigo_skill IS NULL AND comunidades.codigo_hobby IS NOT NULL));
COMMENT ON CONSTRAINT cc_comunidades_ouSkill_ouHobby IS 'Verifica se apenas uma das PKs (codigo_skill ou codigo_hobby) é não nula';

--TABELA "HOBBIES"
--Restricao para a coluna "codigo_hobby"
ALTER TABLE hobbies ADD CONSTRAINT cc_hobbies_codigo_hobby CHECK (hobbies.codigo_hobby > 0);
COMMENT ON CONSTRAINT cc_hobbies_codigo_hobby IS 'Verifica se o código é maior que zero';

--TABELA "SKILLS"
--Restricao para a coluna "codigo_skill"
ALTER TABLE skills ADD CONSTRAINT cc_skills_codigo_skill CHECK (skills.codigo_skill > 0);
COMMENT ON CONSTRAINT cc_skills_codigo_skill IS 'Verifica se o código é maior que zero';
--Restricao para a coluna "tipo_skill"
ALTER TABLE skills ADD CONSTRAINT cc_skills_tipo_skill CHECK (LOWER(skills.tipo_skill) IN ('hard','soft'));
COMMENT ON CONSTRAINT cc_skills_tipo_skill IS 'Verifica se é hard (skill) ou soft (skill)';

--TABELA "CATEGORIAS"
--Restricao para a coluna "codigo_categoria"
ALTER TABLE categorias ADD CONSTRAINT cc_categorias_codigo_categoria CHECK (categorias.codigo_categoria > 0);
COMMENT ON CONSTRAINT cc_categorias_codigo_categoria IS 'Verifica se o código é maior que zero';
