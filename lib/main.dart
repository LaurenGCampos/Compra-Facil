import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'partner_page.dart';
import 'store_catalog.dart';

void main() {
  runApp(const CompraFacilApp());
}

const mainWhatsappNumber = '5511949896488';

abstract final class AppColors {
  static const brandDeep = Color(0xFF064A2B);
  static const brand = Color(0xFF08743E);
  static const brandBright = Color(0xFF42A934);
  static const canvas = Color(0xFFF6F8F3);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFEAF3E9);
  static const border = Color(0xFFDCE5DA);
  static const ink = Color(0xFF172019);
  static const inkMuted = Color(0xFF657068);
  static const whatsapp = Color(0xFF087A3E);
  static const danger = Color(0xFFBA1A1A);
}

class CompraFacilApp extends StatelessWidget {
  const CompraFacilApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = ThemeData.light().textTheme;

    return MaterialApp(
      title: 'Compra Fácil Sarapuí',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.canvas,
        colorScheme: const ColorScheme.light(
          primary: AppColors.brand,
          onPrimary: Colors.white,
          primaryContainer: AppColors.surfaceMuted,
          onPrimaryContainer: AppColors.brandDeep,
          secondary: AppColors.brandBright,
          onSecondary: Colors.white,
          surface: AppColors.surface,
          onSurface: AppColors.ink,
          error: AppColors.danger,
        ),
        textTheme: baseTextTheme.copyWith(
          displaySmall: const TextStyle(
            color: AppColors.ink,
            fontSize: 30,
            height: 1.08,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
          headlineSmall: const TextStyle(
            color: AppColors.ink,
            fontSize: 24,
            height: 1.15,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
          titleLarge: const TextStyle(
            color: AppColors.ink,
            fontSize: 20,
            height: 1.2,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
          titleMedium: const TextStyle(
            color: AppColors.ink,
            fontSize: 16,
            height: 1.25,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: const TextStyle(
            color: AppColors.ink,
            fontSize: 16,
            height: 1.45,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: const TextStyle(
            color: AppColors.inkMuted,
            fontSize: 14,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: const TextStyle(
            fontSize: 14,
            height: 1.2,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.canvas,
          foregroundColor: AppColors.ink,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          toolbarHeight: 68,
          titleSpacing: 20,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.canvas,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.brand,
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 50),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.brand,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.border,
          thickness: 1,
          space: 1,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class Partner {
  String name;
  String category;
  IconData icon;
  String whatsapp;
  final List<CatalogProduct> products;

  Partner({
    required this.name,
    required this.category,
    required this.icon,
    required this.whatsapp,
    List<CatalogProduct>? products,
  }) : products = products ?? [];
}

class Category {
  final String name;
  final IconData icon;

  const Category(this.name, this.icon);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _mainWhatsapp = mainWhatsappNumber;

  late final List<Partner> _partners = [
    Partner(
      name: 'Empório Campo à Mesa',
      category: 'Mercado',
      icon: Icons.shopping_basket_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Empório Guinness',
      category: 'Mercado',
      icon: Icons.storefront_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Drogaria São João',
      category: 'Farmácia',
      icon: Icons.local_pharmacy_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Drogaria Trettel',
      category: 'Farmácia',
      icon: Icons.medical_services_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Ciborg Bar e Lanchonete',
      category: 'Lanchonete',
      icon: Icons.restaurant_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Pizza do Robinho',
      category: 'Lanchonete',
      icon: Icons.local_pizza_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Boi Ralado na Grelha',
      category: 'Lanchonete',
      icon: Icons.lunch_dining_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'My House Pizzas e Pastéis',
      category: 'Lanchonete',
      icon: Icons.fastfood_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Burguer Sport Club',
      category: 'Lanchonete',
      icon: Icons.sports_soccer_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Coxinha Premium',
      category: 'Lanchonete',
      icon: Icons.set_meal_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Bru Delícias',
      category: 'Doces e Bolos',
      icon: Icons.cake_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Cris Bolos e Doces',
      category: 'Doces e Bolos',
      icon: Icons.icecream_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Doces Artesanais Santiago',
      category: 'Doces e Bolos',
      icon: Icons.cookie_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Pipô Pipocas Gourmet',
      category: 'Doces e Bolos',
      icon: Icons.bakery_dining_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'El Shaddai Variedades',
      category: 'Doces e Bolos',
      icon: Icons.card_giftcard_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Marmitas da Fla',
      category: 'Refeições',
      icon: Icons.flatware_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Padaria Califórnia',
      category: 'Padaria',
      icon: Icons.breakfast_dining_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Tropical Açaí',
      category: 'Açaí',
      icon: Icons.icecream_rounded,
      whatsapp: _mainWhatsapp,
      products: [demoAcaiProduct],
    ),
    Partner(
      name: 'Adega do Kaike',
      category: 'Adega e Bebidas',
      icon: Icons.local_bar_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Damas Acessórios',
      category: 'Moda e Acessórios',
      icon: Icons.watch_rounded,
      whatsapp: _mainWhatsapp,
    ),
    Partner(
      name: 'Moda & Variedades GK',
      category: 'Moda e Acessórios',
      icon: Icons.checkroom_rounded,
      whatsapp: _mainWhatsapp,
    ),
  ];

  static const List<Category> _categories = [
    Category('Lanchonete', Icons.restaurant_rounded),
    Category('Doces e Bolos', Icons.cake_rounded),
    Category('Mercado', Icons.shopping_basket_rounded),
    Category('Farmácia', Icons.local_pharmacy_rounded),
    Category('Refeições', Icons.flatware_rounded),
    Category('Padaria', Icons.bakery_dining_rounded),
    Category('Açaí', Icons.icecream_rounded),
    Category('Adega e Bebidas', Icons.local_bar_rounded),
    Category('Moda e Acessórios', Icons.checkroom_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 76,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(18, 8, 8, 8),
          child: _BrandLogo(size: 52),
        ),
        title: const _BrandTitle(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              tooltip: 'Abrir painel administrativo',
              icon: const Icon(Icons.admin_panel_settings_outlined),
              onPressed: _goToAdmin,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;
          final crossAxisCount = isWide ? 3 : 2;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    sliver: SliverToBoxAdapter(
                      child: _PromoCarousel(
                        onOpenAcai: _openDemoStore,
                        onOpenPartner: _openPartnerProgram,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    sliver: SliverToBoxAdapter(
                      child: _PartnerCallout(onTap: _openPartnerProgram),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
                    sliver: SliverToBoxAdapter(
                      child: _SectionHeader(categoryCount: _categories.length),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: isWide ? 1.45 : 1.12,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final category = _categories[index];
                        final partnerCount = _partners
                            .where(
                              (partner) => partner.category == category.name,
                            )
                            .length;

                        return _CategoryCard(
                          category: category,
                          partnerCount: partnerCount,
                          onTap: () => _openCategory(category),
                        );
                      }, childCount: _categories.length),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      24,
                      20,
                      24 + MediaQuery.paddingOf(context).bottom,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: _InstagramCard(onTap: _openInstagram),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _goToAdmin() async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => AdminPage(partners: _partners),
      ),
    );
    if (mounted) {
      setState(() {});
    }
  }

  void _openCategory(Category category) {
    final filteredPartners = _partners
        .where((partner) => partner.category == category.name)
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => CategoryPartnersPage(
          categoryName: category.name,
          partners: filteredPartners,
        ),
      ),
    );
  }

  Future<void> _openInstagram() async {
    final didOpen = await launchUrl(
      Uri.parse('https://www.instagram.com/comprafacilsarapui.015'),
      mode: LaunchMode.externalApplication,
    );
    if (!didOpen && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o Instagram.')),
      );
    }
  }

  void _openPartnerProgram() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) =>
            const PartnerProgramPage(whatsapp: mainWhatsappNumber),
      ),
    );
  }

  void _openDemoStore() {
    final store = _partners.firstWhere(
      (partner) => partner.name == 'Tropical Açaí',
    );
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => StoreCatalogPage(
          storeName: store.name,
          whatsapp: store.whatsapp,
          products: store.products,
        ),
      ),
    );
  }
}

class _BrandTitle extends StatelessWidget {
  const _BrandTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compra Fácil',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.brandDeep,
            fontSize: 18,
          ),
        ),
        const Text(
          'SARAPUÍ',
          style: TextStyle(
            color: AppColors.inkMuted,
            fontSize: 10,
            height: 1.1,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
          ),
        ),
      ],
    );
  }
}

class _BrandLogo extends StatelessWidget {
  final double size;

  const _BrandLogo({this.size = 124});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size < 70 ? 2 : 6),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: size < 70 ? 1.5 : 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: size < 70 ? 0.1 : 0.16),
            blurRadius: size < 70 ? 8 : 18,
            offset: Offset(0, size < 70 ? 2 : 6),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/logo-compra-facil.png',
          key: const Key('brand-logo'),
          fit: BoxFit.cover,
          semanticLabel: 'Logo Compra Fácil Sarapuí',
        ),
      ),
    );
  }
}

class _PromoData {
  final String eyebrow;
  final String title;
  final String description;
  final IconData icon;
  final List<Color> colors;
  final Color accent;
  final String? actionLabel;
  final VoidCallback? onTap;

  const _PromoData({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.icon,
    required this.colors,
    required this.accent,
    this.actionLabel,
    this.onTap,
  });
}

class _PromoCarousel extends StatefulWidget {
  final VoidCallback onOpenAcai;
  final VoidCallback onOpenPartner;

  const _PromoCarousel({required this.onOpenAcai, required this.onOpenPartner});

  @override
  State<_PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<_PromoCarousel> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  late final List<_PromoData> _promotions = [
    const _PromoData(
      eyebrow: 'NOVIDADE',
      title: 'Pedidos mais simples pelo WhatsApp',
      description:
          'Escolha a loja, personalize o pedido e envie tudo organizado em uma mensagem.',
      icon: Icons.chat_bubble_rounded,
      colors: [AppColors.brandDeep, AppColors.brand],
      accent: AppColors.brandBright,
    ),
    _PromoData(
      eyebrow: 'CARDÁPIO DEMONSTRATIVO',
      title: 'Monte seu açaí do seu jeito',
      description:
          'Escolha entre 300, 400 ou 500 ml e combine exatamente 3 sabores.',
      icon: Icons.icecream_rounded,
      colors: const [Color(0xFF3F174F), Color(0xFF773C88)],
      accent: partnerYellow,
      actionLabel: 'Ver cardápio',
      onTap: widget.onOpenAcai,
    ),
    const _PromoData(
      eyebrow: 'ESPAÇO PROMOCIONAL',
      title: 'Ofertas dos parceiros em destaque',
      description:
          'Descontos, combos e novidades aparecerão aqui assim que forem cadastrados.',
      icon: Icons.percent_rounded,
      colors: [Color(0xFF9A5A00), Color(0xFFD28716)],
      accent: Color(0xFFFFE08A),
    ),
    _PromoData(
      eyebrow: 'PARA COMERCIANTES',
      title: 'Leve seu negócio para o Compra Fácil',
      description:
          'Ganhe presença no catálogo local e receba pedidos estruturados no WhatsApp.',
      icon: Icons.storefront_rounded,
      colors: const [Color(0xFF123C2B), Color(0xFF246B48)],
      accent: partnerYellow,
      actionLabel: 'Quero ser parceiro',
      onTap: widget.onOpenPartner,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _advance());
  }

  void _advance() {
    if (!mounted ||
        !_pageController.hasClients ||
        !TickerMode.valuesOf(context).enabled) {
      return;
    }
    final nextPage = (_currentPage + 1) % _promotions.length;
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Novidades e ofertas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              '${_currentPage + 1}/${_promotions.length}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 260,
          child: PageView.builder(
            key: const Key('promotion-carousel'),
            controller: _pageController,
            itemCount: _promotions.length,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 2),
                child: _PromoBanner(promotion: _promotions[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 11),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_promotions.length, (index) {
            final isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isActive ? 22 : 7,
              height: 7,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: isActive ? AppColors.brand : AppColors.border,
                borderRadius: BorderRadius.circular(99),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _PromoBanner extends StatelessWidget {
  final _PromoData promotion;

  const _PromoBanner({required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: promotion.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: promotion.colors.first.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: -48,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.07),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        promotion.eyebrow,
                        style: TextStyle(
                          color: promotion.accent,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.25,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        promotion.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        promotion.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.84),
                          fontSize: 13,
                        ),
                      ),
                      if (promotion.actionLabel != null) ...[
                        const SizedBox(height: 10),
                        TextButton.icon(
                          onPressed: promotion.onTap,
                          style: TextButton.styleFrom(
                            foregroundColor: promotion.accent,
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                          ),
                          label: Text(promotion.actionLabel!),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(
                    promotion.icon,
                    color: promotion.accent,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final int categoryCount;

  const _SectionHeader({required this.categoryCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'O que você procura?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                'Comércios locais prontos para atender você.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            '$categoryCount categorias',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.brandDeep,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;
  final int partnerCount;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.partnerCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final partnerLabel = partnerCount == 1
        ? '1 estabelecimento'
        : '$partnerCount estabelecimentos';

    return Semantics(
      button: true,
      label: '${category.name}, $partnerLabel',
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMuted,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        category.icon,
                        color: AppColors.brand,
                        size: 25,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_outward_rounded,
                      color: AppColors.inkMuted,
                      size: 20,
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 3),
                Text(
                  partnerLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PartnerCallout extends StatelessWidget {
  final VoidCallback onTap;

  const _PartnerCallout({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: partnerYellowSoft,
        border: Border.all(color: partnerYellow.withValues(alpha: 0.85)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final copy = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: partnerYellow,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  color: partnerYellowInk,
                  size: 25,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seu negócio no Compra Fácil',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Receba pedidos organizados diretamente no WhatsApp.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          );
          final button = FilledButton.icon(
            key: const Key('become-partner-button'),
            onPressed: onTap,
            style: FilledButton.styleFrom(
              backgroundColor: partnerYellow,
              foregroundColor: partnerYellowInk,
            ),
            icon: const Icon(Icons.handshake_outlined),
            label: const Text('Quero ser um parceiro'),
          );

          if (constraints.maxWidth < 580) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [copy, const SizedBox(height: 14), button],
            );
          }

          return Row(
            children: [
              Expanded(child: copy),
              const SizedBox(width: 18),
              button,
            ],
          );
        },
      ),
    );
  }
}

class _InstagramCard extends StatelessWidget {
  final VoidCallback onTap;

  const _InstagramCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.brand,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Acompanhe as novidades',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '@comprafacilsarapui.015',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.open_in_new_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryPartnersPage extends StatelessWidget {
  final String categoryName;
  final List<Partner> partners;

  const CategoryPartnersPage({
    super.key,
    required this.categoryName,
    required this.partners,
  });

  Future<void> _openWhatsApp(BuildContext context, Partner partner) async {
    final message =
        'Olá! Gostaria de fazer um pedido para ${partner.name} '
        '(${partner.category}) pelo Compra Fácil.';
    final whatsappUrl = Uri.parse(
      'https://wa.me/${partner.whatsapp}?text=${Uri.encodeComponent(message)}',
    );
    final didOpen = await launchUrl(
      whatsappUrl,
      mode: LaunchMode.externalApplication,
    );
    if (!didOpen && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
      );
    }
  }

  Future<void> _openPartner(BuildContext context, Partner partner) async {
    if (partner.products.isNotEmpty) {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => StoreCatalogPage(
            storeName: partner.name,
            whatsapp: partner.whatsapp,
            products: partner.products,
          ),
        ),
      );
      return;
    }

    if (context.mounted) {
      await _openWhatsApp(context, partner);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: partners.isEmpty
              ? const _EmptyPartners()
              : CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
                      sliver: SliverToBoxAdapter(
                        child: _PartnersHeader(
                          categoryName: categoryName,
                          partnerCount: partners.length,
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
                          final partner = partners[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _PartnerCard(
                              partner: partner,
                              onTap: () => _openPartner(context, partner),
                              onMessage: () => _openWhatsApp(context, partner),
                            ),
                          );
                        }, childCount: partners.length),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _PartnersHeader extends StatelessWidget {
  final String categoryName;
  final int partnerCount;

  const _PartnersHeader({
    required this.categoryName,
    required this.partnerCount,
  });

  @override
  Widget build(BuildContext context) {
    final countLabel = partnerCount == 1
        ? '1 estabelecimento disponível'
        : '$partnerCount estabelecimentos disponíveis';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Escolha onde pedir',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 5),
        Text(
          '$countLabel em $categoryName.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _PartnerCard extends StatelessWidget {
  final Partner partner;
  final VoidCallback onTap;
  final VoidCallback onMessage;

  const _PartnerCard({
    required this.partner,
    required this.onTap,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    final hasCatalog = partner.products.isNotEmpty;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(partner.icon, color: AppColors.brand, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      partner.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hasCatalog
                          ? 'Ver cardápio e montar pedido'
                          : 'Pedido direto pelo WhatsApp',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasCatalog)
                    SizedBox(
                      width: 38,
                      height: 34,
                      child: IconButton(
                        key: ValueKey('message-${partner.name}'),
                        tooltip: 'Falar diretamente com ${partner.name}',
                        padding: EdgeInsets.zero,
                        onPressed: onMessage,
                        icon: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: AppColors.whatsapp,
                          size: 22,
                        ),
                      ),
                    )
                  else
                    const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: AppColors.whatsapp,
                      size: 23,
                    ),
                  const SizedBox(height: 3),
                  Text(
                    hasCatalog ? 'WhatsApp' : 'Pedir',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.whatsapp,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyPartners extends StatelessWidget {
  const _EmptyPartners();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: AppColors.surfaceMuted,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.storefront_outlined,
              color: AppColors.brand,
              size: 34,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Novidades em breve',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Ainda não há estabelecimentos cadastrados nesta categoria.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class AdminPage extends StatefulWidget {
  final List<Partner> partners;

  const AdminPage({super.key, required this.partners});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Future<void> _addPartner() async {
    final draft = await showDialog<_PartnerDraft>(
      context: context,
      builder: (context) => const _PartnerEditorDialog(),
    );

    if (draft == null || !mounted) return;
    setState(() {
      widget.partners.add(
        Partner(
          name: draft.name,
          category: draft.category,
          icon: Icons.storefront_rounded,
          whatsapp: draft.whatsapp,
        ),
      );
    });
  }

  Future<void> _openPartner(Partner partner) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => EstablishmentAdminPage(partner: partner),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _deletePartner(int index) async {
    final partner = widget.partners[index];
    final confirmed = await _confirmDeletion(
      context,
      title: 'Excluir estabelecimento?',
      message:
          '${partner.name} e seus ${partner.products.length} produtos serão removidos deste protótipo.',
    );
    if (confirmed && mounted) {
      setState(() => widget.partners.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final productCount = widget.partners.fold<int>(
      0,
      (total, partner) => total + partner.products.length,
    );
    final directCount = widget.partners
        .where((partner) => partner.whatsapp != mainWhatsappNumber)
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text('Painel administrativo')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gestão de estabelecimentos',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Edite contatos, cardápios e o destino dos pedidos.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _AdminMetric(
                              value: '${widget.partners.length}',
                              label: 'Lojas',
                              icon: Icons.storefront_rounded,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _AdminMetric(
                              value: '$productCount',
                              label: 'Produtos',
                              icon: Icons.inventory_2_outlined,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _AdminMetric(
                              value: '$directCount',
                              label: 'WhatsApps próprios',
                              icon: Icons.chat_bubble_outline_rounded,
                            ),
                          ),
                        ],
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
                  96 + MediaQuery.paddingOf(context).bottom,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final partner = widget.partners[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _AdminPartnerCard(
                        partner: partner,
                        onTap: () => _openPartner(partner),
                        onDelete: () => _deletePartner(index),
                      ),
                    );
                  }, childCount: widget.partners.length),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPartner,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Adicionar parceiro'),
      ),
    );
  }
}

class _AdminMetric extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _AdminMetric({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.brand, size: 20),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _AdminPartnerCard extends StatelessWidget {
  final Partner partner;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _AdminPartnerCard({
    required this.partner,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final usesCentralNumber = partner.whatsapp == mainWhatsappNumber;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(partner.icon, color: AppColors.brand),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      partner.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${partner.category} • ${partner.products.length} ${partner.products.length == 1 ? 'produto' : 'produtos'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 7),
                    _WhatsappStatusBadge(
                      usesCentralNumber: usesCentralNumber,
                      whatsapp: partner.whatsapp,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Excluir ${partner.name}',
                onPressed: onDelete,
                color: AppColors.danger,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhatsappStatusBadge extends StatelessWidget {
  final bool usesCentralNumber;
  final String whatsapp;

  const _WhatsappStatusBadge({
    required this.usesCentralNumber,
    required this.whatsapp,
  });

  @override
  Widget build(BuildContext context) {
    final background = usesCentralNumber
        ? const Color(0xFFFFF3CD)
        : AppColors.surfaceMuted;
    final foreground = usesCentralNumber
        ? const Color(0xFF755900)
        : AppColors.brandDeep;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        usesCentralNumber
            ? 'Usando contato central'
            : 'Direto: ${formatWhatsappNumber(whatsapp)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: foreground, fontSize: 10),
      ),
    );
  }
}

class EstablishmentAdminPage extends StatefulWidget {
  final Partner partner;

  const EstablishmentAdminPage({super.key, required this.partner});

  @override
  State<EstablishmentAdminPage> createState() => _EstablishmentAdminPageState();
}

class _EstablishmentAdminPageState extends State<EstablishmentAdminPage> {
  Future<void> _editEstablishment() async {
    final draft = await showDialog<_PartnerDraft>(
      context: context,
      builder: (context) => _PartnerEditorDialog(partner: widget.partner),
    );
    if (draft == null || !mounted) return;
    setState(() {
      widget.partner
        ..name = draft.name
        ..category = draft.category
        ..whatsapp = draft.whatsapp;
    });
  }

  Future<void> _addProduct() async {
    final product = await showDialog<CatalogProduct>(
      context: context,
      builder: (context) => const _ProductEditorDialog(),
    );
    if (product != null && mounted) {
      setState(() => widget.partner.products.add(product));
    }
  }

  Future<void> _editProduct(int index) async {
    final product = await showDialog<CatalogProduct>(
      context: context,
      builder: (context) =>
          _ProductEditorDialog(product: widget.partner.products[index]),
    );
    if (product != null && mounted) {
      setState(() => widget.partner.products[index] = product);
    }
  }

  Future<void> _deleteProduct(int index) async {
    final product = widget.partner.products[index];
    final confirmed = await _confirmDeletion(
      context,
      title: 'Excluir produto?',
      message:
          '${product.name} será removido do catálogo de ${widget.partner.name}.',
    );
    if (confirmed && mounted) {
      setState(() => widget.partner.products.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final partner = widget.partner;

    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar estabelecimento')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                sliver: SliverToBoxAdapter(
                  child: _EstablishmentAdminHeader(
                    partner: partner,
                    onEdit: _editEstablishment,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Produtos',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              '${partner.products.length} cadastrados',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      FilledButton.icon(
                        key: const Key('add-product-button'),
                        onPressed: _addProduct,
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Adicionar'),
                      ),
                    ],
                  ),
                ),
              ),
              if (partner.products.isEmpty)
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(child: _EmptyProductAdmin()),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    0,
                    20,
                    24 + MediaQuery.paddingOf(context).bottom,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _AdminProductCard(
                          product: partner.products[index],
                          index: index,
                          onEdit: () => _editProduct(index),
                          onDelete: () => _deleteProduct(index),
                        ),
                      );
                    }, childCount: partner.products.length),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EstablishmentAdminHeader extends StatelessWidget {
  final Partner partner;
  final VoidCallback onEdit;

  const _EstablishmentAdminHeader({
    required this.partner,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final usesCentralNumber = partner.whatsapp == mainWhatsappNumber;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Icon(partner.icon, color: AppColors.brand, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        partner.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        partner.category,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  key: const Key('edit-establishment-button'),
                  tooltip: 'Editar estabelecimento',
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(),
            const SizedBox(height: 13),
            Row(
              children: [
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: AppColors.whatsapp,
                  size: 20,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatWhatsappNumber(partner.whatsapp),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        usesCentralNumber
                            ? 'Pedidos ainda vão para o WhatsApp central.'
                            : 'Pedidos vão diretamente para o estabelecimento.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminProductCard extends StatelessWidget {
  final CatalogProduct product;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AdminProductCard({
    required this.product,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                color: AppColors.brand,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${product.sizes.join(' • ')}  ·  ${product.flavors.length} opções',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.brandDeep,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  key: ValueKey('edit-product-$index'),
                  tooltip: 'Editar ${product.name}',
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  key: ValueKey('delete-product-$index'),
                  tooltip: 'Excluir ${product.name}',
                  onPressed: onDelete,
                  color: AppColors.danger,
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyProductAdmin extends StatelessWidget {
  const _EmptyProductAdmin();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              color: AppColors.inkMuted,
              size: 34,
            ),
            const SizedBox(height: 10),
            Text(
              'Nenhum produto cadastrado',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Adicione o primeiro produto para habilitar o cardápio desta loja.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _PartnerDraft {
  final String name;
  final String category;
  final String whatsapp;

  const _PartnerDraft({
    required this.name,
    required this.category,
    required this.whatsapp,
  });
}

const _partnerCategoryNames = [
  'Mercado',
  'Farmácia',
  'Lanchonete',
  'Padaria',
  'Açaí',
  'Doces e Bolos',
  'Refeições',
  'Adega e Bebidas',
  'Moda e Acessórios',
];

class _PartnerEditorDialog extends StatefulWidget {
  final Partner? partner;

  const _PartnerEditorDialog({this.partner});

  @override
  State<_PartnerEditorDialog> createState() => _PartnerEditorDialogState();
}

class _PartnerEditorDialogState extends State<_PartnerEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _whatsappController;
  late String _category;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.partner?.name ?? '');
    _whatsappController = TextEditingController(
      text: widget.partner?.whatsapp ?? mainWhatsappNumber,
    );
    _category = widget.partner?.category ?? _partnerCategoryNames.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.partner == null
            ? 'Novo estabelecimento'
            : 'Editar estabelecimento',
      ),
      content: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  autofocus: widget.partner == null,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nome do estabelecimento',
                    prefixIcon: Icon(Icons.storefront_outlined),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Informe o nome.'
                      : null,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: _partnerCategoryNames
                      .map(
                        (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _category = value);
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _whatsappController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'WhatsApp que receberá os pedidos',
                    hintText: '11 99999-9999',
                    helperText:
                        'O código do Brasil (55) é adicionado automaticamente.',
                    prefixIcon: Icon(Icons.chat_bubble_outline_rounded),
                  ),
                  validator: (value) {
                    final normalized = normalizeWhatsappNumber(value ?? '');
                    return normalized.length < 12
                        ? 'Informe DDD e número completos.'
                        : null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              _PartnerDraft(
                name: _nameController.text.trim(),
                category: _category,
                whatsapp: normalizeWhatsappNumber(_whatsappController.text),
              ),
            );
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}

class _ProductEditorDialog extends StatefulWidget {
  final CatalogProduct? product;

  const _ProductEditorDialog({this.product});

  @override
  State<_ProductEditorDialog> createState() => _ProductEditorDialogState();
}

class _ProductEditorDialogState extends State<_ProductEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _sizesController;
  late final TextEditingController _flavorsController;
  late final TextEditingController _requiredCountController;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    _nameController = TextEditingController(text: product?.name ?? '');
    _descriptionController = TextEditingController(
      text: product?.description ?? '',
    );
    _sizesController = TextEditingController(
      text: product?.sizes.join(', ') ?? '',
    );
    _flavorsController = TextEditingController(
      text: product?.flavors.join(', ') ?? '',
    );
    _requiredCountController = TextEditingController(
      text: '${product?.requiredFlavorCount ?? 0}',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _sizesController.dispose();
    _flavorsController.dispose();
    _requiredCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Novo produto' : 'Editar produto'),
      content: SizedBox(
        width: 480,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  autofocus: widget.product == null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Nome do produto',
                  ),
                  validator: _requiredText,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    alignLabelWithHint: true,
                  ),
                  validator: _requiredText,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _sizesController,
                  decoration: const InputDecoration(
                    labelText: 'Tamanhos ou variações',
                    hintText: '300 ml, 400 ml, 500 ml',
                    helperText: 'Separe cada opção com vírgula.',
                  ),
                  validator: (value) => _parseOptions(value ?? '').isEmpty
                      ? 'Informe pelo menos uma opção.'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _flavorsController,
                  decoration: const InputDecoration(
                    labelText: 'Sabores ou complementos',
                    hintText: 'Banana, morango, paçoca',
                    helperText:
                        'Pode ficar vazio quando o produto não tiver opções.',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _requiredCountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantidade obrigatória de opções',
                    hintText: 'Ex.: 3',
                  ),
                  validator: (value) {
                    final count = int.tryParse(value ?? '');
                    final options = _parseOptions(_flavorsController.text);
                    if (count == null || count < 0) {
                      return 'Informe zero ou um número positivo.';
                    }
                    if (count > options.length) {
                      return 'Não pode ser maior que o total de opções.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              CatalogProduct(
                name: _nameController.text.trim(),
                description: _descriptionController.text.trim(),
                sizes: _parseOptions(_sizesController.text),
                flavors: _parseOptions(_flavorsController.text),
                requiredFlavorCount: int.parse(
                  _requiredCountController.text.trim(),
                ),
              ),
            );
          },
          child: const Text('Salvar produto'),
        ),
      ],
    );
  }

  String? _requiredText(String? value) {
    return value == null || value.trim().isEmpty ? 'Campo obrigatório.' : null;
  }
}

List<String> _parseOptions(String value) {
  return value
      .split(',')
      .map((option) => option.trim())
      .where((option) => option.isNotEmpty)
      .toSet()
      .toList();
}

String normalizeWhatsappNumber(String value) {
  final digits = value.replaceAll(RegExp(r'\D'), '');
  if ((digits.length == 10 || digits.length == 11) &&
      !digits.startsWith('55')) {
    return '55$digits';
  }
  return digits;
}

String formatWhatsappNumber(String value) {
  final digits = normalizeWhatsappNumber(value);
  if (digits.length == 13 && digits.startsWith('55')) {
    return '+55 (${digits.substring(2, 4)}) ${digits.substring(4, 9)}-${digits.substring(9)}';
  }
  if (digits.length == 12 && digits.startsWith('55')) {
    return '+55 (${digits.substring(2, 4)}) ${digits.substring(4, 8)}-${digits.substring(8)}';
  }
  return digits;
}

Future<bool> _confirmDeletion(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excluir'),
            ),
          ],
        ),
      ) ??
      false;
}
