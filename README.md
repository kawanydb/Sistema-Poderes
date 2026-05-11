# Sistema Poderes

## Objetivo

Sistema desktop desenvolvido em Delphi para gerenciamento de superpoderes, permitindo cadastro, pesquisa, importação e exportação de dados.

- Desafio: Lista de Superpoderes
- Entrada: CSV
- Saída: CSV

O sistema possibilita organizar poderes por categorias e níveis de poder, além de apresentar estatísticas em dashboard.

---

## Tecnologias Utilizadas

- Delphi / Object Pascal
- VCL
- FireDAC
- SQL Server 2014
- SQL Server Management Studio (SSMS)

---

## Como Executar

### 1. Configurar o banco de dados

Abra o SQL Server Management Studio e execute o arquivo:

```txt
sql/database.sql
```

### 2. Configurar o arquivo config.ini

Exemplo:

```ini
[Conexao]
DriverID=MSSQL
Server=SERVIDOR\SQLEXPRESS
Database=SuperPoderes
OSAuthent=Yes
User_Name=sa
Password=123
```

### 3. Executar o sistema

Abra o arquivo:

```txt
Desafio.exe
```

---

## Estrutura do Projeto

```txt
SistemaPoderes/
│
├── Desafio.exe
├── config.ini
├── grid_padrao.ini
└── sql/
    └── database.sql
```

---

## Como Importar/Exportar Dados

### Importação CSV

O sistema permite importar poderes através de arquivos CSV.

Formato esperado:

```csv
nome;descricao;categoria;nivel
Telecinese;Mover objetos com a mente;Mental;Avançado
Super Força;Força acima do normal;Física;Intermediário
```

### Passos para importar

1. Abrir o sistema
2. Selecionar a opção de importação
3. Escolher o arquivo CSV
4. Confirmar a importação

---

### Exportação CSV

O sistema exporta os dados cadastrados em formato CSV.

### Passos para exportar

1. Abrir o sistema
2. Selecionar a opção de exportação
3. Escolher o local para salvar
4. Confirmar a exportação

---

## Funcionalidades

- Cadastro de Poderes
- Cadastro de Categorias
- Cadastro de Níveis de Poder
- Pesquisa de registros
- Dashboard com estatísticas
- Importação de CSV
- Exportação de CSV
- Navegação por atalhos de teclado
- Grid configurável
- Interface personalizada

---

## Atalhos

| Tecla | Função |
|------|---------|
| F9 | Cadastro de Poderes |
| F5 | Cadastro de Categorias |
| F2 | Cadastro de Níveis |
| Enter | Navegação entre campos |

---

## Distribuição

O sistema pode ser executado sem Delphi instalado.

Necessário apenas:
- SQL Server configurado
- Banco criado
- Arquivo `config.ini` configurado corretamente

---

## Autor

kawanydb
