import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'cart_screen.dart';
import 'contact_screen.dart';
import 'home_screen.dart';
import 'menu_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openCart() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CartScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    final screens = [
      HomeScreen(
        onOpenMenuDrawer: () => _scaffoldKey.currentState?.openEndDrawer(),
        onExploreMenu: () => _selectTab(1),
      ),
      MenuScreen(onBack: () => _selectTab(0)),
      ContactScreen(onBack: () => _selectTab(0)),
    ];

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        backgroundColor: AppTheme.background,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Grão & Prosa',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  title: const Text(
                    'Início',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _selectTab(0);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Cardápio',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _selectTab(1);
                  },
                ),
                ListTile(
                  title: Text(
                    'Carrinho (${cart.totalCount})',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: cart.totalCount > 0
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.terracotta,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${cart.totalCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    _openCart();
                  },
                ),
                ListTile(
                  title: const Text(
                    'Contato',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _selectTab(2);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: PrototypeBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _selectTab,
      ),
    );
  }
}
