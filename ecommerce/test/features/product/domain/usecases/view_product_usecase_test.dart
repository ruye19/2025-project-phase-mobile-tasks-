import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
// Update the import path below if the file exists elsewhere, or create the file at the specified path.
import 'package:ecommerce/features/product/domain/usecases/view_product_usecase.dart';
import 'package:ecommerce/data/mock_product_repository.dart';

void main() {
  late ViewProductUseCase viewProductUseCase;
  late MockProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
    viewProductUseCase = ViewProductUseCase(repository);
  });

  test('should return product by id', () async {
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
    final result = await viewProductUseCase('1');

    // Assert
    expect(result?.name, 'Laptop');
  });
}
