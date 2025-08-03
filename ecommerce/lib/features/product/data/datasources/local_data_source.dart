import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> createProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final jsonList = products.map((p) => p.toJson()).toList();
    await sharedPreferences.setString(CACHED_PRODUCTS, json.encode(jsonList));
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCTS);
    if (jsonString != null) {
      final List<dynamic> decodedList = json.decode(jsonString);
      return decodedList.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> createProduct(ProductModel product) async {
    final currentProducts = await getCachedProducts();
    currentProducts.add(product);
    await cacheProducts(currentProducts);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final currentProducts = await getCachedProducts();
    final index = currentProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      currentProducts[index] = product;
      await cacheProducts(currentProducts);
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final currentProducts = await getCachedProducts();
    currentProducts.removeWhere((p) => p.id == id);
    await cacheProducts(currentProducts);
  }
}
