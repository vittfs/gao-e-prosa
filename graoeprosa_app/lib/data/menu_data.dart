import '../models/product.dart';
import '../theme.dart';

const categories = ['Todos', 'Cafés', 'Salgados'];

// Preços de exemplo: troque pelos valores reais da cafeteria.
const menu = <Product>[
  Product(name: 'Expresso', description: 'Curto e encorpado', price: 6.00, category: 'Cafés', color: espresso),
  Product(name: 'Cappuccino', description: 'Cremoso e intenso', price: 12.00, category: 'Cafés', color: terracotta, featured: true),
  Product(name: 'Café coado', description: 'Passado na hora', price: 5.50, category: 'Cafés', color: caramel),
  Product(name: 'Latte', description: 'Suave, com leite vaporizado', price: 13.00, category: 'Cafés', color: mustard),
  Product(name: 'Pão de queijo', description: 'Saído do forno', price: 6.50, category: 'Salgados', color: mustard, featured: true),
  Product(name: 'Coxinha', description: 'Frango cremoso e massa crocante', price: 8.00, category: 'Salgados', color: caramel),
  Product(name: 'Misto quente', description: 'Presunto e queijo na chapa', price: 12.00, category: 'Salgados', color: terracotta),
  Product(name: 'Empada de frango', description: 'Massa amanteigada', price: 9.00, category: 'Salgados', color: espresso),
];

final highlights = menu.where((p) => p.featured).toList();
