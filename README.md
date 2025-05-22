# Documentação do Projeto LaMafia: Federação

## Visão Geral
O aplicativo LaMafia: Federação é uma plataforma exclusiva para gerenciamento do clã, com funcionalidades de autenticação, sistema de ponto, mapa tático, relatórios, estrutura hierárquica e muito mais.

## Estrutura do Projeto
O projeto foi desenvolvido em Flutter e segue a seguinte estrutura:

```
lamafiacla/
├── lib/
│   ├── main.dart                  # Ponto de entrada do aplicativo
│   ├── models/                    # Modelos de dados
│   │   └── user_model.dart        # Modelo de usuário com cargos sinistros
│   ├── providers/                 # Gerenciamento de estado
│   │   └── user_provider.dart     # Provider para autenticação e dados do usuário
│   ├── screens/                   # Telas do aplicativo
│   │   ├── splash_screen.dart     # Tela de abertura animada
│   │   ├── login_screen.dart      # Tela de login com ID e PIN
│   │   ├── dashboard_screen.dart  # Tela principal com acesso aos módulos
│   │   ├── identidade_screen.dart # Perfil do usuário
│   │   ├── mapa_tatico_screen.dart # Mapa interativo da Fortaleza Kairo
│   │   ├── relatorio_screen.dart  # Sistema de relatórios e testes ALRO
│   │   ├── estrutura_screen.dart  # Hierarquia e cargos sinistros
│   │   ├── fotos_screen.dart      # Sistema de envio de fotos e evidências
│   │   └── admin_screen.dart      # Painel administrativo exclusivo
│   └── utils/                     # Utilitários
│       └── theme_constants.dart   # Constantes de tema e estilo visual
├── assets/                        # Recursos
│   ├── images/                    # Imagens e logo
│   └── audio/                     # Sons e efeitos sonoros
└── pubspec.yaml                   # Configuração do projeto e dependências
```

## Funcionalidades Principais

### 1. Autenticação
- Login com ID de jogador e PIN de 4 dígitos
- Tratamento especial para o usuário "idcloned" (acesso administrativo sem PIN)
- Persistência de sessão

### 2. Sistema de Ponto
- Abertura e fechamento de ponto
- Registro de data, hora e status
- Histórico de atividades

### 3. Identidade
- Perfil do usuário com dados pessoais
- Exibição do cargo sinistro e nível de acesso
- Histórico de atividades

### 4. Mapa Tático
- Visualização da Fortaleza Kairo
- Pontos estratégicos interativos
- Edição de pontos (para usuários com permissão)

### 5. Relatórios
- Criação de relatórios de missões, atividades e incidentes
- Teste ALRO (Avaliação de Lealdade e Relatório Operacional)
- Histórico de relatórios enviados

### 6. Estrutura
- Visualização da hierarquia do clã
- Detalhes sobre cargos sinistros e suas responsabilidades
- Níveis de acesso e permissões

### 7. Fotos e Evidências
- Envio de fotos categorizadas
- Visualização de evidências por categoria
- Detalhes e metadados das imagens

### 8. Painel Administrativo
- Exclusivo para o usuário "idcloned"
- Modo Alerta para notificações de emergência
- Gerenciamento de membros, cargos e permissões
- Estatísticas do clã

## Estilo Visual
O aplicativo segue um estilo visual sombrio e elegante, com as seguintes características:
- Cores predominantes: preto, vermelho-escuro, cinza metálico
- Elementos de interface com bordas arredondadas e sombras
- Tipografia estilo digital/terminal/serifada gótica
- Ícones minimalistas e sombrios

## Compilação e Execução
Para compilar o projeto:
1. Certifique-se de ter o Flutter instalado (versão 3.0.0 ou superior)
2. Execute `flutter pub get` para instalar as dependências
3. Execute `flutter build apk --release` para gerar o APK de release

## Observações Importantes
- O usuário "idcloned" tem acesso total a todas as funcionalidades
- Os cargos sinistros têm diferentes níveis de permissão no sistema
- O aplicativo utiliza SharedPreferences para armazenamento local de dados
- A integração com Firebase está preparada para autenticação e armazenamento de dados
