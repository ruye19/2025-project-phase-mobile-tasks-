import 'package:dio/dio.dart';
import 'package:ecommerce/core/error/exceptions.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/data/datasources/remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;
  final String baseUrl = 'https://api.example.com';

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await dio.get('$baseUrl/products');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException();
      }
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> fetchProductById(String id) async {
    try {
      final response = await dio.get('$baseUrl/products/$id');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException();
      }
      throw ServerException();
    }
  }

  @override
  Future<void> createProduct(ProductModel product) async {
    try {
      final response = await dio.post(
        '$baseUrl/products',
        data: product.toJson(),
      );
      if (response.statusCode != 201) {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException();
      }
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final response = await dio.put(
        '$baseUrl/products/${product.id}',
        data: product.toJson(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException();
      }
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      final response = await dio.delete('$baseUrl/products/$id');
      if (response.statusCode != 204) {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException();
      }
      throw ServerException();
    }
  }
}


  abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> fetchProductById(String id);
  Future<void> createProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

