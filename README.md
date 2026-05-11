# 🌀 Sistema Poderes

Um sistema desktop desenvolvido em Delphi para gerenciamento de superpoderes, com cadastro, pesquisa, importação e exportação de dados em CSV.

---

## 📋 Sobre o Projeto

| Aspecto | Descrição |
|--------|-----------|
| **Desafio** | Lista de Superpoderes |
| **Entrada** | CSV |
| **Saída** | CSV |

O sistema possibilita organizar poderes por categorias e níveis de poder, além de apresentar estatísticas em um dashboard interativo.

---

## 🛠️ Tecnologias Utilizadas

-  **Delphi / Object Pascal**
-  **VCL** (Visual Component Library)
-  **FireDAC** (Data Access Layer)
-  **SQL Server 2014**
-  **SQL Server Management Studio (SSMS)**

---

## 💻 Como Executar

### 📦 1. Pré-requisitos

Antes de executar o sistema, certifique-se de ter instalado:

-  SQL Server 2014 ou superior

### 🔧 2. Configurar o arquivo `config.ini`

O arquivo `config.ini` deve permanecer na **mesma pasta** do `Desafio.exe`.

**Exemplo de configuração:**

```ini
[Conexao]
DriverID=MSSQL
Server=SERVIDOR\SQLEXPRESS
Database=SuperPoderes
OSAuthent=Yes
User_Name=sa
Password=123
```

**Descrição dos campos:**

| Campo | Descrição |
|-------|-----------|
| `DriverID` | Tipo do banco de dados |
| `Server` | Nome do servidor SQL |
| `Database` | Nome do banco de dados |
| `OSAuthent` | Autenticação do Windows |
| `User_Name` | Usuário do SQL Server |
| `Password` | Senha do SQL Server |

### ▶️ 3. Executar o Sistema

1. Abra a pasta do sistema
2. Execute o arquivo `Desafio.exe`
3. O sistema conectará automaticamente ao banco de dados 🎉

---

## 📂 Estrutura do Projeto

```
SistemaPoderes/
│
├── Desafio.exe
├── config.ini
├── grid_padrao.ini
└── SQL/
    └── Poderes.sql
```

---

## 🗂️ Importar/Exportar Dados

### 📥 Importação CSV

O sistema permite importar superpoderes através de arquivos CSV.

**Formato esperado:**

```csv
nome;descricao;categoria;nivel
Telecinese;Mover objetos com a mente;Mental;Avançado
Super Força;Força acima do normal;Física;Intermediário
```

**Passos para importar:**

1. Abrir o sistema
2. Selecionar a opção de importação.
3. Escolher o arquivo CSV.
4. Confirmar a importação.

### 📤 Exportação CSV

O sistema exporta os dados cadastrados em formato CSV.

**Passos para exportar:**

1. Abrir o sistema.
2. Selecionar a opção de exportação.
3. Escolher o local para salvar.
4. Confirmar a exportação.

---

## ✨ Funcionalidades

-  Cadastro de Poderes.
-  Cadastro de Categorias.
-  Cadastro de Níveis de Poder.
-  Pesquisa de registros.
-  Dashboard com estatísticas.
-  Importação de CSV.
-  Exportação de CSV.
-  Navegação por atalhos de teclado.
-  Grid configurável.
-  Interface personalizada.

---

## ⌨️ Atalhos de Teclado

| Tecla | Função |
|-------|---------|
| **F9** | Cadastro de Poderes |
| **F5** | Cadastro de Categorias |
| **F2** | Cadastro de Níveis |
| **Enter** | Navegação entre campos do grid |

---

## ⚙️ Distribuição

O sistema pode ser executado **sem Delphi instalado**.

**Necessário apenas:**
-  SQL Server instalado.
-  Arquivo `config.ini` configurado corretamente e na **mesma pasta** do `Desafio.exe`.

---

## 👩🏻‍💻 Desenvolvido por

**kawanydb**

