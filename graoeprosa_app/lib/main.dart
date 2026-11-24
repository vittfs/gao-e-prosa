import 'package:flutter/material.dart';
import 'screens/shell_screen.dart';
import 'services/cart_service.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GraoEProsaApp());
}

class GraoEProsaApp extends StatefulWidget {
  const GraoEProsaApp({super.key});

  @override
  State<GraoEProsaApp> createState() => _GraoEProsaAppState();
}

class _GraoEProsaAppState extends State<GraoEProsaApp> {
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return CartScope(
      cartService: _cartService,
      child: MaterialApp(
        title: 'Grão & Prosa',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const ShellScreen(),
      ),
    );
  }
}
