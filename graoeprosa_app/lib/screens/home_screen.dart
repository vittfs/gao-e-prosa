import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onOpenMenu, required this.onOpenDrawer});

  final VoidCallback onOpenMenu;
  final VoidCallback onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text('Grão & Prosa', style: displayStyle(22))),
            IconButton(
              onPressed: onOpenDrawer,
              tooltip: 'Menu',
              icon: const Icon(Icons.menu, color: espresso),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const _Hero(),
        const SizedBox(height: 16),
        const Text(
          'Grãos selecionados, pães quentes e um cantinho para ficar à vontade.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 52,
          child: FilledButton(
            onPressed: onOpenMenu,
            style: FilledButton.styleFrom(
              backgroundColor: espresso,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
              textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            child: const Text('Ver cardápio'),
          ),
        ),
        const SizedBox(height: 24),
        Text('Destaques', style: displayStyle(20)),
        const SizedBox(height: 12),
        Row(
          children: [
            for (var i = 0; i < highlights.length; i++) ...[
              if (i > 0) const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(highlights[i].name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text(highlights[i].description, style: const TextStyle(fontSize: 13)),
                      const SizedBox(height: 10),
                      Text(
                        highlights[i].priceLabel,
                        style: const TextStyle(color: terracotta, fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 176,
        color: terracotta,
        child: Stack(
          children: [
            const Positioned(
              top: -40,
              right: -30,
              child: _Circle(size: 170, color: caramel),
            ),
            const Positioned(
              top: 30,
              right: 42,
              child: _Circle(size: 74, color: cream),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Text(
                'Café fresco,\ntodo dia.',
                style: displayStyle(30).copyWith(color: cream, height: 1.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}
