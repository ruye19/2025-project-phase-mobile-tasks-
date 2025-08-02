import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/product_model.dart';

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
      final remoteProducts = await remoteDataSource.fetchProducts();
      await localDataSource.cacheProducts(remoteProducts);
      return remoteProducts;
    } else {
      return await localDataSource.getCachedProducts();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.fetchProductById(id);
    } else {
      final cachedProducts = await localDataSource.getCachedProducts();
      return cachedProducts.firstWhere((p) => p.id == id);
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    final productModel = ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    );

    if (await networkInfo.isConnected) {
      await remoteDataSource.createProduct(productModel);
    }
    await localDataSource.createProduct(productModel);
  }

  @override
  Future<void> updateProduct(Product product) async {
    final productModel = ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    );

    if (await networkInfo.isConnected) {
      await remoteDataSource.updateProduct(productModel);
    }
    await localDataSource.updateProduct(productModel);
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.deleteProduct(id);
    }
    await localDataSource.deleteProduct(id);
  }
}
