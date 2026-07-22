import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum FulfillmentMethod { delivery, pickup }

class CatalogProduct {
  final String name;
  final String description;
  final List<String> sizes;
  final List<String> flavors;
  final int requiredFlavorCount;

  const CatalogProduct({
    required this.name,
    required this.description,
    required this.sizes,
    required this.flavors,
    required this.requiredFlavorCount,
  });
}

const demoAcaiProduct = CatalogProduct(
  name: 'Açaí',
  description: 'Escolha o tamanho e monte seu açaí com 3 sabores.',
  sizes: ['300 ml', '400 ml', '500 ml'],
  flavors: [
    'Banana',
    'Morango',
    'Paçoca',
    'Leite em pó',
    'Granola',
    'Leite condensado',
  ],
  requiredFlavorCount: 3,
);

String buildWhatsAppOrderMessage({
  required String storeName,
  required String productName,
  required String size,
  required List<String> flavors,
  required FulfillmentMethod fulfillmentMethod,
  required String customerName,
  required int quantity,
  String address = '',
  String notes = '',
}) {
  final cleanName = _singleLine(customerName);
  final cleanAddress = _singleLine(address);
  final cleanNotes = notes.trim();
  final fulfillmentLabel = fulfillmentMethod == FulfillmentMethod.delivery
      ? 'Entrega'
      : 'Retirada no local';
  final buffer = StringBuffer()
    ..writeln('🛍️ *NOVO PEDIDO — COMPRA FÁCIL*')
    ..writeln()
    ..writeln('🏪 *Loja:* ${_singleLine(storeName)}')
    ..writeln('🥤 *Produto:* ${_singleLine(productName)}')
    ..writeln('🔢 *Quantidade:* $quantity')
    ..writeln('📏 *Tamanho:* ${_singleLine(size)}')
    ..writeln()
    ..writeln('🍓 *Sabores escolhidos (${flavors.length}):*');

  for (final flavor in flavors) {
    buffer.writeln('• ${_singleLine(flavor)}');
  }

  buffer
    ..writeln()
    ..writeln('🚚 *Recebimento:* $fulfillmentLabel');

  if (fulfillmentMethod == FulfillmentMethod.delivery &&
      cleanAddress.isNotEmpty) {
    buffer.writeln('📍 *Endereço:* $cleanAddress');
  }

  buffer.writeln('👤 *Cliente:* $cleanName');

  if (cleanNotes.isNotEmpty) {
    final quotedNotes = cleanNotes
        .split('\n')
        .map((line) => '> ${line.trim()}')
        .join('\n');
    buffer
      ..writeln()
      ..writeln('📝 *Observações:*')
      ..writeln(quotedNotes);
  }

  buffer
    ..writeln()
    ..write('_Pedido montado pelo Compra Fácil Sarapuí._');

  return buffer.toString();
}

String _singleLine(String value) {
  return value.trim().replaceAll(RegExp(r'\s+'), ' ');
}

class StoreCatalogPage extends StatelessWidget {
  final String storeName;
  final String whatsapp;
  final List<CatalogProduct> products;

  const StoreCatalogPage({
    super.key,
    required this.storeName,
    required this.whatsapp,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(storeName)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                sliver: SliverToBoxAdapter(
                  child: _StoreHeader(storeName: storeName),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Produtos',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        products.length == 1
                            ? '1 produto'
                            : '${products.length} produtos',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  24 + MediaQuery.paddingOf(context).bottom,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _CatalogProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => ProductCustomizerPage(
                                storeName: storeName,
                                whatsapp: whatsapp,
                                product: product,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }, childCount: products.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoreHeader extends StatelessWidget {
  final String storeName;

  const _StoreHeader({required this.storeName});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.lerp(colors.primary, Colors.black, 0.28)!,
            colors.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.icecream_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Text(
                    'LOJA DE EXEMPLO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  storeName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Cardápio demonstrativo',
                  style: TextStyle(color: Color(0xFFDCEBDF), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CatalogProductCard extends StatelessWidget {
  final CatalogProduct product;
  final VoidCallback onTap;

  const _CatalogProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.icecream_rounded,
                    color: colors.primary,
                    size: 29,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...product.sizes.map(
                  (size) => _ProductBadge(label: size, icon: Icons.straighten),
                ),
                _ProductBadge(
                  label: '${product.requiredFlavorCount} sabores',
                  icon: Icons.add_circle_outline_rounded,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Preço a confirmar com a loja.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.tune_rounded),
                label: const Text('Montar pedido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductBadge extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ProductBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: colors.primary, size: 15),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colors.onPrimaryContainer,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCustomizerPage extends StatefulWidget {
  final String storeName;
  final String whatsapp;
  final CatalogProduct product;

  const ProductCustomizerPage({
    super.key,
    required this.storeName,
    required this.whatsapp,
    required this.product,
  });

  @override
  State<ProductCustomizerPage> createState() => _ProductCustomizerPageState();
}

class _ProductCustomizerPageState extends State<ProductCustomizerPage> {
  final _customerNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  final Set<String> _selectedFlavors = {};

  String? _selectedSize;
  FulfillmentMethod? _fulfillmentMethod;
  int _quantity = 1;
  bool _isSending = false;

  bool get _canSend {
    final hasAddress =
        _fulfillmentMethod != FulfillmentMethod.delivery ||
        _addressController.text.trim().isNotEmpty;
    return _selectedSize != null &&
        _selectedFlavors.length == widget.product.requiredFlavorCount &&
        _fulfillmentMethod != null &&
        _customerNameController.text.trim().isNotEmpty &&
        hasAddress &&
        !_isSending;
  }

  String get _pendingLabel {
    if (_selectedSize == null) return 'Escolha o tamanho para continuar';
    if (_selectedFlavors.length != widget.product.requiredFlavorCount) {
      final remaining =
          widget.product.requiredFlavorCount - _selectedFlavors.length;
      return remaining == 1
          ? 'Escolha mais 1 sabor'
          : 'Escolha mais $remaining sabores';
    }
    if (_fulfillmentMethod == null) {
      return 'Escolha entrega ou retirada';
    }
    if (_customerNameController.text.trim().isEmpty) {
      return 'Informe o nome para o pedido';
    }
    if (_fulfillmentMethod == FulfillmentMethod.delivery &&
        _addressController.text.trim().isEmpty) {
      return 'Informe o endereço de entrega';
    }
    return 'Pedido pronto para enviar';
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Montar pedido')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              Text(
                'Monte seu açaí',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 5),
              Text(
                '${widget.product.name} • ${widget.storeName}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 18),
              _ConfigurationSection(
                number: '1',
                title: 'Escolha o tamanho',
                child: Wrap(
                  spacing: 9,
                  runSpacing: 9,
                  children: widget.product.sizes.map((size) {
                    return ChoiceChip(
                      key: ValueKey('size-$size'),
                      label: Text(size),
                      selected: _selectedSize == size,
                      onSelected: (_) => setState(() => _selectedSize = size),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              _ConfigurationSection(
                number: '2',
                title:
                    'Escolha exatamente ${widget.product.requiredFlavorCount} sabores',
                subtitle:
                    '${_selectedFlavors.length}/${widget.product.requiredFlavorCount} selecionados • opções demonstrativas',
                child: Wrap(
                  spacing: 9,
                  runSpacing: 9,
                  children: widget.product.flavors.map((flavor) {
                    final isSelected = _selectedFlavors.contains(flavor);
                    final reachedLimit =
                        _selectedFlavors.length >=
                        widget.product.requiredFlavorCount;
                    return FilterChip(
                      key: ValueKey('flavor-$flavor'),
                      label: Text(flavor),
                      selected: isSelected,
                      onSelected: isSelected || !reachedLimit
                          ? (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedFlavors.add(flavor);
                                } else {
                                  _selectedFlavors.remove(flavor);
                                }
                              });
                            }
                          : null,
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              _ConfigurationSection(
                number: '3',
                title: 'Como você quer receber?',
                subtitle: 'A escolha será identificada claramente no WhatsApp.',
                child: Column(
                  children: [
                    _FulfillmentOption(
                      key: const Key('fulfillment-delivery'),
                      icon: Icons.delivery_dining_rounded,
                      title: 'Entrega',
                      description: 'Receber no endereço informado',
                      selected:
                          _fulfillmentMethod == FulfillmentMethod.delivery,
                      onTap: () => setState(
                        () => _fulfillmentMethod = FulfillmentMethod.delivery,
                      ),
                    ),
                    const SizedBox(height: 9),
                    _FulfillmentOption(
                      key: const Key('fulfillment-pickup'),
                      icon: Icons.storefront_rounded,
                      title: 'Retirar no local',
                      description: 'Buscar o pedido diretamente na loja',
                      selected: _fulfillmentMethod == FulfillmentMethod.pickup,
                      onTap: () => setState(
                        () => _fulfillmentMethod = FulfillmentMethod.pickup,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _ConfigurationSection(
                number: '4',
                title: 'Dados do pedido',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      key: const Key('customer-name-field'),
                      controller: _customerNameController,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Nome para o pedido',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    if (_fulfillmentMethod == FulfillmentMethod.delivery) ...[
                      const SizedBox(height: 12),
                      TextField(
                        key: const Key('delivery-address-field'),
                        controller: _addressController,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Endereço completo',
                          hintText: 'Rua, número e referência',
                          prefixIcon: Icon(Icons.location_on_outlined),
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Quantidade',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        _QuantitySelector(
                          quantity: _quantity,
                          onDecrement: _quantity > 1
                              ? () => setState(() => _quantity--)
                              : null,
                          onIncrement: () => setState(() => _quantity++),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _notesController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Observações (opcional)',
                        hintText: 'Ex.: sem colher, ponto de referência...',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.notes_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _OrderBottomBar(
        statusLabel: _pendingLabel,
        canSend: _canSend,
        isSending: _isSending,
        onSend: _sendOrder,
      ),
    );
  }

  Future<void> _sendOrder() async {
    if (!_canSend) return;
    setState(() => _isSending = true);

    final message = buildWhatsAppOrderMessage(
      storeName: widget.storeName,
      productName: widget.product.name,
      size: _selectedSize!,
      flavors: _selectedFlavors.toList(),
      fulfillmentMethod: _fulfillmentMethod!,
      customerName: _customerNameController.text,
      address: _addressController.text,
      notes: _notesController.text,
      quantity: _quantity,
    );
    final whatsappUrl = Uri.parse(
      'https://wa.me/${widget.whatsapp}?text=${Uri.encodeComponent(message)}',
    );
    final didOpen = await launchUrl(
      whatsappUrl,
      mode: LaunchMode.externalApplication,
    );

    if (!mounted) return;
    setState(() => _isSending = false);
    if (!didOpen) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
      );
    }
  }
}

class _ConfigurationSection extends StatelessWidget {
  final String number;
  final String title;
  final String? subtitle;
  final Widget child;

  const _ConfigurationSection({
    required this.number,
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    number,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: colors.primary),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _FulfillmentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  const _FulfillmentOption({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: selected ? colors.primaryContainer : colors.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: selected ? colors.primary : colors.outlineVariant,
          width: selected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Icon(icon, color: selected ? colors.primary : colors.onSurface),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: selected ? colors.primary : colors.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback? onDecrement;
  final VoidCallback onIncrement;

  const _QuantitySelector({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Diminuir quantidade',
            onPressed: onDecrement,
            icon: const Icon(Icons.remove_rounded),
          ),
          SizedBox(
            width: 28,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          IconButton(
            tooltip: 'Aumentar quantidade',
            onPressed: onIncrement,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}

class _OrderBottomBar extends StatelessWidget {
  final String statusLabel;
  final bool canSend;
  final bool isSending;
  final VoidCallback onSend;

  const _OrderBottomBar({
    required this.statusLabel,
    required this.canSend,
    required this.isSending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      elevation: 10,
      shadowColor: Colors.black.withValues(alpha: 0.14),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                statusLabel,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: canSend ? Theme.of(context).colorScheme.primary : null,
                  fontSize: 12,
                  fontWeight: canSend ? FontWeight.w700 : null,
                ),
              ),
              const SizedBox(height: 7),
              FilledButton.icon(
                key: const Key('send-whatsapp-button'),
                onPressed: canSend ? onSend : null,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF087A3E),
                ),
                icon: isSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.chat_bubble_outline_rounded),
                label: Text(
                  isSending ? 'Abrindo WhatsApp...' : 'Enviar pelo WhatsApp',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
