import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';

import '../../utils/fixture_reader.dart';

void main() {
  late ProductModel testProductModel;
  testProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'A sample product for testing',
    imageUrl: 'http://example.com/image.png',
    price: 29.99,
  );

  test('should be a subclass of Product entity', () {
    expect(testProductModel, isA<Product>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // Arrange
      final jsonMap = json.decode(fixture('product.json')) as Map<String, dynamic>;
      // Act
      final result = ProductModel.fromJson(jsonMap);
      // Assert
      expect(result, equals(testProductModel));
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      final result = testProductModel.toJson();
      final expectedMap = {
        'id': '1',
        'name': 'Test Product',
        'description': 'A sample product for testing',
        'imageUrl': 'http://example.com/image.png',
        'price': 29.99,
      };
      expect(result, equals(expectedMap));
    });
  });
}
