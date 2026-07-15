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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de parceiros (Pode ser inicializada de um banco de dados)
  final List<Partner> _partners = [
    Partner(name: 'Mercado do Zé', category: 'Mercado', icon: Icons.shopping_cart, whatsapp: '5515997382031'),
    Partner(name: 'Farmácia Central', category: 'Farmácia', icon: Icons.medical_services, whatsapp: '5515997382031'),
    Partner(name: 'Burger King', category: 'Lanches', icon: Icons.fastfood, whatsapp: '5515997382031'),
    Partner(name: 'Padaria Pão Quente', category: 'Padaria', icon: Icons.bakery_dining, whatsapp: '5515997382031'),
    Partner(name: 'Açaí da Vila', category: 'Açaí', icon: Icons.icecream, whatsapp: '5515997382031'),
    Partner(name: 'Táxi/Corridas', category: 'Corridas', icon: Icons.local_taxi, whatsapp: '5515997382031'),
  ];

  Future<void> _openWhatsApp(Partner partner) async {
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
          Expanded(child: _buildGrid()),
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
    setState(() {}); // Atualiza a tela ao voltar do admin
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
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.shopping_bag_outlined, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text('O que você precisa hoje?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.9,
      ),
      itemCount: _partners.length,
      itemBuilder: (context, index) {
        final partner = _partners[index];
        return InkWell(
          onTap: () => _openWhatsApp(partner),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(partner.icon, size: 40, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 10),
                Text(partner.category, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(partner.name, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
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

// --- TELA DE PAINEL ADMINISTRATIVO ---
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
        String category = '';
        return AlertDialog(
          title: const Text('Novo Parceiro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(onChanged: (v) => name = v, decoration: const InputDecoration(labelText: 'Nome')),
              TextField(onChanged: (v) => category = v, decoration: const InputDecoration(labelText: 'Categoria')),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Painel Compra Fácil'), backgroundColor: Colors.black, foregroundColor: Colors.white),
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
