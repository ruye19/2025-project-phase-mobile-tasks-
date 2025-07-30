import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ViewProductUseCase {
  final ProductRepository repository;

  ViewProductUseCase(this.repository);

  Future<Product?> call(String id) {
    return repository.getProductById(id);
  }
}
