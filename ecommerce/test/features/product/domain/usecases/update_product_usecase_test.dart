import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/usecases/update_product_usecase.dart';
import 'package:ecommerce/data/mock_product_repository.dart';

void main() {
  late UpdateProductUseCase updateProductUseCase;
  late MockProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
    updateProductUseCase = UpdateProductUseCase(repository);
  });

  test('should update an existing product', () async {
    // Arrange
    final product = Product(
      id: '1',
      name: 'Laptop',
      description: 'High-performance laptop',
      imageUrl: '',
      price: 1500.0,
    );
    await repository.createProduct(product);

    final updatedProduct = Product(
      id: '1',
      name: 'Laptop Updated',
      description: 'Updated laptop description',
      imageUrl: '',
      price: 1600.0,
    );

    // Act
    await updateProductUseCase(updatedProduct);
    final products = await repository.getAllProducts();

    // Assert
    expect(products.first.name, 'Laptop Updated');
    expect(products.first.price, 1600.0);
  });
}
