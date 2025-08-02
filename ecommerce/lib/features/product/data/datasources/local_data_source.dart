import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  /// Get cached products
  Future<List<ProductModel>> getCachedProducts();

  /// Cache products locally
  Future<void> cacheProducts(List<ProductModel> products);

  /// Create a product locally (optional, for offline mode)
  Future<void> createProduct(ProductModel product);

  /// Update a cached product
  Future<void> updateProduct(ProductModel product);

  /// Delete a cached product
  Future<void> deleteProduct(String id);
}
