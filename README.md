# Lista de Produto

Teste prático desenvolvido em Flutter utilizando Clean Architecture, Bloc, Dio, GetIt + Injectable, GoRouter, Hive e Flutter Secure Storage.

O projeto consome a API pública:

https://fakestoreapi.com/

---

# Tecnologias Utilizadas

* Flutter 3.27.1
* Dart 3.6.0
* Bloc
* Clean Architecture (Feature First)
* Dio
* GoRouter
* GetIt
* Injectable
* Flutter Secure Storage
* Hive
* Flutter Test
* Mockito
* Integration Test
* Intl (i18n/l10n)

---

# Estrutura Arquitetural

O projeto foi desenvolvido utilizando:

* Clean Architecture Feature First
* Separação em:
  * Data
  * Domain
  * Presentation

---

# Funcionalidades Implementadas

## Login

* Validação de e-mail
* Validação de senha obrigatória
* Armazenamento de token fake utilizando Flutter Secure Storage
* Redirecionamento automático após login

---

## Produtos

* Listagem de produtos consumindo:
  GET https://fakestoreapi.com/products

* Detalhe do produto:
  GET https://fakestoreapi.com/products/{id}

* Estados tratados:

  * Loading
  * Error
  * Empty
  * Success

* Retry em falha de rede

* Navegação para detalhe do produto

---

## Logout

* Remoção do token do Secure Storage
* Redirecionamento para login

---

# Todos Requisitos Obrigatórios Implementados

## Clean Architecture

Projeto estruturado em:

* data
* domain
* presentation

---

## Bloc

Gerenciamento de estado utilizando Bloc.

Foram implementados:

* AuthBloc
* ProductsBloc
* ProductDetailBloc

---

## Dio + Interceptors

Implementado:

* Logging interceptor
* Auth interceptor
* Retry interceptor

---

## GoRouter

* Rotas protegidas
* Redirect automático baseado em autenticação

---

## Injeção de Dependência

Utilizado:

* GetIt
* Injectable

---

## Persistência

### Flutter Secure Storage

Utilizado para persistir token de autenticação.

### Hive

Implementado cache local da lista de produtos.

Quando offline:

* exibe cache salvo localmente.

---

## Internacionalização

Implementado suporte para:

* PT-BR
* EN

---

## Acessibilidade

Aplicado:

* Semantics
* Estrutura acessível nos widgets principais

---

# Testes

## Testes Unitários

Implementados testes para:

* AuthBloc
* ProductsBloc
* ProductDetailBloc

---

## Testes de Widget

Implementados testes para:

* LoginPage
* ProductsPage

---

## Integration Test


* integration_test

Devido ao prazo  para entrega do desafio, o fluxo completo de `integration_test` não foi finalizado, por se tratar de um requisito desejável (não eliminatório).

Porém, todos os testes obrigatórios solicitados foram implementados, incluindo:

* Testes unitários dos Blocs
* Testes de Widget das principais telas
* Cobertura dos fluxos principais da aplicação

---


# Flavors

Foram implementados ambientes:

* dev
* prod

---

# Como Rodar o Projeto

## Instalar dependências

```bash
flutter pub get
```

---

## Gerar arquivos do Injectable / Hive

```bash
dart run build_runner build --delete-conflicting-outputs
```

ou

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

# Rodar Ambiente DEV

```bash
flutter run -t lib/app/flavors/main_dev.dart
```

---

# Rodar Ambiente PROD

```bash
flutter run -t lib/app/flavors/main_prod.dart
```

---

# Rodar Testes

## Todos os testes

```bash
flutter test
```
<img src="https://i.ibb.co/wNLPSgBn/Captura-de-Tela-2026-05-28-a-s-15-38-28.png" width="400"/>

---

# Versão Utilizada

| Flutter | Channel | Dart  | Release      |
| ------- | ------- | ----- | ------------ |
| 3.27.1  | stable  | 3.6.0 | Dec 16, 2024 |

---

# Pritins do APP - LoginPage

<img src="https://i.ibb.co/kVsP8nQ3/Captura-de-Tela-2026-05-28-a-s-15-41-08.png" width="128"/>


---

# Pritins do APP - Produto

<img src="https://i.ibb.co/hx3M3638/Captura-de-Tela-2026-05-28-a-s-15-42-31.png" width="128"/>


---

---

# Pritins do APP - Detalhes

<img src="https://i.ibb.co/93bZgTvC/Captura-de-Tela-2026-05-28-a-s-15-43-11.png" width="128"/>


---
