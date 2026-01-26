# Documentacao completa do projeto "Fokus"

Este documento explica a estrutura, o fluxo e os arquivos principais do projeto
Flutter "Fokus", com foco em entendimento rapido e manutencao.

---

## 1) Visao geral

O projeto e um app Flutter com uma tela inicial (Home) que apresenta:
- logo e imagem principal
- tres botoes: Modo Foco, Pausa Curta, Pausa Longa
- rodape com texto institucional

Ha uma tela de timer (TimerPage) que recebe um "tipo de timer" e exibe:
- imagem correspondente
- titulo do modo
- widget de timer (TimerWidget)
- rodape

No estado atual, os botoes da Home estao com `TODO` (nao navegam) e o timer
mostra "00:00" sem contar tempo (somente interface).

---

## 2) Estrutura de pastas

```
lib/
  main.dart
  app/
    app.dart
    enums/
      timer_type.dart
    pages/
      home_page.dart
      timer_page.dart
    utils/
      app_config.dart
    widgets/
      timer_widget.dart
assets/
  logo.png
  home.png
  focus.png
  pause.png
  long.png
```

---

## 3) Arquivos principais e responsabilidades

### `lib/main.dart`
Ponto de entrada do app. Executa:
```dart
runApp(const App());
```

### `lib/app/app.dart`
Configura o `MaterialApp`:
- `title: 'Fokus'`
- tema com `useMaterial3: true`
- fontes via `google_fonts` (Unbounded)
- `home: HomePage`

### `lib/app/pages/home_page.dart`
Tela inicial:
- `Scaffold` com cor de fundo definida em `AppConfig`
- logo e imagem principal
- tres botoes (nao implementados)
- texto de rodape

Cada botao devera futuramente navegar para a `TimerPage` com um tipo diferente:
- Modo Foco -> `TimerType.focus`
- Pausa Curta -> `TimerType.shortBreak`
- Pausa Longa -> `TimerType.longBreak`

### `lib/app/pages/timer_page.dart`
Tela que recebe um `TimerType` por construtor:
- mostra imagem e titulo do tipo selecionado
- renderiza `TimerWidget`
- mostra rodape

### `lib/app/widgets/timer_widget.dart`
Widget de timer (UI):
- container estilizado com borda e fundo transluscido
- texto fixo "00:00"
- botao "Iniciar"

Ainda nao ha logica de contagem regressiva. Quando for implementada, esta
classe vai precisar de:
- `Timer` do dart:async
- estado para minutos/segundos atuais
- controle de play/pause/stop

### `lib/app/enums/timer_type.dart`
Enum que centraliza configuracoes dos modos:
```dart
focus('Modo Foco', 25, 'assets/focus.png')
shortBreak('Pausa Curta', 5, 'assets/pause.png')
longBreak('Pausa Longa', 15, 'assets/long.png')
```
Cada item possui:
- `title` (texto a mostrar)
- `minutes` (duracao inicial)
- `imageName` (asset)

### `lib/app/utils/app_config.dart`
Constantes globais do app:
- duracoes padrao (minutos)
- cores de tema
- textos e strings (titulos e rodape)
- caminhos de assets

---

## 4) Dependencias e configuracoes

### `pubspec.yaml`
Dependencias principais:
- `flutter`
- `google_fonts`
- `cupertino_icons`

Assets registrados:
```
assets/logo.png
assets/home.png
assets/focus.png
assets/pause.png
assets/long.png
```

Se algum asset nao aparecer, verifique:
- nomes corretos
- `flutter pub get`
- `flutter clean` e rodar novamente

---

## 5) Fluxo de telas (navegacao)

Fluxo esperado:
```
HomePage
  |-- Modo Foco  -> TimerPage(timerType: TimerType.focus)
  |-- Pausa Curta -> TimerPage(timerType: TimerType.shortBreak)
  |-- Pausa Longa -> TimerPage(timerType: TimerType.longBreak)
```

Obs: isso ainda nao esta implementado nos botoes da Home.

---

## 6) Tema e estilo

O tema e definido em `App`:
- `useMaterial3: true`
- `textTheme` pelo `GoogleFonts.unboundedTextTheme()`

As cores principais ficam em `AppConfig`:
- `backgroundColor`: fundo principal
- `buttonColor`: botoes

---

## 7) Como rodar (resumo rapido)

```powershell
flutter pub get
flutter run
```

No Windows, ative o Modo do Desenvolvedor para suportar symlinks:
```powershell
start ms-settings:developers
```

---

## 8) Ponto de extensao (proximos passos tipicos)

1. Navegacao:
   - Implementar `Navigator.push` nos botoes da Home.

2. Logica do Timer:
   - Criar estado com minutos/segundos correntes.
   - Usar `Timer.periodic` para decrementar.
   - Botao alternar entre "Iniciar", "Pausar", "Continuar".
   - Quando chegar em 00:00, disparar alerta/animacao.

3. Estado global (opcional):
   - Se precisar compartilhar timer entre telas, usar provider/riverpod/bloc.

4. Acessibilidade e testes:
   - Adicionar `Key` em botoes para teste.
   - Criar testes de widget para Home e Timer.

---

## 9) Troubleshooting rapido

**App nao abre / ANR no emulador**
- Reinicie o emulador (Cold Boot / Wipe Data).
- `flutter clean` -> `flutter pub get` -> `flutter run`.

**Erro de "device offline"**
- `adb kill-server` e `adb start-server`.

**Assets nao aparecem**
- confira `pubspec.yaml` e nomes.
- `flutter pub get` e reinicie o app.

---

## 10) Mapa rapido de dependencia entre arquivos

```
main.dart
  -> app/app.dart
      -> pages/home_page.dart
          -> utils/app_config.dart
      -> pages/timer_page.dart
          -> enums/timer_type.dart
          -> widgets/timer_widget.dart
          -> utils/app_config.dart
      -> google_fonts
```

---

## 11) Resumo final

O projeto ja tem:
- UI principal pronta
- assets configurados
- enum de tipos de timer

Faltam:
- navegacao entre telas
- logica real de contagem do timer

Se quiser, posso:
- implementar a navegacao
- montar o timer funcional com play/pause/stop
*** End Patch}
