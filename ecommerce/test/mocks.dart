import 'package:mockito/annotations.dart';
import 'package:ecommerce/features/product/data/datasources/local_data_source.dart';
import 'package:ecommerce/features/product/data/datasources/remote_data_source.dart';
import 'package:ecommerce/core/network/network_info.dart';

@GenerateMocks([
  ProductRemoteDataSource,
  ProductLocalDataSource,
  NetworkInfo,
])
void main() {}
