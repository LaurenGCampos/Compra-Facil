import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const CompraFacilApp());
}

class CompraFacilApp extends StatelessWidget {
  const CompraFacilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compra Fácil Sarapuí',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          primary: const Color(0xFF1B5E20),
          secondary: const Color(0xFF4CAF50),
          surface: Colors.white,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
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

  Partner({
    required this.name,
    required this.category,
    required this.icon,
    required this.whatsapp,
  });
}

class Category {
  final String name;
  final IconData icon;
  Category(this.name, this.icon);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _mainWhatsapp = '5515997382031';

  late final List<Partner> _partners = [
    // Mercado
    Partner(name: 'Empório Campo à Mesa', category: 'Mercado', icon: Icons.shopping_basket, whatsapp: _mainWhatsapp),
    Partner(name: 'Empório Guinness', category: 'Mercado', icon: Icons.storefront, whatsapp: _mainWhatsapp),
    
    // Farmácia
    Partner(name: 'Drogaria São João', category: 'Farmácia', icon: Icons.local_pharmacy, whatsapp: _mainWhatsapp),
    Partner(name: 'Drogaria Trettel', category: 'Farmácia', icon: Icons.medical_services, whatsapp: _mainWhatsapp),
    
    // Lanchonete
    Partner(name: 'Ciborg Bar e Lanchonete', category: 'Lanchonete', icon: Icons.restaurant, whatsapp: _mainWhatsapp),
    Partner(name: 'Pizza do Robinho', category: 'Lanchonete', icon: Icons.local_pizza, whatsapp: _mainWhatsapp),
    Partner(name: 'Boi Ralado na Grelha', category: 'Lanchonete', icon: Icons.lunch_dining, whatsapp: _mainWhatsapp),
    Partner(name: 'My House Pizzas e Pastéis', category: 'Lanchonete', icon: Icons.fastfood, whatsapp: _mainWhatsapp),
    Partner(name: 'Burguer Sport Club', category: 'Lanchonete', icon: Icons.sports_soccer, whatsapp: _mainWhatsapp),
    Partner(name: 'Coxinha Premium', category: 'Lanchonete', icon: Icons.set_meal, whatsapp: _mainWhatsapp),
    
    // Doces e Bolos
    Partner(name: 'Bru Delícias', category: 'Doces e Bolos', icon: Icons.cake, whatsapp: _mainWhatsapp),
    Partner(name: 'Cris Bolos e Doces', category: 'Doces e Bolos', icon: Icons.icecream_outlined, whatsapp: _mainWhatsapp),
    Partner(name: 'Doces Artesanais Santiago', category: 'Doces e Bolos', icon: Icons.cookie, whatsapp: _mainWhatsapp),
    Partner(name: 'Pipô Pipocas Gourmet', category: 'Doces e Bolos', icon: Icons.bakery_dining, whatsapp: _mainWhatsapp),
    Partner(name: 'El Shaddai Variedades', category: 'Doces e Bolos', icon: Icons.card_giftcard, whatsapp: _mainWhatsapp),

    // Outros
    Partner(name: 'Marmitas da Fla', category: 'Refeições', icon: Icons.flatware, whatsapp: _mainWhatsapp),
    Partner(name: 'Padaria Califórnia', category: 'Padaria', icon: Icons.breakfast_dining, whatsapp: _mainWhatsapp),
    Partner(name: 'Tropical Açaí', category: 'Açaí', icon: Icons.icecream, whatsapp: _mainWhatsapp),
    Partner(name: 'Adega do Kaike', category: 'Adega e Bebidas', icon: Icons.local_bar, whatsapp: _mainWhatsapp),
    Partner(name: 'Damas Acessórios', category: 'Moda e Acessórios', icon: Icons.watch, whatsapp: _mainWhatsapp),
    Partner(name: 'Moda & Variedades GK', category: 'Moda e Acessórios', icon: Icons.checkroom, whatsapp: _mainWhatsapp),
  ];

  final List<Category> _categories = [
    Category('Lanchonete', Icons.restaurant),
    Category('Doces e Bolos', Icons.cake),
    Category('Mercado', Icons.shopping_basket),
    Category('Farmácia', Icons.local_pharmacy),
    Category('Refeições', Icons.flatware),
    Category('Padaria', Icons.bakery_dining),
    Category('Açaí', Icons.icecream),
    Category('Adega e Bebidas', Icons.local_bar),
    Category('Moda e Acessórios', Icons.checkroom),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compra Fácil Sarapuí', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
            onPressed: () => _goToAdmin(),
          )
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildCategoryGrid()),
          _buildInstagramButton(),
        ],
      ),
    );
  }

  void _goToAdmin() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminPage(partners: _partners)),
    );
    setState(() {});
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/logo.png',
            height: 120,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.shopping_bag, size: 80, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 10),
          const Text('O que você precisa hoje?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.2,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final cat = _categories[index];
        return InkWell(
          onTap: () {
            final filteredPartners = _partners.where((p) => p.category == cat.name).toList();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryPartnersPage(categoryName: cat.name, partners: filteredPartners),
              ),
            );
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(cat.icon, size: 40, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(height: 8),
                Text(cat.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstagramButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton.icon(
        onPressed: () => launchUrl(Uri.parse("https://www.instagram.com/comprafacilsarapui.015")),
        icon: const Icon(Icons.camera_alt),
        label: const Text('Nosso Instagram'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

class CategoryPartnersPage extends StatelessWidget {
  final String categoryName;
  final List<Partner> partners;

  const CategoryPartnersPage({super.key, required this.categoryName, required this.partners});

  Future<void> _openWhatsApp(BuildContext context, Partner partner) async {
    final message = 'Olá! Gostaria de fazer um pedido para ${partner.name} (${partner.category}) pelo Compra Fácil.';
    final whatsappUrl = Uri.parse("https://wa.me/${partner.whatsapp}?text=${Uri.encodeComponent(message)}");
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName, style: const TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: partners.isEmpty
          ? const Center(child: Text('Nenhum estabelecimento cadastrado aqui ainda.'))
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: partners.length,
              itemBuilder: (context, index) {
                final p = partners[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      child: Icon(p.icon, color: Theme.of(context).colorScheme.primary),
                    ),
                    title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: const Text('Clique para pedir pelo WhatsApp'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openWhatsApp(context, p),
                  ),
                );
              },
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
  void _addPartner() {
    showDialog(
      context: context,
      builder: (context) {
        String name = '';
        String category = 'Mercado';
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Novo Parceiro'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(onChanged: (v) => name = v, decoration: const InputDecoration(labelText: 'Nome do Local')),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: category,
                  isExpanded: true,
                  items: ['Mercado', 'Farmácia', 'Lanchonete', 'Padaria', 'Açaí', 'Doces e Bolos', 'Refeições', 'Adega e Bebidas', 'Moda e Acessórios']
                      .map((String value) => DropdownMenuItem<String>(value: value, child: Text(value)))
                      .toList(),
                  onChanged: (v) => setDialogState(() => category = v!),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.partners.add(Partner(
                      name: name,
                      category: category,
                      icon: Icons.store,
                      whatsapp: '5515997382031',
                    ));
                  });
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Admin', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: widget.partners.length,
        itemBuilder: (context, index) {
          final p = widget.partners[index];
          return ListTile(
            leading: Icon(p.icon),
            title: Text(p.name),
            subtitle: Text(p.category),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => setState(() => widget.partners.removeAt(index)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPartner,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
