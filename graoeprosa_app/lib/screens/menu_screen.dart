import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../theme.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _category = categories.first;

  @override
  Widget build(BuildContext context) {
    final items = _category == 'Todos'
        ? menu
        : menu.where((p) => p.category == _category).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PageHeader(title: 'Cardápio', onBack: widget.onBack),
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final selected = _category == categories[i];
              return ChoiceChip(
                label: Text(categories[i]),
                selected: selected,
                showCheckmark: false,
                onSelected: (_) => setState(() => _category = categories[i]),
                backgroundColor: Colors.white,
                selectedColor: espresso,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: selected ? Colors.white : espresso,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final p = items[i];
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: p.color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                          const SizedBox(height: 2),
                          Text(p.description, style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    Text(
                      p.priceLabel,
                      style: const TextStyle(color: terracotta, fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 20, 8),
      child: Row(
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.chevron_left, size: 28)),
          Text(title, style: displayStyle(26)),
        ],
      ),
    );
  }
}
