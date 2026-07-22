import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const partnerYellow = Color(0xFFF4C542);
const partnerYellowSoft = Color(0xFFFFF5C9);
const partnerYellowInk = Color(0xFF332B08);

String buildPartnerLeadMessage() {
  return '''🤝 *QUERO SER PARCEIRO — COMPRA FÁCIL*

Olá! Quero entender como cadastrar meu negócio no Compra Fácil Sarapuí.

🏪 *Nome do negócio:*
📂 *Categoria:*
👤 *Responsável:*

_Mensagem enviada pelo Compra Fácil Sarapuí._''';
}

class PartnerProgramPage extends StatelessWidget {
  final String whatsapp;

  const PartnerProgramPage({super.key, required this.whatsapp});

  Future<void> _openWhatsApp(BuildContext context) async {
    final message = buildPartnerLeadMessage();
    final url = Uri.parse(
      'https://wa.me/$whatsapp?text=${Uri.encodeComponent(message)}',
    );
    final didOpen = await launchUrl(url, mode: LaunchMode.externalApplication);

    if (!didOpen && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seja um parceiro')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 24),
                sliver: SliverToBoxAdapter(child: _PartnerHero()),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vantagens para o seu negócio',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Uma operação simples para transformar interesse em pedido.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final benefit = _benefits[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _BenefitCard(benefit: benefit),
                    );
                  }, childCount: _benefits.length),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 14, 20, 10),
                sliver: SliverToBoxAdapter(child: _HowItWorks()),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  24 + MediaQuery.paddingOf(context).bottom,
                ),
                sliver: SliverToBoxAdapter(
                  child: _CommercialNote(onTap: () => _openWhatsApp(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PartnerHero extends StatelessWidget {
  const _PartnerHero();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.lerp(colors.primary, Colors.black, 0.3)!,
            colors.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: partnerYellow,
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.handshake_rounded,
              color: partnerYellowInk,
              size: 29,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Venda mais perto de quem já compra de você',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'Entre no catálogo local do Compra Fácil e receba pedidos estruturados diretamente no WhatsApp.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: const Color(0xFFDCEBDF)),
          ),
        ],
      ),
    );
  }
}

class _Benefit {
  final IconData icon;
  final String title;
  final String description;

  const _Benefit({
    required this.icon,
    required this.title,
    required this.description,
  });
}

const _benefits = [
  _Benefit(
    icon: Icons.receipt_long_rounded,
    title: 'Pedidos mais organizados',
    description:
        'Tamanho, opções, quantidade, entrega e observações chegam estruturados em uma única mensagem.',
  ),
  _Benefit(
    icon: Icons.tune_rounded,
    title: 'Catálogo personalizado',
    description:
        'Produtos podem ter tamanhos, sabores, complementos e regras próprias de seleção.',
  ),
  _Benefit(
    icon: Icons.chat_bubble_rounded,
    title: 'Receba pelo WhatsApp',
    description:
        'O pedido chega no canal que sua operação já utiliza, com menos troca de mensagens para confirmar detalhes.',
  ),
  _Benefit(
    icon: Icons.delivery_dining_rounded,
    title: 'Entrega ou retirada',
    description:
        'O cliente escolhe como quer receber e a modalidade chega identificada no pedido.',
  ),
  _Benefit(
    icon: Icons.location_on_rounded,
    title: 'Presença no comércio local',
    description:
        'Seu negócio aparece por categoria para clientes que já estão procurando onde comprar em Sarapuí.',
  ),
];

class _BenefitCard extends StatelessWidget {
  final _Benefit benefit;

  const _BenefitCard({required this.benefit});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(benefit.icon, color: colors.primary, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    benefit.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    benefit.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HowItWorks extends StatelessWidget {
  const _HowItWorks();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Como funciona',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const _ProcessStep(
              number: '1',
              title: 'Você envia o cardápio',
              description: 'Produtos, opções e WhatsApp do estabelecimento.',
            ),
            const _ProcessDivider(),
            const _ProcessStep(
              number: '2',
              title: 'O catálogo é configurado',
              description:
                  'Organizamos as escolhas necessárias de cada produto.',
            ),
            const _ProcessDivider(),
            const _ProcessStep(
              number: '3',
              title: 'Você começa a receber pedidos',
              description:
                  'Cada pedido chega pronto para confirmar no WhatsApp.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ProcessStep extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _ProcessStep({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: partnerYellow,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: partnerYellowInk,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 3),
              Text(description, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProcessDivider extends StatelessWidget {
  const _ProcessDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 16,
      margin: const EdgeInsets.only(left: 14, top: 5, bottom: 5),
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}

class _CommercialNote extends StatelessWidget {
  final VoidCallback onTap;

  const _CommercialNote({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: partnerYellowSoft,
        border: Border.all(color: partnerYellow.withValues(alpha: 0.8)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quer colocar seu negócio no catálogo?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Fale com a equipe para apresentar seu negócio e conhecer as condições comerciais.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              key: const Key('partner-whatsapp-button'),
              onPressed: onTap,
              style: FilledButton.styleFrom(
                backgroundColor: partnerYellow,
                foregroundColor: partnerYellowInk,
              ),
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              label: const Text('Quero cadastrar meu negócio'),
            ),
          ),
        ],
      ),
    );
  }
}
