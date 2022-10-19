/* Cria a tabela PROJETO, com a chave primária numero  */
CREATE TABLE PROJETO (
    NUMERO       SERIAL PRIMARY KEY,
    NOME         VARCHAR(50),
    LOCALIZACAO  VARCHAR(50)
);


/* Cria a tabela EMPREGADO, com a chave primária RG */
CREATE TABLE EMPREGADO (
    RG             SERIAL PRIMARY KEY,    
    NOME           VARCHAR(50),
    CPF            VARCHAR(10),
    DEPTO          INT,
    RG_SUPERVISOR  INT,
    SALARIO        DECIMAL(12,2),
    DAT_INI_SAL    DATE
    
);



/* Cria a tabela DEPARTAMENTO, com a chave primária numero */
CREATE TABLE DEPARTAMENTO (
    NUMERO      SERIAL PRIMARY KEY,
    NOME        VARCHAR(50),
    RG_GERENTE  INT,
    
  FOREIGN KEY(RG_GERENTE)
    REFERENCES Empregado(RG)      
);



/* Cria a tabela DEPENDENTE, com a chave primária codigo */
CREATE TABLE DEPENDENTE (
    CODIGO           SERIAL PRIMARY KEY,
    RG_RESPONSAVEL   INT NOT NULL,
    NOME_DEPENDENTE  VARCHAR(50),
    NASCIMENTO       DATE,
    RELACAO          VARCHAR(10),
    SEXO             CHAR(1),
    
    FOREIGN KEY(RG_RESPONSAVEL)
    REFERENCES Empregado(RG)      

);

/* Cria a tabela EMPREGADO_PROJETO, com a chave primária codigo */
CREATE TABLE EMPREGADO_PROJETO (
    CODIGO          SERIAL PRIMARY KEY,
    RG_EMPREGADO    INT NOT NULL,
    NUMERO_PROJETO  INT NOT NULL,
    HORAS           INT,
    
  FOREIGN KEY(RG_EMPREGADO)
    REFERENCES Empregado(RG),
  FOREIGN KEY(numero_projeto)
    REFERENCES Projeto(Numero)
);

/* Cria a tabela DEPARTAMENTO_PROJETO, com a chave primária codigo */
CREATE TABLE IF NOT EXISTS DEPARTAMENTO_PROJETO (
    CODIGO          SERIAL PRIMARY KEY,
    NUMERO_DEPTO    INT NOT NULL,
    NUMERO_PROJETO  INT NOT NULL,
   
    FOREIGN KEY(NUMERO_DEPTO)
    REFERENCES DEPARTAMENTO(NUMERO),
    FOREIGN KEY(numero_projeto)
    REFERENCES Projeto(Numero)
);

/* Cria a tabela HISTORICO_SALARIO, com a chave primária composta: RG e DAT_INI_SAL */
CREATE TABLE IF NOT EXISTS HISTORICO_SALARIO (
    RG              SERIAL,
    DAT_INI_SAL     DATE NOT NULL,
    DAT_FIM_SAL     DATE NOT NULL,
    SALARIO         DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY(RG)
    REFERENCES EMPREGADO(RG)
);

/* Cria a chave estrangeira RG_SUPERVISOR A PARTIR DO AUTO-RELACIONAMENTO DA TABELA EMPREGADO */
ALTER TABLE EMPREGADO ADD CONSTRAINT FK_SUPERV_EMPR FOREIGN KEY (RG_SUPERVISOR) REFERENCES EMPREGADO(RG);

/* Cria a chave estrangeira DEPTO A PARTIR DA TABELA DEPARTAMENTO DENTRO DA TABELA EMPREGADO */
ALTER TABLE EMPREGADO ADD CONSTRAINT FK_DEPTO_EMPR FOREIGN KEY (DEPTO) REFERENCES DEPARTAMENTO(NUMERO);


/* Insere dados na tabela Projeto  */
INSERT INTO PROJETO (NOME, NUMERO, LOCALIZACAO) VALUES 
('Financeiro', 5, 'São Paulo'),
('Motor', 10, 'Rio Claro'),
('Prédio Central', 20, 'Campinas'),
('Águas Limpas',25,'Vitória');

/* Insere dados na tabela departamento */
INSERT INTO DEPARTAMENTO (NOME, NUMERO, RG_GERENTE) VALUES 
('Contabilidade', 1, NULL), 	  /*RG_GERENTE=1010 */
('Engenharia Civil', 2, NULL), 	  /*RG_GERENTE=3030 */
('Engenharia Mecânica', 3, NULL), /*RG_GERENTE=2020 */
('Industrial', 4, NULL);

 /* Insere dados na tabela Departamento_projeto */
INSERT INTO DEPARTAMENTO_PROJETO (CODIGO, NUMERO_DEPTO, NUMERO_PROJETO) VALUES 
(1, 2, 5),
(2, 3, 10),
(3, 2, 20);

/* Insere dados na tabela Empregado */
INSERT INTO EMPREGADO (NOME, RG, CPF, DEPTO, RG_SUPERVISOR, SALARIO,DAT_INI_SAL) VALUES 
('João Luiz', 1010, 11111, 1, NULL, 6000,'2011/05/01'),
('Fernanda', 2020, 22222, 1, 1010, 5500,'2008/12/01'),
('Ricardo', 3030, 33333, 2, 2020, 2300,'2009/08/01'),
('Jorge', 4040, 44444, 2, 3030, 3200,'2010/10/01'),
('Renata', 5050, 55555, 2, 3030, 1300,'2012/02/01'),
('Luiz Renato', 6060, 66666, 3, 2020, 3000,'2012/05/01'),
('Luiz Fernando', 7070, 77777, 3, 6060, 2000,'2008/08/01'),
('João Antonio',8080,88888,1,2020,3950,'2010/07/01');

/* Insere dados na tabela Dependente */
INSERT INTO DEPENDENTE (CODIGO, RG_RESPONSAVEL, NOME_DEPENDENTE, NASCIMENTO, RELACAO, SEXO) VALUES 
(1, 1010, 'Jorge', '1986/12/27','Filho','M'),
(2, 1010, 'Luiz', '1979/11/18','Filho','M'),
(3, 2020, 'Fernanda Carla', '1969/02/14','Cônjuge','F'),
(4, 2020, 'Ângelo', '1995/02/10','Filho','M'),
(5, 3030, 'André', '1990/05/01','Filho','M'),
(6,8080,'Ana Maria','1980/06/30','Cônjuge','F'),
(7,8080,'Karla Cristina','1999/08/25','Filha','F');


/* Insere dados na tabela Empregado_Projeto */
INSERT INTO EMPREGADO_PROJETO (CODIGO, RG_EMPREGADO, NUMERO_PROJETO, HORAS) VALUES 
(1, 2020, 5, 10),
(2, 2020, 10, 25),
(3, 3030, 5, 35),
(4, 4040, 20, 50),
(5, 5050, 20, 35),
(6,8080,5,70);

/* Insere dados na tabela Histórico de Salário */
INSERT INTO HISTORICO_SALARIO (RG, DAT_INI_SAL, DAT_FIM_SAL, SALARIO) VALUES 
(1010, '2010/01/01', '2010/11/30',2000),
(1010, '2010/12/01', '2011/04/30',4000),
(2020, '2007/05/01', '2007/12/31',2500),
(2020, '2008/01/01', '2010/11/30',4000),
(4040, '2010/10/01',  '2012/10/31',3500),
(4040,'2008/08/01', '2009/10/31',1500),
(4040,'2009/11/01', '2010/09/30',2500),
(7070,'2008/01/01', '2008/07/31',1000);

/* Atualiza o Gerente dos departamentos que estavam vazios */
UPDATE DEPARTAMENTO SET RG_GERENTE=1010 WHERE NUMERO=1;
UPDATE DEPARTAMENTO SET RG_GERENTE=3030 WHERE NUMERO=2;
UPDATE DEPARTAMENTO SET RG_GERENTE=2020 WHERE NUMERO=3;