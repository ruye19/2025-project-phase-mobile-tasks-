import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUseCase {
  final ProductRepository repository;

  ViewAllProductsUseCase(this.repository);

  Future<List<Product>> call() {
    return repository.getAllProducts();
  }
}
