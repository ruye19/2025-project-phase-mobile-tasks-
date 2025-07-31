import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/usecases/create_product_usecase.dart';
import 'package:ecommerce/data/mock_product_repository.dart';

void main() {
  late CreateProductUseCase createProductUseCase;
  late MockProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
    createProductUseCase = CreateProductUseCase(repository);
  });

  test('should create a new product', () async {
    // Arrange
    final product = Product(
      id: '1',
      name: 'Laptop',
      description: 'High-performance laptop',
      imageUrl: '',
      price: 1500.0,
    );

    // Act
    await createProductUseCase(product);
    final products = await repository.getAllProducts();

    // Assert
    expect(products.length, 1);
    expect(products.first.name, 'Laptop');
  });
}
