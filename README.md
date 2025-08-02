# ✅ Ecommerce App – Task 12: Implement Repository

This task implements the **Repository layer** of the Ecommerce app following **Clean Architecture principles**. The repository interacts with **remote and local data sources** and decides which to use based on network availability.

---

## 📂 **Project Structure**
```
lib/
 ├── core/
 │    └── network/
 │         ├── network_info.dart          # Network check contract
 │         └── network_info_impl.dart     # Implementation using connectivity_plus
 └── features/
      └── product/
           ├── data/
           │    ├── datasources/
           │    │    ├── local_data_source.dart    # Local cache interface
           │    │    └── remote_data_source.dart   # Remote API interface
           │    ├── repositories/
           │    │    └── product_repository_impl.dart # Repository implementation
           │    └── models/product_model.dart      # Data model
           └── domain/
                ├── entities/product.dart          # Core entity
                └── repositories/product_repository.dart # Repository contract

test/
 └── features/
      └── product/
           └── data/
                └── repositories/
                     └── product_repository_impl_test.dart # Unit tests
```

---

## ✅ **Repository Logic**
The `ProductRepositoryImpl` acts as a mediator between:
- **Remote Data Source** → Handles API calls.
- **Local Data Source** → Handles caching for offline support.

### **Flow:**
- If **network is available**:
  - Fetch from **remote**.
  - Cache result in **local** storage.
- If **network is unavailable**:
  - Return data from **local** cache.

### **CRUD Operations**:
- `createProduct`, `updateProduct`, `deleteProduct`:
  - Execute on **remote** (if online).
  - Always update **local** cache.

---

## ✅ **Implemented Interfaces**

### **Domain Layer**
`ProductRepository`:
```dart
abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
}
```

---

### **Data Layer**
**Remote Data Source Contract**:
```dart
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> fetchProductById(String id);
  Future<void> createProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}
```

**Local Data Source Contract**:
```dart
abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> createProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}
```

---

### **Network Info**
`NetworkInfo`:
```dart
abstract class NetworkInfo {
  Future<bool> get isConnected;
}
```

`NetworkInfoImpl` uses `connectivity_plus`:
```dart
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
```

---

## ✅ **Unit Testing**

### **Tools Used**
- [mockito](https://pub.dev/packages/mockito)
- [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)

### **Test Coverage**
- ✅ Fetch from **remote** when online.
- ✅ Fetch from **local cache** when offline.
- ✅ Verify cache is updated after remote fetch.
- ✅ CRUD operations delegate correctly to data sources.

#### **Run Tests**
```bash
flutter test
```

---

### ✅ **Test Result**
```
00:06 +9: All tests passed!
```

You can also display this screenshot in the README:
![All Tests Passed](docs/screenshots/tests_passed.png)

---

## ✅ **Packages Used**
- `connectivity_plus` – For checking network status.
- `mockito` – For mocking dependencies in unit tests.
- `build_runner` – For generating mocks.

Install:
```bash
flutter pub add connectivity_plus
flutter pub add mockito --dev
flutter pub add build_runner --dev
```

Generate mocks:
```bash
dart run build_runner build
```

---

## ✅ **Architecture Diagram**
```
UI → Bloc → Use Case → Repository (ProductRepositoryImpl)
                |              |
          Domain Contract   Data Layer
                            |
        ┌────────────┬─────────────┐
   LocalDataSource   RemoteDataSource
                            |
                        API / DB
```

---

## ✅ **Git Commands**
Commit and push changes:
```bash
git add .
git commit -m "Task 12: Implement Repository with Network Logic and Unit Tests"
git push origin task_12
```

---

## ✅ **Next Steps**
- Implement **real RemoteDataSource** (API) and **LocalDataSource** (DB or SharedPreferences).
- Add **Bloc + UI integration**.
