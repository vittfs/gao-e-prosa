import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../theme.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onOpenMenuDrawer;
  final VoidCallback onExploreMenu;

  const HomeScreen({
    super.key,
    required this.onOpenMenuDrawer,
    required this.onExploreMenu,
  });

  @override
  Widget build(BuildContext context) {
    final featured = MenuData.products.where((p) => p.isFeatured).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho: "Grão & Prosa" à esquerda e ícone de menu à direita
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grão & Prosa',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: AppTheme.textDark),
                onPressed: onOpenMenuDrawer,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Banner terracota com círculos decorativos e texto "Café fresco, todo dia."
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              width: double.infinity,
              height: 205,
              color: AppTheme.terracotta,
              child: Stack(
                children: [
                  Positioned(
                    right: -25,
                    top: -30,
                    child: Container(
                      width: 175,
                      height: 175,
                      decoration: const BoxDecoration(
                        color: AppTheme.terracottaLight,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 45,
                    top: 42,
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: const BoxDecoration(
                        color: AppTheme.background,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    bottom: 22,
                    child: Text(
                      'Café fresco,\ntodo dia.',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                                fontSize: 27,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),
          Text(
            'Grãos selecionados, pães quentes e um cantinho para ficar à vontade.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textDark,
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 18),

          // Botão pílula escuro "Ver cardápio"
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onExploreMenu,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryDark,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'Ver cardápio',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 26),
          Text(
            'Destaques',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          // Cards lado a lado dos destaques
          Row(
            children: List.generate(featured.length, (index) {
              final product = featured[index];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == 0 ? 7 : 0,
                    left: index == 1 ? 7 : 0,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.shortSubtitle,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 12.5,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppTheme.formatPrice(product.basePrice),
                            style: const TextStyle(
                              color: AppTheme.terracotta,
                              fontWeight: FontWeight.w800,
                              fontSize: 13.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
