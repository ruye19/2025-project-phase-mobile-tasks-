import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce/features/product/data/datasources/remote_data_source_impl.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  late MockResponse mockResponse;

  setUp(() {
    mockDio = MockDio();
    mockResponse = MockResponse();
    dataSource = ProductRemoteDataSourceImpl(dio: mockDio);
  });

  group('fetchProducts', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      price: 100.0,
      description: 'Test description',
    );
    final tProductList = [tProductModel];

    test('should return List<ProductModel> when the response code is 200', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(200);
      when(mockResponse.data).thenReturn([tProductModel.toJson()]);
      when(mockDio.get(any)).thenAnswer((_) async => mockResponse);

      // act
      final result = await dataSource.fetchProducts();

      // assert
      verify(mockDio.get('/products'));
      expect(result, equals(tProductList));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(404);
      when(mockDio.get(any)).thenAnswer((_) async => mockResponse);

      // act & assert
      expect(() => dataSource.fetchProducts(),
          throwsA(isA<ServerException>()));
    });
  });

  group('fetchProductById', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      price: 100.0,
      description: 'Test description',
    );

    test('should return ProductModel when the response code is 200', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(200);
      when(mockResponse.data).thenReturn(tProductModel.toJson());
      when(mockDio.get('/products/1')).thenAnswer((_) async => mockResponse);

      // act
      final result = await dataSource.fetchProductById('1');

      // assert
      verify(mockDio.get('/products/1'));
      expect(result, equals(tProductModel));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(404);
      when(mockDio.get(any)).thenAnswer((_) async => mockResponse);

      // act & assert
      expect(() => dataSource.fetchProductById('1'),
          throwsA(isA<ServerException>()));
    });
  });

  group('createProduct', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      price: 100.0,
      description: 'Test description',
    );

    test('should complete successfully when the response code is 201', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(201);
      when(mockDio.post(
        any,
        data: tProductModel.toJson(),
      )).thenAnswer((_) async => mockResponse);

      // act
      await dataSource.createProduct(tProductModel);

      // assert
      verify(mockDio.post(
        '/products',
        data: tProductModel.toJson(),
      ));
    });

    test('should throw ServerException when the response code is not 201', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(400);
      when(mockDio.post(any, data: any)).thenAnswer((_) async => mockResponse);

      // act & assert
      expect(() => dataSource.createProduct(tProductModel),
          throwsA(isA<ServerException>()));
    });
  });

  group('updateProduct', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      price: 100.0,
      description: 'Test description',
    );

    test('should complete successfully when the response code is 200', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(200);
      when(mockDio.put(
        any,
        data: tProductModel.toJson(),
      )).thenAnswer((_) async => mockResponse);

      // act
      await dataSource.updateProduct(tProductModel);

      // assert
      verify(mockDio.put(
        '/products/1',
        data: tProductModel.toJson(),
      ));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(400);
      when(mockDio.put(any, data: any)).thenAnswer((_) async => mockResponse);

      // act & assert
      expect(() => dataSource.updateProduct(tProductModel),
          throwsA(isA<ServerException>()));
    });
  });

  group('deleteProduct', () {
    test('should complete successfully when the response code is 204', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(204);
      when(mockDio.delete('/products/1')).thenAnswer((_) async => mockResponse);

      // act
      await dataSource.deleteProduct('1');

      // assert
      verify(mockDio.delete('/products/1'));
    });

    test('should throw ServerException when the response code is not 204', () async {
      // arrange
      when(mockResponse.statusCode).thenReturn(404);
      when(mockDio.delete(any)).thenAnswer((_) async => mockResponse);

      // act & assert
      expect(() => dataSource.deleteProduct('1'),
          throwsA(isA<ServerException>()));
    });
  });
}
