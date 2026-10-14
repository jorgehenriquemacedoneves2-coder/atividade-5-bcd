-- =====================================================
-- BANCO DE DADOS: CLÍNICA MÉDICA VIDA SAUDÁVEL
-- SGBD: MySQL
-- =====================================================

-- 1. CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS clinica_medica_db;

USE clinica_medica_db;

-- =====================================================
-- 2. TABELA DE MÉDICOS
-- =====================================================

CREATE TABLE IF NOT EXISTS medicos (
    id_medico INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),

    CONSTRAINT pk_medicos PRIMARY KEY (id_medico),
    CONSTRAINT uk_medicos_crm UNIQUE (crm),
    CONSTRAINT uk_medicos_email UNIQUE (email)
);

-- =====================================================
-- 3. TABELA DE PACIENTES
-- =====================================================

CREATE TABLE IF NOT EXISTS pacientes (
    id_paciente INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo CHAR(1),
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200),

    CONSTRAINT pk_pacientes PRIMARY KEY (id_paciente),
    CONSTRAINT uk_pacientes_cpf UNIQUE (cpf),
    CONSTRAINT uk_pacientes_email UNIQUE (email),
    CONSTRAINT chk_pacientes_sexo
        CHECK (sexo IN ('M', 'F', 'O') OR sexo IS NULL)
);

-- =====================================================
-- 4. TABELA DE AGENDAMENTOS
-- Relaciona médicos e pacientes
-- =====================================================

CREATE TABLE IF NOT EXISTS agendamentos (
    id_agendamento INT AUTO_INCREMENT,
    id_medico INT NOT NULL,
    id_paciente INT NOT NULL,
    data_hora DATETIME NOT NULL,
    motivo VARCHAR(255),
    status ENUM(
        'Agendado',
        'Confirmado',
        'Realizado',
        'Cancelado'
    ) NOT NULL DEFAULT 'Agendado',

    CONSTRAINT pk_agendamentos
        PRIMARY KEY (id_agendamento),

    CONSTRAINT fk_agendamentos_medicos
        FOREIGN KEY (id_medico)
        REFERENCES medicos (id_medico)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_agendamentos_pacientes
        FOREIGN KEY (id_paciente)
        REFERENCES pacientes (id_paciente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT uk_medico_data_hora
        UNIQUE (id_medico, data_hora)
);

-- =====================================================
-- 5. ÍNDICES PARA CONSULTAS
-- =====================================================

CREATE INDEX idx_agendamentos_paciente
    ON agendamentos (id_paciente);

CREATE INDEX idx_agendamentos_data_hora
    ON agendamentos (data_hora);

-- =====================================================
-- 6. VISUALIZAR AS TABELAS CRIADAS
-- =====================================================

SHOW TABLES;

-- Conferir a estrutura das tabelas
DESCRIBE medicos;
DESCRIBE pacientes;
DESCRIBE agendamentos;

-- =====================================================
-- FIM DO SCRIPT
-- =====================================================
