# ✅ Ecommerce App – Task 14: Implement Local Data Source

This task adds **local caching** using **SharedPreferences** to the Ecommerce app.  
The local data source is used when:
- The app is offline.
- Temporary items need to be displayed while fetching from the server.

---

## 📂 **Project Structure**
```
lib/
 ├── core/
 │    └── network/network_info.dart
 └── features/
      └── product/
           ├── data/
           │    ├── datasources/
           │    │    ├── local_data_source.dart    # Local cache logic
           │    │    └── remote_data_source.dart
           │    ├── repositories/product_repository_impl.dart
           │    └── models/product_model.dart      # Updated to extend Product entity
           └── domain/
                ├── entities/product.dart          # Entity class
                └── repositories/product_repository.dart

test/
 ├── core/network/network_info_test.dart
 └── features/product/data/datasources/product_local_data_source_test.dart
```

---

## ✅ **What Was Done in Task 14**
✔ Added **SharedPreferences** dependency  
✔ Implemented `ProductLocalDataSourceImpl` with:
- Cache all products
- Get cached products
- Create product
- Update product
- Delete product  
✔ Updated `ProductModel`:
- ✅ Extends **Product entity** (Clean Architecture compliance)
- ✅ Added `copyWith`, `toJson`, `fromJson`, `==` and `hashCode`  
✔ Wrote **unit tests** for local data source  

---

## ✅ **Add Dependency**
In `pubspec.yaml`:
```yaml
dependencies:
  shared_preferences: ^2.2.2
```

Install:
```bash
flutter pub get
```

---

## ✅ **Updated ProductModel**
`lib/features/product/data/models/product_model.dart`:
```dart
import 'package:ecommerce/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required double price,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          price: price,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          imageUrl == other.imageUrl &&
          price == other.price;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      imageUrl.hashCode ^
      price.hashCode;
}
```

---

## ✅ **Local Data Source Implementation**
`lib/features/product/data/datasources/local_data_source.dart`:
```dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> createProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(Stri
