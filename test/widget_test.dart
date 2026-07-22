import 'package:comprafacil/main.dart';
import 'package:comprafacil/partner_page.dart';
import 'package:comprafacil/store_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the updated WhatsApp number', () {
    expect(mainWhatsappNumber, '5511949896488');
    expect(normalizeWhatsappNumber('(11) 94989-6488'), mainWhatsappNumber);
  });

  test('partner lead message arrives ready to complete', () {
    final message = buildPartnerLeadMessage();

    expect(message, contains('*QUERO SER PARCEIRO — COMPRA FÁCIL*'));
    expect(message, contains('*Nome do negócio:*'));
    expect(message, contains('*Categoria:*'));
    expect(message, contains('*Responsável:*'));
  });

  test('WhatsApp order message carries every customization', () {
    final message = buildWhatsAppOrderMessage(
      storeName: 'Tropical Açaí',
      productName: 'Açaí',
      size: '400 ml',
      flavors: const ['Banana', 'Morango', 'Paçoca'],
      fulfillmentMethod: FulfillmentMethod.delivery,
      customerName: 'Gustavo',
      address: 'Rua Exemplo, 123',
      notes: 'Sem colher\nInterfone 2',
      quantity: 2,
    );

    expect(message, contains('*NOVO PEDIDO — COMPRA FÁCIL*'));
    expect(message, contains('*Loja:* Tropical Açaí'));
    expect(message, contains('*Tamanho:* 400 ml'));
    expect(message, contains('• Banana'));
    expect(message, contains('• Morango'));
    expect(message, contains('• Paçoca'));
    expect(message, contains('*Recebimento:* Entrega'));
    expect(message, contains('*Endereço:* Rua Exemplo, 123'));
    expect(message, contains('> Sem colher\n> Interfone 2'));
  });

  test('new establishments receive a mutable product catalog', () {
    final partner = Partner(
      name: 'Loja de teste',
      category: 'Açaí',
      icon: Icons.storefront,
      whatsapp: mainWhatsappNumber,
    );

    partner.products.add(demoAcaiProduct);

    expect(partner.products, contains(demoAcaiProduct));
  });

  testWidgets('home presents the new brand and shopping categories', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CompraFacilApp());

    expect(find.byKey(const Key('brand-logo')), findsOneWidget);
    expect(find.text('Novidades e ofertas'), findsOneWidget);
    expect(find.text('Pedidos mais simples pelo WhatsApp'), findsOneWidget);
    expect(find.text('O que você procura?'), findsOneWidget);
    expect(find.text('9 categorias'), findsOneWidget);
    expect(find.text('Quero ser um parceiro'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Lanchonete'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Lanchonete'), findsOneWidget);
  });

  testWidgets('promotion carousel advances automatically', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const CompraFacilApp());

    final pageView = tester.widget<PageView>(
      find.byKey(const Key('promotion-carousel')),
    );
    expect(pageView.controller?.page, 0);

    await tester.pump(const Duration(seconds: 5));
    await tester.pump(const Duration(milliseconds: 600));

    expect(pageView.controller?.page, closeTo(1, 0.01));
  });

  testWidgets('partner callout opens benefits and conversion CTA', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const CompraFacilApp());

    await tester.tap(find.text('Quero ser um parceiro'));
    await tester.pumpAndSettle();

    expect(
      find.text('Venda mais perto de quem já compra de você'),
      findsOneWidget,
    );
    expect(find.text('Pedidos mais organizados'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('partner-whatsapp-button')),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('Quero cadastrar meu negócio'), findsOneWidget);
  });

  testWidgets('category card opens its partner list', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const CompraFacilApp());

    await tester.scrollUntilVisible(
      find.text('Mercado'),
      520,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Mercado'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mercado'));
    await tester.pumpAndSettle();

    expect(find.text('Mercado'), findsOneWidget);
    expect(
      find.textContaining('2 estabelecimentos disponíveis'),
      findsOneWidget,
    );
    expect(find.text('Empório Campo à Mesa'), findsOneWidget);
    expect(find.text('Pedir'), findsWidgets);
  });

  testWidgets('demo açaí store opens its product configurator', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const CompraFacilApp());

    await tester.scrollUntilVisible(
      find.text('Açaí'),
      680,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Açaí'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Açaí'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('message-Tropical Açaí')), findsOneWidget);
    await tester.tap(find.text('Tropical Açaí'));
    await tester.pumpAndSettle();

    expect(find.text('Cardápio demonstrativo'), findsOneWidget);
    expect(find.text('Açaí'), findsWidgets);
    expect(find.text('Montar pedido'), findsOneWidget);

    await tester.tap(find.text('Montar pedido'));
    await tester.pumpAndSettle();

    expect(find.text('Monte seu açaí'), findsOneWidget);
    expect(find.text('300 ml'), findsOneWidget);
    expect(find.text('400 ml'), findsOneWidget);
    expect(find.text('500 ml'), findsOneWidget);
    expect(find.text('Escolha exatamente 3 sabores'), findsOneWidget);
    expect(find.byKey(const Key('send-whatsapp-button')), findsOneWidget);
  });

  testWidgets('order becomes available only after required choices', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      const MaterialApp(
        home: ProductCustomizerPage(
          storeName: 'Tropical Açaí',
          whatsapp: mainWhatsappNumber,
          product: demoAcaiProduct,
        ),
      ),
    );

    FilledButton sendButton() => tester.widget<FilledButton>(
      find.byKey(const Key('send-whatsapp-button')),
    );

    expect(sendButton().onPressed, isNull);
    await tester.tap(find.byKey(const ValueKey('size-400 ml')));
    await tester.tap(find.byKey(const ValueKey('flavor-Banana')));
    await tester.tap(find.byKey(const ValueKey('flavor-Morango')));
    await tester.tap(find.byKey(const ValueKey('flavor-Paçoca')));
    await tester.drag(find.byType(ListView), const Offset(0, -650));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('fulfillment-pickup')));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -420));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('customer-name-field')),
      'Gustavo',
    );
    await tester.pump();

    expect(sendButton().onPressed, isNotNull);
    expect(find.byKey(const Key('delivery-address-field')), findsNothing);
  });

  testWidgets('admin opens establishment and product management', (
    WidgetTester tester,
  ) async {
    final partner = Partner(
      name: 'Tropical Açaí',
      category: 'Açaí',
      icon: Icons.icecream,
      whatsapp: mainWhatsappNumber,
      products: [demoAcaiProduct],
    );
    await tester.binding.setSurfaceSize(const Size(430, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(home: AdminPage(partners: [partner])));

    await tester.tap(find.text('Tropical Açaí'));
    await tester.pumpAndSettle();

    expect(find.text('Gerenciar estabelecimento'), findsOneWidget);
    expect(find.text('Produtos'), findsOneWidget);
    expect(find.text('Açaí'), findsWidgets);
    expect(find.byKey(const Key('edit-establishment-button')), findsOneWidget);
    expect(find.byKey(const Key('add-product-button')), findsOneWidget);
    expect(find.byKey(const Key('edit-product-0')), findsOneWidget);
    expect(find.byKey(const Key('delete-product-0')), findsOneWidget);

    await tester.tap(find.byKey(const Key('edit-product-0')));
    await tester.pumpAndSettle();
    expect(find.text('Editar produto'), findsOneWidget);
    final productNameField = tester.widget<TextFormField>(
      find.byType(TextFormField).first,
    );
    expect(productNameField.controller?.text, 'Açaí');
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('delete-product-0')));
    await tester.pumpAndSettle();
    expect(find.text('Excluir produto?'), findsOneWidget);
    await tester.tap(find.text('Excluir'));
    await tester.pumpAndSettle();
    expect(find.text('Nenhum produto cadastrado'), findsOneWidget);
    expect(partner.products, isEmpty);
  });

  testWidgets('brand theme uses an emerald primary color', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CompraFacilApp());

    final context = tester.element(find.byType(Scaffold).first);
    final theme = Theme.of(context);

    expect(theme.colorScheme.primary, AppColors.brand);
    expect(theme.scaffoldBackgroundColor, AppColors.canvas);
  });

  testWidgets('home fits a compact mobile viewport without layout errors', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 700));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const CompraFacilApp());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byKey(const Key('brand-logo')), findsOneWidget);
  });
}
