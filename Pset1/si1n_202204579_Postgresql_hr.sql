--criando o usuario
create role thales with 
createdb;

--criando o banco de dados
CREATE DATABASE uvv
WITH
OWNER = thales
TEMPLATE = template0 
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
CONNECTION LIMIT -1;

\c uvv thales;
CREATE SCHEMA hr AUTHORIZATION thales;
ALTER USER thales
SET SEARCH_PATH TO hr, "$user", public;


CREATE TABLE hr.jobs (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minino NUMERIC(8,2) NOT NULL,
                salario_maximo NUMERIC(8,2) NOT NULL,
                CONSTRAINT id_cargo PRIMARY KEY (id_cargo)
);


CREATE TABLE hr.regions (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE hr.regions IS 'tabela com as regioes';


CREATE UNIQUE INDEX regions_idx
 ON hr.regions
 ( nome );

CREATE TABLE hr.countries (
                id_pais CHAR(2) NOT NULL,
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                CONSTRAINT id_pais PRIMARY KEY (id_pais)
);
COMMENT ON TABLE hr.countries IS 'tabela com paises';


CREATE TABLE hr.locations (
                id_localizacoes INTEGER NOT NULL,
                endereco VARCHAR(50),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                cep CHAR(14) NOT NULL,
                id_pais CHAR(2) NOT NULL,
                CONSTRAINT id_localizacoes PRIMARY KEY (id_localizacoes)
);
COMMENT ON TABLE hr.locations IS 'tabela comas localizaceos';


CREATE TABLE hr.departments (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizacoes INTEGER,
                id_gerente INTEGER,
                CONSTRAINT id_departamentos PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE hr.departments IS 'tabela departamentos';


CREATE UNIQUE INDEX departments_idx
 ON hr.departments
 ( nome );

CREATE TABLE hr.employees (
                id_empregados INTEGER NOT NULL,
                nome VARCHAR(75),
                email VARCHAR(75) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                salario NUMERIC(8,2) NOT NULL,
                comissao NUMERIC(4,2) NOT NULL,
                id_supervisor INTEGER,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                Parent_id_empregados INTEGER,
                CONSTRAINT id_empregado PRIMARY KEY (id_empregados)
);
COMMENT ON TABLE hr.employees IS 'tabela empregados';


CREATE TABLE hr.job_history (
                data_inicial DATE NOT NULL,
                id_empregados INTEGER NOT NULL,
                id_empregado REAL NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT data_inicial PRIMARY KEY (data_inicial, id_empregados)
);
COMMENT ON TABLE hr.job_history IS 'historico cargos';


ALTER TABLE hr.job_history ADD CONSTRAINT jobs_job_history_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.jobs (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.employees ADD CONSTRAINT jobs_employees_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.jobs (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.countries ADD CONSTRAINT regions_countries_fk
FOREIGN KEY (id_regiao)
REFERENCES hr.regions (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.locations ADD CONSTRAINT countries_locations_fk
FOREIGN KEY (id_pais)
REFERENCES hr.countries (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departments ADD CONSTRAINT locations_departments_fk
FOREIGN KEY (id_localizacoes)
REFERENCES hr.locations (id_localizacoes)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.employees ADD CONSTRAINT departments_employees_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departments (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.job_history ADD CONSTRAINT departments_job_history_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departments (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.employees ADD CONSTRAINT employees_employees_fk
FOREIGN KEY (Parent_id_empregados)
REFERENCES hr.employees (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.job_history ADD CONSTRAINT employees_job_history_fk
FOREIGN KEY (id_empregados)
REFERENCES hr.employees (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- populando as tabelas anteriores

INSERT INTO hr.regions (id_regiao, nome) VALUES 
        ( 1
        , 'Europe' 
        );

INSERT INTO hr.regions (id_regiao, nome) VALUES 
        ( 2
        , 'Americas' 
        );

INSERT INTO hr.regions (id_regiao, nome) VALUES 
        ( 3
        , 'Asia' 
        );

INSERT INTO hr.regions (id_regiao, nome) VALUES 
        ( 4
        , 'Middle East and Africa' 
        );



INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'IT'
        , 'Italy'
        , 1 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'JP'
        , 'Japan'
	, 3 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'US'
        , 'United States of America'
        , 2 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'CA'
        , 'Canada'
        , 2 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'CN'
        , 'China'
        , 3 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'IN'
        , 'India'
        , 3 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'AU'
        , 'Australia'
        , 3 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'ZW'
        , 'Zimbabwe'
        , 4 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'SG'
        , 'Singapore'
        , 3 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'UK'
        , 'United Kingdom'
        , 1 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'FR'
        , 'France'
        , 1 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'DE'
        , 'Germany'
        , 1 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'ZM'
        , 'Zambia'
        , 4 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'EG'
        , 'Egypt'
        , 4 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'BR'
        , 'Brazil'
        , 2 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'CH'
        , 'Switzerland'
        , 1 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'NL'
        , 'Netherlands'
        , 1 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'MX'
        , 'Mexico'
        , 2 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'KW'
        , 'Kuwait'
        , 4 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'IL'
        , 'Israel'
        , 4 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'DK'
        , 'Denmark'
        , 1 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'ML'
        , 'Malaysia'
        , 3 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'NG'
        , 'Nigeria'
        , 4 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'AR'
        , 'Argentina'
        , 2 
        );

INSERT INTO hr.countries (id_pais, nome, id_regiao) VALUES 
        ( 'BE'
        , 'Belgium'
        , 1 
        );




INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1000 
        , '1297 Via Cola di Rie'
        , '00989'
        , 'Roma'
        , NULL
        , 'IT'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1100 
        , '93091 Calle della Testa'
        , '10934'
        , 'Venice'
        , NULL
        , 'IT'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1200 
        , '2017 Shinjuku-ku'
        , '1689'
        , 'Tokyo'
        , 'Tokyo Prefecture'
        , 'JP'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1300 
        , '9450 Kamiya-cho'
        , '6823'
        , 'Hiroshima'
        , NULL
        , 'JP'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1400 
        , '2014 Jabberwocky Rd'
        , '26192'
        , 'Southlake'
        , 'Texas'
        , 'US'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1500 
        , '2011 Interiors Blvd'
        , '99236'
        , 'South San Francisco'
        , 'California'
        , 'US'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1600 
        , '2007 Zagora St'
        , '50090'
        , 'South Brunswick'
        , 'New Jersey'
        , 'US'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1700 
        , '2004 Charade Rd'
        , '98199'
        , 'Seattle'
        , 'Washington'
        , 'US'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1800 
        , '147 Spadina Ave'
        , 'M5V 2L7'
        , 'Toronto'
        , 'Ontario'
        , 'CA'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 1900 
        , '6092 Boxwood St'
        , 'YSW 9T2'
        , 'Whitehorse'
        , 'Yukon'
        , 'CA'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2000 
        , '40-5-12 Laogianggen'
        , '190518'
        , 'Beijing'
        , NULL
        , 'CN'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2100 
        , '1298 Vileparle (E)'
        , '490231'
        , 'Bombay'
        , 'Maharashtra'
        , 'IN'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2200 
        , '12-98 Victoria Street'
        , '2901'
        , 'Sydney'
        , 'New South Wales'
        , 'AU'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2300 
        , '198 Clementi North'
        , '540198'
        , 'Singapore'
        , NULL
        , 'SG'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2400 
        , '8204 Arthur St'
        , NULL
        , 'London'
        , NULL
        , 'UK'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2500 
        , 'Magdalen Centre, The Oxford Science Park'
        , 'OX9 9ZB'
        , 'Oxford'
        , 'Oxford'
        , 'UK'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2600 
        , '9702 Chester Road'
        , '09629850293'
        , 'Stretford'
        , 'Manchester'
        , 'UK'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2700 
        , 'Schwanthalerstr. 7031'
        , '80925'
        , 'Munich'
        , 'Bavaria'
        , 'DE'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2800 
        , 'Rua Frei Caneca 1360 '
        , '01307-002'
        , 'Sao Paulo'
        , 'Sao Paulo'
        , 'BR'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 2900 
        , '20 Rue des Corps-Saints'
        , '1730'
        , 'Geneva'
        , 'Geneve'
        , 'CH'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 3000 
        , 'Murtenstrasse 921'
        , '3095'
        , 'Bern'
        , 'BE'
        , 'CH'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 3100 
        , 'Pieter Breughelstraat 837'
        , '3029SK'
        , 'Utrecht'
        , 'Utrecht'
        , 'NL'
        );

INSERT INTO hr.locations (id_localizacoes, endereco, cep, cidade, uf, id_pais) VALUES 
        ( 3200 
        , 'Mariano Escobedo 9991'
        , '11932'
        , 'Mexico City'
        , 'Distrito Federal,'
        , 'MX'
        );




ALTER TABLE hr.departments 
  DISABLE CONSTRAINT dept_mgr_fk;

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 10
        , 'Administration'
        , 200
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 20
        , 'Marketing'
        , 201
        , 1800
        );
                                
INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 30
        , 'Purchasing'
        , 114
        , 1700
	);
                
INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 40
        , 'Human Resources'
        , 203
        , 2400
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 50
        , 'Shipping'
        , 121
        , 1500
        );
                
INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 60 
        , 'IT'
        , 103
        , 1400
        );
                
INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 70 
        , 'Public Relations'
        , 204
        , 2700
        );
                
INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 80 
        , 'Sales'
        , 145
        , 2500
        );
                
INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 90 
        , 'Executive'
        , 100
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 100 
        , 'Finance'
        , 108
        , 1700
        );
                
INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 110 
        , 'Accounting'
        , 205
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 120 
        , 'Treasury'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 130 
        , 'Corporate Tax'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 140 
        , 'Control And Credit'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 150 
        , 'Shareholder Services'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 160 
        , 'Benefits'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 170 
        , 'Manufacturing'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 180 
        , 'Construction'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 190 
        , 'Contracting'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 200 
        , 'Operations'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 210 
        , 'IT Support'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 220 
        , 'NOC'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 230 
        , 'IT Helpdesk'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 240 
        , 'Government Sales'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 250 
        , 'Retail Sales'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 260 
        , 'Recruiting'
        , NULL
        , 1700
        );

INSERT INTO hr.departments ( id_departamentos, nome, id_localizacoes, id_gerente) VALUES 
        ( 270 
        , 'Payroll'
        , NULL
        , 1700
        );




INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AD_PRES'
        , 'President'
        , 20080
        , 40000
        );
INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AD_VP'
        , 'Administration Vice President'
        , 15000
        , 30000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AD_ASST'
        , 'Administration Assistant'
        , 3000
        , 6000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'FI_MGR'
        , 'Finance Manager'
        , 8200
        , 16000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'FI_ACCOUNT'
        , 'Accountant'
        , 4200
        , 9000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AC_MGR'
        , 'Accounting Manager'
        , 8200
        , 16000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AC_ACCOUNT'
        , 'Public Accountant'
        , 4200
        , 9000
        );
INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'SA_MAN'
        , 'Sales Manager'
        , 10000
        , 20080
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'SA_REP'
        , 'Sales Representative'
        , 6000
        , 12008
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'PU_MAN'
        , 'Purchasing Manager'
        , 8000
        , 15000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'PU_CLERK'
        , 'Purchasing Clerk'
        , 2500
        , 5500
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'ST_MAN'
        , 'Stock Manager'
        , 5500
        , 8500
        );
INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'ST_CLERK'
        , 'Stock Clerk'
        , 2008
        , 5000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'SH_CLERK'
        , 'Shipping Clerk'
        , 2500
        , 5500
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'IT_PROG'
        , 'Programmer'
        , 4000
        , 10000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'MK_MAN'
        , 'Marketing Manager'
        , 9000
        , 15000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'MK_REP'
        , 'Marketing Representative'
        , 4000
        , 9000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'HR_REP'
        , 'Human Resources Representative'
        , 4000
        , 9000
        );

INSERT INTO hr.jobs (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'PR_REP'
        , 'Public Relations Representative'
        , 4500
        , 10500
        );



INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 100
        , 'Steven'
        , 'King'
        , 'SKING'
        , '515.123.4567'
        , '17-06-2003',
        , 'AD_PRES'
        , 24000
        , NULL
        , NULL
        , 90
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 101
        , 'Neena'
        , 'Kochhar'
        , 'NKOCHHAR'
        , '515.123.4568'
        , '21-09-2005',
        , 'AD_VP'
        , 17000
        , NULL
        , 100
        , 90
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 102
        , 'Lex'
        , 'De Haan'
        , 'LDEHAAN'
        , '515.123.4569'
        , '13-01-2001',
        , 'AD_VP'
        , 17000
        , NULL
        , 100
        , 90
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 103
        , 'Alexander'
        , 'Hunold'
        , 'AHUNOLD'
        , '590.423.4567'
        , '03-01-2006',
        , 'IT_PROG'
        , 9000
        , NULL
        , 102
        , 60
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 104
        , 'Bruce'
        , 'Ernst'
        , 'BERNST'
        , '590.423.4568'
        , '21-05-2007',
        , 'IT_PROG'
        , 6000
        , NULL
        , 103
        , 60
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 105
        , 'David'
        , 'Austin'
        , 'DAUSTIN'
        , '590.423.4569'
        , '25-06-2005',
        , 'IT_PROG'
        , 4800
        , NULL
        , 103
        , 60
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 106
        , 'Valli'
        , 'Pataballa'
        , 'VPATABAL'
        , '590.423.4560'
        , '05-02-2006',
        , 'IT_PROG'
        , 4800
        , NULL
        , 103
        , 60
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 107
        , 'Diana'
        , 'Lorentz'
        , 'DLORENTZ'
        , '590.423.5567'
        , '07-02-2007',
        , 'IT_PROG'
        , 4200
        , NULL
        , 103
        , 60
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 108
        , 'Nancy'
        , 'Greenberg'
        , 'NGREENBE'
        , '515.124.4569'
        , '17-08-2002',
        , 'FI_MGR'
        , 12008
        , NULL
        , 101
        , 100
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 109
        , 'Daniel'
        , 'Faviet'
        , 'DFAVIET'
        , '515.124.4169'
        , '16-08-2002',
        , 'FI_ACCOUNT'
        , 9000
        , NULL
        , 108
        , 100
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 110
        , 'John'
        , 'Chen'
        , 'JCHEN'
        , '515.124.4269'
        , '28-09-2005',
        , 'FI_ACCOUNT'
        , 8200
        , NULL
        , 108
        , 100
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 111
        , 'Ismael'
        , 'Sciarra'
        , 'ISCIARRA'
        , '515.124.4369'
        , '30-09-2005',
        , 'FI_ACCOUNT'
        , 7700
        , NULL
        , 108
        , 100
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 112
        , 'Jose Manuel'
        , 'Urman'
        , 'JMURMAN'
        , '515.124.4469'
        , '07-03-2006',
        , 'FI_ACCOUNT'
        , 7800
        , NULL
        , 108
        , 100
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 113
        , 'Luis'
        , 'Popp'
        , 'LPOPP'
        , '515.124.4567'
        , '07-12-2007',
        , 'FI_ACCOUNT'
        , 6900
        , NULL
        , 108
        , 100
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 114
        , 'Den'
        , 'Raphaely'
        , 'DRAPHEAL'
        , '515.127.4561'
        , '07-12-2002',
        , 'PU_MAN'
        , 11000
        , NULL
        , 100
        , 30
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 115
        , 'Alexander'
        , 'Khoo'
        , 'AKHOO'
        , '515.127.4562'
        , '18-05-2003',
        , 'PU_CLERK'
        , 3100
        , NULL
        , 114
        , 30
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 116
        , 'Shelli'
        , 'Baida'
        , 'SBAIDA'
        , '515.127.4563'
        , '24-12-2005',
        , 'PU_CLERK'
        , 2900
        , NULL
        , 114
        , 30
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 117
        , 'Sigal'
        , 'Tobias'
        , 'STOBIAS'
        , '515.127.4564'
        , '24-07-2005',
        , 'PU_CLERK'
        , 2800
        , NULL
        , 114
        , 30
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 118
        , 'Guy'
        , 'Himuro'
        , 'GHIMURO'
        , '515.127.4565'
        , '15-11-2006',
        , 'PU_CLERK'
        , 2600
        , NULL
        , 114
        , 30
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 119
        , 'Karen'
        , 'Colmenares'
        , 'KCOLMENA'
        , '515.127.4566'
        , '10-08-2007',
        , 'PU_CLERK'
        , 2500
        , NULL
        , 114
        , 30
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 120
        , 'Matthew'
        , 'Weiss'
        , 'MWEISS'
        , '650.123.1234'
        , '18-07-2004',
        , 'ST_MAN'
        , 8000
        , NULL
        , 100
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 121
        , 'Adam'
        , 'Fripp'
        , 'AFRIPP'
        , '650.123.2234'
        , '10-04-2005',
        , 'ST_MAN'
        , 8200
        , NULL
        , 100
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 122
        , 'Payam'
        , 'Kaufling'
        , 'PKAUFLIN'
        , '650.123.3234'
        , '01-05-2003',
        , 'ST_MAN'
        , 7900
        , NULL
        , 100
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 123
        , 'Shanta'
        , 'Vollman'
        , 'SVOLLMAN'
        , '650.123.4234'
        , '10-10-2005',
        , 'ST_MAN'
        , 6500
        , NULL
        , 100
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 124
        , 'Kevin'
        , 'Mourgos'
        , 'KMOURGOS'
        , '650.123.5234'
        , '16-11-2007',
        , 'ST_MAN'
        , 5800
        , NULL
        , 100
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 125
        , 'Julia'
        , 'Nayer'
        , 'JNAYER'
        , '650.124.1214'
        , '16-07-2005',
        , 'ST_CLERK'
        , 3200
        , NULL
        , 120
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 126
        , 'Irene'
        , 'Mikkilineni'
        , 'IMIKKILI'
        , '650.124.1224'
        , '28-09-2006',
        , 'ST_CLERK'
        , 2700
        , NULL
        , 120
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 127
        , 'James'
        , 'Landry'
        , 'JLANDRY'
        , '650.124.1334'
        , '14-01-2007',
        , 'ST_CLERK'
        , 2400
        , NULL
        , 120
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 128
        , 'Steven'
        , 'Markle'
        , 'SMARKLE'
        , '650.124.1434'
        , '08-03-2008',
        , 'ST_CLERK'
        , 2200
        , NULL
        , 120
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 129
        , 'Laura'
        , 'Bissot'
        , 'LBISSOT'
        , '650.124.5234'
        , '20-08-2005',
        , 'ST_CLERK'
        , 3300
        , NULL
        , 121
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 130
        , 'Mozhe'
        , 'Atkinson'
        , 'MATKINSO'
        , '650.124.6234'
        , '30-10-2005',
        , 'ST_CLERK'
        , 2800
        , NULL
        , 121
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 131
        , 'James'
        , 'Marlow'
        , 'JAMRLOW'
        , '650.124.7234'
        , '16-02-2005',
        , 'ST_CLERK'
        , 2500
        , NULL
        , 121
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 132
        , 'TJ'
        , 'Olson'
        , 'TJOLSON'
        , '650.124.8234'
        , '10-04-2007',
        , 'ST_CLERK'
        , 2100
        , NULL
        , 121
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 133
        , 'Jason'
        , 'Mallin'
        , 'JMALLIN'
        , '650.127.1934'
        , '14-06-2004',
        , 'ST_CLERK'
        , 3300
        , NULL
        , 122
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 134
        , 'Michael'
        , 'Rogers'
        , 'MROGERS'
        , '650.127.1834'
        , '26-08-2006',
        , 'ST_CLERK'
        , 2900
        , NULL
        , 122
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 135
        , 'Ki'
        , 'Gee'
        , 'KGEE'
        , '650.127.1734'
        , '12-12-2007',
        , 'ST_CLERK'
        , 2400
        , NULL
        , 122
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 136
        , 'Hazel'
        , 'Philtanker'
        , 'HPHILTAN'
        , '650.127.1634'
        , '06-02-2008',
        , 'ST_CLERK'
        , 2200
        , NULL
        , 122
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 137
        , 'Renske'
        , 'Ladwig'
        , 'RLADWIG'
        , '650.121.1234'
        , '14-07-2003',
        , 'ST_CLERK'
        , 3600
        , NULL
        , 123
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 138
        , 'Stephen'
        , 'Stiles'
        , 'SSTILES'
        , '650.121.2034'
        , '26-10-2005',
        , 'ST_CLERK'
        , 3200
        , NULL
        , 123
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 139
        , 'John'
        , 'Seo'
        , 'JSEO'
        , '650.121.2019'
        , '12-02-2006',
        , 'ST_CLERK'
        , 2700
        , NULL
        , 123
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 140
        , 'Joshua'
        , 'Patel'
        , 'JPATEL'
        , '650.121.1834'
        , '06-04-2006',
        , 'ST_CLERK'
        , 2500
        , NULL
        , 123
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 141
        , 'Trenna'
        , 'Rajs'
        , 'TRAJS'
        , '650.121.8009'
        , '17-10-2003',
        , 'ST_CLERK'
        , 3500
        , NULL
        , 124
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 142
        , 'Curtis'
        , 'Davies'
        , 'CDAVIES'
        , '650.121.2994'
        , '29-01-2005',
        , 'ST_CLERK'
        , 3100
        , NULL
        , 124
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 143
        , 'Randall'
        , 'Matos'
        , 'RMATOS'
        , '650.121.2874'
        , '15-03-2006',
        , 'ST_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 144
        , 'Peter'
        , 'Vargas'
        , 'PVARGAS'
        , '650.121.2004'
        , '09-07-2006',
        , 'ST_CLERK'
        , 2500
        , NULL
        , 124
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 145
        , 'John'
        , 'Russell'
        , 'JRUSSEL'
        , '011.44.1344.429268'
        , '01-10-2004',
        , 'SA_MAN'
        , 14000
        , .4
        , 100
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 146
        , 'Karen'
        , 'Partners'
        , 'KPARTNER'
        , '011.44.1344.467268'
        , '05-01-2005',
        , 'SA_MAN'
        , 13500
        , .3
        , 100
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 147
        , 'Alberto'
        , 'Errazuriz'
        , 'AERRAZUR'
        , '011.44.1344.429278'
        , '10-03-2005',
        , 'SA_MAN'
        , 12000
        , .3
        , 100
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 148
        , 'Gerald'
        , 'Cambrault'
        , 'GCAMBRAU'
        , '011.44.1344.619268'
        , '15-10-2007',
        , 'SA_MAN'
        , 11000
        , .3
        , 100
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 149
        , 'Eleni'
        , 'Zlotkey'
        , 'EZLOTKEY'
        , '011.44.1344.429018'
        , '29-01-2008',
        , 'SA_MAN'
        , 10500
        , .2
        , 100
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 150
        , 'Peter'
        , 'Tucker'
        , 'PTUCKER'
        , '011.44.1344.129268'
        , '30-01-2005',
        , 'SA_REP'
        , 10000
        , .3
        , 145
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 151
        , 'David'
        , 'Bernstein'
        , 'DBERNSTE'
        , '011.44.1344.345268'
        , '24-03-2005',
        , 'SA_REP'
        , 9500
        , .25
        , 145
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 152
        , 'Peter'
        , 'Hall'
        , 'PHALL'
        , '011.44.1344.478968'
        , '20-08-2005',
        , 'SA_REP'
        , 9000
        , .25
        , 145
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 153
        , 'Christopher'
        , 'Olsen'
        , 'COLSEN'
        , '011.44.1344.498718'
        , '30-03-2006',
        , 'SA_REP'
        , 8000
        , .2
        , 145
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 154
        , 'Nanette'
        , 'Cambrault'
        , 'NCAMBRAU'
        , '011.44.1344.987668'
        , '09-12-2006',
        , 'SA_REP'
        , 7500
        , .2
        , 145
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 155
        , 'Oliver'
        , 'Tuvault'
        , 'OTUVAULT'
        , '011.44.1344.486508'
        , '23-11-2007',
        , 'SA_REP'
        , 7000
        , .15
        , 145
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 156
        , 'Janette'
        , 'King'
        , 'JKING'
        , '011.44.1345.429268'
        , '30-01-2004',
        , 'SA_REP'
        , 10000
        , .35
        , 146
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 157
        , 'Patrick'
        , 'Sully'
        , 'PSULLY'
        , '011.44.1345.929268'
        , '04-03-2004',
        , 'SA_REP'
        , 9500
        , .35
        , 146
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 158
        , 'Allan'
        , 'McEwen'
        , 'AMCEWEN'
        , '011.44.1345.829268'
        , '01-08-2004',
        , 'SA_REP'
        , 9000
        , .35
        , 146
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 159
        , 'Lindsey'
        , 'Smith'
        , 'LSMITH'
        , '011.44.1345.729268'
        , '10-03-2005',
        , 'SA_REP'
        , 8000
        , .3
        , 146
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 160
        , 'Louise'
        , 'Doran'
        , 'LDORAN'
        , '011.44.1345.629268'
        , '15-12-2005',
        , 'SA_REP'
        , 7500
        , .3
        , 146
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 161
        , 'Sarath'
        , 'Sewall'
        , 'SSEWALL'
        , '011.44.1345.529268'
        , '03-11-2006',
        , 'SA_REP'
        , 7000
        , .25
        , 146
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 162
        , 'Clara'
        , 'Vishney'
        , 'CVISHNEY'
        , '011.44.1346.129268'
        , '11-11-2005',
        , 'SA_REP'
        , 10500
        , .25
        , 147
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 163
        , 'Danielle'
        , 'Greene'
        , 'DGREENE'
        , '011.44.1346.229268'
        , '19-03-2007',
        , 'SA_REP'
        , 9500
        , .15
        , 147
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 164
        , 'Mattea'
        , 'Marvins'
        , 'MMARVINS'
        , '011.44.1346.329268'
        , '24-01-2008',
        , 'SA_REP'
        , 7200
        , .10
        , 147
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 165
        , 'David'
        , 'Lee'
        , 'DLEE'
        , '011.44.1346.529268'
        , '23-02-2008',
        , 'SA_REP'
        , 6800
        , .1
        , 147
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 166
        , 'Sundar'
        , 'Ande'
        , 'SANDE'
        , '011.44.1346.629268'
        , '24-03-2008',
        , 'SA_REP'
        , 6400
        , .10
        , 147
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 167
        , 'Amit'
        , 'Banda'
        , 'ABANDA'
        , '011.44.1346.729268'
        , '21-04-2008',
        , 'SA_REP'
        , 6200
        , .10
        , 147
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 168
        , 'Lisa'
        , 'Ozer'
        , 'LOZER'
        , '011.44.1343.929268'
        , '11-03-2005',
        , 'SA_REP'
        , 11500
        , .25
        , 148
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 169  
        , 'Harrison'
        , 'Bloom'
        , 'HBLOOM'
        , '011.44.1343.829268'
        , '23-03-2006',
        , 'SA_REP'
        , 10000
        , .20
        , 148
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 170
        , 'Tayler'
        , 'Fox'
        , 'TFOX'
        , '011.44.1343.729268'
        , '24-01-2006',
        , 'SA_REP'
        , 9600
        , .20
        , 148
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 171
        , 'William'
        , 'Smith'
        , 'WSMITH'
        , '011.44.1343.629268'
        , '23-02-2007',
        , 'SA_REP'
        , 7400
        , .15
        , 148
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 172
        , 'Elizabeth'
        , 'Bates'
        , 'EBATES'
        , '011.44.1343.529268'
        , '24-03-2007',
        , 'SA_REP'
        , 7300
        , .15
        , 148
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 173
        , 'Sundita'
        , 'Kumar'
        , 'SKUMAR'
        , '011.44.1343.329268'
        , '21-04-2008',
        , 'SA_REP'
        , 6100
        , .10
        , 148
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 174
        , 'Ellen'
        , 'Abel'
        , 'EABEL'
        , '011.44.1644.429267'
        , '11-05-2004',
        , 'SA_REP'
        , 11000
        , .30
        , 149
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 175
        , 'Alyssa'
        , 'Hutton'
        , 'AHUTTON'
        , '011.44.1644.429266'
        , '19-03-2005',
        , 'SA_REP'
        , 8800
        , .25
        , 149
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 176
        , 'Jonathon'
        , 'Taylor'
        , 'JTAYLOR'
        , '011.44.1644.429265'
        , '24-03-2006',
        , 'SA_REP'
        , 8600
        , .20
        , 149
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 177
        , 'Jack'
        , 'Livingston'
        , 'JLIVINGS'
        , '011.44.1644.429264'
        , '23-04-2006',
        , 'SA_REP'
        , 8400
        , .20
        , 149
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 178
        , 'Kimberely'
        , 'Grant'
        , 'KGRANT'
        , '011.44.1644.429263'
        , '24-05-2007',
        , 'SA_REP'
        , 7000
        , .15
        , 149
        , NULL
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 179
        , 'Charles'
        , 'Johnson'
        , 'CJOHNSON'
        , '011.44.1644.429262'
        , '04-01-2008',
        , 'SA_REP'
        , 6200
        , .10
        , 149
        , 80
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 180
        , 'Winston'
        , 'Taylor'
        , 'WTAYLOR'
        , '650.507.9876'
        , '24-01-2006',
        , 'SH_CLERK'
        , 3200
        , NULL
        , 120
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 181
        , 'Jean'
        , 'Fleaur'
        , 'JFLEAUR'
        , '650.507.9877'
        , '23-02-2006',
        , 'SH_CLERK'
        , 3100
        , NULL
        , 120
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 182
        , 'Martha'
        , 'Sullivan'
        , 'MSULLIVA'
        , '650.507.9878'
        , '21-06-2007',
        , 'SH_CLERK'
        , 2500
        , NULL
        , 120
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 183
        , 'Girard'
        , 'Geoni'
        , 'GGEONI'
        , '650.507.9879'
        , '03-02-2008',
        , 'SH_CLERK'
        , 2800
        , NULL
        , 120
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 184
        , 'Nandita'
        , 'Sarchand'
        , 'NSARCHAN'
        , '650.509.1876'
        , '27-01-2004',
        , 'SH_CLERK'
        , 4200
        , NULL
        , 121
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 185
        , 'Alexis'
        , 'Bull'
        , 'ABULL'
        , '650.509.2876'
        , '20-02-2005',
        , 'SH_CLERK'
        , 4100
        , NULL
        , 121
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 186
        , 'Julia'
        , 'Dellinger'
        , 'JDELLING'
        , '650.509.3876'
        , '24-06-2006',
        , 'SH_CLERK'
        , 3400
        , NULL
        , 121
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 187
        , 'Anthony'
        , 'Cabrio'
        , 'ACABRIO'
        , '650.509.4876'
        , '07-02-2007',
        , 'SH_CLERK'
        , 3000
        , NULL
        , 121
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 188
        , 'Kelly'
        , 'Chung'
        , 'KCHUNG'
        , '650.505.1876'
        , '14-06-2005',
        , 'SH_CLERK'
        , 3800
        , NULL
        , 122
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 189
        , 'Jennifer'
        , 'Dilly'
        , 'JDILLY'
        , '650.505.2876'
        , '13-08-2005',
        , 'SH_CLERK'
        , 3600
        , NULL
        , 122
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 190
        , 'Timothy'
        , 'Gates'
        , 'TGATES'
        , '650.505.3876'
        , '11-07-2006',
        , 'SH_CLERK'
        , 2900
        , NULL
        , 122
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 191
        , 'Randall'
        , 'Perkins'
        , 'RPERKINS'
        , '650.505.4876'
        , '19-12-2007',
        , 'SH_CLERK'
        , 2500
        , NULL
        , 122
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 192
        , 'Sarah'
        , 'Bell'
        , 'SBELL'
        , '650.501.1876'
        , '04-02-2004',
        , 'SH_CLERK'
        , 4000
        , NULL
        , 123
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 193
        , 'Britney'
        , 'Everett'
        , 'BEVERETT'
        , '650.501.2876'
        , '03-03-2005',
        , 'SH_CLERK'
        , 3900
        , NULL
        , 123
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 194
        , 'Samuel'
        , 'McCain'
        , 'SMCCAIN'
        , '650.501.3876'
        , '01-07-2006',
        , 'SH_CLERK'
        , 3200
        , NULL
        , 123
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 195
        , 'Vance'
        , 'Jones'
        , 'VJONES'
        , '650.501.4876'
        , '17-03-2007',
        , 'SH_CLERK'
        , 2800
        , NULL
        , 123
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 196
        , 'Alana'
        , 'Walsh'
        , 'AWALSH'
        , '650.507.9811'
        , '24-04-2006',
        , 'SH_CLERK'
        , 3100
        , NULL
        , 124
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 197
        , 'Kevin'
        , 'Feeney'
        , 'KFEENEY'
        , '650.507.9822'
        , '23-05-2006',
        , 'SH_CLERK'
        , 3000
        , NULL
        , 124
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 198
        , 'Donald'
        , 'OConnell'
        , 'DOCONNEL'
        , '650.507.9833'
        , '21-06-2007',
        , 'SH_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 199
        , 'Douglas'
        , 'Grant'
        , 'DGRANT'
        , '650.507.9844'
        , '13-01-2008',
        , 'SH_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 200
        , 'Jennifer'
        , 'Whalen'
        , 'JWHALEN'
        , '515.123.4444'
        , '17-09-2003',
        , 'AD_ASST'
        , 4400
        , NULL
        , 101
        , 10
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 201
        , 'Michael'
        , 'Hartstein'
        , 'MHARTSTE'
        , '515.123.5555'
        , '17-02-2004',
        , 'MK_MAN'
        , 13000
        , NULL
        , 100
        , 20
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 202
        , 'Pat'
        , 'Fay'
        , 'PFAY'
        , '603.123.6666'
        , '17-08-2005',
        , 'MK_REP'
        , 6000
        , NULL
        , 201
        , 20
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 203
        , 'Susan'
        , 'Mavris'
        , 'SMAVRIS'
        , '515.123.7777'
        , '07-06-2002',
        , 'HR_REP'
        , 6500
        , NULL
        , 101
        , 40
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 204
        , 'Hermann'
        , 'Baer'
        , 'HBAER'
        , '515.123.8888'
        , '07-06-2002',
        , 'PR_REP'
        , 10000
        , NULL
        , 101
        , 70
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 205
        , 'Shelley'
        , 'Higgins'
        , 'SHIGGINS'
        , '515.123.8080'
        , '07-06-2002',
        , 'AC_MGR'
        , 12008
        , NULL
        , 101
        , 110
        );

INSERT INTO hr.employees (id_empregados, nome, email, telefone, data_contratacao, id_cargo, salario, id_departamento, id_supervisor) VALUES 
        ( 206
        , 'William'
        , 'Gietz'
        , 'WGIETZ'
        , '515.123.8181'
        , '07-06-2002',
        , 'AC_ACCOUNT'
        , 8300
        , NULL
        , 205
        , 110
        );



INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES (102
       , '13-01-2001',
       , '24-07-2006',
       , 'IT_PROG'
       , 60);

INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES (101
       , '21-09-1997',
       , '27-10-2001',
       , 'AC_ACCOUNT'
       , 110);

INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES (101
       , '28-10-2001',
       , '15-03-2005',
       , 'AC_MGR'
       , 110);

INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES (201
       , '17-02-2004',
       , '19-12-2007',
       , 'MK_REP'
       , 20);

INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES  (114
        , '24-03-2006',
        , '31-12-2007',
        , 'ST_CLERK'
        , 50
        );

INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES  (122
        , '01-01-2007',
        , '31-12-2007',
        , 'ST_CLERK'
        , 50
        );

INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES  (200
        , '17-09-1995',
        , '17-06-2001',
        , 'AD_ASST'
        , 90
        );

INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES  (176
        , '24-03-2006',
        , '31-12-2006',
        , 'SA_REP'
        , 80
        );

INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES  (176
        , '01-01-2007',
        , '31-12-2007',
        , 'SA_MAN'
        , 80
        );

INSERT INTO hr.job_history ( id_empregados, data_inicial, data_final, id_cargo, id_departamento)VALUES
VALUES  (200
        , '01-07-2002',
        , '31-12-2006',
        , 'AC_ACCOUNT'
        , 90
        );