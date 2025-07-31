import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:ecommerce/data/mock_product_repository.dart';

void main() {
  late DeleteProductUseCase deleteProductUseCase;
  late MockProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
    deleteProductUseCase = DeleteProductUseCase(repository);
  });

  test('should delete a product by id', () async {
    // Arrange
    final product = Product(
      id: '1',
      name: 'Laptop',
      description: 'High-performance laptop',
      imageUrl: '',
      price: 1500.0,
    );
    await repository.createProduct(product);

    // Act
    await deleteProductUseCase('1');
    final products = await repository.getAllProducts();

    // Assert
    expect(products.isEmpty, true);
  });
}
