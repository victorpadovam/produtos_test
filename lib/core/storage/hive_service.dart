import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../features/produtos/data/models/produto_model.dart';

@lazySingleton
class HiveService {
  static const String productsBox = 'produtos_box_hive';

  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(
      ProdutoModelAdapter(),
    );

    await Hive.openBox<List>(
      productsBox,
    );
  }

  Box<List> getProductsBox() {
    return Hive.box<List>(
      productsBox,
    );
  }

  Future<void> clearProductsCache() async {
    await Hive.box<List>(
      productsBox,
    ).clear();
  }
}
