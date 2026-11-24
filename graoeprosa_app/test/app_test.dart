import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graoeprosa_app/main.dart';
import 'package:graoeprosa_app/theme.dart';

Future<void> openApp(WidgetTester t, {Size size = const Size(390, 844)}) async {
  t.view.physicalSize = size;
  t.view.devicePixelRatio = 1.0;
  addTearDown(t.view.reset);
  await t.pumpWidget(const GraoEProsaApp());
  await t.pumpAndSettle();
}

void main() {
  setUpAll(() => useWebFonts = false);

  group('Tela inicial', () {
    testWidgets('mostra banner, botão e destaques', (t) async {
      await openApp(t);
      expect(find.text('Grão & Prosa'), findsOneWidget);
      expect(find.text('Café fresco,\ntodo dia.'), findsOneWidget);
      expect(find.text('Ver cardápio'), findsOneWidget);
      expect(find.text('Destaques'), findsOneWidget);
      expect(find.text('Cappuccino'), findsOneWidget);
      expect(find.text('Pão de queijo'), findsOneWidget);
    });

    testWidgets('botão "Ver cardápio" abre o cardápio', (t) async {
      await openApp(t);
      await t.tap(find.text('Ver cardápio'));
      await t.pumpAndSettle();
      expect(find.text('Expresso'), findsOneWidget);
      expect(find.text('Empada de frango'), findsOneWidget);
    });

    testWidgets('ícone de menu abre o drawer e navega', (t) async {
      await openApp(t);
      await t.tap(find.byTooltip('Menu'));
      await t.pumpAndSettle();
      expect(find.byType(Drawer), findsOneWidget);
      await t.tap(find.descendant(of: find.byType(Drawer), matching: find.text('Cardápio')));
      await t.pumpAndSettle();
      expect(find.byType(Drawer), findsNothing);
      expect(find.text('Expresso'), findsOneWidget);
    });
  });

  group('Cardápio', () {
    testWidgets('lista nome, descrição e preço dos produtos', (t) async {
      await openApp(t);
      await t.tap(find.text('Cardápio'));
      await t.pumpAndSettle();
      expect(find.text('Cappuccino'), findsOneWidget);
      expect(find.text('Cremoso e intenso'), findsOneWidget);
      expect(find.text('R\$ 12,00'), findsOneWidget);
    });

    testWidgets('filtros alternam entre Todos, Cafés e Salgados', (t) async {
      await openApp(t);
      await t.tap(find.text('Cardápio'));
      await t.pumpAndSettle();

      await t.tap(find.widgetWithText(ChoiceChip, 'Salgados'));
      await t.pumpAndSettle();
      expect(find.text('Coxinha'), findsOneWidget);
      expect(find.text('Cappuccino'), findsNothing);

      await t.tap(find.widgetWithText(ChoiceChip, 'Cafés'));
      await t.pumpAndSettle();
      expect(find.text('Cappuccino'), findsOneWidget);
      expect(find.text('Coxinha'), findsNothing);

      await t.tap(find.widgetWithText(ChoiceChip, 'Todos'));
      await t.pumpAndSettle();
      expect(find.text('Cappuccino'), findsOneWidget);
      expect(find.text('Coxinha'), findsOneWidget);
    });

    testWidgets('seta de voltar retorna ao início', (t) async {
      await openApp(t);
      await t.tap(find.text('Cardápio'));
      await t.pumpAndSettle();
      await t.tap(find.byIcon(Icons.chevron_left));
      await t.pumpAndSettle();
      expect(find.text('Destaques'), findsOneWidget);
    });
  });

  group('Contato', () {
    testWidgets('mostra horário, endereço e formulário', (t) async {
      await openApp(t);
      await t.tap(find.text('Contato'));
      await t.pumpAndSettle();
      expect(find.text('Horário'), findsOneWidget);
      expect(find.text('Endereço'), findsOneWidget);
      expect(find.text('Enviar'), findsOneWidget);
    });

    testWidgets('pede para preencher os campos antes de enviar', (t) async {
      await openApp(t);
      await t.tap(find.text('Contato'));
      await t.pumpAndSettle();
      await t.tap(find.text('Enviar'));
      await t.pump();
      expect(find.text('Preencha seu nome e a mensagem.'), findsOneWidget);
    });
  });

  group('Responsividade', () {
    for (final size in const [Size(360, 640), Size(390, 844), Size(768, 1024)]) {
      testWidgets('sem overflow em ${size.width.toInt()}x${size.height.toInt()}', (t) async {
        await openApp(t, size: size);
        await t.tap(find.text('Cardápio'));
        await t.pumpAndSettle();
        await t.tap(find.text('Contato'));
        await t.pumpAndSettle();
        expect(tester(t), isNull);
      });
    }
  });
}

// Um overflow de layout lança exceção e já reprova o teste; este helper só
// devolve a exceção pendente (se houver) para deixar a intenção explícita.
Object? tester(WidgetTester t) => t.takeException();
