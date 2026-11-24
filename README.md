# Grão & Prosa (Flutter)

Aplicativo da cafeteria Grão & Prosa, feito a partir do protótipo do Marvel.
Telas: **Início**, **Cardápio** e **Contato**.

## Como rodar
```
flutter create . --platforms=android,ios
flutter pub get
flutter run
```
`flutter create .` gera as pastas android/ios sem apagar `lib/`. As fontes
(Fraunces e DM Sans) são baixadas na primeira execução, então é preciso internet.

## Como testar
```
flutter test
```
Checklist manual em `docs/TESTES.md`.

## Estrutura
- `lib/theme.dart` — cores e fontes
- `lib/data/menu_data.dart` — produtos e categorias (edite aqui preços e itens)
- `lib/models/product.dart` — modelo de produto
- `lib/services/message_db.dart` — mensagens do Contato em SQLite
- `lib/screens/` — `shell.dart` (navegação, menu lateral e barra inferior), `home_screen.dart`, `menu_screen.dart`, `contact_screen.dart`
- `test/app_test.dart` — testes de interface
- `docs/` — plano de testes e roteiro da apresentação

## Critérios de conclusão do cronograma
| Critério | Onde está |
| --- | --- |
| 1. Início integrado ao cardápio | botão "Ver cardápio", barra inferior e menu lateral (`shell.dart`) |
| 2. Produtos com nome, descrição e preço | `menu_screen.dart` e `menu_data.dart` |
| 3. Filtros de categoria | chips Todos, Cafés e Salgados (`menu_screen.dart`) |
| 4. Navegação entre telas | `shell.dart` |
| 5. Consistência com o protótipo | `theme.dart`; conferir com o Marvel (Dia 9 e 14) |
| 6. Testes essenciais | `test/app_test.dart` e `docs/TESTES.md` |
| 7. Documentação e apresentação | este README e `docs/APRESENTACAO.md` |

## Pendências
- Trocar os preços de exemplo pelos reais.
- Conferir cores e fontes com o protótipo e ajustar em `theme.dart`.
- Menu lateral: o protótipo não mostra o conteúdo dele; usei Início, Cardápio e Contato.

