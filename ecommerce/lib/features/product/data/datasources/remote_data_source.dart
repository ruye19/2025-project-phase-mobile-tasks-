import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// Fetch all products from API
  Future<List<ProductModel>> fetchProducts();

  /// Fetch a single product by ID from API
  Future<ProductModel> fetchProductById(String id);

  /// Create a new product on API
  Future<void> createProduct(ProductModel product);

  /// Update product on API
  Future<void> updateProduct(ProductModel product);

  /// Delete product from API
  Future<void> deleteProduct(String id);
}
