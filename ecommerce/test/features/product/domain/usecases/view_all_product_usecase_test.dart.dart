import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/usecases/view_all_products_usecase.dart';
import 'package:ecommerce/data/mock_product_repository.dart';

void main() {
  late ViewAllProductsUseCase viewAllProductsUseCase;
  late MockProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
    viewAllProductsUseCase = ViewAllProductsUseCase(repository);
  });

  test('should return all products', () async {
    // Arrange
    await repository.createProduct(Product(
      id: '1',
      name: 'Laptop',
      description: 'High-performance laptop',
      imageUrl: '',
      price: 1500.0,
    ));

    await repository.createProduct(Product(
      id: '2',
      name: 'Phone',
      description: 'Smartphone',
      imageUrl: '',
      price: 800.0,
    ));

    // Act
    final products = await viewAllProductsUseCase();

    // Assert
    expect(products.length, 2);
    expect(products[0].name, 'Laptop');
    expect(products[1].name, 'Phone');
  });
}
