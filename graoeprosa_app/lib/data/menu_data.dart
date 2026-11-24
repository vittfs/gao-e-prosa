import '../models/product.dart';
import '../theme.dart';

class MenuData {
  static const List<Product> products = [
    Product(
      id: 'cappuccino',
      name: 'Cappuccino',
      shortSubtitle: 'Cremoso e intenso',
      description:
          'Espresso com leite vaporizado e uma camada de espuma cremosa.',
      basePrice: 11.00,
      category: 'Cafés',
      cardColor: AppTheme.terracotta,
      isFeatured: true,
      options: [
        ProductOption(label: 'Pequeno', priceDelta: 0.0),
        ProductOption(label: 'Médio', priceDelta: 3.0),
        ProductOption(label: 'Grande', priceDelta: 5.0),
      ],
    ),
    Product(
      id: 'pao_de_queijo',
      name: 'Pão de queijo',
      shortSubtitle: 'Saído do forno',
      description:
          'Receita tradicional mineira com queijo curado, casquinha crocante e interior macio.',
      basePrice: 9.00,
      category: 'Salgados',
      cardColor: AppTheme.ochre,
      isFeatured: true,
      options: [
        ProductOption(label: '6 un.', priceDelta: 0.0),
        ProductOption(label: '12 un.', priceDelta: 7.0),
        ProductOption(label: '24 un.', priceDelta: 19.0),
      ],
    ),
  ];
}
