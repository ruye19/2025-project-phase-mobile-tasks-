# ✅ Ecommerce App – Task 13: Implement Network Info

This task enhances the **Ecommerce app** by introducing **network connectivity detection** using `internet_connection_checker` and improving **error handling** when the device is offline. The feature ensures a better user experience by using **remote data when online** and **cached data when offline**.

---

## 📂 **Project Structure**
```
lib/
 ├── core/
 │    └── network/
 │         └── network_info.dart            # NetworkInfo interface and implementation
 └── features/
      └── product/
           ├── data/
           │    ├── datasources/
           │    │    ├── local_data_source.dart    # Local cache logic
           │    │    └── remote_data_source.dart   # Remote API logic
           │    ├── repositories/
           │    │    └── product_repository_impl.dart # Repository implementation with network check
           │    └── models/product_model.dart
           └── domain/
                ├── entities/product.dart
                └── repositories/product_repository.dart # Repository contract

test/
 ├── core/network/network_info_test.dart          # Unit test for NetworkInfo
 └── features/product/data/repositories/product_repository_impl_test.dart # Repository tests
```

---

## ✅ **What Was Added in Task 13**
✔ Implemented **NetworkInfo** using `internet_connection_checker`  
✔ Integrated **NetworkInfo** into repository  
✔ Added **error handling** for no network and empty cache  
✔ Wrote **unit tests** for NetworkInfo  

---

## ✅ **NetworkInfo Implementation**
`lib/core/network/network_info.dart`:
```dart
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
```

---

## ✅ **Repository with Error Handling**
Example from `ProductRepositoryImpl`:
```dart
@override
Future<List<Product>> getAllProducts() async {
  if (await networkInfo.isConnected) {
    try {
      final remoteProducts = await remoteDataSource.fetchProducts();
      await localDataSource.cacheProducts(remoteProducts);
      return remoteProducts;
    } catch (e) {
      throw Exception('Failed to fetch products from remote: $e');
    }
  } else {
    final cachedProducts = await localDataSource.getCachedProducts();
    if (cachedProducts.isEmpty) {
      throw Exception('No internet and no cached data available');
    }
    return cachedProducts;
  }
}
```

---

## ✅ **Add Dependency**
In `pubspec.yaml`:
```yaml
dependencies:
  internet_connection_checker: ^1.0.0+1
```

Install:
```bash
flutter pub get
```

---

## ✅ **Unit Testing for NetworkInfo**
`test/core/network/network_info_test.dart`:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockConnectionChecker);
  });

  test('should forward the call to InternetConnectionChecker.hasConnection', () async {
    final tHasConnectionFuture = Future.value(true);

    when(mockConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);

    final result = networkInfoImpl.isConnected;

    expect(result, tHasConnectionFuture);
    verify(mockConnectionChecker.hasConnection);
  });
}
```

Generate mocks:
```bash
dart run build_runner build
```

---

## ✅ **Run All Tests**
```bash
flutter test
```

**Expected Output:**
```
00:07 +10: All tests passed!
```

---

## ✅ **Packages Used**
- `internet_connection_checker` – Check internet connectivity.
- `mockito` – For mocking dependencies in tests.
- `build_runner` – For generating mocks.

---

## ✅ **Architecture Diagram**
```
UI → Bloc → Use Case → Repository
                |
          Domain Contract
                |
            Data Layer
        ┌────────────┬─────────────┐
   LocalDataSource   RemoteDataSource
                |
        NetworkInfo → InternetConnectionChecker
```

---

## ✅ **Git Commands**
Commit and push changes:
```bash
git add .
git commit -m "Task 13: Implement NetworkInfo with InternetConnectionChecker and error handling"
git push origin task_13
```

---

## ✅ **Next Steps**
- Implement **real RemoteDataSource** with API integration.
- Implement **LocalDataSource** with SharedPreferences or SQLite.
- Integrate **Bloc & UI**.

