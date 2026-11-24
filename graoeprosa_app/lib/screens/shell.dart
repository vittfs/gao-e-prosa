import 'package:flutter/material.dart';

import '../theme.dart';
import 'contact_screen.dart';
import 'home_screen.dart';
import 'menu_screen.dart';

const _labels = ['Início', 'Cardápio', 'Contato'];

/// Largura máxima do conteúdo: mantém o layout de celular em tablets e na web.
const _maxContentWidth = 560.0;

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 0;

  void _go(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        onOpenMenu: () => _go(1),
        onOpenDrawer: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      MenuScreen(onBack: () => _go(0)),
      ContactScreen(onBack: () => _go(0)),
    ];

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        backgroundColor: cream,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text('Grão & Prosa', style: displayStyle(22)),
              const SizedBox(height: 16),
              for (var i = 0; i < _labels.length; i++)
                ListTile(
                  title: Text(
                    _labels[i],
                    style: TextStyle(
                      fontWeight: i == _index ? FontWeight.w700 : FontWeight.w500,
                      color: i == _index ? terracotta : espresso,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _go(i);
                  },
                ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxContentWidth),
            child: IndexedStack(index: _index, children: pages),
          ),
        ),
      ),
      bottomNavigationBar: _BottomBar(index: _index, onTap: _go),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.index, required this.onTap});

  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: fieldBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxContentWidth),
            child: SizedBox(
              height: 56,
              child: Row(
                children: [
                  for (var i = 0; i < _labels.length; i++)
                    Expanded(
                      child: InkWell(
                        onTap: () => onTap(i),
                        child: Center(
                          child: Text(
                            _labels[i],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: i == index ? FontWeight.w700 : FontWeight.w500,
                              color: i == index ? terracotta : espresso,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
