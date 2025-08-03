import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/features/product/data/datasources/local_data_source.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late SharedPreferences sharedPreferences;

  const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    dataSource = ProductLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'A sample product for testing',
    imageUrl: 'http://example.com/image.png',
    price: 29.99,
  );

  final tProductList = [tProductModel];

  test('should cache products in SharedPreferences', () async {
    await dataSource.cacheProducts(tProductList);

    final result = sharedPreferences.getString(CACHED_PRODUCTS);
    expect(result, isNotNull);

    final decoded = json.decode(result!);
    expect(decoded, isA<List>());
  });

  test('should return cached products if present', () async {
    await sharedPreferences.setString(
        CACHED_PRODUCTS, json.encode(tProductList.map((p) => p.toJson()).toList()));

    final result = await dataSource.getCachedProducts();
    expect(result.length, 1);
    expect(result.first.name, 'Test Product');
  });

  test('should return empty list if no cache exists', () async {
    final result = await dataSource.getCachedProducts();
    expect(result, []);
  });

  test('should create a new product and save it', () async {
    await dataSource.createProduct(tProductModel);
    final result = await dataSource.getCachedProducts();
    expect(result.length, 1);
  });

  test('should update an existing product', () async {
    await dataSource.createProduct(tProductModel);
    final updatedProduct = tProductModel.copyWith(name: 'Updated Product');
    await dataSource.updateProduct(updatedProduct);

    final result = await dataSource.getCachedProducts();
    expect(result.first.name, 'Updated Product');
  });

  test('should delete a product by id', () async {
    await dataSource.createProduct(tProductModel);
    await dataSource.deleteProduct(tProductModel.id);

    final result = await dataSource.getCachedProducts();
    expect(result, []);
  });
}
