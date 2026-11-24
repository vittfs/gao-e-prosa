import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import '../theme.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductOption _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.product.options.first;
  }

  double get _currentPrice =>
      widget.product.basePrice + _selectedOption.priceDelta;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão voltar "<"
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Card quadrado grande com anel bege no centro
              Container(
                width: double.infinity,
                height: 235,
                decoration: BoxDecoration(
                  color: widget.product.cardColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Container(
                    width: 118,
                    height: 118,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.background,
                        width: 22,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Nome à esquerda e Preço em terracota à direita
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.product.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 26,
                        ),
                  ),
                  Text(
                    AppTheme.formatPrice(_currentPrice),
                    style: const TextStyle(
                      color: AppTheme.terracotta,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Descrição do produto
              Text(
                widget.product.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textMuted,
                      fontSize: 14,
                    ),
              ),
              const SizedBox(height: 22),

              // Opções em pílula (Pequeno / Médio / Grande ou 6 un. / 12 un. / 24 un.)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.product.options.map((option) {
                  final isSelected = option.label == _selectedOption.label;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedOption = option),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryDark
                            : AppTheme.surface,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        option.label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppTheme.textDark,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              // Botão terracota "Fazer pedido"
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    cart.addItem(widget.product, _selectedOption);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.terracotta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Fazer pedido',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}