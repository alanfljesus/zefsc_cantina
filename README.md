# Sistema de Cadastro de Cantinas e Refeições

## Descrição do Projeto

Este projeto visa desenvolver um sistema de cadastro e controle de refeições em cantinas para uma empresa que possui várias unidades. Cada unidade tem uma cantina que oferece refeições para colaboradores locais e visitantes de outras unidades. O sistema permitirá o cadastro de cantinas, horários e valores das refeições, bem como o registro de refeições realizadas por colaboradores. Além disso, o sistema fornecerá relatórios detalhados sobre o consumo e os custos associados às refeições.

## Funcionalidades

### 1. Cadastro de Colaborador (Z<INICIAIS>R_CANTINA_COLABORADOR)
Permite o cadastro de colaboradores, onde são registrados o número do crachá, CPF, nome completo e centro de custo. A tela de cadastro apresenta uma interface ALV (Active List Viewer) onde os dados podem ser visualizados e editados.

#### Regras:
- Não permitir cadastro de dois IDs de colaboradores idênticos.
- CPF deve ser salvo sem os pontos.
- Validação do centro de custo informado (Tabela T001W-WERKS).
- Todos os campos devem estar preenchidos para salvar o cadastro.

### 2. Cadastro de Cantina (Z<INICIAIS>R_CANTINA_CADASTRO)
Permite o cadastro de cantinas, registrando o código da cantina, o nome da cantina e o centro de custo ao qual está associada. A interface também utiliza ALV para visualização e edição.

#### Regras:
- Código, nome da cantina e centro são obrigatórios.
- Nome da cantina deve ter no mínimo 10 caracteres.
- Validação do centro de custo informado (Tabela T001W-WERKS).

### 3. Cadastro de Horário/Valor de Refeição (Z<INICIAIS>R_CANTINA_VALOR)
Registra os horários e valores das refeições oferecidas pelas cantinas. A interface permite ao usuário visualizar e editar os dados em uma tela ALV.

#### Regras:
- Todos os campos devem estar preenchidos.
- O campo de seleção na tela deve ser obrigatório e de valor único.
- Inserção automática dos tipos de refeições ao adicionar uma nova linha no ALV.
- Código e nome da cantina, bem como o tipo de refeição, são de exibição e preenchidos automaticamente.
- O nome da cantina não é salvo nesta tabela, mas o código é usado para vinculação.

### 4. Cadastro de Refeições (Z<INICIAIS>R_CANTINA_REFEICAO)
Registra as refeições realizadas pelos colaboradores, incluindo o tipo de refeição, horário, valor, ID do colaborador, centro de custo e cantina onde a refeição foi realizada.

#### Regras:
- O valor da refeição deve ser buscado da tabela de cadastro de horários/valores.

### 5. Relatório de Refeições
Gera relatórios detalhados sobre as refeições realizadas, contabilizando o número de refeições por tipo e o custo total por colaborador e centro de custo.

## Estrutura das Tabelas

### Tabelas Principais

- **Z<INICIAIS>R_CANTINA_COLABORADOR**: Cadastro de colaboradores.
- **Z<INICIAIS>R_CANTINA_CADASTRO**: Cadastro de cantinas.
- **Z<INICIAIS>R_CANTINA_VALOR**: Cadastro de horários e valores de refeições.
- **Z<INICIAIS>R_CANTINA_REFEICAO**: Registro de refeições realizadas.

### Campos Comuns

Todas as tabelas devem conter os campos:
- **DATA_CRIAÇÃO**: Data de criação do registro.
- **DATA_MODIFICAÇÃO**: Data de modificação do registro.
