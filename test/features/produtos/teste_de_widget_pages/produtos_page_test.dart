import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:produtos_test/features/produtos/domain/entities/produto_entity.dart';
import 'package:produtos_test/features/produtos/presentation/widgets/card_produto.dart';

void main() {
  final product = ProdutoEntity(
    id: 1,
    title: 'Produto Teste',
    price: 10.0,
    description: 'Descrição',
    category: 'Categoria',
    image: 'https://teste.com/image.png',
    rating: 4.5,
    ratingCount: 100,
  );

  testWidgets(
    'deve renderizar card do produto',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardProduto(
              product: product,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(
        find.text('Produto Teste'),
        findsOneWidget,
      );

      expect(
        find.text('Categoria'),
        findsOneWidget,
      );

      expect(
        find.text('R\$ 10.00'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'deve clicar no card',
    (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardProduto(
              product: product,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(
        find.byType(InkWell),
      );

      await tester.pump();

      expect(tapped, true);
    },
  );
}
