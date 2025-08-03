import 'package:ecommerce/core/network/network_info.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce/features/product/data/datasources/local_data_source.dart';
import 'package:ecommerce/features/product/data/datasources/remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.fetchProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return remoteProducts.map((model) => model as Product).toList();
      } catch (e) {
        throw Exception('Failed to fetch products from remote: $e');
      }
    } else {
      final cachedProducts = await localDataSource.getCachedProducts();
      if (cachedProducts.isEmpty) {
        throw Exception('No internet and no cached data available');
      }
      return cachedProducts.map((model) => model as Product).toList();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = await remoteDataSource.fetchProductById(id);
        return productModel as Product;
      } catch (e) {
        throw Exception('Failed to fetch product from remote: $e');
      }
    } else {
      final cachedProducts = await localDataSource.getCachedProducts();
      try {
        final productModel = cachedProducts.firstWhere((p) => p.id == id);
        return productModel as Product;
      } catch (_) {
        throw Exception('Product not found in cache.');
      }
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createProduct(product as dynamic);
      } catch (e) {
        throw Exception('Failed to create product remotely: $e');
      }
    }
    await localDataSource.createProduct(product as dynamic);
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateProduct(product as dynamic);
      } catch (e) {
        throw Exception('Failed to update product remotely: $e');
      }
    }
    await localDataSource.updateProduct(product as dynamic);
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
      } catch (e) {
        throw Exception('Failed to delete product remotely: $e');
      }
    }
    await localDataSource.deleteProduct(id);
  }
}
