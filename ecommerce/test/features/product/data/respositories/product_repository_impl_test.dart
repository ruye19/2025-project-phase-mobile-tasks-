import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';

// import '../../../../../mocks.mocks.dart';
import '../../../../mocks.mocks.dart';

// Ensure your mock class extends or implements the correct type
// Example (in your mocks.mocks.dart):
// class MockProductRemoteDataSource extends Mock implements ProductRemoteDataSource {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  var tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Description',
    imageUrl: 'http://example.com/image.png',
    price: 29.99,
  );

  var tProductList = [tProductModel];

  group('getAllProducts', () {
    test('should return remote data when online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.fetchProducts()).thenAnswer((_) async => tProductList);

      final result = await repository.getAllProducts();

      verify(mockRemoteDataSource.fetchProducts());
      verify(mockLocalDataSource.cacheProducts(tProductList));
      expect(result, equals(tProductList));
    });

    test('should return local data when offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getCachedProducts()).thenAnswer((_) async => tProductList);

      final result = await repository.getAllProducts();

      verifyNever(mockRemoteDataSource.fetchProducts());
      verify(mockLocalDataSource.getCachedProducts());
      expect(result, equals(tProductList));
    });
  });
}
